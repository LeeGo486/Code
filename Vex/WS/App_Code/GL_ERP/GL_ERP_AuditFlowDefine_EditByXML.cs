using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：GL_ERP_AuditFlowDefine_EditByXML 
/// 类说明：审批流模版增删改查
/// 创建人：钱超
/// 创建日期：2013-07-05
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{
    /// <summary>
    /// 根据XML内容更新审批流模版
    /// </summary>
    public class GL_ERP_AuditFlowDefine_EditByXML : LogicBase, ILogicGetData
    {
        public GL_ERP_AuditFlowDefine_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容更新审批流模版
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
                    string strWHERE = "1=1";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = @" SELECT 
                                       [WFT_CONO]
                                      ,[WFT_DIVI]
                                      ,[WFT_AFDId]
                                      ,[WFT_Type]
                                      ,[WFT_Node]
                                      ,[WFT_Person]
                                      ,[WFT_Step]
                                      ,[WFT_IsMust]
                                      ,[WFT_RgUser]
                                      ,[WFT_RgDt]
                                      ,[WFT_LmUser]
                                      ,[WFT_LmDt]
                                      ,[WFT_UptNo]
                                FROM    GL_ERP.M02_BPM.WFT_AuditFlowDefine WITH ( NOLOCK )                                                
                                WHERE " + strWHERE;
                    ds_Return = conn.GetDataSet(strSQL);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("GL_ERP.M02_BPM.WFT_AuditFlowDefine");
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
                                strSQL = @"DELETE FROM GL_ERP.M02_BPM.WFT_AuditFlowDefine  
                                WHERE WFT_AFDId='" + ds.Tables["LIST"].Rows[i]["WFT_AFDId"].ToString() + @"'
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

                                strSQL = @"SELECT * FROM GL_ERP.M02_BPM.WFT_AuditFlowDefine WHERE  WFT_AFDId=@param0
                                 ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["WFT_AFDId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {
                                    //处理结果
                                    if (ds.Tables["LIST"].Rows[i]["WFT_LmUser"].ToString() != "")
                                    {
                                        string strCode = dt_SR.Rows[0]["WFT_UptNo"].ToString();
                                        if (strCode == "0")
                                        {
                                            strCode = Convert.ToInt32(strCode) + 1.ToString();
                                        }
                                        else
                                        {
                                            strCode = "0";
                                        }

                                        if (!dt.Columns.Contains("WFT_LmDt"))
                                        {
                                            dt.Columns.Add("WFT_LmDt");
                                        }


                                        if (!dt.Columns.Contains("WFT_UptNo"))
                                        {
                                            dt.Columns.Add("WFT_UptNo");
                                        }


                                        dt.Rows[0]["WFT_LmDt"] = DateTime.Now;
                                        dt.Rows[0]["WFT_UptNo"] = strCode;
                                    }

                                    conn.Update("GL_ERP.M02_BPM.WFT_AuditFlowDefine", dt, "WFT_AFDId='" + ds.Tables["LIST"].Rows[i]["WFT_AFDId"].ToString() + @"'");


                                }

                                else  //add
                                {

                                    string WFT_AFDId = Guid.NewGuid().ToString();


                                    if (!dt.Columns.Contains("WFT_AFDId"))
                                    {
                                        dt.Columns.Add("WFT_AFDId");
                                    }


                                    if (!dt.Columns.Contains("WFT_RgDt"))
                                    {
                                        dt.Columns.Add("WFT_RgDt");
                                    }

                                    if (!dt.Columns.Contains("WFT_LmDt"))
                                    {
                                        dt.Columns.Add("WFT_LmDt");
                                    }

                                    if (!dt.Columns.Contains("WFT_UptNo"))
                                    {
                                        dt.Columns.Add("WFT_UptNo");
                                    }


                                    dt.Rows[0]["WFT_AFDId"] = WFT_AFDId;
                                    dt.Rows[0]["WFT_RgDt"] = DateTime.Now;
                                    dt.Rows[0]["WFT_LmDt"] = DateTime.Now;
                                    dt.Rows[0]["WFT_UptNo"] = '0';



                                    conn.Insert("GL_ERP.M02_BPM.WFT_AuditFlowDefine", dt);


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





    }

}