using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：GL_ERP_Contract_EditByXML 
/// 类说明：合同增删改查
/// 创建人：钱超
/// 创建日期：2013-07-05
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{ 
    /// <summary>  
    /// 根据XML内容更新合同
    /// </summary>
    public class GL_ERP_Contract_EditByXML : LogicBase, ILogicGetData
    {
        public GL_ERP_Contract_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容更新合同
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
                    string strWHERE = "ISNULL(PR0_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = @"SELECT  
                                     [PR0_CONO]
                                    ,[PR0_DIVI]
                                    ,[PR0_ContractId]
                                    ,[PR0_ContractCode]
                                    ,[PR0_SU0_SupplierId]
                                    ,CAST([PR0_Amount] AS DECIMAL(20,2)) as  PR0_Amount
                                    ,[PR0_CurrencyId]
                                    ,[PR0_Description]
                                    ,[PR0_Status]
                                    ,[PR0_ECopyPath]
                                    ,[PR0_PrePayRate]
                                    ,LEFT(CONVERT(VARCHAR(20),[PR0_StartDate],121),10) AS PR0_StartDate
                                    ,LEFT(CONVERT(VARCHAR(20),[PR0_EndDate],121),10) AS PR0_EndDate  
                                    ,[PR0_RgUser]
                                    ,[PR0_RgDt]
                                    ,[PR0_LmUser]
                                    ,[PR0_LmDt]
                                    ,[PR0_UptNo]
                                    ,[PR0_SettleAccount]
                                    ,[PR0_Total]
                                    ,A.[SU0_SupplierCode] as SU0_SupplierCode
                                    ,A.[SU0_SupplierName] as SU0_SupplierName
                                    ,B.WFT_NODE AS WFT_NODE1
                                    ,C.WFT_NODE AS WFT_NODE2
                                    ,D.WFT_NODE AS WFT_NODE3
                                    ,E.WFT_NODE AS WFT_NODE4
                                    ,F.WFT_NODE AS WFT_NODE5
                                    ,L.DC0_DICTNAME1 AS DC0_DICTNAME1
                                    ,M.DC0_DICTNAME1 AS DC0_DICTNAME2
                                    ,N.DC0_DICTNAME1 AS DC0_DICTNAME3
                                    ,O.DC0_DICTNAME1 AS DC0_DICTNAME4
                                    ,P.DC0_DICTNAME1 AS DC0_DICTNAME5
                                    ,G.WFP_AuditTime AS WFP_AuditTime1
                                    ,H.WFP_AuditTime AS WFP_AuditTime2 
                                    ,I.WFP_AuditTime AS WFP_AuditTime3
                                    ,J.WFP_AuditTime AS WFP_AuditTime4
                                    ,K.WFP_AuditTime AS WFP_AuditTime5 
                                    ,G.WFP_AFID AS WFP_AFID1
                                    ,H.WFP_AFID AS WFP_AFID2 
                                    ,I.WFP_AFID AS WFP_AFID3
                                    ,J.WFP_AFID AS WFP_AFID4
                                    ,K.WFP_AFID AS WFP_AFID5  
                                    ,Q.[DC0_DictName1] AS CurrencyDictName
                                    ,R.[DC0_DictName1] AS StatusDictName
                                    ,S.[DC0_DictName1] AS AccountDictName
                                FROM   B02_Bill.PR0_Contract WITH ( NOLOCK )  
                                LEFT JOIN  B01_MDM.SU0_Supplier A        ON    PR0_SU0_SupplierId=A.SU0_SupplierId  
                                LEFT JOIN  M02_BPM.WFT_AuditFlowDefine B ON    B.WFT_Type='Contract' and B.WFT_Step='1'
                                LEFT JOIN  M02_BPM.WFT_AuditFlowDefine C ON    C.WFT_Type='Contract' and C.WFT_Step='2'
                                LEFT JOIN  M02_BPM.WFT_AuditFlowDefine D ON    D.WFT_Type='Contract' and D.WFT_Step='3'
                                LEFT JOIN  M02_BPM.WFT_AuditFlowDefine E ON    E.WFT_Type='Contract' and E.WFT_Step='4'
                                LEFT JOIN  M02_BPM.WFT_AuditFlowDefine F ON    F.WFT_Type='Contract' and F.WFT_Step='5'
                                LEFT JOIN  M02_BPM.WFP_AuditFlow G       ON    PR0_ContractId=G.WFP_BillId AND G.WFP_WFT_AFDId=B.WFT_AFDId
                                LEFT JOIN  M02_BPM.WFP_AuditFlow H       ON    PR0_ContractId=H.WFP_BillId AND H.WFP_WFT_AFDId=C.WFT_AFDId
                                LEFT JOIN  M02_BPM.WFP_AuditFlow I       ON    PR0_ContractId=I.WFP_BillId AND I.WFP_WFT_AFDId=D.WFT_AFDId
                                LEFT JOIN  M02_BPM.WFP_AuditFlow J       ON    PR0_ContractId=J.WFP_BillId AND J.WFP_WFT_AFDId=E.WFT_AFDId
                                LEFT JOIN  M02_BPM.WFP_AuditFlow K       ON    PR0_ContractId=K.WFP_BillId AND K.WFP_WFT_AFDId=F.WFT_AFDId
                                LEFT JOIN  M01_CONF.DC0_Dictionary L     ON    G.WFP_AFResultId=L.DC0_DictId 
                                LEFT JOIN  M01_CONF.DC0_Dictionary M     ON    H.WFP_AFResultId=M.DC0_DictId
                                LEFT JOIN  M01_CONF.DC0_Dictionary N     ON    I.WFP_AFResultId=N.DC0_DictId
                                LEFT JOIN  M01_CONF.DC0_Dictionary O     ON    J.WFP_AFResultId=O.DC0_DictId
                                LEFT JOIN  M01_CONF.DC0_Dictionary P     ON    K.WFP_AFResultId=P.DC0_DictId                             
                                LEFT JOIN  M01_CONF.DC0_Dictionary Q     ON    PR0_CurrencyId=Q.DC0_DictId   
                                LEFT JOIN  M01_CONF.DC0_Dictionary R     ON    PR0_Status=R.DC0_DictId  
                                LEFT JOIN  M01_CONF.DC0_Dictionary S     ON    PR0_SettleAccount=S.DC0_DictId   
                                WHERE " + strWHERE
                                + @"ORDER BY [PR0_LmDt] DESC "; 
                    ds_Return = conn.GetDataSet(strSQL);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("B02_Bill.PR0_Contract");
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
                                strSQL = @"UPDATE B02_Bill.PR0_Contract SET PR0_Status='E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                               WHERE PR0_ContractId='" + ds.Tables["LIST"].Rows[i]["PR0_ContractId"].ToString() + @"'
                                AND ISNULL(PR0_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                                  ";
                                conn.ExcuteQuerryByTran(strSQL);
                            }

                        }
                        else if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "EDIT")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                DataTable dt = ds.Tables["LIST"].Clone();
                                dt.ImportRow(ds.Tables["LIST"].Rows[i]);

                                strSQL = @"SELECT * FROM B02_Bill.PR0_Contract WHERE  PR0_ContractId=@param0
                                  AND ISNULL(PR0_Status,'') <>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["PR0_ContractId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {

                                    strSQL = @"SELECT * FROM M02_BPM.WFP_AuditFlow  WHERE  WFP_BillId=@param0
                                         AND  WFP_AFResultId<>''
                                             ";

                                    DataTable dt_CO = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["PR0_ContractId"].ToString() });
                                //update
                                 if (dt_CO.Rows.Count > 0)
                                 {
                                     throw new Exception("合同已审核，不能进行修改！");      
                                 }
                                 else

                                     //处理结果
                                     if (ds.Tables["LIST"].Rows[i]["PR0_LmUser"].ToString() != "")
                                     {
                                         string strCode = dt_SR.Rows[0]["PR0_UptNo"].ToString();
                                         if (strCode == "0")
                                         {
                                             strCode = Convert.ToInt32(strCode) + 1.ToString();
                                         }
                                         else
                                         {
                                             strCode = "0";
                                         }

                                         if (!dt.Columns.Contains("PR0_LmDt"))
                                         {
                                             dt.Columns.Add("PR0_LmDt");
                                         }
                                        // if (!dt.Columns.Contains("PR0_Status"))
                                        // {
                                       //      dt.Columns.Add("PR0_Status");
                                       //  }

                                         if (!dt.Columns.Contains("PR0_UptNo"))
                                         {
                                             dt.Columns.Add("PR0_UptNo");
                                         }

                                        // dt.Rows[0]["PR0_Status"] = '0';
                                         dt.Rows[0]["PR0_LmDt"] = DateTime.Now;
                                         dt.Rows[0]["PR0_UptNo"] = strCode;
                                     }

                                 conn.Update("B02_Bill.PR0_Contract", dt, "PR0_ContractId='" + ds.Tables["LIST"].Rows[i]["PR0_ContractId"].ToString() + @"'");

                                }
                                else  //add
                                {


                                    DataTable dtTemp = conn.GetDataTableInTrans(
                                    @"SELECT  ISNULL(MAX(PR0_ContractCode),'')  AS MaxCode,
                                      RIGHT(left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)+'-'+
                                      LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2) as PreCode FROM B02_Bill.PR0_Contract where 
                                      left(PR0_ContractCode,'2')=RIGHT(left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
                                      AND left(right(PR0_ContractCode,'4'),'2')=LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2) ");
                                    //供应商编号生成
                                    string strCode = dtTemp.Rows[0]["MaxCode"].ToString();
                                    if (strCode == "")
                                    {
                                        strCode = dtTemp.Rows[0]["PreCode"].ToString() + "01";
                                      //  strCode = strCode.Substring(strCode.Substring(DateTime.Now.ToString().Length + 4).Length + 4)
                                            
                                       //     RIGHT(left(DateTime.Now.ToString(), 4), 2) + "-" + RIGHT(left(DateTime.Now.ToString(), 7), 2) + "01";
                                        //dtTemp.Rows[0]["PreCode"].ToString() + "0001";
                                    }
                                    else
                                    {
                                        strCode = dtTemp.Rows[0]["PreCode"].ToString() + (Convert.ToInt32(strCode.Substring(strCode.Length - 2)) + 1).ToString("00"); 
                                        //strCode = left(strCode, 2) + "-" + left(RIGHT(strCode, 4), 2) + (Convert.ToInt32(strCode.Substring(strCode.Length - 2)) + 1).ToString("00"); 
                                          //  dtTemp.Rows[0]["PreCode"].ToString() + (Convert.ToInt32(strCode.Substring(strCode.Length - 4)) + 1).ToString("0000");
                                    }


                                    string PR0_ContractId = Guid.NewGuid().ToString();


                                    if (!dt.Columns.Contains("PR0_ContractId"))
                                    {
                                        dt.Columns.Add("PR0_ContractId");
                                    }

                                  //  if (!dt.Columns.Contains("PR0_Status"))
                                   // {
                                   //     dt.Columns.Add("PR0_Status");
                                 //   }

                                    if (!dt.Columns.Contains("PR0_RgDt"))
                                    {
                                        dt.Columns.Add("PR0_RgDt");
                                    }

                                    if (!dt.Columns.Contains("PR0_LmDt"))
                                    {
                                        dt.Columns.Add("PR0_LmDt");
                                    }

                                    if (!dt.Columns.Contains("PR0_ContractCode"))
                                    {
                                        dt.Columns.Add("PR0_ContractCode");
                                    }

                                    if (!dt.Columns.Contains("PR0_UptNo"))
                                    {
                                        dt.Columns.Add("PR0_UptNo");
                                    }


                                    dt.Rows[0]["PR0_ContractId"] = PR0_ContractId;
                                 //   dt.Rows[0]["PR0_Status"] = '0';
                                    dt.Rows[0]["PR0_RgDt"] = DateTime.Now;
                                    dt.Rows[0]["PR0_LmDt"] = DateTime.Now;
                                    dt.Rows[0]["PR0_ContractCode"] = strCode;
                                    dt.Rows[0]["PR0_UptNo"] = '0';
                                    conn.Insert("B02_Bill.PR0_Contract", dt); 

                                    GL_ERP_Common clsCommon = new GL_ERP_Common();

                                    GL_ERP_Common.CreateWorkFlow(conn, "Contract", ds.Tables["LIST"].Rows[i]["PR0_CONO"].ToString(), ds.Tables["LIST"].Rows[i]["PR0_DIVI"].ToString(), PR0_ContractId,
                                     "Contract", "", "", ds.Tables["LIST"].Rows[i]["PR0_Status"].ToString(), ds.Tables["LIST"].Rows[i]["PR0_RgUser"].ToString(),
                                     ds.Tables["LIST"].Rows[i]["PR0_LmUser"].ToString(), "", "PR0_ContractId", "B02_Bill.PR0_Contract");
          
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





        private object pR0_CONO;

        public object PR0_CONO
        {
            get { return pR0_CONO; }
            set { pR0_CONO = value; }
        }

        private object pR0_DIVI;

        public object PR0_DIVI
        {
            get { return pR0_DIVI; }
            set { pR0_DIVI = value; }
        }

        private object pR0_Status;

        public object PR0_Status
        {
            get { return pR0_Status; }
            set { pR0_Status = value; }
        }

        private object pR0_RgUser;

        public object PR0_RgUser
        {
            get { return pR0_RgUser; }
            set { pR0_RgUser = value; }
        }

        private object pR0_LmUser;

        public object PR0_LmUser
        {
            get { return pR0_LmUser; }
            set { pR0_LmUser = value; }
        }

        private string sSS;

        public string SSS
        {
            get { return sSS; }
            set { sSS = value; }
        }
    }

}