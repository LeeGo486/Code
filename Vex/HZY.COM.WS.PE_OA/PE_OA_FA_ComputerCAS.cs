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
    public class PE_OA_FA_ComputerCAS : LogicBase, ILogicGetData
    {

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        Dbconn conn = new Dbconn("PE_OA");

        #region 构造函数
        public PE_OA_FA_ComputerCAS()
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
                    ds = SetCCAS(conn, strType); 

                } 
                else if (strType == "GetHs")
                {
                    ds = GetCCASList(conn, strType);
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
        public DataSet SetCCAS(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString(); 
            //获取申购单主表数据
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strOPType = dsXML.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper();
            String strID = dsXML.Tables["LIST"].Rows[0]["fa4_id"].ToString();
            DataTable dt_List = dsXML.Tables["LIST"]; 
            if (strID == "")
            {
                throw new Exception("数据异常，缺少主键，请联系管理员！");
            }

            bool bResult = false;
            if (strType == "New") //新建单据
            { 
                conn.BeginTransaction();
                bResult = conn.Insert("[B02_BILL].[FA4_ComputerCAStandard]", dt_List);
                conn.CommitTransaction();
            }
            else if (strType == "Upd") //修改单据
            {
                conn.BeginTransaction();
                bResult = conn.Update("[B02_BILL].[FA4_ComputerCAStandard]", dt_List, "fa4_id='" + strID + "'");
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

         

        #region 根据条件获取鉴定单数据集 条件-分页-排序等
        /// <summary>
        /// 根据条件获取鉴定单数据集 条件-分页-排序等
        /// </summary>
        /// <returns></returns>
        public DataSet GetCCASList(Dbconn conn, String strType)
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
            strSQL = @" SELECT FA4_ID, FA4_CONO, FA4_DIVI, FA4_State, FA4_Department, FA4_Name, 
                      CONVERT(VARCHAR(10),FA4_FillDate,120) FA4_FillDate, FA4_DiagnosisPeople, 
                      FA4_NoteBook, FA4_Computer, FA4_DeviceNo, 
                      FA4_CPU, FA4_MEM, FA4_HD, FA4_BuyDate, FA4_OMoney, FA4_RMoney, FA4_OfficeWareBef1, 
                      FA4_OfficeWareBef2, FA4_OfficeWareBef3, FA4_OfficeWareBef4, 
                      FA4_OfficeWareBef5, FA4_OfficeWareBef6, FA4_OfficeWareBef7, FA4_OfficeWareBef8, 
                      FA4_UnOfficeWareBef1, FA4_UnOfficeWareBef2, FA4_UnOfficeWareBef3, 
                      FA4_UnOfficeWareBef4, FA4_UnOfficeWareBef5, FA4_UnOfficeWareBef6, FA4_UnOfficeWareBef7, 
                      FA4_UnOfficeWareBef8, FA4_OpenTimeBef1, FA4_OpenTimeBef2, 
                      FA4_OpenTimeBef3, FA4_OpenTimeBef4, FA4_OfficeWareAft1, FA4_OfficeWareAft2, 
                      FA4_OfficeWareAft3, FA4_OfficeWareAft4, FA4_OfficeWareAft5, 
                      FA4_OfficeWareAft6, FA4_OfficeWareAft7, FA4_OfficeWareAft8, FA4_UnOfficeWareAft1, 
                      FA4_UnOfficeWareAft2, FA4_UnOfficeWareAft3, FA4_UnOfficeWareAft4, 
                      FA4_UnOfficeWareAft5, FA4_UnOfficeWareAft6, FA4_UnOfficeWareAft7, FA4_UnOfficeWareAft8, 
                      FA4_OpenTimeAft1, FA4_OpenTimeAft2, FA4_OpenTimeAft3, 
                      FA4_OpenTimeAft4, FA4_CompreheEvaluation, FA4_SpecificRequire, FA4_Suggest, 
                      FA4_Audit, CONVERT(VARCHAR(10),FA4_AuditDate,120) FA4_AuditDate, 
                      CONVERT(VARCHAR(20),FA4_RgDt,120) FA4_RgDt, FA4_RgUser, 
                      CONVERT(VARCHAR(20),FA4_LmDt,120) FA4_LmDt, FA4_LmUser, FA4_UptNo, FA4_RefID 
                      FROM B02_BILL.FA4_ComputerCAStandard WHERE 1=1 " + strCons;
            ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy); 
            return ds;
        }
        #endregion
        
    }     
}