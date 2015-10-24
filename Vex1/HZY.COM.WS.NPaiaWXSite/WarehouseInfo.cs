using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：WarehouseInfo
/// 类说明：NPaia库存管理的后台类
/// 创建人：刘洪
/// 创建日期：2014-10-21
/// WSID: bb1d5a13-afd3-49d9-8891-219fe83b295a
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.NPaiaWXSite
{

    public class WarehouseInfo : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public WarehouseInfo()
        {
            this.m_SessionCheck = true;

        }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("NPaia");

        DataSet ds = new DataSet();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_RequestXML = new DataSet();
        private DataSet m_dsRequturn = new DataSet();
        DateTime timeNow = DateTime.Now;

        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DateTime time = DateTime.Now;

                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];


                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetWarehouse".ToUpper())      //查询仓库
                {
                    GetWarehouse();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AddWarehouse".ToUpper())      //新建仓库
                {
                    AddWarehouse();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EditWarehouse".ToUpper())      //修改仓库
                {
                    EditWarehouse();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CheckDepot".ToUpper())      //检查仓库
                {
                    CheckDepot();
                }
                
                
                return m_dsRequturn;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
        #endregion


        #region  内部函数

            #region 新建仓库
            private void AddWarehouse()
            {
                DataTable dtList = ds.Tables["LIST"];
                DataTable dtInsert = new DataTable();
                
                DataRow dr = dtInsert.NewRow();
                //dtInsert.Rows.Add(dr);

                //店铺编号，名称，状态
                string strDepotCode = dtList.Rows[0]["DepotCode"].ToString();
                string strDepotName = dtList.Rows[0]["DepotName"].ToString();
                string strState = dtList.Rows[0]["State"].ToString();

                //GUID
                System.Guid guid = System.Guid.NewGuid();               //Guid 类型
                string strGUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型

                dtInsert.Columns.Add("WAHS_ID");
                dtInsert.Columns.Add("WAHS_M01P_ID");
                dtInsert.Columns.Add("WAHS_M02C_ID");
                dtInsert.Columns.Add("WAHS_Code");
                dtInsert.Columns.Add("WAHS_Name");
                dtInsert.Columns.Add("WAHS_State");
                dtInsert.Columns.Add("WAHS_Rgdt");
                dtInsert.Columns.Add("WAHS_RgUser");
                dtInsert.Columns.Add("WAHS_LmDt");
                dtInsert.Columns.Add("WAHS_LmUser");
                dtInsert.Columns.Add("WAHS_UptNo");

                //赋值
                dr["WAHS_ID"] = strGUID;
                dr["WAHS_M01P_ID"] = "DB7AC6E4-AB82-4DDA-9D81-8F3838EA8C77";
                dr["WAHS_M02C_ID"] = "505B751B-85DE-4B1C-8A47-93802A0A8711";
                dr["WAHS_Code"] = strDepotCode;
                dr["WAHS_Name"] = strDepotName;
                dr["WAHS_State"] = strState;
                dr["WAHS_Rgdt"] = timeNow;
                dr["WAHS_RgUser"] = m_hzyMessage.User_Name;
                dr["WAHS_LmDt"] = timeNow;
                dr["WAHS_LmUser"] = m_hzyMessage.User_Name;
                dr["WAHS_UptNo"] = "0";

                //追加一行
                dtInsert.Rows.Add(dr);

                bool bResult = false;
                conn.BeginTransaction(); // 开启事务
                bResult = conn.Insert("[B01_MDM].[WAHS_Warehouse]", dtInsert);

                conn.CommitTransaction();

                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "strGUID" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "" });
                };
                m_dsRequturn.Tables.Add(dt_EditResult);
            }
            #endregion

            #region 查询库存
            private void GetWarehouse() {
                string strSQL = @"
                    SELECT [WAHS_ID]
                          ,[WAHS_Code]
                          ,[WAHS_Name]
                          ,[WAHS_State]
                          ,CASE WHEN [WAHS_State] = '20' THEN '启用'
                                WHEN [WAHS_State] = '90' THEN '禁用'
                           END AS [WAHS_StateName]
                          ,[WAHS_Rgdt]
                          ,[WAHS_RgUser]
                          ,[WAHS_LmDt]
                          ,[WAHS_LmUser]
                      FROM [B01_MDM].[WAHS_Warehouse] WHERE 1=1 " + m_hzyPageInfo.Where;
                m_dsRequturn = conn.GetDataSetForPageList(strSQL,new string [0],m_hzyPageInfo);
            }
            #endregion

            #region 检查是否存在店铺
                private void CheckDepot() { 

                    DataTable dt = ds.Tables["LIST"];

                    //店铺编号
                    string strDepotCode = dt.Rows[0]["DepotCode"].ToString();

                    string strSQL = @"SELECT 1 FROM [B01_MDM].[WAHS_Warehouse] WHERE WAHS_Code = '" + strDepotCode + "'";

                    string strResult = conn.GetDataTableFirstValue(strSQL).ToString();

                    if (strResult != "")
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "" });
                    }
                    else {
                        dt_EditResult.Rows.Add(new object[] { true, "" });
                    };

                    m_dsRequturn.Tables.Add(dt_EditResult);
                }
            #endregion

            #region 修改仓库
                private void EditWarehouse() {

                    DataTable dt = ds.Tables["LIST"];

                    dt.Columns.Add("WAHS_LmDt");
                    dt.Columns.Add("WAHS_LmUser");

                    dt.Rows[0]["WAHS_LmDt"] = timeNow;
                    dt.Rows[0]["WAHS_LmUser"] = m_hzyMessage.User_Name;



                    bool bResult = false;
                    ArrayList listKey = new ArrayList();
                    listKey.Add("WAHS_ID");

                    conn.BeginTransaction(); // 开启事务
                    bResult = conn.Update("[B01_MDM].[WAHS_Warehouse]", dt, listKey);
                    conn.CommitTransaction();

                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, dt.Rows[0]["WAHS_ID"].ToString() });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "" });
                    };

                    m_dsRequturn.Tables.Add(dt_EditResult);
                }
            #endregion

        #endregion
    }

}