using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;

/// 类名：GL_ERP_ArrivalPlan_EditByXML 
/// 类说明：到货计划增删改查
/// 创建人：钱超
/// 创建日期：2013-08-02
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{
    /// <summary>
    /// 根据XML内容更新到货计划
    /// </summary>
    public class GL_ERP_ArrivalPlan_EditByXML : LogicBase, ILogicGetData
    {
        public GL_ERP_ArrivalPlan_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容更新到货计划
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
                    string strWHERE = "isnull(PRA_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = @" SELECT 
                                [PRA_CONO]
                               ,[PRA_DIVI]
                               ,[PRA_ArrivalPlanId]
                               ,[PRA_ArrivalPlanCode]
                               ,[PRA_PR1_OrderId]
                               ,[PRA_PerchaseTotal]
                               ,[PRA_ArrivalTotal]
                               ,[PRA_PlanTotal]
                               ,[PRA_PerchaseAmount]
                               ,[PRA_ArrivalAmount]
                               ,[PRA_PlanAmount]
                               ,[PRA_TotalDiff]
                               ,[PRA_AmountDiff]
                               ,[PRA_Status]
                               ,[PRA_RgUser]
                               ,[PRA_RgDt]
                               ,[PRA_LmUser]
                               ,[PRA_LmDt]
                               ,[PRA_UptNo]
                               ,A.PR1_OrderCode
                               FROM B02_Bill.PRA_ArrivalPlan
                               LEFT JOIN B02_Bill.PR1_Order A ON PRA_PR1_OrderId=PR1_OrderId                           
                               WHERE " + strWHERE;
                    ds_Return = conn.GetDataSet(strSQL);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("B02_Bill.PRA_ArrivalPlan");
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
                                strSQL = @"UPDATE B02_Bill.PRA_ArrivalPlan SET PRA_Status='E3CA9B7A-8E17-4E52-B667-39689445D4A1' 
                               WHERE PRA_ArrivalPlanId='" + ds.Tables["LIST"].Rows[i]["PRA_ArrivalPlanId"].ToString() + @"'
                                AND isnull(PRA_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' 
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

                                strSQL = @"SELECT * FROM B02_Bill.PRA_ArrivalPlan WHERE  PRA_ArrivalPlanId=@param0
                                AND isnull(PRA_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                                 ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["PRA_ArrivalPlanId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {
                                    //处理结果
                                    if (ds.Tables["LIST"].Rows[i]["PRA_LmUser"].ToString() != "")
                                    {
                                        string strCode = dt_SR.Rows[0]["PRA_UptNo"].ToString();
                                        if (strCode == "0")
                                        {
                                            strCode = Convert.ToInt32(strCode) + 1.ToString();
                                        }
                                        else
                                        {
                                            strCode = "0";
                                        }

                                        if (!dt.Columns.Contains("PRA_LmDt"))
                                        {
                                            dt.Columns.Add("PRA_LmDt");
                                        }


                                        if (!dt.Columns.Contains("PRA_UptNo"))
                                        {
                                            dt.Columns.Add("PRA_UptNo");
                                        }

                                       // if (!dt.Columns.Contains("PRA_Status"))
                                       // {
                                       //     dt.Columns.Add("PRA_Status");
                                       // }

                                       // dt.Rows[0]["PRA_Status"] = '0';
                                        dt.Rows[0]["PRA_LmDt"] = DateTime.Now;
                                        dt.Rows[0]["PRA_UptNo"] = strCode;
                                    }

                                    conn.Update("B02_Bill.PRA_ArrivalPlan", dt, "PRA_ArrivalPlanId='" + ds.Tables["LIST"].Rows[i]["PRA_ArrivalPlanId"].ToString() + @"'");

                  
                                    }            

                                else  //add
                                {

                                    string PRA_ArrivalPlanId = Guid.NewGuid().ToString();


                                    if (!dt.Columns.Contains("PRA_ArrivalPlanId"))
                                    {
                                        dt.Columns.Add("PRA_ArrivalPlanId");
                                    }

                                  //  if (!dt.Columns.Contains("PRA_Status"))
                                  //  {
                                  //      dt.Columns.Add("PRA_Status");
                                  //  }


                                    if (!dt.Columns.Contains("PRA_RgDt"))
                                    {
                                        dt.Columns.Add("PRA_RgDt");
                                    }

                                    if (!dt.Columns.Contains("PRA_LmDt"))
                                    {
                                        dt.Columns.Add("PRA_LmDt");
                                    }

                                    if (!dt.Columns.Contains("PRA_UptNo"))
                                    {
                                        dt.Columns.Add("PRA_UptNo");
                                    }


                                    dt.Rows[0]["PRA_ArrivalPlanId"] = PRA_ArrivalPlanId;

                                    dt.Rows[0]["PRA_RgDt"] = DateTime.Now;
                                    dt.Rows[0]["PRA_LmDt"] = DateTime.Now;
                                    dt.Rows[0]["PRA_UptNo"] = '0';
                                  //  dt.Rows[0]["PRA_Status"] = '0';

                                    conn.Insert("B02_Bill.PRA_ArrivalPlan", dt);


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