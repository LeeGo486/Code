using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：PE_OA_BM_ExpenseBudget
/// 类说明：费用预算编制
/// 创建人：DLY
/// 创建日期：2014-09-01
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.PE_OA
{
    public class PE_OA_BM_ExpenseBudget : LogicBase, ILogicGetData
    {

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        Dbconn conn = new Dbconn("PE_OA");

        #region 构造函数
        public PE_OA_BM_ExpenseBudget()
        {
            this.m_SessionCheck = true;
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }
        #endregion

        #region GetData
        public DataSet GetData()
        {
            try
            {
                string strType = m_request.Tables[0].Rows[0]["type"].ToString();  
                
                DataSet ds = new DataSet();
                if (strType == "Save")
                {
                    ds = SaveRows(conn, strType); 

                }
                else if (strType == "SaveAdd")
                {
                    ds = SaveAddRows(conn, strType);

                }
                else if (strType == "GetHs" || strType == "GetSums" || strType == "GetHAs" || strType == "GetASums"
                    || strType == "GetHAAs" || strType == "GetHAAlls")
                {
                    ds = GetRows(conn, strType);
                }
                else if (strType == "GetApH" || strType == "GetApAH" || strType == "GetApAAH")
                {
                    ds = GetApproveRows(conn, strType);
                }
                else if (strType == "SetApH" || strType == "NewApH" || strType == "SetApAH" || strType == "NewApAH")
                {
                    ds = SetApproveRows(conn, strType);
                }
                else if (strType == "GetShopSBHs" || strType == "GetShopSBHs1" || strType == "GetShopSBSums")
                {
                    ds = GetSSBRows(conn, strType);
                }
                else if (strType == "SaveShopSB")
                {
                    ds = SaveShopSBRows(conn, strType);

                }
                else if (strType == "GetDeptKMGQRows")
                {
                    ds = GetDeptKMGQRows(conn, strType);

                }
                else if (strType == "GetDeptKMGQRowsA")
                {
                    ds = GetDeptKMGQRowsA(conn, strType);

                }
                else if (strType == "ISRows" || strType == "UpdISRows" || strType == "ISRowsHZ")
                {
                    ds = ISRows(conn, strType);
                } 
                return ds; 

            }
            catch
            {
                throw;
            } 
        } 
        #endregion

        #region 新建或修改预算记录 
        /// <summary>
        /// 新建或修改预算记录
        /// </summary>
        /// <returns></returns>
        public DataSet SaveRows(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();  
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            DataTable dtOptypes = dsXML.Tables["OPTYPE"];
            bool bResult = true;
            conn.BeginTransaction();
            for (int i = 0; i < dtOptypes.Rows.Count; i++)
            {
                //如果包含rowindex，就循环移除
                if (dsXML.Tables[i + 1].Columns.Contains("rowindex"))
                {
                    dsXML.Tables[i + 1].Columns.Remove("rowindex");
                }
                //如果子表解析出来的XML，类型有insert，做新增
                if (dtOptypes.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    DataTable dt_List1 = dsXML.Tables[i + 1];
                    //如果包含bg3_lmdt，就循环移除
                    if (dt_List1.Columns.Contains("bg3_lmdt"))
                    {
                        dt_List1.Columns.Remove("bg3_lmdt");
                    }
                    bResult = conn.Insert("B01_MDM.BG3_ExpenseBudget", dt_List1); 
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("bg3_id"); 
                    bResult = conn.Update("B01_MDM.BG3_ExpenseBudget", dt_List2, ListKey); 
                }
                ////如果类型包含，DELETE，解析成表，做DELETE
                //else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                //{
                //    DataTable dt_List3 = dsXML.Tables[i + 1]; 
                //}
            } 
            conn.CommitTransaction();  
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功！" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        } 
        #endregion


        #region 新建或修改预算记录(追加)
        /// <summary>
        /// 新建或修改预算记录(追加)
        /// </summary>
        /// <returns></returns>
        public DataSet SaveAddRows(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            DataTable dtOptypes = dsXML.Tables["OPTYPE"];
            bool bResult = true;
            conn.BeginTransaction();
            for (int i = 0; i < dtOptypes.Rows.Count; i++)
            {
                //如果包含rowindex，就循环移除
                if (dsXML.Tables[i + 1].Columns.Contains("rowindex"))
                {
                    dsXML.Tables[i + 1].Columns.Remove("rowindex");
                }
                //如果子表解析出来的XML，类型有insert，做新增
                if (dtOptypes.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    DataTable dt_List1 = dsXML.Tables[i + 1];
                    //如果包含bg3_lmdt，就循环移除
                    if (dt_List1.Columns.Contains("bg8_lmdt"))
                    {
                        dt_List1.Columns.Remove("bg8_lmdt");
                    }
                    bResult = conn.Insert("B01_MDM.BG8_ExpenseBudgetAdd", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("bg8_id");
                    bResult = conn.Update("B01_MDM.BG8_ExpenseBudgetAdd", dt_List2, ListKey);
                }
                ////如果类型包含，DELETE，解析成表，做DELETE
                //else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                //{
                //    DataTable dt_List3 = dsXML.Tables[i + 1]; 
                //}
            }
            conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功！" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        }
        #endregion
         

        #region 根据条件获取数据集 条件-分页-排序 求和等 
        /// <summary>
        /// 根据条件获取数据集 条件-分页-排序 求和等
        /// </summary>
        /// <returns></returns>
        public DataSet GetRows(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();
            string[] strParam = new string[] {};
            if (strType == "GetHs" )
            {
                strSQL = @" SELECT *
                          FROM B01_MDM.BG3_ExpenseBudget WHERE 1=1 " + strCons ;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetSums")
            {
                strSQL = @" SELECT SUM(BG3_Total) AS sTotal , COUNT(bg3_id) AS totalCount
                          FROM B01_MDM.BG3_ExpenseBudget WHERE 1=1 " + strCons;
                ds = conn.GetDataSet(strSQL);
            } 
            else if (strType == "GetHAs") //(追加)
            {
                strSQL = @" SELECT *
                          FROM B01_MDM.BG8_ExpenseBudgetAdd WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetASums")//(追加)
            {
                strSQL = @" SELECT SUM(BG8_Total) AS sTotal , COUNT(bg8_id) AS totalCount
                          FROM B01_MDM.BG8_ExpenseBudgetAdd WHERE 1=1 " + strCons;
                ds = conn.GetDataSet(strSQL);
            }
            else if (strType == "GetHAAs") //(追加明细带主题等)
            {
                strSQL = @" SELECT *
                          FROM B01_MDM.V_BM_BudgetDeptZQueryAdd WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetHAAlls") //(全部含追加的明细带主题等)
            {
                strSQL = @" SELECT *
                          FROM B01_MDM.V_BM_BudgetDeptZQueryAll WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            } 
            return ds;
        }
        #endregion


        #region 根据条件获取审批记录
        /// <summary>
        /// 根据条件获取获取审批记录
        /// </summary>
        /// <returns></returns>
        public DataSet GetApproveRows(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();
            string[] strParam = new string[] { };
            if (strType == "GetApH") //(编制)
            {
                strSQL = @" SELECT *
                          FROM B01_MDM.BG4_EBudgetApprove WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetApAH")  //(追加)
            {
                strSQL = @" SELECT *
                          FROM B01_MDM.BG7_EBudgetApproveAdd WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetApAAH") //(编制+追加)
            {
                strSQL = @" SELECT NEWID() AS BG4_id, BG4_Year, BG4_Brand, BG4_DeptID, BG4_DeptName, SUM(BG4_Total) BG4_Total 
	                            FROM (SELECT BG4_Year, BG4_State, BG4_Brand, BG4_DeptID, BG4_DeptName, BG4_Type, BG4_Total 
		                                  FROM B01_MDM.BG4_EBudgetApprove  
	                                  UNION  ALL
	                                  SELECT BG7_Year, BG7_State, BG7_Brand, BG7_DeptID, BG7_DeptName, BG7_Type, BG7_Total
		                                  FROM B01_MDM.BG7_EBudgetApproveAdd) T 
                             WHERE 1=1 " + strCons + " GROUP BY BG4_Year, BG4_Brand, BG4_DeptID, BG4_DeptName ";
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            return ds;
        }
        #endregion


        #region 修改审批记录
        /// <summary>
        /// 修改审批记录
        /// </summary>
        /// <returns></returns>
        public DataSet SetApproveRows(Dbconn conn, String strType)
        { 
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strOPType = dsXML.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper();
            String strID = "";
            //String strFatherID = dsXML.Tables["LIST"].Rows[0]["ct1_fatherid"].ToString();
            DataTable dt_List = dsXML.Tables["LIST"];


            if (strType == "SetApH" || strType == "NewApH")
            { 
                strID = dsXML.Tables["LIST"].Rows[0]["bg4_id"].ToString();
            }
            else if (strType == "SetApAH" || strType == "NewApAH")
            { 
                strID = dsXML.Tables["LIST"].Rows[0]["bg7_id"].ToString();
            }

            if (strID == "")
            {
                throw new Exception("数据异常，缺少主键，请联系管理员！");
            }
            bool bResult = false;
            if (strType == "NewApH") //新建 
            {
                conn.BeginTransaction();
                bResult = conn.Insert("B01_MDM.BG4_EBudgetApprove", dt_List);
                conn.CommitTransaction();
            }
            else if (strType == "SetApH") //修改 
            {
                conn.BeginTransaction();
                bResult = conn.Update("B01_MDM.BG4_EBudgetApprove", dt_List, "bg4_id='" + strID + "'");
                conn.CommitTransaction();
            }

            if (strType == "NewApAH") //新建 追加
            {
                conn.BeginTransaction();
                bResult = conn.Insert("B01_MDM.BG7_EBudgetApproveAdd", dt_List);
                conn.CommitTransaction();
            }
            else if (strType == "SetApAH") //修改 追加
            {
                conn.BeginTransaction();
                bResult = conn.Update("B01_MDM.BG7_EBudgetApproveAdd", dt_List, "bg7_id='" + strID + "'");
                conn.CommitTransaction();
            }

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功！" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        }
        #endregion

 
        #region 根据条件获取店铺销售预算 条件-分页-排序 求和等
        /// <summary>
        /// 根据条件获取店铺销售预算 条件-分页-排序 求和等
        /// </summary>
        /// <returns></returns>
        public DataSet GetSSBRows(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();
            string[] strParam = new string[] { };
            if (strType == "GetShopSBHs")
            {
                strSQL = @" SELECT *
                          FROM B01_MDM.BG5_ShopSaleBudgets WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetShopSBHs1")
            { 
                //不同标签页
                string strXX = dsXML.Tables["LIST"].Rows[0]["XXStr"].ToString(); 
                strSQL = @" SELECT BG5_ID, BG5_CONO, BG5_DIVI, BG5_Year, BG5_Brand, BG5_Com, BG5_Branch, 
                            BG5_ShopType, BG5_ShopType1, BG5_ShopType2, BG5_CenterCode, 
                            BG5_CenterName, BG5_DeptID, BG5_DeptName, BG5_City, BG5_State, BG5_RgDt, 
                            BG5_RgUser, BG5_LmDt, BG5_LmUser, BG5_UptNo ";
                if (strXX != "")
                {
                    for (int i = 1; i < 13; i++)
                    {
                        strSQL = strSQL + @", BG5_" + strXX + "M"+i.ToString();
                    }
                }
                strSQL = strSQL + @" FROM B01_MDM.BG5_ShopSaleBudgets WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }

            else if (strType == "GetShopSBSums")
            {
                strSQL = @" SELECT SUM(BG3_Total) AS sTotal , COUNT(bg3_id) AS totalCount
                          FROM B01_MDM.BG5_ShopSaleBudgets WHERE 1=1 " + strCons;
                ds = conn.GetDataSet(strSQL);
            }
            return ds;
        }
        #endregion


        #region 新建或修改记录_店铺销售预算
        /// <summary>
        /// 新建或修改记录_店铺销售预算
        /// </summary>
        /// <returns></returns>
        public DataSet SaveShopSBRows(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            DataTable dtOptypes = dsXML.Tables["OPTYPE"];
            bool bResult = true;
            conn.BeginTransaction();
            for (int i = 0; i < dtOptypes.Rows.Count; i++)
            {
                //如果包含rowindex，就循环移除
                if (dsXML.Tables[i + 1].Columns.Contains("rowindex"))
                {
                    dsXML.Tables[i + 1].Columns.Remove("rowindex");
                }
                //如果子表解析出来的XML，类型有insert，做新增
                if (dtOptypes.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    DataTable dt_List1 = dsXML.Tables[i + 1];
                    //如果包含bg3_lmdt，就循环移除
                    if (dt_List1.Columns.Contains("bg5_lmdt"))
                    {
                        dt_List1.Columns.Remove("bg5_lmdt");
                    }
                    bResult = conn.Insert("B01_MDM.BG5_ShopSaleBudgets", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("bg5_id");
                    bResult = conn.Update("B01_MDM.BG5_ShopSaleBudgets", dt_List2, ListKey);
                }
                ////如果类型包含，DELETE，解析成表，做DELETE
                //else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                //{
                //    DataTable dt_List3 = dsXML.Tables[i + 1]; 
                //}
            }
            conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功！" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        }
        #endregion
         

        #region  部门预算汇总 
        /// <summary>
        /// 部门预算汇总
        /// </summary>
        /// <returns></returns>
        public DataSet GetDeptKMGQRows(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值  
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML); 
            string strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            string strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();
            string strType1 = dsXML.Tables["LIST"].Rows[0]["Type"].ToString();
            string strYear = dsXML.Tables["LIST"].Rows[0]["Year"].ToString();
            string strBrand = dsXML.Tables["LIST"].Rows[0]["Brand"].ToString();
            string strDept = dsXML.Tables["LIST"].Rows[0]["Dept"].ToString();
            string strProject = dsXML.Tables["LIST"].Rows[0]["Project"].ToString();
            string strCostCenter = dsXML.Tables["LIST"].Rows[0]["CostCenter"].ToString();
            string strDLCode = dsXML.Tables["LIST"].Rows[0]["DLCode"].ToString();
            string strXLCode = dsXML.Tables["LIST"].Rows[0]["XLCode"].ToString();
            string strState = dsXML.Tables["LIST"].Rows[0]["State"].ToString(); 

            String strXMLC = "【操作类型,GET】【实体, 部门预算科目汇总】"
                           + "【CONO," + strCONO + "】【DIVI," + strDIVI + "】"
                           + "【《W》汇总方式, " + strType1 + "】"
                           + "【《W》年份," + strYear + "】 【《W》品牌," + strBrand + "】"
                           + "【《W》部门," + strDept + "】【《W》项目名称," + strProject + "】"
                           + "【《W》成本中心," + strCostCenter + "】"
                           + "【《W》大类编码," + strDLCode + "】【《W》小类编码," + strXLCode + "】"
                           + "【《W》状态," + strState + "】"
                           + "【条件内容,】" 
		                   + "【返回内容,】";

            ds = conn.GetDataSetBySP("[API_BM].[Budget]", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;

        }
        #endregion


        #region  部门预算汇总(含追加)
        /// <summary>
        /// 部门预算汇总(含追加)
        /// </summary>
        /// <returns></returns>
        public DataSet GetDeptKMGQRowsA(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值  
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            string strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();
            string strType1 = dsXML.Tables["LIST"].Rows[0]["Type"].ToString();
            string strYear = dsXML.Tables["LIST"].Rows[0]["Year"].ToString();
            string strBrand = dsXML.Tables["LIST"].Rows[0]["Brand"].ToString();
            string strDept = dsXML.Tables["LIST"].Rows[0]["Dept"].ToString();
            string strProject = dsXML.Tables["LIST"].Rows[0]["Project"].ToString();
            string strCostCenter = dsXML.Tables["LIST"].Rows[0]["CostCenter"].ToString();
            string strDLCode = dsXML.Tables["LIST"].Rows[0]["DLCode"].ToString();
            string strXLCode = dsXML.Tables["LIST"].Rows[0]["XLCode"].ToString();
            string strState = dsXML.Tables["LIST"].Rows[0]["State"].ToString();

            String strXMLC = "【操作类型,GET】【实体, 部门预算科目汇总】"
                           + "【CONO," + strCONO + "】【DIVI," + strDIVI + "】"
                           + "【《W》汇总方式, " + strType1 + "】"
                           + "【《W》年份," + strYear + "】 【《W》品牌," + strBrand + "】"
                           + "【《W》部门," + strDept + "】【《W》项目名称," + strProject + "】"
                           + "【《W》成本中心," + strCostCenter + "】"
                           + "【《W》大类编码," + strDLCode + "】【《W》小类编码," + strXLCode + "】"
                           + "【《W》状态," + strState + "】"
                           + "【条件内容,】"
                           + "【返回内容,】";

            ds = conn.GetDataSetBySP("[API_BM].[BudgetA]", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;

        }
        #endregion


        #region 利润中心损益表 配置-修改-查询
        /// <summary>
        /// 利润中心损益表配置 配置-修改-查询
        /// </summary>
        /// <returns></returns>
        public DataSet ISRows(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML); 
            DataSet ds = new DataSet();
            String strSQL = "";
            if (strType == "UpdISRows")
            {
                DataTable dtOptypes = dsXML.Tables["OPTYPE"];
                bool bResult = true;
                conn.BeginTransaction();
                for (int i = 0; i < dtOptypes.Rows.Count; i++)
                {
                    //如果包含rowindex，就循环移除
                    if (dsXML.Tables[i + 1].Columns.Contains("rowindex"))
                    {
                        dsXML.Tables[i + 1].Columns.Remove("rowindex");
                    }
                    if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                    {
                        DataTable dt_List2 = dsXML.Tables[i + 1];
                        //添加更新主键，按照GUID更新
                        ArrayList ListKey = new ArrayList();
                        ListKey.Add("bg6_id");
                        bResult = conn.Update("B01_MDM.BG6_IncomeStatement", dt_List2, ListKey);
                    }
                     
                }
                conn.CommitTransaction();
                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "保存成功！" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

                }
                ds_Return.Tables.Add(dt_EditResult);
                return ds_Return; 
            }
            else if (strType == "ISRows")
            { 
                //获取条件值   
                string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
                string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
                string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
                string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();
                string[] strParam = new string[] { };
                strSQL = @"  SELECT * FROM B01_MDM.BG6_IncomeStatement
                            WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
                return ds;
            }
            else if (strType == "ISRowsHZ")
            {
                //获取条件值   
                string strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
                string strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();
                string strType1 = dsXML.Tables["LIST"].Rows[0]["Type"].ToString();
                string strYear = dsXML.Tables["LIST"].Rows[0]["Year"].ToString();
                string strBrand = dsXML.Tables["LIST"].Rows[0]["Brand"].ToString();
                string strCostCenter = dsXML.Tables["LIST"].Rows[0]["CostCenter"].ToString();
                string strShopType = dsXML.Tables["LIST"].Rows[0]["ShopType"].ToString();
                string strDLCode = dsXML.Tables["LIST"].Rows[0]["DLCode"].ToString();
                string strXLCode = dsXML.Tables["LIST"].Rows[0]["XLCode"].ToString();
                string strCom = dsXML.Tables["LIST"].Rows[0]["Com"].ToString();
                string strDept = dsXML.Tables["LIST"].Rows[0]["Dept"].ToString();
                string strProject = dsXML.Tables["LIST"].Rows[0]["Project"].ToString();
                string strState = dsXML.Tables["LIST"].Rows[0]["State"].ToString();

                String strXMLC = "【操作类型,GET】【实体, 利润中心损益】"
                                + "【CONO," + strCONO + "】【DIVI," + strDIVI + "】"
                                + "【《W》汇总方式, " + strType1 + "】"
                                + "【《W》年份," + strYear + "】 【《W》品牌," + strBrand + "】"
                                + "【《W》成本中心," + strCostCenter + "】【《W》店铺类型," + strShopType + "】"
                                + "【《W》大类编码," + strDLCode + "】【《W》小类编码," + strXLCode + "】"
                                + "【《W》公司, " + strCom + "】"
                                + "【《W》部门," + strDept + "】【《W》项目名称," + strProject + "】"
                                + "【《W》状态," + strState + "】"
                                + "【条件内容,】" 
		                        + "【返回内容,】";

                ds = conn.GetDataSetBySP("[API_BM].[IncomeStatement]", new string[4] { "@InputFormat", "@OutputFormat"
                        , "@OutputContentType", "@ConditionStr" }
                        , new string[4] { "AML", "DB", "RS", strXMLC });
                return ds;
            } 
            return ds;
        }
        #endregion


       

    }     
}