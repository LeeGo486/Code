using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;

/// 类名：GL_ERP_ArrivalPlanDetail_EditByXML 
/// 类说明：到货计划字表增删改查
/// 创建人：钱超
/// 创建日期：2013-08-02
/// 修改人：
/// 修改日期： 
namespace HZY.COM.GL_ERP
{
    /// <summary>
    /// 根据XML内容更新到货计划字表
    /// </summary>
    public class GL_ERP_ArrivalPlanDetail_EditByXML : LogicBase, ILogicGetData
    {
        public GL_ERP_ArrivalPlanDetail_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容更新到货计划字表
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
                    string strWHERE = "isnull(PRAD_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'";
                    string strWHERE1 = "isnull(PRAD_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'"; 
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                         if (ds.Tables["LIST"].Rows[0]["Condition1"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE1 += " AND (" + ds.Tables["LIST"].Rows[0]["Condition1"].ToString().Trim() + ")";
                        }

                    }
                     
                    strSQL = @"SELECT * FROM B02_Bill.PRAD_ArrivalPlanDetail WHERE " + strWHERE;
                                
                       DataTable dt_SR = conn.GetDataTable(strSQL);

                        if (dt_SR.Rows.Count > 0)
                        {
                            strSQL = @"SELECT
                                       [PRAD_CONO]
                                      ,[PRAD_DIVI]
                                      ,[PRAD_ArrivalPlanDetailId]
                                      ,[PRAD_PRA_ArrivalPlanId]
                                      ,[PRAD_PD0_ProductId]
                                      ,[PRAD_UnitID]
                                      ,[PRAD_PR1D_OrderDetailId]
                                      ,[PRAD_ArrivalDate]
                                      ,[PRAD_PerchaseTotal]
                                      ,[PRAD_ArrivalTotal]
                                      ,[PRAD_PlanTotal]
                                      ,[PRAD_PlanArrival]
                                      ,[PRAD_PlanArrivalAmount]
                                      ,[PRAD_TotalDiff]
                                      ,[PRAD_Status]
                                      ,[PRAD_RgUser]
                                      ,[PRAD_RgDt]
                                      ,[PRAD_LmUser]
                                      ,[PRAD_LmDt]
                                      ,[PRAD_UptNo]
                             FROM  B02_Bill.PRAD_ArrivalPlanDetail 
                             WHERE " + strWHERE;
                        }
                         
                      else
                       {
                           strSQL = @"SELECT  
                                 [PRAD_CONO]
                                ,[PRAD_DIVI]      
                                ,'' AS [PRAD_ArrivalPlanDetailId]                                   
                                ,[PRA_ArrivalPlanId]
                                ,[PR1D_OrderDetailId] 
                                ,[PR1D_PD0_ProductId]                                                     
                                ,[PR1D_UnitID]
                                ,'' AS [PRAD_ArrivalDate]
                                ,ISNULL([PR1D_Total],'0') AS [PR1D_Total]
                                ,SUM(ISNULL(PRAD_PlanArrival,'0')) AS PRAD_PlanTotal
                                ,SUM(ISNULL([PRAD_ArrivalTotal],'0')) as PRAD_ArrivalTotal
                                ,'0' AS  [PRAD_PlanArrival] 
                                ,'0' AS  [PRAD_PlanArrivalAmount]
                                ,'0' as [PRAD_TotalDiff]
                                ,'' as [PRAD_Status]   
                                ,'' as [PRAD_RgUser]
                                ,'' as [PRAD_RgDt]
                                ,'' as [PRAD_LmUser]
                                ,'' as [PRAD_LmDt]
                                ,'0' as [PRAD_UptNo]
                            FROM  B02_Bill.PRA_ArrivalPlan 
                            LEFT JOIN B02_Bill.PR1D_OrderDetail  ON PRA_PR1_OrderId=PR1D_PR1_OrderId
                            LEFT JOIN B02_Bill.PRAD_ArrivalPlanDetail ON PR1D_OrderDetailId=PRAD_PR1D_OrderDetailId  
                            WHERE " + strWHERE1
                             + @"GROUP BY  [PRAD_CONO],[PRAD_DIVI] ,[PRA_ArrivalPlanId],[PR1D_PD0_ProductId]
                                ,[PR1D_OrderDetailId],[PR1D_UnitID]    
                                ,[PR1D_Total]";                            
                            
                         }
                        ds_Return = conn.GetDataSet(strSQL); 

