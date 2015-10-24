using System;
using System.Collections.Generic;
using System.Web;
using System.Data;

using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：GL_ERP_PayApply_EditByXML 
/// 类说明：付款申请单增删改查
/// 创建人：钱超
/// 创建日期：2013-07-05
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{
    /// <summary>  
    /// 根据XML内容更新付款申请单
    /// </summary>
    public class GL_ERP_PayApply_EditByXML : LogicBase, ILogicGetData
    {
        private object FNP_CONO;
        public GL_ERP_PayApply_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容更新付款申请单
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();
                DataSet dsRequest = new DataSet();

                ArrayList listAMSendList = new ArrayList();

                Dbconn conn = new Dbconn("GL_ERP");

                string strXML = "";
                string strSQL = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                //XML是前台传入
                ds = Common.Common.GetDSByExcelXML(strXML);

                if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "GET")
                //读取ROWS到/ROWS 中的参数
                {
                    string strWHERE = "ISNULL(FNP_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = @"SELECT 
                               [FNP_CONO]
                              ,[FNP_DIVI]
                              ,[FNP_PayApplyId]
                              ,[FNP_PayApplyCode]
                              ,[FNP_PR0_ContractId]
                              ,[FNP_SU0_SupplierId]
                              ,[FNP_Type]
                              ,[FNP_BankReceipt]
                              ,[FNP_Status]
                              ,[FNP_RgUser]
                              ,[FNP_RgDt]
                              ,[FNP_LmUser]
                              ,[FNP_LmDt]
                              ,[FNP_UptNo]
                              ,A.PR0_ContractCode
                              ,B.SU0_SupplierCode 
                              ,C.DC0_DICTNAME1 AS  TypeDictName                              
                              ,D.WFT_NODE AS WFT_NODE1
                              ,E.WFT_NODE AS WFT_NODE2
                              ,F.WFT_NODE AS WFT_NODE3
                              ,G.WFT_NODE AS WFT_NODE4

                              ,N.DC0_DICTNAME1 AS DC0_DICTNAME1
                              ,O.DC0_DICTNAME1 AS DC0_DICTNAME2
                              ,P.DC0_DICTNAME1 AS DC0_DICTNAME3
                              ,Q.DC0_DICTNAME1 AS DC0_DICTNAME4

                              ,I.WFP_AuditTime AS WFP_AuditTime1
                              ,J.WFP_AuditTime AS WFP_AuditTime2 
                              ,K.WFP_AuditTime AS WFP_AuditTime3
                              ,L.WFP_AuditTime AS WFP_AuditTime4
                              ,R.[DC0_DictName1] AS StatusDictName
                              FROM  B02_Bill.FNP_PayApply
                              LEFT JOIN  B02_Bill.PR0_Contract A       ON    FNP_PR0_ContractId=A.PR0_ContractId
                              LEFT JOIN  B01_MDM.SU0_Supplier  B       ON    FNP_SU0_SupplierId=B.SU0_SupplierId   
                              LEFT JOIN  M01_CONF.DC0_Dictionary C     ON    FNP_Type=C.DC0_DictId     
                              LEFT JOIN  M02_BPM.WFT_AuditFlowDefine D ON    D.WFT_Type='PayApply' and D.WFT_Step='1'
                              LEFT JOIN  M02_BPM.WFT_AuditFlowDefine E ON    E.WFT_Type='PayApply' and E.WFT_Step='2'
                              LEFT JOIN  M02_BPM.WFT_AuditFlowDefine F ON    F.WFT_Type='PayApply' and F.WFT_Step='3'
                              LEFT JOIN  M02_BPM.WFT_AuditFlowDefine G ON    G.WFT_Type='PayApply' and G.WFT_Step='4'

                              LEFT JOIN  M02_BPM.WFP_AuditFlow I       ON    FNP_PayApplyId=I.WFP_BillId AND I.WFP_WFT_AFDId=D.WFT_AFDId
                              LEFT JOIN  M02_BPM.WFP_AuditFlow J       ON    FNP_PayApplyId=J.WFP_BillId AND J.WFP_WFT_AFDId=E.WFT_AFDId
                              LEFT JOIN  M02_BPM.WFP_AuditFlow K       ON    FNP_PayApplyId=K.WFP_BillId AND K.WFP_WFT_AFDId=F.WFT_AFDId
                              LEFT JOIN  M02_BPM.WFP_AuditFlow L       ON    FNP_PayApplyId=L.WFP_BillId AND L.WFP_WFT_AFDId=G.WFT_AFDId

                              LEFT JOIN  M01_CONF.DC0_Dictionary N     ON    I.WFP_AFResultId=N.DC0_DictId 
                              LEFT JOIN  M01_CONF.DC0_Dictionary O     ON    J.WFP_AFResultId=O.DC0_DictId
                              LEFT JOIN  M01_CONF.DC0_Dictionary P     ON    K.WFP_AFResultId=P.DC0_DictId
                              LEFT JOIN  M01_CONF.DC0_Dictionary Q     ON    L.WFP_AFResultId=Q.DC0_DictId
                              LEFT JOIN  M01_CONF.DC0_Dictionary R     ON    FNP_Status=R.DC0_DictId   
                                WHERE " + strWHERE;
                    ds_Return = conn.GetDataSet(strSQL);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("B02_Bill.FNP_PayApply");
                    conn.BeginTransaction();
                    //开启事物
                    conn.TableLock(tableList);
                    //锁表
                    try
                    {
                        if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "DELETE")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                strSQL = @"UPDATE B02_Bill.FNP_PayApply SET FNP_Status='E3CA9B7A-8E17-4E52-B667-39689445D4A1' 
                               WHERE FNP_PayApplyId='" + ds.Tables["LIST"].Rows[i]["FNP_PayApplyId"].ToString() + @"'
                                AND ISNULL(FNP_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' ";
                                conn.ExcuteQuerryByTran(strSQL);
                            }

                        }
                        else if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "EDIT")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                DataTable dt = ds.Tables["LIST"].Clone();
                                dt.ImportRow(ds.Tables["LIST"].Rows[i]);

                                strSQL = @"SELECT * FROM B02_Bill.FNP_PayApply WHERE  FNP_PayApplyId=@param0
                                AND ISNULL(FNP_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["FNP_PayApplyId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {
                                    //处理结果

                                strSQL = @"SELECT * FROM M02_BPM.WFP_AuditFlow  WHERE  WFP_BillId=@param0
                                         AND  WFP_AFResultId<>'' AND ISNULL(WFP_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                                             ";

                                DataTable dt_PA = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["FNP_PayApplyId"].ToString() });
                                //update
                                if (dt_PA.Rows.Count > 0)
                                    {
                                        throw new Exception("付款申请单已审核，不能进行修改！");         
                                    }
                                    else
                                        if (ds.Tables["LIST"].Rows[i]["FNP_LmUser"].ToString() != "")
                                        {
                                            string strCode = dt_SR.Rows[0]["FNP_UptNo"].ToString();
                                            if (strCode == "0")
                                            {
                                                strCode = Convert.ToInt32(strCode) + 1.ToString();
                                            }
                                            else
                                            {
                                                strCode = "0";
                                            }

                                            if (!dt.Columns.Contains("FNP_LmDt"))
                                            {
                                                dt.Columns.Add("FNP_LmDt");
                                            }
                                          //  if (!dt.Columns.Contains("FNP_Status"))
                                          //  {
                                          //      dt.Columns.Add("FNP_Status");
                                          //  }

                                            if (!dt.Columns.Contains("FNP_UptNo"))
                                            {
                                                dt.Columns.Add("FNP_UptNo");
                                            }

                                          //  dt.Rows[0]["FNP_Status"] = '0';
                                            dt.Rows[0]["FNP_LmDt"] = DateTime.Now;
                                            dt.Rows[0]["FNP_UptNo"] = strCode;
                                        }

                                    conn.Update("B02_Bill.FNP_PayApply", dt, "FNP_PayApplyId='" + ds.Tables["LIST"].Rows[i]["FNP_PayApplyId"].ToString() + @"'");

                                }
                                else  //add
                                {


                                    string FNP_PayApplyId = Guid.NewGuid().ToString();


                                    if (!dt.Columns.Contains("FNP_PayApplyId"))
                                    {
                                        dt.Columns.Add("FNP_PayApplyId");
                                    }

                               //    if (!dt.Columns.Contains("FNP_Status"))
                                  //  {
                                  //      dt.Columns.Add("FNP_Status");
                                 //   }

                                    if (!dt.Columns.Contains("FNP_RgDt"))
                                    {
                                        dt.Columns.Add("FNP_RgDt");
                                    }

                                    if (!dt.Columns.Contains("FNP_LmDt"))
                                    {
                                        dt.Columns.Add("FNP_LmDt");
                                    }
                
                                    if (!dt.Columns.Contains("FNP_UptNo"))
                                    {
                                        dt.Columns.Add("FNP_UptNo");
                                    }


                                    dt.Rows[0]["FNP_PayApplyId"] = FNP_PayApplyId;
                                   // dt.Rows[0]["FNP_Status"] = '0';
                                    dt.Rows[0]["FNP_RgDt"] = DateTime.Now;
                                    dt.Rows[0]["FNP_LmDt"] = DateTime.Now;
                                    dt.Rows[0]["FNP_UptNo"] = '0';
                                    conn.Insert("B02_Bill.FNP_PayApply", dt);


                                    GL_ERP_Common.CreateWorkFlow(conn, "PayApply", ds.Tables["LIST"].Rows[i]["FNP_CONO"].ToString(), ds.Tables["LIST"].Rows[i]["FNP_DIVI"].ToString(), FNP_PayApplyId,
                                     "PayApply", "", "", ds.Tables["LIST"].Rows[i]["FNP_Status"].ToString(), ds.Tables["LIST"].Rows[i]["FNP_RgUser"].ToString(),
                                     ds.Tables["LIST"].Rows[i]["FNP_LmUser"].ToString(), "", "FNP_PayApplyId", "B02_Bill.FNP_PayApply");
          
                                }

                            }
                        }
                        conn.CommitTransaction();



                        ds_Return = Common.Common.GetRequestDataSet(new string[] { "Result" }, new string[] { "true" });
                    }
                    catch
                    {
                        conn.RollbackTransaction();
                        //事物结束
                        throw;
                    }
                }
                return ds_Return;
            }
            catch
            {
                throw;
            }

        }

        private string RIGHT(string p, int p_2)
        {
            throw new NotImplementedException();
        }

        private string left(string p, int p_2)
        {
            throw new NotImplementedException();
        }






        private object fNP_DIVI;

        public object FNP_DIVI
        {
            get { return fNP_DIVI; }
            set { fNP_DIVI = value; }
        }

        private object fNP_Status;

        public object FNP_Status
        {
            get { return fNP_Status; }
            set { fNP_Status = value; }
        }

        private object fNP_RgUser;

        public object FNP_RgUser
        {
            get { return fNP_RgUser; }
            set { fNP_RgUser = value; }
        }

        private object fNP_LmUser;

        public object FNP_LmUser
        {
            get { return fNP_LmUser; }
            set { fNP_LmUser = value; }
        }
    }

}