using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System.Collections;
using System.Web;
using HZY.COM.Common.Base;

// 类名：BasicData
// 类说明：雅斓ERP基础资料下拉
// 创建人： 郭琦琦
// 创建日期：2014-04-10
// 修改人：
// 修改日期：
namespace HZY.COM.WS.GL_ERP2
{
    public class BasicData : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public BasicData()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("GL_ERP");
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        string filter = "";//为模糊查询用

        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            string strXML = "";
            strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            ds = Common.Common.GetDSByExcelXML(strXML);
            DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
            filter = m_request.Tables[0].Rows[0]["q"].ToString(); // 实时条件，用于下拉框查询数据
            if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET") //取ERP基础表基础资料
            {
                Get(filter);
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET2Level".ToUpper())//取基础（内部GUID关联）
            {

                GET2Level();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETBRAND")//取品牌表数据下拉
            {
                GETBRAND(filter);
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETBRANDSEARCH")//模糊查询品牌
            {
                GETBRANDSEARCH(filter);
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETBRANDCODE")//通过名称取品牌ID
            {
                GETBRANDCODE();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETBRANDNAME")//通过品牌ID取名称
            {
                GETBRANDNAME();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETUNIT")//取单位数据供下拉
            {
                GETUNIT();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETMAXSKC")//取SKC小类最大号下拉
            {
                GETMAXSKC();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETALL")//View_ALLData
            {
                GETALL(filter);
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ALLDataALL".ToUpper())//View_ALLDataALL
            {
                ALLDataALL();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "checkPOre".ToUpper())//采购单删除的时候验证是否收货
            {
                checkPOre();
            }


            return ds_Return;
        }
        #endregion

        #region 内部函数

        #region Get取ERP基础表基础资料(模糊查询)
        /// <summary>
        /// 取ERP基础表基础资料
        /// </summary>
        private void Get(string pstrQ)
        {
            string strSQL = @"
                                    SELECT [CT1_OptionsValues]
                                          ,[CT1_Options]
                                          ,[CT1_ID]
                                          ,[CT1_CONO]
                                          ,[CT1_DIVI]
                                          ,[CT1_Code]
                                          ,[CT1_CodeName]
                                          ,[CT1_KeyID]
                                          ,[CT1_KeyName]
                                          ,[CT1_State]
                                          ,[CT1_FatherID]
                                          ,[CT1_RgDt]
                                          ,[CT1_RgUser]
                                          ,[CT1_LmDt]
                                          ,[CT1_LmUser]
                                          ,[CT1_UptNo]
                                      FROM [M01_CONF].[CT0_CSYTAB]   
                                      WHERE 1=1  AND CT1_Options LIKE '%" + pstrQ + "%'" + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 取基础（内部GUID关联）2级
        /// <summary>
        /// 取基础（内部GUID关联）2级
        /// </summary>
        private void GET2Level()
        {
            m_hzyPageInfo.Order = " ASC ";//重写排序条件
            m_hzyPageInfo.Sort = " CT1_KeyName ";//重写排序字段
            string strCT1_Code = ds.Tables["list"].Rows[0]["CT1_Code"].ToString();//获取类型
            string strCT1_KeyID = ds.Tables["list"].Rows[0]["CT1_KeyID"].ToString();//获取下拉ID编号
            string strSQL = @"
                          SELECT  CT1_ID ,
                                  CT1_CONO ,
                                  CT1_DIVI ,
                                  CT1_Code ,
                                  CT1_CodeName ,
                                  CT1_KeyID ,
                                  CT1_KeyName ,
                                  CT1_OptionsValues ,
                                  CT1_Options ,
                                  CT1_State ,
                                  CT1_FatherID ,
                                  CT1_RgDt ,
                                  CT1_RgUser ,
                                  CT1_LmDt ,
                                  CT1_LmUser ,
                                  CT1_UptNo
                        FROM      [M01_CONF].[CT0_CSYTAB]
                        WHERE     CT1_FatherID IN ( SELECT    ct1_id
                                                    FROM      [M01_CONF].[CT0_CSYTAB]
                                                    WHERE     CT1_Code = @param0
							                        and  CT1_KeyID = @param1 AND CT1_State = 20 ) 
                                          " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[] { strCT1_Code, strCT1_KeyID }, m_hzyPageInfo);
        }
        #endregion

        #region 取品牌表数据下拉
        /// <summary>
        /// 取品牌表数据下拉
        /// </summary>
        private void GETBRAND(string strfilter)
        {
            string strSQL = @"
                            SELECT   [BR1_ID]
                                    ,[BR1_CONO]
                                    ,[BR1_DIVI]
                                    ,[BR1_BrandCode]
                                    ,[BR1_Name]
                                    ,[BR1_Desp]
                                    ,[BR1_SupplierCode]
                                    ,[BR1_Country]
                                    ,[BR1_StyleName]
                                    ,[BR1_CustomerGroup]
                                    ,[BR1_State]
                                    ,[BR1_RgDt]
                                    ,[BR1_RgUser]
                                    ,[BR1_LmDt]
                                    ,[BR1_LmUser]
                                    ,[BR1_UptNo]
                                FROM [B01_MDM].[BR1_Brand]  
                                WHERE 1=1 AND BR1_BrandCode LIKE '%" + strfilter + "%' OR BR1_Name LIKE '%" + strfilter + "%' " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }

        #endregion

        #region 模糊查询品牌
        /// <summary>
        /// 模糊查询品牌
        /// </summary>
        /// <param name="pstrQ">模糊查询条件</param>
        private void GETBRANDSEARCH(string pstrQ)
        {
            string strSQL = @"
                                    SELECT   [BR1_ID]
                                            ,[BR1_CONO]
                                            ,[BR1_DIVI]
                                            ,[BR1_BrandCode]
                                            ,[BR1_Name]
                                            ,[BR1_Desp]
                                            ,[BR1_SupplierCode]
                                            ,[BR1_Country]
                                            ,[BR1_StyleName]
                                            ,[BR1_CustomerGroup]
                                            ,[BR1_State]
                                            ,[BR1_RgDt]
                                            ,[BR1_RgUser]
                                            ,[BR1_LmDt]
                                            ,[BR1_LmUser]
                                            ,[BR1_UptNo]
                                        FROM [B01_MDM].[BR1_Brand]  
                                        WHERE 1=1 and  BR1_Name LIKE '%" + pstrQ + "%' " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }

        #endregion

        #region 通过名称取品牌ID
        /// <summary>
        /// 通过名称取品牌ID
        /// </summary>
        private void GETBRANDCODE()
        {
            string strSQL = @"
                                   SELECT BR1_BrandCode
                                   FROM [B01_MDM].[BR1_Brand]
                                   WHERE 1=1 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 通过品牌ID取名称
        /// <summary>
        /// 通过品牌ID取名称
        /// </summary>
        private void GETBRANDNAME()
        {
            string strSQL = @"
                                   SELECT BR1_Name
                                    FROM [B01_MDM].[BR1_Brand]
                                    WHERE 1=1 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 取单位数据供下拉
        /// <summary>
        /// 取单位数据供下拉
        /// </summary>
        private void GETUNIT()
        {
            string strSQL = @"
                            SELECT  ST1_ID ,
                                    ST1_CONO ,
                                    ST1_DIVI ,
                                    ST1_StyleCode ,
                                    ST1_SupplierCode ,
                                    ST1_BR1_BrandCode ,
                                    ST1_SupperierStyle ,
                                    ST1_Years ,
                                    ST1_Season ,
                                    ST1_ComModity ,
                                    ST1_Unit ,
                                    ST1_Category ,
                                    ST1_LargeClass ,
                                    ST1_SmallClass ,
                                    ST1_Grade ,
                                    ST1_Currency ,
                                    ST1_Provenance ,
                                    ST1_Ingredients ,
                                    ST1_Standard ,
                                    ST1_SafeTechnology ,
                                    ST1_IsPrint ,
                                    ST1_State ,
                                    ST1_Attr01 ,
                                    ST1_Attr02 ,
                                    ST1_Attr03 ,
                                    ST1_Attr04 ,
                                    ST1_Attr05 ,
                                    ST1_RgDt ,
                                    ST1_RgUser ,
                                    ST1_LmDt ,
                                    ST1_LmUser ,
                                    ST1_UptNo
                                FROM [B01_MDM].[ST1_Style] where 1=1  
                                 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 取SKC小类最大号下拉
        /// <summary>
        /// 取SKC小类最大号下拉
        /// </summary>
        private void GETMAXSKC()
        {
            string SKC = "";
            string strst1_years = ds.Tables["list"].Rows[0]["st1_years"].ToString();
            string strst1_season = ds.Tables["list"].Rows[0]["st1_season"].ToString();
            string strst1_category = ds.Tables["list"].Rows[0]["st1_category"].ToString();
            string strst1_largeclass = ds.Tables["list"].Rows[0]["st1_largeclass"].ToString();
            SKC = "A" + strst1_years + strst1_season + strst1_category + strst1_largeclass;

            string mMaxSkcCode = "";
            mMaxSkcCode = AutoKeyCode.GetMaxKeyCode("获取SKC最大号", SKC, "", "", m_conn);

            DataTable dtMaxKSC = new DataTable();
            dtMaxKSC.Columns.Add("maxskc");
            DataRow drMaxKSC = dtMaxKSC.NewRow();
            drMaxKSC["maxskc"] = mMaxSkcCode;
            dtMaxKSC.Rows.Add(drMaxKSC);
            DataSet dsMaxKSC = new DataSet();
            dsMaxKSC.Tables.Add(dtMaxKSC);
            ds_Return = dsMaxKSC;
        }
        #endregion


        #region View_ALLData
        /// <summary>
        /// View_ALLData
        /// </summary>
        private void GETALL(string pstrQ)
        {
            m_hzyPageInfo.Order = " code ";

            string strSQL = @"
                                    SELECT DISTINCT Code,COID
                                      FROM [dbo].[View_ALLData]
                                      WHERE MARA_Code IS NOT  null 
                                        AND code LIKE '%" + pstrQ + "%'" + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region View_ALLDataALL
        /// <summary>
        /// View_ALLData
        /// </summary>
        private void ALLDataALL()
        {
            m_hzyPageInfo.Page = 1;
            m_hzyPageInfo.PageRowCount = 100000;
            string strSQL = @"
                               SELECT  *
                                      FROM [dbo].[View_ALLData]
                                      WHERE MARA_Code IS NOT  null  
                                                " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region checkPOre
        /// <summary>
        /// checkPOre//采购单删除的时候验证是否已经收货
        /// </summary>
        private void checkPOre()
        {
            string strPORECode = ds.Tables["list"].Rows[0]["PORECode"].ToString();//获取类型
            string strWhere = "";
            if (ds.Tables["list"].Columns.Contains("po2_pd1_productcode"))
            {
                strWhere = " AND RP2_PD1_ProductCode='" + ds.Tables["list"].Rows[0]["po2_pd1_productcode"].ToString() + "'";
            }
            string strSQL = @"
                              SELECT COUNT(*)  COUNT FROM B02_BILL.RP2_POReceiptDetail t1 
                                    LEFT JOIN  B02_BILL.RP1_POReceiptHead  t2 ON t1.RP2_ReceiptCode= t2.RP1_ReceiptCode 
                                WHERE t1.RP2_State IS NOT NULL  and t2.RP1_PO1_POCode = '" + strPORECode + "'" + strWhere;
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion



        #endregion

    }
}