                   // }
                 }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("B02_Bill.PRAD_ArrivalPlanDetail");
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
                                strSQL = @"UPDATE B02_Bill.PRAD_ArrivalPlanDetail SET PRAD_Status='E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                               WHERE PRAD_PRA_ArrivalPlanId='" + ds.Tables["LIST"].Rows[i]["PRAD_PRA_ArrivalPlanId"].ToString() + @"'
                               AND iusnull(PRA_Status,'')<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1' ";
                                conn.ExcuteQuerryByTran(strSQL);
                            }

                        }
                        else if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "EDIT")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                DataTable dt = ds.Tables["LIST"].Clone();
                                dt.ImportRow(ds.Tables["LIST"].Rows[i]);

                                strSQL = @"SELECT * FROM B02_Bill.PRAD_ArrivalPlanDetail WHERE  PRAD_ArrivalPlanDetailId=@param0
                                AND PRAD_Status<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
                                 ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["PRAD_ArrivalPlanDetailId"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                { 
                                    //处理结果
                                    if (ds.Tables["LIST"].Rows[i]["PRAD_LmUser"].ToString() != "")
                                    {
                                        string strCode = dt_SR.Rows[0]["PRAD_UptNo"].ToString();
                                        if (strCode == "0")
                                        {
                                            strCode = Convert.ToInt32(strCode) + 1.ToString();
                                        }
                                        else
                                        {
                                            strCode = "0";
                                        }

                                        if (!dt.Columns.Contains("PRAD_LmDt"))
                                        {
                                            dt.Columns.Add("PRAD_LmDt");
                                        }


                                        if (!dt.Columns.Contains("PRAD_UptNo"))
                                        {
                                            dt.Columns.Add("PRAD_UptNo");
                                        }

                                        //if (!dt.Columns.Contains("PRA_Status"))
                                        //{
                                        //    dt.Columns.Add("PRA_Status");
                                        //}

                                        //dt.Rows[0]["PRA_Status"] = '0';
                                        dt.Rows[0]["PRA_LmDt"] = DateTime.Now;
                                        dt.Rows[0]["PRA_UptNo"] = strCode;
                                    }

                                    conn.Update("B02_Bill.PRAD_ArrivalPlanDetail", dt, "PRAD_ArrivalPlanDetailId='" + ds.Tables["LIST"].Rows[i]["PRAD_ArrivalPlanDetailId"].ToString() + @"'");
                                  
                                    strSQL = @"UPDATE AA SET AA.PR1_PurchaseTotal=BB.PR1_PurchaseTotal,
                                               AA.PR1_PurchaseAmount=BB.PR1_PurchaseAmount,AA.PR1_POriginalAmount=BB.PR1_POriginalAmount,
                                               AA.PR1_LmUser='" + ds.Tables["LIST"].Rows[i]["PR1D_LmUser"].ToString() + @"',
                                               AA.PR1_LmDt='" + ds.Tables["LIST"].Rows[i]["PR1D_LmDt"].ToString() + @"',
                                               AA.PR1_UptNo=AA.PR1D_UptNo+1
                                               FROM 
                                               B02_Bill.PR1_Order AA,
                                               (SELECT SUM(PR1D_Total) AS PR1_PurchaseTotal,SUM(PR1D_OriginalAmount) AS PR1_PurchaseAmount,
                                                SUM(PR1D_EstimateCost) AS PR1D_EstimateCost,SUM(PR1D_CurrencyAmount) AS PR1_POriginalAmount,PR1D_PR1_OrderId
                                                FROM B02_Bill.PR1D_OrderDetail WHERE PR1D_PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1D_PR1_OrderId"].ToString() + @"'
                                                GROUP BY PR1D_PR1_OrderId)BB
                                                WHERE AA.PR1_OrderId=BB.PR1D_PR1_OrderId";
                                    conn.ExcuteQuerryByTran(strSQL);

                                }

                                else  //add
                                {

                                    DataTable dtTemp = conn.GetDataTableInTrans(
                                      @" SELECT   " + ds.Tables["LIST"].Rows[i]["PRAD_PerchaseTotal"].ToString() + @"  -
                                         " + ds.Tables["LIST"].Rows[i]["PRAD_ArrivalTotal"].ToString() + @" -
                                         " + ds.Tables["LIST"].Rows[i]["PRAD_PlanArrival"].ToString() + @"  as PRAD_TotalDiff
                                      ");

                                    string PRAD_TotalDiff = dtTemp.Rows[0]["PRAD_TotalDiff"].ToString();


                                    DataTable dtAmot = conn.GetDataTableInTrans(
                                     @" SELECT  ISNULL(PR1D_POriginalPrice * " + ds.Tables["LIST"].Rows[i]["PRAD_PlanArrival"].ToString() + @",'0')
                                        as PRAD_PlanArrivalAmount 
                                        FROM  B02_Bill.PR1D_OrderDetail   WHERE PR1D_OrderDetailId='" + ds.Tables["LIST"].Rows[i]["PRAD_PR1D_OrderDetailId"].ToString() + @"'
                                        AND  PR1D_PD0_ProductId='" + ds.Tables["LIST"].Rows[i]["PRAD_PD0_ProductId"].ToString() + @"'
                                      ");

                                    string PRAD_PlanArrivalAmount = dtAmot.Rows[0]["PRAD_PlanArrivalAmount"].ToString();
 
                                    string PRAD_ArrivalPlanDetailId = Guid.NewGuid().ToString();


                                    if (!dt.Columns.Contains("PRAD_ArrivalPlanDetailId"))
                                    {
                                        dt.Columns.Add("PRAD_ArrivalPlanDetailId");
                                    }


                                    if (!dt.Columns.Contains("PRAD_RgDt"))
                                    {
                                        dt.Columns.Add("PRAD_RgDt");
                                    }

                                    if (!dt.Columns.Contains("PRAD_LmDt"))
                                    {
                                        dt.Columns.Add("PRAD_LmDt");
                                    }

                                    if (!dt.Columns.Contains("PRAD_UptNo"))
                                    {
                                        dt.Columns.Add("PRAD_UptNo");
                                    }

                                    if (!dt.Columns.Contains("PRAD_TotalDiff"))
                                    {
                                        dt.Columns.Add("PRAD_TotalDiff");
                                    }

                                    if (!dt.Columns.Contains("PRAD_PlanArrivalAmount"))
                                    {
                                        dt.Columns.Add("PRAD_PlanArrivalAmount");
                                    }


                                    dt.Rows[0]["PRAD_ArrivalPlanDetailId"] = PRAD_ArrivalPlanDetailId;

                                    dt.Rows[0]["PRAD_RgDt"] = DateTime.Now;
                                    dt.Rows[0]["PRAD_LmDt"] = DateTime.Now;
                                    dt.Rows[0]["PRAD_TotalDiff"] = PRAD_TotalDiff;
                                    dt.Rows[0]["PRAD_PlanArrivalAmount"] = PRAD_PlanArrivalAmount;

                                    conn.Insert("B02_Bill.PRAD_ArrivalPlanDetail", dt);

 

                                    strSQL = @"UPDATE AA SET AA.PRA_PlanTotal=BB.PRAD_PlanTotal,
                                                AA.PRA_PlanAmount=BB.PRAD_PlanArrivalAmount,
                                                AA.PRA_LmUser='" + ds.Tables["LIST"].Rows[i]["PRAD_LmUser"].ToString() + @"',
                                                AA.PRA_LmDt=CONVERT(VARCHAR(100),GETDATE(),121),
                                                AA.PRA_TotalDiff=AA.PRA_PerchaseTotal-AA.PRA_ArrivalTotal-BB.PRA_PlanTotal,
                                                AA.PRA_AmountDiff=AA.PRA_PerchaseAmount-AA.PRA_ArrivalAmount-BB.PRA_PlanAmount, 
                                                AA.PRA_UptNo=AA.PRA_UptNo+1
                                                FROM 
                                                PRA_ArrivalPlan AA,
                                               (SELECT PRAD_PRA_ArrivalPlanId,SUM(ISNULL(PRAD_PlanArrival,'0')) AS PRAD_PlanTotal,              
                                                SUM(ISNULL(PRAD_PlanArrivalAmount,'0')) AS PRAD_PlanArrivalAmount                                       
                                                FROM   B02_Bill.PRAD_ArrivalPlanDetail 
                                                WHERE  PRAD_PRA_ArrivalPlanId=' " + ds.Tables["LIST"].Rows[i]["PRAD_PRA_ArrivalPlanId"].ToString() + @" '
                                                GROUP BY PRAD_PRA_ArrivalPlanId)BB
                                                WHERE AA.PRA_ArrivalPlanId=BB.PRAD_PRA_ArrivalPlanId";
                                        
                                    conn.ExcuteQuerryByTran(strSQL);




//                                    strSQL = @"UPDATE AA SET AA.PR1_PurchaseTotal=BB.PR1_PurchaseTotal,
//                                               AA.PR1_PurchaseAmount=BB.PR1_PurchaseAmount,AA.PR1_POriginalAmount=BB.PR1_POriginalAmount,
//                                               AA.PR1_LmUser='" + ds.Tables["LIST"].Rows[i]["PR1D_LmUser"].ToString() + @"',
//                                               AA.PR1_LmDt='" + ds.Tables["LIST"].Rows[i]["PR1D_LmDt"].ToString() + @"',
//                                               AA.PR1_UptNo=AA.PR1D_UptNo+1
//                                               FROM 
//                                               B02_Bill.PR1_Order AA,
//                                               (SELECT SUM(PR1D_Total) AS PR1_PurchaseTotal,SUM(PR1D_OriginalAmount) AS PR1_PurchaseAmount,
//                                                SUM(PR1D_EstimateCost) AS PR1D_EstimateCost,SUM(PR1D_CurrencyAmount) AS PR1_POriginalAmount,PR1D_PR1_OrderId
//                                                FROM B02_Bill.PR1D_OrderDetail WHERE PR1D_PR1_OrderId='" + ds.Tables["LIST"].Rows[i]["PR1D_PR1_OrderId"].ToString() + @"'
//                                                GROUP BY PR1D_PR1_OrderId)BB
//                                                WHERE AA.PR1_OrderId=BB.PR1D_PR1_OrderId";
                                 //   conn.ExcuteQuerryByTran(strSQL);
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