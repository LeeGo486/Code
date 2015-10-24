using System;
using System.Collections.Generic;
using System.Web;


using HZY.COM.Common;
using HZY.COM.DBAccess;
using System.Data;

/// 类名：GL_ERP_ArrivalPlan_EditByXML 
/// 类说明：到货计划增删改查
/// 创建人：钱超
/// 创建日期：2013-08-02
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{
    /// <summary>
    ///Common 的摘要说明
    /// </summary>
    public class GL_ERP_Common
    {
        public GL_ERP_Common()
        {
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }


        public static void CreateWorkFlow(Dbconn conn, string WFT_Type, string WFP_CONO,string WFP_DIVI,string WFP_BillId,
        string WFP_BillTypeId,string WFP_AFResultId,string WFP_Status,string WFP_Describe,string WFP_RgUser,
        string WFP_LmUser,string WFP_AUDITTIME,string WFP_BillIdValue,string WFP_TableName)
        {
            GL_ERP_AuditFlow_EditByXML cls = new GL_ERP_AuditFlow_EditByXML();
            cls.Conn = conn;
            cls.DataByXML = false;

            DataSet dsRequestFlow = new DataSet();

            DataTable dtFlowType = new DataTable("OPTYPE");

            dtFlowType.Columns.Add("OPTYPE");

            dtFlowType.Rows.Add(new object[] { "EDIT" });

            dsRequestFlow.Tables.Add(dtFlowType);

            DataTable dtFlowList = new DataTable("LIST");
            dtFlowList.Columns.Add("WFT_Type");
            dtFlowList.Columns.Add("WFP_CONO");
            dtFlowList.Columns.Add("WFP_DIVI");
            dtFlowList.Columns.Add("WFP_BillId");
            dtFlowList.Columns.Add("WFP_BillTypeId");
            dtFlowList.Columns.Add("WFP_AFResultId");
            dtFlowList.Columns.Add("WFP_Status");
            dtFlowList.Columns.Add("WFP_Describe");
            dtFlowList.Columns.Add("WFP_RgUser");
            dtFlowList.Columns.Add("WFP_LmUser");
            dtFlowList.Columns.Add("WFP_AUDITTIME");
            dtFlowList.Columns.Add("WFP_BillIdValue");
            dtFlowList.Columns.Add("WFP_TableName");

            DataRow drFlowList = dtFlowList.NewRow();
            drFlowList["WFT_Type"] = WFT_Type;
            drFlowList["WFP_CONO"] = WFP_CONO;
            drFlowList["WFP_DIVI"] = WFP_DIVI;
            drFlowList["WFP_BillId"] = WFP_BillId;
            drFlowList["WFP_BillTypeId"] = WFP_BillTypeId;
            drFlowList["WFP_AFResultId"] = WFP_AFResultId;
            drFlowList["WFP_Status"] = WFP_Status;
            drFlowList["WFP_Describe"] = WFP_Describe;
            drFlowList["WFP_RgUser"] = WFP_RgUser;
            drFlowList["WFP_LmUser"] = WFP_LmUser;   
            drFlowList["WFP_AUDITTIME"] = WFP_AUDITTIME;   
            drFlowList["WFP_BillIdValue"] = WFP_BillIdValue;  
            drFlowList["WFP_TableName"] = WFP_TableName;   

            dtFlowList.Rows.Add(drFlowList);

            dsRequestFlow.Tables.Add(dtFlowList);

            cls.Request = dsRequestFlow;

            cls.GetData();
        }




        internal static void CreateWorkFlow(Dbconn conn, string p, object PR0_CONO, object PR0_DIVI, string PR0_ContractId, string p_2, string p_3, string p_4, object PR0_Status, string p_5, object PR0_RgUser, object PR0_LmUser, string p_6)
        {
            throw new NotImplementedException();
        }
    }
}