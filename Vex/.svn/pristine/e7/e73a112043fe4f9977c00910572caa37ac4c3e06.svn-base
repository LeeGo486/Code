using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：GL_ERP_AuditFlow_EditByXML 
/// 类说明：审批流增删改查
/// 创建人：钱超
/// 创建日期：2013-07-29
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{
    /// <summary>
    /// 根据XML内容更新审批流
    /// </summary>
    public class GL_ERP_AuditFlow_EditByXML : LogicBase, ILogicGetData
    {
        public GL_ERP_AuditFlow_EditByXML()
        {
            this.m_SessionCheck = false;

        }


        private bool m_DataByXML = true;
        private Dbconn m_Conn = null;

        public bool DataByXML
        {
            get { return m_DataByXML; }
            set { m_DataByXML = value; }
        }

        public Dbconn Conn
        {
            get { return m_Conn; }
            set { m_Conn = value; }
        }

        /// <summary>
        /// 根据XML内容更新审批流
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

                Dbconn conn = null;


                
                string strXML = "";
                string strSQL = "";

                if (m_DataByXML == true)
                {
                    strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                    //XML是前台传入
                    ds = Common.Common.GetDSByExcelXML(strXML);
                    conn = new Dbconn("GL_ERP");
                }
                else
                {
                    ds = m_request;
                    conn = m_Conn;
                }

                if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "GET")
                //读取ROWS到/ROWS 中的参数
                {
                    string strWHERE = "isnull(WFP_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = @" SELECT [WFP_CONO]
                                      ,[WFP_DIVI]
                                      ,[WFP_AFID]
                                      ,[WFP_WFT_AFDId]
                                      ,[WFP_BillId]
                                      ,[WFP_BillTypeId]
                                      ,[WFP_AFResultId]
                                      ,[WFP_AUDITTIME]
                                      ,[WFP_Status]
                                      ,[WFP_Describe]
                                      ,[WFP_RgUser]
                                      ,[WFP_RgDt]
                                      ,[WFP_LmUser]
                                      ,[WFP_LmDT] 
                                      ,[WFP_UptNo]
                                      ,B.WFT_Node
                                FROM M02_BPM.WFP_AuditFlow  WITH ( NOLOCK )    
                                LEFT JOIN M02_BPM.WFT_AuditFlowDefine B ON WFP_WFT_AFDId=B.WFT_AFDId                                            
                                WHERE " + strWHERE;
                    ds_Return = conn.GetDataSet(strSQL);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("M02_BPM.WFP_AuditFlow");


                    if (DataByXML == true)
                    {
                        conn.BeginTransaction();
                        conn.TableLock(tableList);
                    }
                     
                    //开启事物
                    conn.TableLock(tableList);
                    //锁表
                    try
                    {
                        if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "DELETE")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                strSQL = @"UPDATE  FROM M02_BPM.WFP_AuditFlow  SET WFP_Status='E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                                WHERE WFT_AFDId='" + ds.Tables["LIST"].Rows[i]["WFT_AFDId"].ToString() + @"'
                                AND isnull(WFP_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
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

                                strSQL = @"SELECT * FROM M02_BPM.WFP_AuditFlow   WHERE  WFP_BillId=@param0
                                AND isnull(WFP_Status,'') <>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                                 ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["WFP_BillId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {
                                    //处理结果
                                    if (ds.Tables["LIST"].Rows[i]["WFP_LmUser"].ToString() != "")
                                    {
                                        string strCode = dt_SR.Rows[0]["WFP_UptNo"].ToString();
                                        if (strCode == "0")
                                        {
                                            strCode = Convert.ToInt32(strCode) + 1.ToString();
                                        }
                                        else
                                        {
                                            strCode = "0";
                                        }

                                        if (!dt.Columns.Contains("WFP_LmDT"))
                                        {
                                            dt.Columns.Add("WFP_LmDT");
                                        }

                                     //   if (!dt.Columns.Contains("WFP_AuditTime"))
                                     //   {
                                     //       dt.Columns.Add("WFP_AuditTime");
                                     //   }

                                        if (!dt.Columns.Contains("WFP_UptNo"))
                                        {
                                            dt.Columns.Add("WFP_UptNo");
                                        }


                                        dt.Rows[0]["WFP_LmDT"] = DateTime.Now;
                                      //  dt.Rows[0]["WFP_AuditTime"] = DateTime.Now;  
                                        dt.Rows[0]["WFP_UptNo"] = strCode;
                                    }
                                  
                                    conn.Update("M02_BPM.WFP_AuditFlow", dt, "WFP_AFID='" + ds.Tables["LIST"].Rows[i]["WFP_AFID"].ToString() + @"'");

                                }

                                else  //add
                                {

                              
                                     
                                        strSQL = @" INSERT INTO GL_ERP.M02_BPM.WFP_AuditFlow(WFP_CONO,WFP_DIVI
                                               ,WFP_AFID,WFP_WFT_AFDId,WFP_BillId,WFP_BillTypeId,WFP_AFResultId,WFP_Status,WFP_Describe,WFP_RgUser
                                               ,WFP_RgDt,WFP_LmUser,WFP_LmDT ,WFP_UptNo,WFP_AUDITTIME)
                                                SELECT '" + ds.Tables["LIST"].Rows[i]["WFP_CONO"].ToString() + @"','" + ds.Tables["LIST"].Rows[i]["WFP_DIVI"].ToString() + @"',
                                                newID(),WFT_AFDId,'" + ds.Tables["LIST"].Rows[i]["WFP_BillId"].ToString() + @"','" + ds.Tables["LIST"].Rows[i]["WFP_BillTypeId"].ToString() + @"',
                                                '" + ds.Tables["LIST"].Rows[i]["WFP_AFResultId"].ToString() + @"','" + ds.Tables["LIST"].Rows[i]["WFP_Status"].ToString() + @"',
                                                '" + ds.Tables["LIST"].Rows[i]["WFP_Describe"].ToString() + @"','" + ds.Tables["LIST"].Rows[i]["WFP_RgUser"].ToString() + @"',
                                                CONVERT(VARCHAR(100),GETDATE(),121),'" + ds.Tables["LIST"].Rows[i]["WFP_LmUser"].ToString() + @"', CONVERT(VARCHAR(100),GETDATE(),121),
                                                '0','" + ds.Tables["LIST"].Rows[i]["WFP_AUDITTIME"].ToString() + @"' 
                                                FROM " + ds.Tables["LIST"].Rows[i]["WFP_TableName"].ToString() + @"
                                                LEFT JOIN M02_BPM.WFT_AuditFlowDefine ON WFT_Type='" + ds.Tables["LIST"].Rows[i]["WFT_Type"].ToString() + @"'
                                                WHERE " + ds.Tables["LIST"].Rows[i]["WFP_BillIdValue"].ToString() + @"='" + ds.Tables["LIST"].Rows[i]["WFP_BillId"].ToString() + @"'
                                             ";
                                        dt.Columns.Remove("WFT_Type"); 
                                        conn.ExcuteQuerryByTran(strSQL);
                                    
                                   

                                 //   string WFT_AFDId = Guid.NewGuid().ToString();


                                 //   if (!dt.Columns.Contains("WFT_AFDId"))
                                 //   {
                                 //       dt.Columns.Add("WFT_AFDId");
                                 //   }


                                 //   if (!dt.Columns.Contains("WFT_RgDt"))
                                 //   {
                                 //       dt.Columns.Add("WFT_RgDt");
                                 //   }

                                 //   if (!dt.Columns.Contains("WFT_LmDt"))
                                 //   {
                                 //       dt.Columns.Add("WFT_LmDt");
                                 //   }

                                 //   if (!dt.Columns.Contains("WFT_UptNo"))
                                 //   {
                                 //       dt.Columns.Add("WFT_UptNo");
                                 //   }


                                 //   dt.Rows[0]["WFT_AFDId"] = WFT_AFDId;
                                 //   dt.Rows[0]["WFT_RgDt"] = DateTime.Now;
                                 //   dt.Rows[0]["WFT_LmDt"] = DateTime.Now;
                                 //   dt.Rows[0]["WFT_UptNo"] = '0';

                                 // //  sqlBC.DestinationTableName = "GL_ERP.M02_BPM.WFT_AuditFlowDefine";
                                 ////   sqlBC.ColumnMappings.Add("GL_ERP.M02_BPM.WFT_AuditFlowDefine", dt);
                                  
                                 //   conn.Insert("GL_ERP.M02_BPM.WFT_AuditFlowDefine", dt);

                                    //for (int i = 0; i < listMenu.Count; i++)
                                    //{
                                    //    DataTable dt = m_request.Tables[0].Clone();
                                    //    DataRow dr = dt.NewRow();
                                    //    dr["Menu_ID"] = listMenu[i];
                                    //    dr["Authorization_ID"] = strAuthorization_ID;
                                    //    dr["HavaFlag"] = 1;
                                    //    dt.Rows.Add(dr);

                                    //    conn.Insert("MDM_System_Menu_AUZ", dt);
                                    //}
                          


                                }

                            }
                        }

                        if (DataByXML == true)
                        {
                            conn.CommitTransaction();
                        }


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





    }

}