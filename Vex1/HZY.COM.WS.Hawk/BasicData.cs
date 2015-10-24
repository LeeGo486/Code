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



// 类名：BasicData
// 类说明：雅斓ERP基础资料下拉
// 创建人： 郭琦琦
// 创建日期：2014-04-10
// 修改人：
// 修改日期：
namespace HZY.COM.WS.Hawk
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

        private Dbconn m_conn = new Dbconn("Hawk");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
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
            string strZT = "";
            if (ds.Tables["list"].Columns.Contains("zt"))
            {
                strZT = ds.Tables["list"].Rows[0]["zt"].ToString();  //获取登录事业体 GL/LX
            }
            else
            {
                strZT = "LX";  //2015-01-04  等集团合并的时候  改成 抛出为抓到事业体异常
            }
            //strZT = ds.Tables["List"].Rows[0]["zt"].ToString();//登录事业GL/LX
            filter = m_request.Tables[0].Rows[0]["q"].ToString(); // 实时条件，用于下拉框查询数据
            if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET") //取ERP基础表基础资料
            {
                Get(filter, strZT);
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET2Level".ToUpper())//取基础（内部GUID关联）
            {

                GET2Level(strZT);
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETBRAND")//取品牌表数据下拉
            {
                GETBRAND(filter, strZT);
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETBRANDSEARCH")//模糊查询品牌
            {
                GETBRANDSEARCH(filter, strZT);
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
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETSIZE") //获取尺码
            {
                GETSIZE(strZT);
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "SupplierBasicInfo".ToUpper())
            {
                SupplierBasicInfo(strZT);
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETSKULIST") //根据SKC获取SKU表数据
            {
                GETSKULIST(strZT);
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Edit".ToUpper())
            {
                Edit();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetSupplierPool".ToUpper())
            {
                GetSupplierPool();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetSA_Location".ToUpper())
            {
                GetSA_Location();
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetWH_WareHouse".ToUpper())
            {
                GetWH_WareHouse();
            }

            return ds_Return;
        }
        #endregion

        #region 内部函数

        #region Get取ERP基础表基础资料(模糊查询)
        /// <summary>
        /// 取ERP基础表基础资料
        /// </summary>
        private void Get(string pstrQ, string strEVN)
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
                                      WHERE 1=1 AND CT1_DIVI='" + strEVN + "'" + "AND CT1_Options LIKE '%" + pstrQ + "%' AND CT1_State='20'" + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 取基础（内部GUID关联）2级
        /// <summary>
        /// 取基础（内部GUID关联）2级
        /// </summary>
        private void GET2Level(string strEVN)
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
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[] { strCT1_Code, strCT1_KeyID, strEVN }, m_hzyPageInfo);
        }
        #endregion

        #region 取品牌表数据下拉
        /// <summary>
        /// 取品牌表数据下拉
        /// </summary>
        private void GETBRAND(string pstrfilter, string strEVN)
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
                                WHERE 1=1 AND BR1_DIVI='" + strEVN + "' AND BR1_Name LIKE '%" + pstrfilter + "%'" + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }

        #endregion

        #region 模糊查询品牌
        /// <summary>
        /// 模糊查询品牌
        /// </summary>
        /// <param name="pstrQ">模糊查询条件</param>
        private void GETBRANDSEARCH(string pstrQ, string pstrDIVI)
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
                                        WHERE 1=1 and  BR1_Name LIKE '%" + pstrQ + "%' AND BR1_DIVI='" + pstrDIVI + "'" + m_hzyPageInfo.Where;
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
            string strst1_category = ds.Tables["list"].Rows[0]["st1_category"].ToString();
            string strst1_largeclass = ds.Tables["list"].Rows[0]["st1_largeclass"].ToString();
            string strDIVI = ds.Tables["list"].Rows[0]["zt"].ToString();
            if (strDIVI == "GL")
            {
                string strSeason = ds.Tables["list"].Rows[0]["st1_season"].ToString();
                SKC = "A" + strst1_years + strSeason + strst1_category + strst1_largeclass;
            }
            else
            {
                SKC = "R" + strst1_years + strst1_category + strst1_largeclass;
            }


            string mMaxSkcCode = "";
            mMaxSkcCode = AutoKeyCode.GetMaxKeyCode("获取SKC最大号", SKC, strDIVI, "", m_conn);
            if (strDIVI == "GL")
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
            string strDIVI = ds.Tables["list"].Rows[0]["divi"].ToString();
            SKC = "R" + strst1_years + strst1_category + strst1_largeclass + 'T';

            string mMaxSkcCode = "";
            mMaxSkcCode = AutoKeyCode.GetMaxKeyCode("获取试用品最大SKC号", SKC, strDIVI, "", m_conn);

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
            string strDIVI = ds.Tables["list"].Rows[0]["zt"].ToString();
            string strSQL = @"
                              SELECT COUNT(*) COUNT FROM B02_BILL.RP2_POReceiptDetail t1 
                                    LEFT JOIN  B02_BILL.RP1_POReceiptHead  t2 ON t1.RP2_ReceiptCode= t2.RP1_ReceiptCode and t1.RP2_DIVI=t2.RP1_DIVI
                                WHERE t1.RP2_State IS NOT NULL  and t2.RP1_PO1_POCode = '" + strPORECode + "' and t2.RP1_DIVI='" + strDIVI + "'";
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion

        #region 根据SKC取尺码
        /// <summary>
        /// 根据SKC取尺码
        /// </summary>
        /// <param name="strEVN">事业体</param>
        private void GETSIZE(string strEVN)
        {
            string strSIZE = ds.Tables["list"].Rows[0]["ct1_optionsvalues"].ToString();//获取尺码组
            string strSKC = ds.Tables["list"].Rows[0]["st3_st2_skccode"].ToString();
            string strSQL = @"
                                SELECT * FROM [Hawk].[M01_CONF].[CT0_CSYTAB] 
                                WHERE CT1_FatherID IN (	SELECT CT1_ID
						                                FROM [Hawk].[M01_CONF].[CT0_CSYTAB]
						                                WHERE CT1_Code='SDGP' AND CT1_DIVI='" + strEVN + "' AND CT1_OptionsValues='" + strSIZE + "') AND CT1_DIVI='" + strEVN +
                                                        "'AND CT1_OptionsValues not in (SELECT [ST3_Size] FROM [Hawk].[B01_MDM].[ST3_StyleColorSize] WHERE ST3_State='20' AND ST3_ST2_SKCCode='" + strSKC + "' AND ST3_DIVI='" + strEVN + "')";
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion

        #region 根据SKC获取SKU表数据
        /// <summary>
        /// 根据SKC获取SKU表中的数据
        /// </summary>
        /// <param name="strEVN">事业体</param>
        private void GETSKULIST(string strEVN)
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
                                  FROM [Hawk].[B01_MDM].[ST3_StyleColorSize] t1
		                                join [Hawk].[B01_MDM].[ST2_StyleColor] t2 on t1.ST3_ST2_SKCCode=t2.ST2_SKCCode
		                                join [Hawk].[M01_CONF].[CT0_CSYTAB] t3 on t2.ST2_SizeGroup=t3.CT1_OptionsValues AND t2.ST2_DIVI=t3.CT1_DIVI
		                                join [Hawk].[M01_CONF].[CT0_CSYTAB] t4 on t4.CT1_FatherID=t3.CT1_ID and t4.CT1_OptionsValues=t1.ST3_Size AND t4.CT1_State='20'
                                  WHERE ST3_State='20' AND ST3_ST2_SKCCode='" + strSKC + "' AND ST3_DIVI='" + strEVN + "'";
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion

        #region 获取供应商基础资料

        private void SupplierBasicInfo(string strDIVI)
        {
            string strSQL = @"
                SELECT [CT1_KeyID]
                      ,[CT1_KeyName]
                  FROM [M01_CONF].[CT0_CSYTAB]
                  WHERE [CT1_State] = '20' AND CT1_DIVI='" + strDIVI + "'" + m_hzyPageInfo.Where; ;
            ds_Return = m_conn.GetDataSet(strSQL);

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
            if (strCT1_ID == "")//新增
            {
                string GUID = System.Guid.NewGuid().ToString();
                dtEdit.Columns.Add("CT1_CONO");
                dtEdit.Columns.Add("CT1_RgDt");
                dtEdit.Columns.Add("CT1_RgUser");
                dtEdit.Columns.Add("CT1_LmDt");
                dtEdit.Columns.Add("CT1_LmUser");

                dtEdit.Rows[0]["ct1_id"] = GUID;
                dtEdit.Rows[0]["CT1_CONO"] = "HYFG";
                dtEdit.Rows[0]["CT1_RgDt"] = datetime;
                dtEdit.Rows[0]["CT1_RgUser"] = m_hzyMessage.User_Name;
                dtEdit.Rows[0]["CT1_LmDt"] = datetime;
                dtEdit.Rows[0]["CT1_LmUser"] = m_hzyMessage.User_Name;

                m_conn.LockTableList.Add("[M01_CONF].[CT0_CSYTAB]");
                m_conn.BeginTransaction();
                bResult = m_conn.Insert("[M01_CONF].[CT0_CSYTAB]", dtEdit);
                m_conn.CommitTransaction();

            }
            else //修改
            {
                ArrayList aList = new ArrayList();
                aList.Add("ct1_id");
                m_conn.LockTableList.Add("[M01_CONF].[CT0_CSYTAB]");
                m_conn.BeginTransaction();
                bResult = m_conn.Update("[M01_CONF].[CT0_CSYTAB]", ds.Tables["list"], aList);
                m_conn.CommitTransaction();

            }
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { true, "操作失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region GetSupplierPool 取供应商资金池
        private void GetSupplierPool()
        {
            string strDIVI = ds.Tables["list"].Rows[0]["DIVI"].ToString();
            string strSupplierCode = ds.Tables["list"].Rows[0]["SupplierCode"].ToString();
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
                                WHERE  SP2_DIVI='" + strDIVI + "' AND SP2_SP1_SupplierCode='" + strSupplierCode + "'"; //+m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSet(strSql);
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
                                  WHERE 1=1 "+m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);
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
                                  WHERE 1=1 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);
        }

        #endregion

        #endregion

    }
}
