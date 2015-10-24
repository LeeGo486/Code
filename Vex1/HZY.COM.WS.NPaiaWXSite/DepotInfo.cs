using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：NGoods
/// 类说明：恩派雅商品维护后台类
/// 创建人：刘洪
/// 创建日期：2014-09-29
/// WSID: 8501f40e-134f-4f6d-b604-b37705c986d1
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.NPaiaWXSite
{

    public class DepotInfo : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public DepotInfo()
        {
            this.m_SessionCheck = false;

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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AddDepot".ToUpper())      //新建微信店铺
                {
                    AddDepot();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EditDepot".ToUpper())      //修改微信店铺
                {
                    EditDepot();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetDepot".ToUpper())      //查询微信店铺信息
                {
                    GetDepot();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetProvince".ToUpper())      //查询微信店铺省信息
                {
                    GetProvince();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCity".ToUpper())      //查询微信店铺市信息
                {
                    GetCity();
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

            #region 新建微信店铺
                private void AddDepot()
                {
                    ds.Tables[1].Columns.Add("DEPT_M01P_ID");
                    ds.Tables[1].Columns.Add("DEPT_M02C_ID");
                    ds.Tables[1].Columns.Add("DEPT_Rgdt");
                    ds.Tables[1].Columns.Add("DEPT_RgUser");
                    ds.Tables[1].Columns.Add("DEPT_LmDt");
                    ds.Tables[1].Columns.Add("DEPT_LmUser");
                    ds.Tables[1].Columns.Add("DEPT_UptNo");

                    //GUID
                    System.Guid guid = System.Guid.NewGuid();               //Guid 类型
                    string strGUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型

                    ds.Tables[1].Rows[0]["DEPT_ID"] = strGUID;
                    ds.Tables[1].Rows[0]["DEPT_M01P_ID"] = "DB7AC6E4-AB82-4DDA-9D81-8F3838EA8C77";
                    ds.Tables[1].Rows[0]["DEPT_M02C_ID"] = "505B751B-85DE-4B1C-8A47-93802A0A8711";
                    ds.Tables[1].Rows[0]["DEPT_Rgdt"] = timeNow;
                    ds.Tables[1].Rows[0]["DEPT_RgUser"] = this.hzyMessage.User_Name;
                    ds.Tables[1].Rows[0]["DEPT_LmDt"] = timeNow;
                    ds.Tables[1].Rows[0]["DEPT_LmUser"] = this.hzyMessage.User_Name;
                    ds.Tables[1].Rows[0]["DEPT_UptNo"] = 0;

                    bool bResult = false;
                    conn.BeginTransaction(); // 开启事务
                    bResult = conn.Insert("[B01_MDM].[DEPT_Depot]", ds.Tables[1]);
                    conn.CommitTransaction();

                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "创建成功" });
                        dt_EditResult.Rows.Add(new object[] { true, strGUID });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "创建失败" });
                        dt_EditResult.Rows.Add(new object[] { false, "" });
                    };
                    m_dsRequturn.Tables.Add(dt_EditResult);
                }
            #endregion

            #region 修改微信店铺
                private void EditDepot() 
                {
                    ds.Tables[1].Columns.Add("DEPT_M01P_ID");
                    ds.Tables[1].Columns.Add("DEPT_M02C_ID");
                    ds.Tables[1].Columns.Add("DEPT_LmDt");
                    ds.Tables[1].Columns.Add("DEPT_LmUser");

                    ds.Tables[1].Rows[0]["DEPT_M01P_ID"] = "DB7AC6E4-AB82-4DDA-9D81-8F3838EA8C77";
                    ds.Tables[1].Rows[0]["DEPT_M02C_ID"] = "505B751B-85DE-4B1C-8A47-93802A0A8711";
                    ds.Tables[1].Rows[0]["DEPT_LmDt"] = timeNow;
                    ds.Tables[1].Rows[0]["DEPT_LmUser"] = this.hzyMessage.User_Name;

                    string strID = ds.Tables[1].Rows[0]["DEPT_ID"].ToString();

                    bool bResult = false;
                    ArrayList listKey = new ArrayList();
                    listKey.Add("DEPT_ID");
                    conn.BeginTransaction(); // 开启事务
                    bResult = conn.Update("[B01_MDM].[DEPT_Depot]", ds.Tables[1], listKey);
                    conn.CommitTransaction();

                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                        dt_EditResult.Rows.Add(new object[] { true, strID });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
                        dt_EditResult.Rows.Add(new object[] { false, "" });
                    };
                    m_dsRequturn.Tables.Add(dt_EditResult);
                }
            #endregion

            #region 查询微信店铺信息
            private void GetDepot() 
            {
                string strSQL = @"
                    SELECT [DEPT_ID]
                        ,[DEPT_DISP_ID_Province]
                        ,[DEPT_DISP_ID_City]
                        ,[DEPT_Name]
                        ,[DEPT_Phone]
                        ,[DEPT_Address]
                        ,[DEPT_State]
                        ,CASE WHEN [DEPT_State] = '20' THEN '启用'
                              WHEN [DEPT_State] = '90' THEN '禁用'
                         END  AS [DEPT_StateName]
                        ,[DEPT_Rgdt]
                        ,[DEPT_RgUser]
                        ,[DEPT_LmDt]
                        ,[DEPT_LmUser]
                        ,[DEPT_UptNo]
                      FROM [B01_MDM].[DEPT_Depot] WHERE 1=1" + m_hzyPageInfo.Where;
                m_dsRequturn = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
            }
            #endregion

            #region 查询微信店铺省信息
            private void GetProvince()
            {
                string strSQL = @"
                    SELECT A.[DEPT_ID]
                          ,A.[DEPT_Name]
                          ,A.[DEPT_DISP_ID_Province]
                          ,A.[DEPT_DISP_ID_City]
                          ,A.[DEPT_Address]
                          ,A.[DEPT_Phone]
                          ,CASE WHEN A.[DEPT_State] = '20' THEN '启用' END  AS [DEPT_State]
                          ,A.[DEPT_Rgdt]
                          ,A.[DEPT_RgUser]
                          ,A.[DEPT_LmDt]
                          ,A.[DEPT_LmUser]
                          ,A.[DEPT_UptNo]
                            ,B.[DICP_Code]
                          ,B.[DICP_Name]
                      FROM [B01_MDM].[DEPT_Depot] A
                        LEFT JOIN [M01_CONF].[DICP_Dictionary] B
                        ON A.[DEPT_DISP_ID_Province]=B.[DICP_Code] AND [DICP_Type]='省' 
                        WHERE [DEPT_State] = '20'" + m_hzyPageInfo.Where;
                m_dsRequturn = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
            }
            #endregion

            #region 查询微信店铺市信息
            private void GetCity()
            {
                string strSQL = @"
                    SELECT A.[DEPT_ID]
                          ,A.[DEPT_Name]
                          ,A.[DEPT_DISP_ID_Province]
                          ,A.[DEPT_DISP_ID_City]
                          ,A.[DEPT_Address]
                          ,A.[DEPT_Phone]
                          ,CASE WHEN A.[DEPT_State] = '20' THEN '启用' END  AS [DEPT_State]
                          ,A.[DEPT_Rgdt]
                          ,A.[DEPT_RgUser]
                          ,A.[DEPT_LmDt]
                          ,A.[DEPT_LmUser]
                          ,A.[DEPT_UptNo]
                           ,C.[DICP_Code]
                          ,C.[DICP_Name]
                      FROM [B01_MDM].[DEPT_Depot] A
                        LEFT JOIN [M01_CONF].[DICP_Dictionary] B
                        ON A.[DEPT_DISP_ID_Province]=B.[DICP_Code] AND B.[DICP_Type]='省'
                        LEFT JOIN [M01_CONF].[DICP_Dictionary] C
                        ON B.[DICP_ID]=C.[DICP_ID_Father] AND C.[DICP_Type]='市' AND A.[DEPT_DISP_ID_CITY]=C.[DICP_Code]
                        WHERE [DEPT_State] = '20'" + m_hzyPageInfo.Where;
                m_dsRequturn = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
            }
            #endregion
        #endregion
    }

}