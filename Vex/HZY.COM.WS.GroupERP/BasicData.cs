using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;

//WSID:7ea4d40d-02fa-43cf-ae3c-8231943f8124
//
//strZT,帐套.保留该方法是为了兼容旧方法，
//以后的所有方法都从m_hzymessage.Env_SN取。
//
//

namespace HZY.COM.WS.GroupERP
{
    public class BasicData : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public BasicData()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn conn = new Dbconn(),
                    lx_conn = new Dbconn("F22LX"), //斓绣
                    rs_conn = new Dbconn("F22RS"),//斓居
                    gl_conn = new Dbconn("F22GL");//雅斓

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        string filter = "",//为模糊查询用
               strComp = "";

        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            string strXML = "";

            strComp = m_hzyMessage.Env_SN;
            strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            conn = new Dbconn(strComp);
            ds = Common.Common.GetDSByExcelXML(strXML);

            filter = m_request.Tables[0].Rows[0]["q"].ToString(); // 实时条件

            DataTable dt_OPTYPE = ds.Tables["OPTYPE"];


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
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETMAXSKCTEST")
            {
                GETMAXSKCTEST();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETMAXSKC_NEW")//新编码规则 取最大SKC
            {
                GETMAXSKC_New();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "checkPOre".ToUpper())//采购单删除的时候验证是否收货
            {
                checkPOre();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETSIZE") //获取尺码
            {
                GETSIZE();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "SupplierBasicInfo".ToUpper())
            {
                SupplierBasicInfo();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETSKULIST") //根据SKC获取SKU表数据
            {
                GETSKULIST();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Edit".ToUpper())
            {
                Edit();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetSupplierPool".ToUpper())
            {
                GetSupplierPool();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetSupplierPoolTrans".ToUpper()) //供应商资金池交易记录
            {
                GetSupplierPoolTrans();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetSA_Location".ToUpper())
            {
                GetSA_Location();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetWH_WareHouse".ToUpper())
            {
                GetWH_WareHouse();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetWH".ToUpper())
            {
                GetWH();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "isAPO".ToUpper()) //在反审核采购单子行的时候检查该商品是否已经做了到货计划和付款申请 yjw-2015-4-8 2015-06-08
            {
                isAPO();
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
                                      WHERE 1=1 AND CT1_DIVI='" + m_hzyMessage.Env_SN + "'" + "AND CT1_Options LIKE '%" + pstrQ + "%' " + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
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
							                        AND  CT1_KeyID = @param1 AND CT1_State = 20 ) AND CT1_DIVI=@param2
                                          " + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSetForPageList(strSQL, new string[] { strCT1_Code, strCT1_KeyID, m_hzyMessage.Env_SN }, m_hzyPageInfo);
        }
        #endregion

        #region 取品牌表数据下拉
        /// <summary>
        /// 取品牌表数据下拉
        /// </summary>
        private void GETBRAND(string pstrfilter)
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
                                WHERE 1=1 AND BR1_DIVI='" + m_hzyMessage.Env_SN + "' AND BR1_Name LIKE '%" + pstrfilter + "%'" + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSet(strSQL);
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
                                        WHERE 1=1 and  BR1_Name LIKE '%" + pstrQ + "%' AND BR1_DIVI='" + m_hzyMessage.Env_SN + "'" + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
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
                                   WHERE 1=1 AND BR1_DIVI = '" + strComp + "' " + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
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
                                    WHERE 1=1 AND BR1_DIVI = '" + strComp + "' " + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
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
                                FROM [B01_MDM].[ST1_Style] where 1=1  AND ST1_DIVI = '" + strComp + @"' "
                                                                                        + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
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
            string strst1_category = ds.Tables["list"].Rows[0]["st1_category"].ToString();
            string strst1_largeclass = ds.Tables["list"].Rows[0]["st1_largeclass"].ToString();
            string strDIVI = ds.Tables["list"].Rows[0]["zt"].ToString();
            if (strComp == "GL")
            {
                string strSeason = ds.Tables["list"].Rows[0]["st1_season"].ToString();
                SKC = "A" + strst1_years + strSeason + strst1_category + strst1_largeclass;
            }
            else
            {
                SKC = "R" + strst1_years + strst1_category + strst1_largeclass;
            }


            string mMaxSkcCode = "";
            mMaxSkcCode = AutoKeyCode.GetMaxKeyCode("获取SKC最大号", SKC, strComp, "", conn);
            if (strComp == "GL")
            {
                string strMaterial = ds.Tables["list"].Rows[0]["material"].ToString();
                mMaxSkcCode = mMaxSkcCode + strMaterial;
            }
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

        #region 取试用品SKC小类最大号下拉
        /// <summary>
        /// 取试用品SKC小类最大号下拉
        /// </summary>
        private void GETMAXSKCTEST()
        {
            string SKC = "";
            string strst1_years = ds.Tables["list"].Rows[0]["st1_years"].ToString();
            string strst1_category = ds.Tables["list"].Rows[0]["st1_category"].ToString();
            string strst1_largeclass = ds.Tables["list"].Rows[0]["st1_largeclass"].ToString();

            SKC = "R" + strst1_years + strst1_category + strst1_largeclass + 'T';

            string mMaxSkcCode = "";
            mMaxSkcCode = AutoKeyCode.GetMaxKeyCode("获取试用品最大SKC号", SKC, strComp, "", conn);

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

        #region GetWH

        private void GetWH()
        {
            string strSQL = @"
                                SELECT DepotID AS WH1_WareHouseCode
                                             ,d_name AS WH1_Name
                                FROM [dbo].[j_depot] WHERE freeze=0 and m_type=0";

            if (strComp == "LX")
            {
                DataTable dt_lx = lx_conn.GetDataTable(strSQL);
                DataTable dt_rs = rs_conn.GetDataTable(strSQL);

                int RowCount = dt_rs.Rows.Count;

                do
                {
                    DataRow dr_lx = dt_lx.NewRow();
                    dr_lx["WH1_WareHouseCode"] = dt_rs.Rows[RowCount - 1]["WH1_WareHouseCode"];
                    dr_lx["WH1_Name"] = dt_rs.Rows[RowCount - 1]["WH1_Name"];

                    dt_lx.Rows.Add(dr_lx);
                    RowCount--;
                } while (RowCount != 0);
                dt_EditResult = dt_lx;
            }
            else if (strComp == "GL")
            {
                DataTable dt_gl = gl_conn.GetDataTable(strSQL);
                dt_EditResult = dt_gl;
            }



            ds_Return.Tables.Add(dt_EditResult.Copy());
        }

        #endregion

        //        #region View_ALLData
        //        /// <summary>
        //        /// View_ALLData
        //        /// </summary>
        //        private void GETALL(string pstrQ)
        //        {
        //            m_hzyPageInfo.Order = " code ";

        //            string strSQL = @"
        //                                    SELECT DISTINCT Code,COID
        //                                      FROM [dbo].[View_ALLData]
        //                                      WHERE MARA_Code IS NOT  null 
        //                                        AND code LIKE '%" + pstrQ + "%'" + m_hzyPageInfo.Where;
        //            ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        //        }
        //        #endregion

        //        #region View_ALLDataALL
        //        /// <summary>
        //        /// View_ALLData
        //        /// </summary>
        //        private void ALLDataALL()
        //        {
        //            m_hzyPageInfo.Page = 1;
        //            m_hzyPageInfo.PageRowCount = 100000;
        //            string strSQL = @"
        //                               SELECT  *
        //                                      FROM [dbo].[View_ALLData]
        //                                      WHERE MARA_Code IS NOT  null  
        //                                                " + m_hzyPageInfo.Where;
        //            ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        //        }
        //        #endregion

        #region checkPOre
        /// <summary>
        /// checkPOre//采购单删除的时候验证是否已经收货
        /// </summary>
        private void checkPOre()
        {
            string strPORECode = ds.Tables["list"].Rows[0]["PORECode"].ToString();//获取类型
            string strDIVI = ds.Tables["list"].Rows[0]["zt"].ToString();
            string strSQL = @"
                              SELECT COUNT(*) AS [COUNT] 
                              FROM B02_BILL.RP2_POReceiptDetail t1 
                              LEFT JOIN B02_BILL.RP1_POReceiptHead t2 
                              ON t1.RP2_ReceiptCode= t2.RP1_ReceiptCode 
                                AND t1.RP2_DIVI=t2.RP1_DIVI
                              WHERE t1.RP2_State IS NOT NULL AND t1.RP2_DIVI = '" + strComp + @"'
                                AND t2.RP1_PO1_POCode = '" + strPORECode + "'";
            ds_Return = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 根据SKC取尺码
        /// <summary>
        /// 根据SKC取尺码
        /// </summary>
        /// <param name="strEVN">事业体</param>
        private void GETSIZE()
        {
            string strSIZE = ds.Tables["list"].Rows[0]["ct1_optionsvalues"].ToString();//获取尺码组
            string strSKC = ds.Tables["list"].Rows[0]["st3_st2_skccode"].ToString();
            string strSQL = @"
                                SELECT * FROM [Hawk].[M01_CONF].[CT0_CSYTAB] 
                                WHERE CT1_FatherID IN (	SELECT CT1_ID
						                                FROM [Hawk].[M01_CONF].[CT0_CSYTAB]
						                                WHERE CT1_Code='SDGP' AND CT1_State='20' AND CT1_DIVI='" + m_hzyMessage.Env_SN + "' AND CT1_OptionsValues='" + strSIZE + "') AND CT1_DIVI='" + m_hzyMessage.Env_SN +
                                                        "' AND CT1_State='20' AND CT1_OptionsValues not in (SELECT [ST3_Size] FROM [Hawk].[B01_MDM].[ST3_StyleColorSize] WHERE ST3_State='20' AND ST3_ST2_SKCCode='" + strSKC + "' AND ST3_DIVI='" + m_hzyMessage.Env_SN + "')";
            ds_Return = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 根据SKC获取SKU表数据
        /// <summary>
        /// 根据SKC获取SKU表中的数据
        /// </summary>
        /// <param name="strEVN">事业体</param>
        private void GETSKULIST()
        {
            string strSKC = ds.Tables["list"].Rows[0]["st3_st2_skccode"].ToString();
            string strSQL = @"
                                SELECT [ST3_ID]
                                      ,[ST3_CONO]
                                      ,[ST3_DIVI]
                                      ,[ST3_ST1_StyleCode]
                                      ,[ST3_ST2_SKCCode]
                                      ,[ST3_SKUCode]
                                      ,[ST3_Size]
                                      ,[ST3_SupperierSize]
                                      ,[ST3_State]
                                      ,[ST3_RgDt]
                                      ,[ST3_RgUser]
                                      ,[ST3_LmDt]
                                      ,[ST3_LmUser]
                                      ,[ST3_UptNo]
                                      ,[ST3_Upload]
                                      ,[ST3_Check]
                                      ,[ST3_Spec]
                                      ,t4.[CT1_KeyID]
                                  FROM [Hawk].[B01_MDM].[ST3_StyleColorSize] t1 WITH(NOLOCK)
		                                LEFT JOIN [Hawk].[B01_MDM].[ST2_StyleColor] t2 WITH(NOLOCK) on t1.ST3_ST2_SKCCode=t2.ST2_SKCCode
		                                LEFT JOIN [Hawk].[M01_CONF].[CT0_CSYTAB] t3 WITH(NOLOCK) on t2.ST2_SizeGroup=t3.CT1_OptionsValues AND t2.ST2_DIVI=t3.CT1_DIVI
		                                LEFT JOIN [Hawk].[M01_CONF].[CT0_CSYTAB] t4 WITH(NOLOCK) on t4.CT1_FatherID=t3.CT1_ID and t4.CT1_OptionsValues=t1.ST3_Size AND t4.CT1_State='20'
                                  WHERE ST3_State='20' AND ST3_ST2_SKCCode='" + strSKC + "' AND ST3_DIVI='" + strComp + "'";
            ds_Return = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 获取供应商基础资料

        private void SupplierBasicInfo()
        {
            string strSQL = @"
                SELECT [CT1_KeyID]
                      ,[CT1_KeyName]
                  FROM [M01_CONF].[CT0_CSYTAB]
                  WHERE [CT1_State] = '20' AND CT1_DIVI='" + strComp + "'" + m_hzyPageInfo.Where; ;
            ds_Return = conn.GetDataSet(strSQL);

        }

        #endregion

        #region Edit 基础数据修改
        /// <summary>
        /// Edit 基础数据修改
        /// 创建人:俞佳伟
        /// 创建时间：2015-01-29
        /// </summary>
        /// <param name="strDIVI">事业体</param>
        private void Edit()
        {
            bool bResult = false;
            DateTime datetime = DateTime.Now;
            DataTable dtEdit = ds.Tables["list"];
            string strCT1_ID = ds.Tables["list"].Rows[0]["ct1_id"].ToString();
            conn.BeginTransaction();
            if (strCT1_ID == "")//新增
            {
                string GUID = System.Guid.NewGuid().ToString();
                dtEdit.Columns.Add("CT1_CONO");
                dtEdit.Columns.Add("CT1_DIVI");
                dtEdit.Columns.Add("CT1_RgDt");
                dtEdit.Columns.Add("CT1_RgUser");
                dtEdit.Columns.Add("CT1_LmDt");
                dtEdit.Columns.Add("CT1_LmUser");

                dtEdit.Rows[0]["ct1_id"] = GUID;
                dtEdit.Rows[0]["CT1_CONO"] = "HYFG";
                dtEdit.Rows[0]["CT1_DIVI"] = strComp;
                dtEdit.Rows[0]["CT1_RgDt"] = datetime;
                dtEdit.Rows[0]["CT1_RgUser"] = m_hzyMessage.User_Name;
                dtEdit.Rows[0]["CT1_LmDt"] = datetime;
                dtEdit.Rows[0]["CT1_LmUser"] = m_hzyMessage.User_Name;


                bResult = conn.Insert("[M01_CONF].[CT0_CSYTAB]", dtEdit);
            }
            else //修改
            {
                ArrayList aList = new ArrayList();
                aList.Add("ct1_id");
                //aList.Add("ct1_divi");
                bResult = conn.Update("[M01_CONF].[CT0_CSYTAB]", ds.Tables["list"], aList);

            }
            if (bResult)
            {
                conn.CommitTransaction();
                dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
            }
            else
            {
                conn.RollbackTransaction();
                dt_EditResult.Rows.Add(new object[] { true, "操作失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region GetSupplierPool 取供应商资金池
        private void GetSupplierPool()
        {
            string strSupplierCode = ds.Tables["list"].Rows[0]["SupplierCode"].ToString();
            string strWhere = "";
            if (ds.Tables["list"].Columns.Contains("Currency"))
            {
                strWhere = " AND SP2_Currency='" + ds.Tables["list"].Rows[0]["Currency"].ToString() + "'";
            }
            string strSql = @"  
                                SELECT [SP2_ID]
                                      ,[SP2_CONO]
                                      ,[SP2_DIVI]
                                      ,[SP2_SP1_SupplierCode]
                                      ,[SP2_Currency]
                                      ,[SP2_PoolAmount]
                                      ,[SP2_State]
                                      ,[SP2_RgDt]
                                      ,[SP2_RgUser]
                                      ,[SP2_LmDt]
                                      ,[SP2_LmUser]
                                      ,[SP2_UptNo]
                                FROM [Hawk].[B01_MDM].[SP2_SupplierPool]
                                WHERE  SP2_DIVI='" + strComp + "' AND SP2_SP1_SupplierCode='" + strSupplierCode + "'" + strWhere; //+m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSet(strSql);
        }
        #endregion

        #region GetSA_Location取储位信息
        /// <summary>
        /// GetSA_Location取储位信息
        /// </summary>
        private void GetSA_Location()
        {
            string strSQL = @"
                                SELECT [SA1_ID]
                                      ,[SA1_CONO]
                                      ,[SA1_DIVI]
                                      ,[SA1_WH1_WareHouseCode]
                                      ,[SA1_LocationCode]
                                      ,[SA1_Name]
                                      ,[SA1_Desp]
                                      ,[SA1_Indentify]
                                      ,[SA1_State]
                                      ,[SA1_RgDt]
                                      ,[SA1_RgUser]
                                      ,[SA1_LmDt]
                                      ,[SA1_LmUser]
                                      ,[SA1_UptNo]
                                  FROM [Hawk].[B01_MDM].[SA1_Location] 
                                  WHERE 1=1 AND SA1_DIVI = '" + strComp + "' " + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);
        }
        #endregion

        #region GetWH_WareHouse去仓库信息
        /// <summary>
        /// GetWH_WareHouse去仓库信息
        /// </summary>
        private void GetWH_WareHouse()
        {
            string strSQL = @"
                                SELECT [WH1_ID]
                                      ,[WH1_CONO]
                                      ,[WH1_DIVI]
                                      ,[WH1_WareHouseCode]
                                      ,[WH1_Name]
                                      ,[WH1_Desp]
                                      ,[WH1_State]
                                      ,[WH1_RgDt]
                                      ,[WH1_RgUser]
                                      ,[WH1_LmDt]
                                      ,[WH1_LmUser]
                                      ,[WH1_UptNo]
                                      ,[WH1_Indentify]
                                  FROM [Hawk].[B01_MDM].[WH1_WareHouse]
                                  WHERE 1=1 AND WH1_DIVI = '" + strComp + "' " + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);
        }

        #endregion

        #region isAPO检查商品是否做了到货计划
        /// <summary>
        /// isAPO检查商品是否做了到货计划和付款申请
        /// </summary>
        private void isAPO()
        {
            string strPOCode = ds.Tables["list"].Rows[0]["po2_pocode"].ToString();
            string strSKU = ds.Tables["list"].Rows[0]["po2_pd1_product"].ToString();
            string strDIVI = ds.Tables["list"].Rows[0]["po2_divi"].ToString();
            string strPO2_Liseq = ds.Tables["list"].Rows[0]["po2_liseq"].ToString();
            string strPO2_Lsseq = ds.Tables["list"].Rows[0]["po2_lsseq"].ToString();

            int nResult = 0;

            string strSQL = @"
                                  SELECT COUNT(*) COUNTNUM
                                  FROM [Hawk].[B02_BILL].[AP2_APODetail] WITH(NOLOCK)
                                  LEFT JOIN [Hawk].[B02_BILL].[AP1_APOHead] WITH(NOLOCK) ON AP2_APCode=AP1_APCode AND AP2_CONO=AP1_CONO AND AP2_DIVI=AP1_DIVI
                                  WHERE AP2_DIVI='" + strDIVI + "' AND AP2_PD1_ProductCode='" + strSKU + "' AND AP1_PO1_PurchaseCode='" + strPOCode + "'"
                                                    + " AND AP2_LINumber='" + strPO2_Liseq + "' AND AP2_LSNumber='" + strPO2_Lsseq + "'";
            nResult = Convert.ToInt32(conn.GetDataTableFirstValue(strSQL).ToString());

            if (nResult > 0)
            {
                dt_EditResult.Rows.Add(new object[] { false, "已经做了到货计划" });
            }
            else
            {
                string strSQL1 = @"
                                SELECT COUNT(*) COUNTNUM
                                FROM B02_BILL.PR1_PaymentRequisitHead WITH(NOLOCK)
	                                JOIN B02_BILL.PR2_PaymentRequisitDetail WITH(NOLOCK) ON PR1_CONO=PR2_CONO AND PR1_DIVI=PR2_DIVI AND PR1_RequestCode=PR2_RequestCode
                                WHERE PR2_State<>'99' AND PR1_PO1_POCode='" + strPOCode + "' AND PR2_DIVI='" + strDIVI + "' AND PR2_PO2_LISeq='" + strPO2_Liseq
                                                                            + "' AND PR2_PO2_LSSeq='" + strPO2_Lsseq + "' AND PR2_PO2_ProductCode='" + strSKU + "'";
                nResult = Convert.ToInt32(conn.GetDataTableFirstValue(strSQL).ToString());
                if (nResult > 0)
                {
                    dt_EditResult.Rows.Add(new object[] { false, "已经做了付款申请" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { true, "允许弃审" });
                }
            }

            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region GetSupplierPoolTrans获取供应商资金交易记录
        /// <summary>
        /// GetSupplierPoolTrans获取供应商资金交易记录
        /// </summary>
        private void GetSupplierPoolTrans()
        {
            string strWhere = "1=1";
            if (ds.Tables["list"].Columns.Contains("BeginDate") && ds.Tables["list"].Rows[0]["BeginDate"].ToString() != "")
            {
                strWhere += " AND CONVERT(VARCHAR(10),SP3_RgDt,120)>='" + ds.Tables["list"].Rows[0]["BeginDate"].ToString() + "'";
            }
            if (ds.Tables["list"].Columns.Contains("EndDate") && ds.Tables["list"].Rows[0]["EndDate"].ToString() != "")
            {
                strWhere += " AND CONVERT(VARCHAR(10),SP3_RgDt,120)<='" + ds.Tables["list"].Rows[0]["EndDate"].ToString() + "'";
            }
            string strSQL = @"
                                SELECT [SP3_ID]
                                      ,[SP3_CONO]
                                      ,[SP3_DIVI]
                                      ,[SP3_Seq]
                                      ,[SP3_SP1_SupplierCode]
                                      ,[SP3_Currency]
                                      ,[SP3_RefCODE]
                                      ,[SP3_RefType]
                                      ,[SP3_TransAmount]
                                      ,[SP3_SurplusAmount]
                                      ,[SP3_RgDt]
                                      ,[SP3_RgUser]
                                      ,[SP3_LmDt]
                                      ,[SP3_LmUser]
                                      ,[SP3_UptNo]
                                FROM [Hawk].[B03_TRANS].[SP3_SupplierPoolTrans] 
                                WHERE " + strWhere + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);
        }
        #endregion

        #region GETMAXSKC_New 新编码规则 取最大SKC
        /// <summary>
        /// GETMAXSKC_New 新编码规则 取最大SKC
        /// </summary>
        private void GETMAXSKC_New()
        {
            string strDIVI = ds.Tables["list"].Rows[0]["zt"].ToString();
            string strStyleCode = ds.Tables["list"].Rows[0]["stylecode"].ToString();

            string mMaxSkcCode = "";
            mMaxSkcCode = AutoKeyCode.GetMaxKeyCode("获取SKC最大号2", strStyleCode, strDIVI, "", conn);
            DataTable dtMaxKSC = new DataTable();
            dtMaxKSC.Columns.Add("maxskc");
            DataRow drMaxKSC = dtMaxKSC.NewRow();
            DataSet dsMaxKSC = new DataSet();

            drMaxKSC["maxskc"] = mMaxSkcCode;
            dtMaxKSC.Rows.Add(drMaxKSC);
            dsMaxKSC.Tables.Add(dtMaxKSC);

            ds_Return = dsMaxKSC;
        }

        #endregion

        #endregion

    }
}
