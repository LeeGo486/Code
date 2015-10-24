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
/// 类说明：恩派雅微信后台服务
/// 创建人：刘洪
/// 创建日期：2014-09-19
/// WSID:df8dc27e-703a-4f79-ac01-f9efe6dfad1f
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.NPaiaWXSite
{

    public class StyleInfo : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public StyleInfo()
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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetStyleInfo".ToUpper())      //获取款式信息
                {
                    GetStyleInfo();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetStyleInfoVex".ToUpper())      //获取款式信息
                {
                    GetStyleInfoVex();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AddStyleSKU".ToUpper())      //AddStyle
                {
                    AddStyleSKU();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetYear".ToUpper())      //获取年份
                {
                    GetYear();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetSeason".ToUpper())      //获取季节
                {
                    GetSeason();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetClass".ToUpper())      //获取大类
                {
                    GetClass();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetSubClass".ToUpper())      //获取小类
                {
                    GetSubClass();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetStyleSKU".ToUpper())      //获取小类
                {
                    GetStyleSKU();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EditStyle".ToUpper())      //修改款式资料
                {
                    EditStyle();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CheckStyle".ToUpper())      //修改款式资料
                {
                    CheckStyle();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "UPDateState".ToUpper())      //批量更新状态
                {
                    UPDateState();
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

        #region 查询款式信息
        private void GetStyleInfo()
        {
            string strSQL = @"SELECT [STYL_ID]
                  ,[STYL_M01P_ID]
                  ,[STYL_M02C_ID]
                  ,[STYL_Code]
                  ,[STYL_Name]
                  ,[STYL_Desp]
                  ,[STYL_State]
                  ,[STYL_Class]
                  ,[STYL_Year]
                  ,[STYL_Season]
                  ,[STYL_SubClass]
                  ,[STYL_Type]
                  ,[STYL_Price]
                  ,[STYL_SellPrice]
                  ,[STYL_Property1]
                  ,[STYL_Property2]
                  ,[STYL_Property3]
                  ,[STYL_Property4]
                  ,[STYL_PicturePath]
                  ,[STYL_BigPicturePath]
                  ,[STYL_Rgdt]
                  ,[STYL_RgUser]
                  ,[STYL_LmDt]
                  ,[STYL_LmUser]
                  ,[STYL_UptNo]
              FROM [B01_MDM].[STYL_Style] 
              WHERE 1=1 " + m_hzyPageInfo.Where;
            m_dsRequturn = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 新建款式SKU信息 VEX
        private void AddStyleSKU()
        {
            string strColSiz = ds.Tables[1].Rows[0]["corsie"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strColSiz);

            ds.Tables[1].Columns.Remove("corsie");

            ds.Tables[1].Columns.Add("STYL_ID");
            ds.Tables[1].Columns.Add("STYL_M01P_ID");
            ds.Tables[1].Columns.Add("STYL_M02C_ID");
            ds.Tables[1].Columns.Add("STYL_Rgdt");
            ds.Tables[1].Columns.Add("STYL_RgUser");
            ds.Tables[1].Columns.Add("STYL_LmDt");
            ds.Tables[1].Columns.Add("STYL_LmUser");
            ds.Tables[1].Columns.Add("STYL_UptNo");

            dsXML.Tables[1].Columns.Add("STL2_ID");
            dsXML.Tables[1].Columns.Add("STL2_M01P_ID");
            dsXML.Tables[1].Columns.Add("STL2_M02C_ID");
            dsXML.Tables[1].Columns.Add("STL2_STYL_ID");
            dsXML.Tables[1].Columns.Add("STL2_Rgdt");
            dsXML.Tables[1].Columns.Add("STL2_RgUser");
            dsXML.Tables[1].Columns.Add("STL2_LmDt");
            dsXML.Tables[1].Columns.Add("STL2_LmUser");
            dsXML.Tables[1].Columns.Add("STL2_UptNo");

            dsXML.Tables[1].Columns["colorid"].ColumnName = "STL2_color";
            dsXML.Tables[1].Columns["sizeid"].ColumnName = "STL2_size";

            //GUID
            System.Guid guid = System.Guid.NewGuid();               //Guid 类型
            string strGUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型

            //主表复制
            ds.Tables[1].Rows[0]["STYL_ID"] = strGUID;
            ds.Tables[1].Rows[0]["STYL_M01P_ID"] = "DB7AC6E4-AB82-4DDA-9D81-8F3838EA8C77";
            ds.Tables[1].Rows[0]["STYL_M02C_ID"] = "505B751B-85DE-4B1C-8A47-93802A0A8711";
            ds.Tables[1].Rows[0]["STYL_Rgdt"] = timeNow;
            ds.Tables[1].Rows[0]["STYL_RgUser"] = this.hzyMessage.User_Name;
            ds.Tables[1].Rows[0]["STYL_LmDt"] = timeNow;
            ds.Tables[1].Rows[0]["STYL_LmUser"] = this.hzyMessage.User_Name;
            ds.Tables[1].Rows[0]["STYL_UptNo"] = 0;

            //颜色尺码table行数
            int rowCount = dsXML.Tables[1].Rows.Count;

            //赋值
            for (int i = 0; i <= rowCount - 1; i++)
            {
                string strGUID1 = System.Guid.NewGuid().ToString();      //直接返回字符串类型

                dsXML.Tables[1].Rows[i]["STL2_ID"] = strGUID1;
                dsXML.Tables[1].Rows[i]["STL2_M01P_ID"] = "DB7AC6E4-AB82-4DDA-9D81-8F3838EA8C77";
                dsXML.Tables[1].Rows[i]["STL2_M02C_ID"] = "505B751B-85DE-4B1C-8A47-93802A0A8711";
                dsXML.Tables[1].Rows[i]["STL2_STYL_ID"] = strGUID;
                dsXML.Tables[1].Rows[i]["STL2_Rgdt"] = timeNow;
                dsXML.Tables[1].Rows[i]["STL2_RgUser"] = this.m_hzyMessage.User_Name;
                dsXML.Tables[1].Rows[i]["STL2_LmDt"] = timeNow;
                dsXML.Tables[1].Rows[i]["STL2_LmUser"] = this.m_hzyMessage.User_Name;
                dsXML.Tables[1].Rows[i]["STL2_UptNo"] = 0;
            };

            bool bResult = false;
            conn.BeginTransaction(); // 开启事务
            bResult = conn.Insert("[B01_MDM].[STYL_Style]", ds.Tables[1]);
            bResult = conn.Insert("[B01_MDM].[STL2_StyleSKU]", dsXML.Tables[1]);
            conn.CommitTransaction();

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "创建成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "创建失败" });
            };
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 查询款式信息Vex
        private void GetStyleInfoVex()
        {
            string strSQL = @"SELECT [STYL_ID]
                      ,[STYL_M01P_ID]
                      ,[STYL_M02C_ID]
                      ,[STYL_Code]
                      ,[STYL_Name]
                      ,[STYL_Desp]
                      ,[STYL_State]
                      ,CASE [STYL_State] WHEN '20' THEN '上架' WHEN '90' THEN '下架' WHEN '15' THEN '未上架' END AS [StateName] 
                      ,[STYL_Class]
                      ,[STYL_Year]
                      ,[STYL_Season]
                      ,[STYL_SubClass]
                      ,[STYL_Type]
                      ,[STYL_Price]
                      ,[STYL_SellPrice]
                      ,[STYL_Property1]
                      ,[STYL_Property2]
                      ,[STYL_Property3]
                      ,[STYL_Property4]
                      ,[STYL_PicturePath]
                      ,[STYL_BigPicturePath]
                      ,[STYL_Rgdt]
                      ,[STYL_RgUser]
                      ,[STYL_LmDt]
                      ,[STYL_LmUser]
                      ,[STYL_UptNo]
                  FROM [B01_MDM].[STYL_Style] 
                  WHERE [STYL_State] <> '99' " + m_hzyPageInfo.Where;
            m_dsRequturn = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 获取combobox下拉值
            //年
            private void GetYear()
            {
                string strSQL = @"
                                SELECT DISTINCT [STYL_Year]
                                FROM [B01_MDM].[STYL_Style]";
                m_dsRequturn = conn.GetDataSet(strSQL);
            }
            //季节
            private void GetSeason()
            {
                string strSQL = @"
                                SELECT DISTINCT [STYL_Season]
                                FROM [B01_MDM].[STYL_Style]";
                m_dsRequturn = conn.GetDataSet(strSQL);
            }
            //大类
            private void GetClass()
            {
                string strSQL = @"
                                SELECT DISTINCT [STYL_Class]
                                FROM [B01_MDM].[STYL_Style]";
                m_dsRequturn = conn.GetDataSet(strSQL);
            }
            //小类
            private void GetSubClass()
            {
                string strSQL = @"
                                SELECT DISTINCT [STYL_SubClass]
                                FROM [B01_MDM].[STYL_Style]";
                m_dsRequturn = conn.GetDataSet(strSQL);
            }
        #endregion

        #region 查询款式SKU信息
            private void GetStyleSKU()
            {
                string strSQL = @"SELECT [STL2_ID]
                    ,[STL2_M01P_ID]
                    ,[STL2_M02C_ID]
                    ,[STL2_STYL_ID]
                    ,[STL2_Color]
                    ,[STL2_Size]
                    ,[STL2_Desp]
                    ,[STL2_Rgdt]
                    ,[STL2_RgUser]
                    ,[STL2_LmDt]
                    ,[STL2_LmUser]
                    ,[STL2_UptNo]
            FROM [B01_MDM].[STL2_StyleSKU] 
        WHERE 1=1 " + m_hzyPageInfo.Where;
                m_dsRequturn = conn.GetDataSet(strSQL);
            }
        #endregion

        #region 修改款式信息

            private void EditStyle() {

                ds.Tables[1].Columns.Add("STYL_M01P_ID");
                ds.Tables[1].Columns.Add("STYL_M02C_ID");
                ds.Tables[1].Columns.Add("STYL_LmDt");
                ds.Tables[1].Columns.Add("STYL_LmUser");

                ds.Tables[1].Rows[0]["STYL_M01P_ID"] = "DB7AC6E4-AB82-4DDA-9D81-8F3838EA8C77";
                ds.Tables[1].Rows[0]["STYL_M02C_ID"] = "505B751B-85DE-4B1C-8A47-93802A0A8711";
                ds.Tables[1].Rows[0]["STYL_LmDt"] = timeNow;
                ds.Tables[1].Rows[0]["STYL_LmUser"] = this.hzyMessage.User_Name;

                bool bResult = false;
                ArrayList listKey = new ArrayList();
                listKey.Add("STYL_ID");
                conn.BeginTransaction(); // 开启事务
                bResult = conn.Update("[B01_MDM].[STYL_Style]", ds.Tables[1], listKey);
                conn.CommitTransaction();

                if (bResult){
                    dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                }else{
                    dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
                };
                m_dsRequturn.Tables.Add(dt_EditResult);
            }

        #endregion

        #region 检查款式是否存在
            private void CheckStyle() {
                string strCode = ds.Tables[1].Rows[0]["Code"].ToString();

                string strSQL = @"
                            SELECT [STYL_Code]
                            FROM [B01_MDM].[STYL_Style]
                            WHERE 1=1 AND [STYL_Code] = '" + strCode + "'";
                int icount = conn.GetDataTableRowCount(strSQL);
                dt_EditResult.Rows.Add(new object[] { true, icount });
                m_dsRequturn.Tables.Add(dt_EditResult);
            }
        #endregion

        #region 批量更更新状态
            private void UPDateState() {
                DataTable dt = ds.Tables["list"];


                bool bResult = false;
                ArrayList listKey = new ArrayList();
                listKey.Add("STYL_ID");
                conn.BeginTransaction(); // 开启事务
                bResult = conn.Update("[B01_MDM].[STYL_Style]", dt, listKey);
                conn.CommitTransaction();

                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "更新成功" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "更新失败" });
                };
                m_dsRequturn.Tables.Add(dt_EditResult);
            }
        #endregion
        #endregion
    }

}