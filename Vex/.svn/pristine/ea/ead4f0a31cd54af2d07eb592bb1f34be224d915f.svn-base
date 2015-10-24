using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System.Collections;
using HZY.COM.Common.Base;
using System.Data;

///WSID:6e647c56-cd98-4eb9-ae95-0021cc435801
///创建人：俞佳伟
///创建日期：2015-07-20

namespace HZY.COM.WS.PLMAS
{
    class ProductPlan : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public ProductPlan()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region  全局变量
        private Dbconn m_conn;
        private Dbconn m_ConnErpAss = new Dbconn("ERPASS");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        DataSet m_Return = new DataSet();
        DataSet ds = new DataSet();
        #endregion

        #region GetData
        public DataSet GetData()
        {
            try
            {
                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dtOPTYPE = ds.Tables["OPTYPE"];
                DataTable dtList = ds.Tables["List"];

                var strzt = dtList.Rows[0]["zt"].ToString();//获取帐套

                m_conn = new Dbconn("PLM_AS_" + strzt);

                if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "ImportPlan".ToUpper())
                {
                    ImportPlan();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "DeletePlan".ToUpper())
                {
                    DeletePlan();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "UpdatePlan".ToUpper())
                {
                    UpdatePlan();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "CheckForUserPower".ToUpper())
                {
                    CheckForUserPower();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetStyleDetailTable".ToUpper())
                {
                    GetStyleDetailTable();
                }
                return m_Return;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region 商品企划维护 导入计划
        private void ImportPlan()
        {
            string strResult = "因数据错误,导入0条";
            bool bResult = true;
            DataTable dtFromExcel = DeleteNullRowData(m_RequestBak.Tables[0]);
            string strInBrand = ds.Tables["list"].Rows[0]["brand"].ToString();
            string strInSeason = ds.Tables["list"].Rows[0]["season"].ToString();

            dtFromExcel.Columns.Add("错误原因");

            if (dtFromExcel.Rows.Count > 0)
            {
                if (CheckForExcel(dtFromExcel))
                {
                    DataTable UserTable = GetUserIdFromName();

                    //创建插入表
                    DataTable InsertTable = new DataTable();
                    InsertTable.Columns.Add("UserID");
                    //InsertTable.Columns.Add("BoDuan");
                    //InsertTable.Columns.Add("Brand");
                    //InsertTable.Columns.Add("StyleSeries");
                    //InsertTable.Columns.Add("Category");
                    InsertTable.Columns.Add("PlaceHolderID");
                    InsertTable.Columns.Add("DisplaySubCategory");
                    InsertTable.Columns.Add("CostMultiplyingpower");
                    InsertTable.Columns.Add("TargetCost");
                    InsertTable.Columns.Add("PlanedRetailedPrice");
                    InsertTable.Columns.Add("PlanedFabricCost");

                    for (int i = 0; i < dtFromExcel.Rows.Count; i++)
                    {
                        if (strInBrand == dtFromExcel.Rows[i]["品牌"].ToString().Trim() && strInSeason == dtFromExcel.Rows[i]["季节"].ToString())
                        {
                            string strBrand = dtFromExcel.Rows[i]["品牌"].ToString().Trim();
                            if ("EP,EP.Lab,EP.Zen,E.Prosper,DoubleLove".Contains(strBrand))
                            {
                                DataRow[] userDataRow = UserTable.Select("UserNameC='" + dtFromExcel.Rows[i]["设计师"].ToString().Trim() + "'");
                                if (userDataRow.Length == 1)
                                {
                                    DataRow dr = InsertTable.NewRow();
                                    dr["UserID"] = userDataRow[0]["username"].ToString();
                                    //dr["BoDuan"] = dtFromExcel.Rows[i]["上市日期"].ToString().Trim();
                                    //dr["Brand"] = dtFromExcel.Rows[i]["品牌"].ToString().Trim();
                                    //dr["StyleSeries"] = dtFromExcel.Rows[i]["系列"].ToString().Trim();
                                    //dr["Category"] = dtFromExcel.Rows[i]["品类"].ToString().Trim();
                                    dr["PlaceHolderID"] = dtFromExcel.Rows[i]["占位符"].ToString().Trim();
                                    dr["DisplaySubCategory"] = dtFromExcel.Rows[i]["SKC要求"].ToString().Trim();
                                    dr["CostMultiplyingpower"] = dtFromExcel.Rows[i]["成本倍率"].ToString().Trim();
                                    dr["TargetCost"] = dtFromExcel.Rows[i]["目标成本"].ToString().Trim();
                                    dr["PlanedRetailedPrice"] = dtFromExcel.Rows[i]["计划吊牌价"].ToString().Trim();
                                    dr["PlanedFabricCost"] = dtFromExcel.Rows[i]["计划面料成本"].ToString().Trim();

                                    InsertTable.Rows.Add(dr);
                                }
                                else
                                {
                                    dtFromExcel.Rows[i]["错误原因"] = "设计师不存在或者存在多个";
                                    //bResult = false;
                                    //dt_EditResult.Rows.Add(new object[] { false, "导入失败:" + "设计师不存在或者存在多个" });
                                    //break;
                                }
                            }
                            else
                            {
                                dtFromExcel.Rows[i]["错误原因"] = "该品牌不允许导入";
                                //bResult = false;
                                //dt_EditResult.Rows.Add(new object[] { false, "导入失败:" + "该品牌不允许导入" });
                                //break;
                            }
                        }
                        else
                        {
                            dtFromExcel.Rows[i]["错误原因"] = "导入的EXCEL中品牌、季节和选择的产品线、季节不同";
                            //bResult = false;
                            //dt_EditResult.Rows.Add(new object[] { false, "导入失败:" + "导入的EXCEL中品牌、季节和选择的产品线、季节不同" });
                            //break;
                        }
                    }

                    m_conn.BeginTransaction();
                    if (InsertTable.Rows.Count > 0)
                    {
                        ArrayList aList = new ArrayList();
                        aList.Add("PlaceHolderID");
                        bResult = m_conn.Update("WsUserPower", InsertTable, aList);
                        if (bResult)
                        {
                            strResult = "导入成功";
                        }
                    }
                    bool result = m_conn.Insert("importWsUserPower", dtFromExcel);
                    if (bResult && result)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, strResult });
                        m_conn.CommitTransaction();
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "导入失败" });
                        m_conn.RollbackTransaction();
                    }

                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "导入的EXCEL格式不正确" });
                }
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "导入的EXCEL没有数据" });
            }
            m_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 商品企划维护 移除计划
        private void DeletePlan()
        {
            string strBrand = ds.Tables["list"].Rows[0]["Brand"].ToString();
            string strSeason = ds.Tables["list"].Rows[0]["Season"].ToString();

            string strSQL = @"Update WsUserPower SET DisplaySubCategory=NULL,CostMultiplyingpower=NULL,TargetCost=NULL,PlanedRetailedPrice=NULL,PlanedFabricCost=NULL,UserID=''" +
                " WHERE Brand='" + strBrand + "' AND Season='" + strSeason + "'";

            try
            {
                m_conn.BeginTransaction();
                m_conn.ExcuteQuerryByTran(strSQL);
                m_conn.CommitTransaction();
                dt_EditResult.Rows.Add(new object[] { true, "执行成功" });
            }
            catch (Exception ex)
            {
                dt_EditResult.Rows.Add(new object[] { false, ex });
            }


            m_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 商品企划维护 更改计划
        private void UpdatePlan()
        {
            bool bResult = false;
            //创建插入表
            DataTable UpdateTable = new DataTable();
            UpdateTable.Columns.Add("UserID");
            UpdateTable.Columns.Add("PlaceHolderID");
            UpdateTable.Columns.Add("DisplaySubCategory");
            UpdateTable.Columns.Add("CostMultiplyingpower");
            UpdateTable.Columns.Add("TargetCost");
            UpdateTable.Columns.Add("PlanedRetailedPrice");
            UpdateTable.Columns.Add("PlanedFabricCost");

            DataRow dr = UpdateTable.NewRow();
            dr["UserID"] = ds.Tables["list"].Rows[0]["UserID"].ToString().Trim();
            dr["PlaceHolderID"] = ds.Tables["list"].Rows[0]["PlaceHolderID"].ToString().Trim();
            dr["DisplaySubCategory"] = ds.Tables["list"].Rows[0]["DisplaySubCategory"].ToString().Trim();
            dr["CostMultiplyingpower"] = ds.Tables["list"].Rows[0]["CostMultiplyingpower"].ToString().Trim();
            dr["TargetCost"] = ds.Tables["list"].Rows[0]["TargetCost"].ToString().Trim();
            dr["PlanedRetailedPrice"] = ds.Tables["list"].Rows[0]["PlanedRetailedPrice"].ToString().Trim();
            dr["PlanedFabricCost"] = ds.Tables["list"].Rows[0]["PlanedFabricCost"].ToString().Trim();

            UpdateTable.Rows.Add(dr);

            m_conn.BeginTransaction();
            ArrayList aList = new ArrayList();
            aList.Add("PlaceHolderID");

            bResult = m_conn.Update("WsUserPower", UpdateTable, aList);

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                m_conn.CommitTransaction();
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
                m_conn.RollbackTransaction();
            }

            m_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 检查导入的EXCEL是否符合格式
        /// <summary>
        /// 检查导入的EXCEL是否符合格式
        /// </summary>
        /// <param name="dt">需要检查的Table</param>
        /// <returns>bool</returns>
        private bool CheckForExcel(DataTable dt)
        {
            bool bCheck = true;
            if (!dt.Columns.Contains("上市日期"))
            {
                bCheck = false;
            }
            if (!dt.Columns.Contains("品牌"))
            {
                bCheck = false;
            }
            if (!dt.Columns.Contains("系列"))
            {
                bCheck = false;
            }
            if (!dt.Columns.Contains("品类"))
            {
                bCheck = false;
            }
            if (!dt.Columns.Contains("占位符"))
            {
                bCheck = false;
            }
            if (!dt.Columns.Contains("SKC要求"))
            {
                bCheck = false;
            }
            if (!dt.Columns.Contains("设计师"))
            {
                bCheck = false;
            }
            if (!dt.Columns.Contains("成本倍率"))
            {
                bCheck = false;
            }
            if (!dt.Columns.Contains("目标成本"))
            {
                bCheck = false;
            }
            if (!dt.Columns.Contains("计划吊牌价"))
            {
                bCheck = false;
            }
            if (!dt.Columns.Contains("计划面料成本"))
            {
                bCheck = false;
            }
            return bCheck;
        }
        #endregion

        #region 获取Userid
        private DataTable GetUserIdFromName()
        {
            string strSQL = @"SELECT [username],[UserNameC] FROM [PLMAss].[dbo].[USERINFO] WITH(NOLOCK)";
            DataTable dt = m_conn.GetDataTable(strSQL);
            return dt;
        }
        #endregion

        #region 删除DataTable中的空行
        private DataTable DeleteNullRowData(DataTable dt)
        {
            DataRow[] dr = dt.Select("占位符=''");
            for (int i = 0; i < dr.Length; i++)
            {
                dt.Rows.Remove(dr[i]);
            }
            return dt;
        }

        #endregion

        #region 验证用户权限
        private void CheckForUserPower()
        {
            string strUser = ds.Tables["list"].Rows[0]["userid"].ToString(); //获取用户
            string strBrand = ds.Tables["list"].Rows[0]["brand"].ToString(); //获取品牌

            string strSQL = @"   SELECT userid ,powerid , brand
                                 FROM  wsuserpower WITH ( NOLOCK )
                                 WHERE powerid = 'viewplan' AND userid='" + strUser + "' AND brand='" + strBrand + "'";
            DataTable dt = m_conn.GetDataTable(strSQL);
            if (dt.Rows.Count > 0)
            {
                dt_EditResult.Rows.Add(new object[] { true, "有权限" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "无权限" });
            }

            m_Return.Tables.Add(dt_EditResult);
        }

        #endregion

        #region 获取设计目标与款式明细对照表数据
        private void GetStyleDetailTable()
        {
            string strUser = ds.Tables["list"].Rows[0]["user"].ToString();
            string strSQL = @"
                            SELECT  PlaceHolderID ,
                                    DisplaySubCategory ,
                                    CostMultiplyingpower ,
                                    TargetCost ,
                                    PlanedRetailedPrice ,
                                    PlanedFabricCost ,
                                    MeasurementsId ,
                                    DesignImageBig,
                                    DesignImageSmall ,
                                    PDYINF.SampleNum
                            FROM    WsUserPower WITH(NOLOCK)
                                    LEFT JOIN FLEXPLMProduct WITH(NOLOCK) ON PlaceHolderID = PlaceholderName
                                    LEFT JOIN ( SELECT  DYPRNO ,COUNT(DYPRNO) AS SampleNum
                                                FROM    PDYINF WITH(NOLOCK)
                                                WHERE   DYBRAND = 'EP.Lab' AND DYDYTP = '初样'
                                                GROUP BY DYPRNO
                                              ) PDYINF ON PDYINF.DYPRNO = FLEXPLMProduct.ProductName
                            WHERE   WsUserPower.Brand = 'EP.Lab' 
                                    AND WsUserPower.Season = 'EP.Lab - 2016 - 春夏' 
                                    AND SUBSTRING(WsUserPower.BoDuan, 5, 4) NOT IN ('1201','0601') 
                                     " + m_hzyPageInfo.Where;
            m_Return = m_conn.GetDataSetForPageList(strSQL,m_hzyPageInfo);
        }

        #endregion

        #endregion
    }
}
