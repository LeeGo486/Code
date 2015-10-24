using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

 
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets; 
using HZY.COM.Common.Base;


/// 类名：PE_OA_LV_POApply
/// 类说明：低值易耗品申购单
/// 创建人：DLY
/// 创建日期：2014-11-03
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.PE_OA
{
    public class PE_OA_LV_POApply : LogicBase, ILogicGetData
    {

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        #region 构造函数
        public PE_OA_LV_POApply()
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
                    ds = SetPOApply(conn, strType);
                }
                else if (strType == "GetHs" || strType == "GetDs")
                {
                    ds = GetPOApplyList(conn, strType);
                } 
                else if (strType == "FlowOut")
                {
                    ds = ActFlowOut(conn, strType);
                }
                else if (strType == "LinkCCAS")
                {
                    ds = LinkCCAS(conn, strType);
                }
                else if (strType == "GetYSInfo")
                {
                    ds = GetYSInfo(conn, strType);
                }
                return ds;

            }
            catch
            {
                throw;
            } 
        }
        #endregion

        #region 新建或修改申购单
        /// <summary>
        /// 新建或修改申购单
        /// </summary>
        /// <returns></returns>
        public DataSet SetPOApply(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            string strXML1 = m_request.Tables[0].Rows[0]["XML1"].ToString();
            //获取申购单主表数据
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strOPType = dsXML.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper();
            String strID = dsXML.Tables["LIST"].Rows[0]["ID"].ToString();
            String strTaskID = dsXML.Tables["LIST"].Rows[0]["TaskID"].ToString();
            String strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            String strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString(); 

            String strXMLC = "【操作类型,SAVE】【实体,单据保存】"
                           + "【CONO," + strCONO + "】【DIVI," + strDIVI + "】"
                           + "【TableXML," + strXML + "】"
                           + "【TableXMLsub," + strXML1 + "】"
                           + "【Type," + strType + "】【Actor," + strActor + "】【ID," + strID + "】"
                           + "【TaskID," + strTaskID + "】"
                           + "【返回内容, id,单据号,流程id】";

            ds = conn.GetDataSetBySP("API_LV.POApply", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;
        }
        #endregion


        #region  获取申购单主/从数据集  可条件-分页-排序
        /// <summary>
        /// 获取申购单主/从数据集 可条件-分页-排序
        /// </summary>
        /// <returns></returns>
        public DataSet GetPOApplyList(Dbconn conn, String strType)
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
                strSQL = @" SELECT A.* FROM B02_BILL.LV1_POApplyHead A
									LEFT JOIN F01_CERT.OZ1_Organization B ON  A.LV1_DeptID = B.OZ1_OrgCode 
                        WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }  
            else if (strType == "GetDs")   
            {
                strSQL = @" SELECT * FROM B02_BILL.LV1_POApplyDetail WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }   
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

            ds = conn.GetDataSetBySP("API_LV.POApply", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;
            
        }
         #endregion


        #region 明细关联或替换鉴定单
        /// <summary>
        /// 明细关联或替换鉴定单
        /// </summary>
        /// <returns></returns>
        public DataSet LinkCCAS(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值 
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML); 
            string strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            string strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();

            String strXMLC = "【操作类型,LinkCCAS】【实体,关联鉴定单】【CONO," + strCONO + "】【DIVI," + strDIVI + "】"
                           + "【Actor," + strActor + "】"
                           + "【TableXML," + strXML + "】"
                           + "【返回内容, 执行结果】"; 

            ds = conn.GetDataSetBySP("API_LV.POApply", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds; 
        }
        #endregion

        #region 获取预算信息
        /// <summary>
        /// 获取预算信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetYSInfo(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值  
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            string strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();
            string strCenterCode = dsXML.Tables["LIST"].Rows[0]["CenterCode"].ToString();
            string strDate = dsXML.Tables["LIST"].Rows[0]["Date"].ToString();
            string strBillCode = dsXML.Tables["LIST"].Rows[0]["BillCode"].ToString();

            String strXMLC = "【操作类型,GET】【实体, LVAPP预算查询】"
                           + "【CONO," + strCONO + "】【DIVI," + strDIVI + "】"
                           + "【《W》成本中心, " + strCenterCode + "】"
                           + "【《W》查询日期," + strDate + "】"
                           + "【《W》申购单号, " + strBillCode + "】"
                           + "【条件内容,】"
                           + "【返回内容,】";

            ds = conn.GetDataSetBySP("[API_LV].[POApply]", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;

        }
        #endregion

    }     
}