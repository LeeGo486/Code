using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：PE_OA_FA_Budget
/// 类说明：固定资产预算API
/// 创建人：DLY
/// 创建日期：2014-05-21
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.PE_OA
{
    public class PE_OA_FA_Budget : LogicBase, ILogicGetData
    {

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

         #region 构造函数
        public PE_OA_FA_Budget()
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
                Dbconn conn = new Dbconn("PE_OA");
                DataSet ds = new DataSet();

                if (strType == "Gets")
                {
                    ds = GetFABudgetByCons(strType, conn);
                }
                else if (strType == "Save")
                {
                    ds = SaveFABudgets(strType, conn);
                }
                else if (strType == "Gets1")
                {
                    ds = GetFABudgetByCons1(strType, conn);
                }
                else if (strType == "CheckFABudget")
                {
                    ds = CheckFABudget(strType, conn);
                }
                else if (strType == "GetHs" || strType == "GetSums" || strType == "GetHsT" || strType == "GetSumsT")
                {
                    ds = GetRows(conn, strType);
                }
                else if (strType == "Save1")
                {
                    ds = SaveRows(conn, strType);
                }
                else if (strType == "SaveT")
                {
                    ds = SaveRowsT(conn, strType);
                }
                return ds;
            }
            catch
            {
                throw;
            } 
        }
        #endregion

        #region 根据条件获取固定资产预算数据集
        /// <summary>
        /// 根据条件获取固定资产预算数据集
        /// </summary>
        /// <returns></returns>
        public DataSet GetFABudgetByCons(string strType, Dbconn conn)
        {
            DataSet ds = new DataSet(); 

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();

            String strXMLC = "【操作类型,GET】【实体,预算查询】【CONO,】【DIVI,】"
                           + "【《W》页码," + strPage + "】【《W》记录数," + strNum + "】"
                           + "【《W》查询条件," + strCons + "】"
                           + "【排序方式," + strOrderBy + "】" 
                           + "【返回内容, 主表列表】";

            ds = conn.GetDataSetBySP("API_FA.Budget", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC }); 

            return ds; 
        }
        #endregion


        #region 保存固定资产预算数据集
        /// <summary>
        /// 保存固定资产预算数据集
        /// </summary>
        /// <returns></returns>
        public DataSet SaveFABudgets(string strType, Dbconn conn)
        {
            DataSet ds = new DataSet();

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();  
            String strXMLC = "【操作类型,SAVE】【实体,预算保存】【CONO,】【DIVI,】"
                           + "【TableXML," + strXML + "】"  
                           + "【返回内容, 主表列表】";

            ds = conn.GetDataSetBySP("API_FA.Budget", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });

            return ds;
        }
        #endregion


        #region 根据条件获取固定资产预算数据集-带已用
        /// <summary>
        /// 根据条件获取固定资产预算数据集-带已用
        /// </summary>
        /// <returns></returns>
        public DataSet GetFABudgetByCons1(string strType, Dbconn conn)
        {
            DataSet ds = new DataSet();

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();
            string strPOApplyCode = dsXML.Tables["LIST"].Rows[0]["POApplyCode"].ToString();

            String strXMLC = "【操作类型,GET】【实体,可用预算查询】【CONO,】【DIVI,】"
                           + "【《W》页码," + strPage + "】【《W》记录数," + strNum + "】"
                           + "【《W》查询条件," + strCons + "】"
                           + "【《W》申购单号," + strPOApplyCode + "】"
                           + "【排序方式," + strOrderBy + "】" 
                           + "【返回内容, 主表列表】";

            ds = conn.GetDataSetBySP("API_FA.BudgetOfTYBZ", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });

            return ds;  
        }
        #endregion

        #region  固定资产申购单预算校验
        /// <summary>
        /// 固定资产申购单预算校验
        /// </summary>
        /// <returns></returns>
        public DataSet CheckFABudget(string strType, Dbconn conn)
        {
            DataSet ds = new DataSet();

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML); 
            string strPOApplyCode = dsXML.Tables["LIST"].Rows[0]["POApplyCode"].ToString();

            String strXMLC = "【操作类型,GET】【实体,FAAPP预算校验】【CONO,】【DIVI,】" 
                           + "【《W》申购单号," + strPOApplyCode + "】" 
                           + "【返回内容, 主表列表】";

            ds = conn.GetDataSetBySP("API_FA.BudgetOfTYBZ", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });

            return ds;
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
            string[] strParam = new string[] { };
            if (strType == "GetHs")
            {
                strSQL = @" SELECT *
                          FROM B01_MDM.BG1_FABudget WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetSums")
            {
                strSQL = @" SELECT SUM(BG1_SureAmount) AS sTotal , COUNT(bg1_id) AS totalCount
                          FROM B01_MDM.BG1_FABudget WHERE 1=1 " + strCons;
                ds = conn.GetDataSet(strSQL);
            }
            else if (strType == "GetHsT") //行政部统一编制
            {
                strSQL = @" SELECT *
                          FROM B01_MDM.BG1_FABudgetT WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetSumsT")//行政部统一编制
            {
                strSQL = @" SELECT SUM(BG1_SureAmount) AS sTotal , COUNT(bg1_id) AS totalCount
                          FROM B01_MDM.BG1_FABudgetT WHERE 1=1 " + strCons;
                ds = conn.GetDataSet(strSQL);
            }
            return ds;
        }
        #endregion

        #region 新建或修改记录
        /// <summary>
        /// 新建或修改记录
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
                    if (dt_List1.Columns.Contains("bg1_lmdt"))
                    {
                        dt_List1.Columns.Remove("bg1_lmdt");
                    }
                    bResult = conn.Insert("B01_MDM.BG1_FABudget", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("bg1_id");
                    bResult = conn.Update("B01_MDM.BG1_FABudget", dt_List2, ListKey);
                }
                //如果类型包含，DELETE，解析成表，做DELETE
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    DataTable dt_List3 = dsXML.Tables[i + 1];
                    for (int k = 0; k < dt_List3.Rows.Count; k++)
                    {
                        string strID1 = dt_List3.Rows[k]["bg1_id"].ToString();
                        bResult = conn.Delete("B01_MDM.BG1_FABudget", "bg1_id=" + "'" + strID1 + "'");
                    }
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
        #endregion

        #region 新建或修改记录-行政部统一编制
        /// <summary>
        /// 新建或修改记录-行政部统一编制
        /// </summary>
        /// <returns></returns>
        public DataSet SaveRowsT(Dbconn conn, String strType)
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
                    if (dt_List1.Columns.Contains("bg1_lmdt"))
                    {
                        dt_List1.Columns.Remove("bg1_lmdt");
                    }
                    bResult = conn.Insert("B01_MDM.BG1_FABudgetT", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("bg1_id");
                    bResult = conn.Update("B01_MDM.BG1_FABudgetT", dt_List2, ListKey);
                }
                //如果类型包含，DELETE，解析成表，做DELETE
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    DataTable dt_List3 = dsXML.Tables[i + 1];
                    for (int k = 0; k < dt_List3.Rows.Count; k++)
                    {
                        string strID1 = dt_List3.Rows[k]["bg1_id"].ToString();
                        bResult = conn.Delete("B01_MDM.BG1_FABudgetT", "bg1_id=" + "'" + strID1 + "'");
                    }
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
        #endregion
    }    
}