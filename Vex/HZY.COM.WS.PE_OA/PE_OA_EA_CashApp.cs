using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

 
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets; 
using HZY.COM.Common.Base;


/// 类名：PE_OA_EA_CashApp
/// 类说明：现金报销单
/// 创建人：DLY
/// 创建日期：2014-07-30
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.PE_OA
{
    public class PE_OA_EA_CashApp : LogicBase, ILogicGetData
    {

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        #region 构造函数
        public PE_OA_EA_CashApp()
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
                if (strType == "New" || strType == "Upd")
                {
                    ds = SetBillInfo(conn, strType);
                }
                else if (strType == "GetH" || strType == "GetD" )
                {
                    ds = GetBillList(conn, strType);
                } 
                return ds;

            }
            catch
            {
                throw;
            } 
        }
        #endregion

        #region 新建或修改报销单
        /// <summary>
        /// 新建或修改报销单
        /// </summary>
        /// <returns></returns>
        public DataSet SetBillInfo(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            string strXML1 = m_request.Tables[0].Rows[0]["XML1"].ToString();
            //获取报销单主表数据
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strOPType = dsXML.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper();
            String strID = dsXML.Tables["LIST"].Rows[0]["ea1_id"].ToString();
            String strTaskID = dsXML.Tables["LIST"].Rows[0]["TaskID"].ToString();
            String strCONO = dsXML.Tables["LIST"].Rows[0]["ea1_cono"].ToString();
            String strDIVI = dsXML.Tables["LIST"].Rows[0]["ea1_divi"].ToString(); 

            String strXMLC = "【操作类型,SAVE】【实体,单据保存】"
                           + "【CONO," + strCONO + "】【DIVI," + strDIVI + "】"
                           + "【TableXML," + strXML + "】"
                           + "【TableXMLsub," + strXML1 + "】"
                           + "【Type," + strType + "】【Actor," + strActor + "】【ID," + strID + "】"
                           + "【TaskID," + strTaskID + "】"
                           + "【返回内容, id,单据号,流程id】";

            ds = conn.GetDataSetBySP("[API_FBI].[CashApp]", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;
        }
        #endregion

        

        #region  根据条件获取报销单主表数据集 条件-分页-排序等
        /// <summary>
        /// 根据条件获取报销单主表数据集 条件-分页-排序等
        /// </summary>
        /// <returns></returns>
        public DataSet GetBillList(Dbconn conn, String strType)
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
            if (strType == "GetH" )
            {
                strSQL = @" SELECT EA1_ID, EA1_CONO, EA1_DIVI,
							EA1_BillCode, EA1_State, EA1_ApplyUser, CONVERT(VARCHAR(10),EA1_ApplyDt,120) EA1_ApplyDt,
							EA1_DeptName, EA1_CenterCode, EA1_EmployeeId, EA1_EmployeeName,
							EA1_Superior, EA1_Tel, EA1_ProjectCode, EA1_TAmount,
							EA1_BankName, EA1_BankAccount, EA1_Comment
                        FROM B02_BILL.EA1_CashAppHead WHERE 1=1 " + strCons;
            }
            else if (strType == "GetD")
            {
                strSQL = @" SELECT EA2_ID, EA2_CONO, EA2_DIVI, 
							  EA2_BillCode, CONVERT(VARCHAR(10),EA2_UseDt,120) EA2_UseDt, EA2_Comment, EA2_Amount
                      FROM B02_BILL.EA1_CashAppDetail WHERE 1=1 " + strCons;
            } 
            ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            return ds;
        }
        #endregion

        #region  流程流转
        /// <summary>
        /// 流程流转
        /// </summary>
        /// <returns></returns>
        public DataSet ActFlowOut(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值 
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strID = dsXML.Tables["LIST"].Rows[0]["ID"].ToString();
            String strTaskID = dsXML.Tables["LIST"].Rows[0]["TaskID"].ToString();
            string strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            string strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();

            String strXMLC = "【操作类型,FlowOut】【实体,单据流转】【CONO,"+strCONO+"】【DIVI,"+strDIVI+"】"
                           + "【Actor," + strActor + "】【ID," + strID + "】"
                           + "【TableXML," + strXML + "】"
                           + "【返回内容, 主表列表】"; 

            ds = conn.GetDataSetBySP("API_FA.POApply", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;
            
        }
         #endregion 

    }     
}