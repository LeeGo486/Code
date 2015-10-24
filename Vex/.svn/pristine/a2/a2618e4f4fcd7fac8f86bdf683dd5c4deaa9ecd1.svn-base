using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：PE_OA_FA_POApply
/// 类说明：信息类资产诊断报告-鉴定单
/// 创建人：DLY
/// 创建日期：2014-06-16
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.PE_OA
{
    public class PE_OA_FA_ITAppraisal : LogicBase, ILogicGetData
    {

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        Dbconn conn = new Dbconn("PE_OA");

        #region 构造函数
        public PE_OA_FA_ITAppraisal()
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
                if (strType == "New" || strType == "Upd" )
                {
                    ds = SetITAppraisal(conn, strType); 

                } 
                else if (strType == "GetHs")
                {
                    ds = GetITAppraisalList(conn, strType);
                } 
                return ds; 

            }
            catch
            {
                throw;
            } 
        } 
        #endregion

        #region 新建或修改鉴定单记录
        /// <summary>
        /// 新建或修改鉴定单记录
        /// </summary>
        /// <returns></returns>
        public DataSet SetITAppraisal(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString(); 
            //获取申购单主表数据
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strOPType = dsXML.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper();
            String strID = dsXML.Tables["LIST"].Rows[0]["fa3_id"].ToString();
            DataTable dt_List = dsXML.Tables["LIST"]; 
            if (strID == "")
            {
                throw new Exception("数据异常，缺少主键，请联系管理员！");
            }

            bool bResult = false;
            if (strType == "New") //新建单据
            { 
                conn.BeginTransaction(); 
                bResult = conn.Insert("[B02_BILL].[FA3_ITAppraisal]", dt_List);
                conn.CommitTransaction();
            }
            else if (strType == "Upd") //修改单据
            {
                conn.BeginTransaction();
                bResult = conn.Update("[B02_BILL].[FA3_ITAppraisal]", dt_List, "fa3_id='" + strID+"'");
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


        #region 新建或修改鉴定单记录
        /// <summary>
        /// 新建或修改鉴定单记录
        /// </summary>
        /// <returns></returns>
        public int SetITAppraisal1(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            //获取申购单主表数据
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strOPType = dsXML.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper();
            String strID = dsXML.Tables["LIST"].Rows[0]["fa3_id"].ToString();
            String strDIVI = dsXML.Tables["LIST"].Rows[0]["fa3_divi"].ToString();
            String strCONO = dsXML.Tables["LIST"].Rows[0]["fa3_cono"].ToString();
            String strState = dsXML.Tables["LIST"].Rows[0]["fa3_state"].ToString();
            String strDepartment = dsXML.Tables["LIST"].Rows[0]["fa3_department"].ToString();
            String strName = dsXML.Tables["LIST"].Rows[0]["fa3_name"].ToString();
            String strDeviceno = dsXML.Tables["LIST"].Rows[0]["fa3_deviceno"].ToString();
            String strAssetsno = dsXML.Tables["LIST"].Rows[0]["fa3_assetsno"].ToString();
            String strFilldate = dsXML.Tables["LIST"].Rows[0]["fa3_filldate"].ToString();
            String strFaultphenomenon = dsXML.Tables["LIST"].Rows[0]["fa3_faultphenomenon"].ToString();
            String strDiagnosisresults = dsXML.Tables["LIST"].Rows[0]["fa3_diagnosisresults"].ToString();
            String strSolution = dsXML.Tables["LIST"].Rows[0]["fa3_solution"].ToString();
            String strDiagnosisdept = dsXML.Tables["LIST"].Rows[0]["fa3_diagnosisdept"].ToString();
            String strDiagnosispeople = dsXML.Tables["LIST"].Rows[0]["fa3_diagnosispeople"].ToString();
            String strAudit = dsXML.Tables["LIST"].Rows[0]["fa3_audit"].ToString();
            String strAuditdate = dsXML.Tables["LIST"].Rows[0]["fa3_auditdate"].ToString();
            String strBrandmodel1 = dsXML.Tables["LIST"].Rows[0]["fa3_brandmodel1"].ToString();
            String strNo1 = dsXML.Tables["LIST"].Rows[0]["fa3_no1"].ToString();
            String strNum1 = dsXML.Tables["LIST"].Rows[0]["fa3_num1"].ToString();
            String strRemarks1 = dsXML.Tables["LIST"].Rows[0]["fa3_remarks1"].ToString();
            String strBrandmodel2 = dsXML.Tables["LIST"].Rows[0]["fa3_brandmodel2"].ToString();
            String strNo2 = dsXML.Tables["LIST"].Rows[0]["fa3_no2"].ToString();
            String strNum2 = dsXML.Tables["LIST"].Rows[0]["fa3_num2"].ToString();
            String strRemarks2 = dsXML.Tables["LIST"].Rows[0]["fa3_remarks2"].ToString();
            String strBrandmodel3 = dsXML.Tables["LIST"].Rows[0]["fa3_brandmodel3"].ToString();
            String strNo3 = dsXML.Tables["LIST"].Rows[0]["fa3_no3"].ToString();
            String strNum3 = dsXML.Tables["LIST"].Rows[0]["fa3_num3"].ToString();
            String strRemarks3 = dsXML.Tables["LIST"].Rows[0]["fa3_remarks3"].ToString();


            //拼接查询语句
            string strSQL = "";
            if (strType == "New")
            {
                strSQL = @" INSERT INTO B02_BILL.FA3_ITAppraisal(FA3_ID, FA3_CONO, FA3_DIVI, FA3_State, 
                            FA3_Department, FA3_Name, FA3_DeviceNo, FA3_Assetsno, FA3_FillDate, 
                            FA3_FaultPhenomenon, FA3_DiagnosisResults, FA3_Solution, FA3_DiagnosisDept, 
                            FA3_DiagnosisPeople, FA3_BrandModel1, FA3_No1, 
                            FA3_Num1, FA3_Remarks1, FA3_BrandModel2, FA3_No2, FA3_Num2, FA3_Remarks2, 
                            FA3_BrandModel3, FA3_No3, FA3_Num3, FA3_Remarks3, 
                            FA3_RgUser, FA3_UptNo, FA3_RgDt) VALUES( '"
                        + strID + "', '" + strCONO + "', '" + strDIVI + "', '" + strState + "', '"
                        + strDepartment + "', '" + strName + "', '" + strDeviceno + "', '"
                        + strAssetsno + "', '" + strFilldate + "', '" + strFaultphenomenon + "', '"
                        + strDiagnosisresults + "', '" + strSolution + "', '"
                        + strDiagnosisdept + "', '" + strDiagnosispeople + "', '"
                        + strNo1 + "', '" + strBrandmodel1 + "', '" + strNum1 + "', '" + strRemarks1 + "', '"
                        + strNo2 + "', '" + strBrandmodel2 + "', '" + strNum2 + "', '" + strRemarks2 + "', '"
                        + strNo3 + "', '" + strBrandmodel3 + "', '" + strNum3 + "', '" + strRemarks3 + "', '"
                        + strActor + "', 0, GETDATE())";

            }
            else if (strType == "Upd")
            {
                strSQL = @" UPDATE B02_BILL.FA3_ITAppraisal SET FA3_State = '" + strState
                       + "', FA3_Department = '" + strDepartment
                       + "', FA3_Name = '" + strDepartment
                       + "', FA3_DeviceNo = '" + strDeviceno
                       + "', FA3_Assetsno = '" + strAssetsno
                       + "', FA3_AssetsNo = '" + strFilldate
                       + "', FA3_FillDate = '" + strFilldate
                       + "', FA3_FaultPhenomenon = '" + strFaultphenomenon
                       + "', FA3_DiagnosisResults = '" + strDiagnosisresults
                       + "', FA3_Solution = '" + strSolution
                       + "', FA3_DiagnosisDept = '" + strDiagnosisdept
                       + "', FA3_DiagnosisPeople = '" + strDiagnosispeople
                       + "', FA3_No1 = '" + strNo1
                       + "', FA3_BrandModel1 = '" + strBrandmodel1
                       + "', FA3_Num1 = '" + strNum1
                       + "', FA3_Remarks1 = '" + strRemarks1
                       + "', FA3_No2 = '" + strNo2
                       + "', FA3_BrandModel2 = '" + strBrandmodel2
                       + "', FA3_Num2 = '" + strNum2
                       + "', FA3_Remarks2 = '" + strRemarks2
                       + "', FA3_No3 = '" + strNo3
                       + "', FA3_BrandModel3 = '" + strBrandmodel3
                       + "', FA3_Num3 = '" + strNum3
                       + "', FA3_Remarks3 = '" + strRemarks3
                       + "', FA3_LmUser = '" + strActor
                       + "', FA3_RgDt = GETDATE(), FA3_UptNo = ISNULL(FA3_UptNo, 0)+1 "
                       + " WHERE FA3_ID = '" + strID + "'";
            }
            return conn.Excute(strSQL);
        }
        #endregion



        #region 根据条件获取鉴定单数据集 条件-分页-排序等
        /// <summary>
        /// 根据条件获取鉴定单数据集 条件-分页-排序等
        /// </summary>
        /// <returns></returns>
        public DataSet GetITAppraisalList(Dbconn conn, String strType)
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
            strSQL = @" SELECT FA3_ID, FA3_CONO, FA3_DIVI, FA3_State, FA3_Department, FA3_Name, FA3_DeviceNo, FA3_AssetsNo, 
                      CONVERT(VARCHAR(10),FA3_FillDate,120) FA3_FillDate, FA3_FaultPhenomenon, 
                      FA3_DiagnosisResults, FA3_Solution, FA3_DiagnosisDept, FA3_DiagnosisPeople, FA3_Audit, 
                      CONVERT(VARCHAR(10),FA3_AuditDate,120) FA3_AuditDate, FA3_BrandModel1, FA3_No1, FA3_Num1, 
                      FA3_Remarks1, FA3_BrandModel2, FA3_No2, FA3_Num2, FA3_Remarks2, FA3_BrandModel3, FA3_No3, 
                      FA3_Num3, FA3_Remarks3, CONVERT(VARCHAR(20),FA3_RgDt,120) FA3_RgDt, FA3_RgUser, 
                      CONVERT(VARCHAR(20),FA3_LmDt,120) FA3_LmDt, FA3_LmUser, FA3_UptNo, FA3_RefID
                      FROM B02_BILL.FA3_ITAppraisal WHERE 1=1 " + strCons;
            ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy); 
            return ds;
        }
        #endregion
        
    }     
}