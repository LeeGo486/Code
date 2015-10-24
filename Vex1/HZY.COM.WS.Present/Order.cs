using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;


using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.ST1005A;

/// 类名：订单
/// 类说明：对Order(订单管理)的CRUD,为Easyui专用
/// 创建人：刘洪
/// 创建日期：2015-03-13
/// 修改人：
/// 修改日期： 
/// 修改内容：
/// WSID: 

namespace HZY.COM.WS.Present
{
     public class Order: HZYLogicBase, ILogicGetData
    {
         #region 构造函数
         public Order()
         {
            this.m_SessionCheck = true;
        }
        #endregion

         #region 内部变量
         private Dbconn conn = new Dbconn("HZY_Present");
         private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

         private DataTable dt_List = new dsCommon.dtResultDataTable();
         private DataSet m_RequestXML = new DataSet();
         private DataSet m_ReturnData = new DataSet();

         DateTime now = DateTime.Now;
         #endregion

         #region 方法入口
         public DataSet GetData()
         {
             try
             {
                 //接收XML的内容
                 string strXML = "";
                 strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                 m_RequestXML = Common.Common.GetDSByExcelXML(strXML);

                 DataTable dt_OPTYPE = m_RequestXML.Tables["OPTYPE"];
                 dt_List = m_RequestXML.Tables["List"];
                 string strTag = dt_OPTYPE.Rows[0][0].ToString().ToUpper().ToString();

                 if (strTag == "GetOrder".ToUpper())
                 {
                     GetOrder("");
                 }
                 else if (strTag == "AllowOrder".ToUpper())
                 {
                     UpdatePoint("AllowOrder");
                 }
                 else if (strTag == "Overrule".ToUpper())
                 {
                     UpdatePoint("Overrule");
                 }
                 else if (strTag == "GetHistory".ToUpper())
                 {
                     GetHistory("");
                 }
                 else if (strTag == "SearchOrder".ToUpper())
                 {
                     SearchOrder();
                 }
                 else if (strTag == "SearchHistory".ToUpper())
                 {
                     SearchHistory();
                 };
                 return m_ReturnData;
             }
             catch
             {
                 conn.RollbackTransaction();
                 throw;
             };
         }
         #endregion

        #region 内部方法

        #region GetOrder
         private void GetOrder(string where)
         {
             string strTemp = @"
                    --取积分
                          SELECT SUM(ISNULL(UnusedCredits,0)) +  SUM( ISNULL([WaitCredits],0)) AS UnusedCredits
                          ,EmployeeNo
                          ,EmployeeName
                          INTO #Temp1
                          FROM [dbo].[EmployeeInfo] WITH(NOLOCK)
                          WHERE [Status] 
                          NOT IN ( '已删除','已确认')
                          GROUP BY EmployeeNo,EmployeeName
                    
                    --取商品
                          SELECT GoodsNo
                          ,Name
                          ,RetailPrice 
                          INTO #Temp2
                          FROM dbo.Goods WITH(NOLOCK)
                          WHERE [Status] = '已上架'

                    --综合数据
                            SELECT [CartID]
                                  ,T1.[GoodsNo]
                                  ,T1.[EmployeeNo]
                                  ,T2.[EmployeeName]
                                  ,T1.[Status]
                                  ,[GoodsNum]
                                  ,T2.[UnusedCredits]
                                  ,T3.[Name]
                                  ,T3.[RetailPrice]
                                  ,T1.[LmDt]
                              INTO #Data 
                              FROM dbo.Cart T1 WITH(NOLOCK)
                              LEFT JOIN #Temp1 T2 WITH(NOLOCK) ON T1.EmployeeNo = T2.EmployeeNo
                              LEFT JOIN #Temp2 T3 WITH(NOLOCK) ON T1.GoodsNo = T3.GoodsNo
                              WHERE T1.[Status] = '已申请'";
             conn.BeginTransaction();
             conn.ExcuteQuerryByTran(strTemp, new string[] { });

             string strSQL = @"SELECT [CartID]
                                  ,[GoodsNo]
                                  ,[EmployeeNo]
                                  ,[EmployeeName]
                                  ,[GoodsNum]
                                  ,[UnusedCredits]
                                  ,[Name]
                                  ,[RetailPrice]
                                  ,[Status]
                                  ,[LmDt]
                             From #Data WITH(NOLOCK)
                             WHERE 1=1 " + where;
             m_ReturnData = conn.GetDataSetForPageList(strSQL,new string [0],m_hzyPageInfo);
             conn.CommitTransaction();
         }
         #endregion

        #region GetHistory
         private void GetHistory(string where)
         {
             string strTemp = @"
                    --取积分
                          SELECT SUM(ISNULL(UnusedCredits,0)) AS UnusedCredits
                          ,EmployeeNo
                          ,EmployeeName
                          INTO #Temp1
                          FROM [dbo].[EmployeeInfo] WITH(NOLOCK)
                          WHERE [Status] 
                          NOT IN ( '已删除')
                          GROUP BY EmployeeNo,EmployeeName
                    
                    --取商品
                          SELECT GoodsNo
                          ,Name
                          ,RetailPrice 
                          INTO #Temp2
                          FROM dbo.Goods WITH(NOLOCK)
                          WHERE [Status] = '已上架'

                    --综合数据
                            SELECT [CartID]
                                  ,T1.[GoodsNo]
                                  ,T1.[EmployeeNo]
                                  ,T2.[EmployeeName]
                                  ,T1.[Status]
                                  ,[GoodsNum]
                                  ,T2.[UnusedCredits]
                                  ,T3.[Name]
                                  ,T3.[RetailPrice]
                                  ,T1.[LmDt]
                              INTO #Data 
                              FROM dbo.Cart T1 WITH(NOLOCK)
                              LEFT JOIN #Temp1 T2 WITH(NOLOCK) ON T1.EmployeeNo = T2.EmployeeNo
                              LEFT JOIN #Temp2 T3 WITH(NOLOCK) ON T1.GoodsNo = T3.GoodsNo
                              WHERE T1.[Status] IN ('已确认','已驳回')";
             conn.BeginTransaction();
             conn.ExcuteQuerryByTran(strTemp, new string[] { });

             string strSQL = @"SELECT [CartID]
                                  ,[GoodsNo]
                                  ,[EmployeeNo]
                                  ,[EmployeeName]
                                  ,[GoodsNum]
                                  ,[UnusedCredits]
                                  ,[Name]
                                  ,[RetailPrice]
                                  ,[Status]
                                  ,[LmDt]
                             From #Data WITH(NOLOCK)
                             WHERE 1=1 " + where;
             m_ReturnData = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
             conn.CommitTransaction();
         }
         #endregion

        #region UpdatePoint
         private void UpdatePoint(string Type) {
             bool bResult = false;

             //员工表
             DataTable dtEmp = new DataTable();
             dtEmp.Columns.Add("Employeeno");
             dtEmp.Columns.Add("RetailPrice");
             dtEmp.Columns.Add("Num");

             //购物车表
             DataTable dtCart = new DataTable();
             dtCart.Columns.Add("CartID");
             dtCart.Columns.Add("Status");
             dtCart.Columns.Add("LmDt");
             dtCart.Columns.Add("LmUser");
             
             int dtCount = dt_List.Rows.Count;

             do {
                 //初始化，记录现有表行数，用于循环。
                 int dtRowsCount = dtCount;
                 string strEmpNo = "";
                 do
                 {
                     dtRowsCount --;
                     DataRow drEmp = dtEmp.NewRow();
                     DataRow drCart = dtCart.NewRow();

                     if (strEmpNo == "" && dtRowsCount != 0)
                     {
                         strEmpNo = dt_List.Rows[dtRowsCount]["Employeeno"].ToString();
                         drEmp["EmployeeNo"] = strEmpNo;
                         drEmp["RetailPrice"] = dt_List.Rows[dtRowsCount]["RetailPrice"].ToString();
                         drEmp["Num"] = dt_List.Rows[dtRowsCount]["GoodsNum"].ToString();

                         drCart["CartID"] = dt_List.Rows[dtRowsCount]["CartID"].ToString();
                         drCart["Status"] = "";
                         drCart["LmUser"] = hzyMessage.User_Name;
                         drCart["LmDt"] = now;

                         dtEmp.Rows.Add(drEmp);
                         dtCart.Rows.Add(drCart);
                         //删除已经用过的行
                         dt_List.Rows.Remove(dt_List.Rows[dtRowsCount]);

                     }
                     else if (strEmpNo == "" && dtRowsCount == 0) {
                         strEmpNo = dt_List.Rows[dtRowsCount]["Employeeno"].ToString();
                         drEmp["EmployeeNo"] = strEmpNo;
                         drEmp["RetailPrice"] = dt_List.Rows[dtRowsCount]["RetailPrice"].ToString();
                         drEmp["Num"] = dt_List.Rows[dtRowsCount]["GoodsNum"].ToString();

                         drCart["CartID"] = dt_List.Rows[dtRowsCount]["CartID"].ToString();
                         drCart["Status"] = "";
                         drCart["LmUser"] = hzyMessage.User_Name;
                         drCart["LmDt"] = now;

                         dtEmp.Rows.Add(drEmp);
                         dtCart.Rows.Add(drCart);
                         //删除已经用过的行
                         dt_List.Rows.Remove(dt_List.Rows[dtRowsCount]);
                     }
                     else if (strEmpNo != "" && dtRowsCount != 0)
                     {
                         string EmpDiff = dt_List.Rows[dtRowsCount]["EmployeeNo"].ToString();
                         if (strEmpNo != EmpDiff)
                         {
                             continue;
                         }
                         else
                         {
                             drEmp["EmployeeNo"] = strEmpNo;
                             drEmp["RetailPrice"] = dt_List.Rows[dtRowsCount]["RetailPrice"].ToString();
                             drEmp["Num"] = dt_List.Rows[dtRowsCount]["GoodsNum"].ToString();

                             drCart["CartID"] = dt_List.Rows[dtRowsCount]["CartID"].ToString();
                             drCart["Status"] = "";
                             drCart["LmUser"] = hzyMessage.User_Name;
                             drCart["LmDt"] = now;


                             dtEmp.Rows.Add(drEmp);
                             dtCart.Rows.Add(drCart);
                             //删除已经用过的行
                             dt_List.Rows.Remove(dt_List.Rows[dtRowsCount]);
                         };
                     }
                     else if (strEmpNo != "" && dtRowsCount == 0)
                     {
                         string EmpDiff = dt_List.Rows[dtRowsCount]["EmployeeNo"].ToString();
                         if (strEmpNo == EmpDiff)
                         {
                             drEmp["EmployeeNo"] = strEmpNo;
                             drEmp["RetailPrice"] = dt_List.Rows[dtRowsCount]["RetailPrice"].ToString();
                             drEmp["Num"] = dt_List.Rows[dtRowsCount]["GoodsNum"].ToString();

                             drCart["CartID"] = dt_List.Rows[dtRowsCount]["CartID"].ToString();
                             drCart["Status"] = "";
                             drCart["LmUser"] = hzyMessage.User_Name;
                             drCart["LmDt"] = now;

                             dtEmp.Rows.Add(drEmp);
                             dtCart.Rows.Add(drCart);
                             //删除已经用过的行
                             dt_List.Rows.Remove(dt_List.Rows[dtRowsCount]);
                         };
                     };
                 } while (dtRowsCount != 0);

                 //处理每位员工数据--入口
                 bResult = UpEmpCart(dtEmp, dtCart, Type);

                 //清空整张表,为下一个员工做准备
                 for (int i = 0, j = dtEmp.Rows.Count; i < j; i++)
                 {
                     dtEmp.Rows.RemoveAt(i);
                 };
                 for (int i = 0, j = dtCart.Rows.Count; i < j; i++)
                 {
                     dtCart.Rows.RemoveAt(i);
                 };

                 //取处理后dt_List的行数，如果空结束循环，如果不空继续循环
                 dtCount = dt_List.Rows.Count;
             } while (dtCount != 0);

             dt_EditResult.Rows.Add(new object[] { true, "操作完成" });
             m_ReturnData.Tables.Add(dt_EditResult);

         }
        #endregion

        #region UpEmpCart
         private bool UpEmpCart(DataTable dtEmp, DataTable dtCart, string Type)
         {
             bool bResult = false;
             //消耗积分量
             int iAmount = 0;
             int dtRowsCount = dtEmp.Rows.Count;

             

             for (int i = 0; i < dtRowsCount; i++)
             {
                 int num = Int32.Parse(dtEmp.Rows[i]["Num"].ToString());
                 int price = Int32.Parse(dtEmp.Rows[i]["retailPrice"].ToString());
                 iAmount += num * price;
             };

             if (iAmount == 0)
             {
                 bResult = false;
             }
             else
             {
                 string strEmpNo = dtEmp.Rows[0]["EmployeeNo"].ToString();
                 string strSQL = @"SELECT [ID] 
                                            ,[UnusedCredits]
                                            ,[WaitCredits] 
                                            ,[UseCredits]
                                            ,[Status]
                                            ,[LmDt]
                                            ,[LmUser]
                                From [dbo].[EmployeeInfo] WITH(NOLOCK)
                                WHERE [Status] = '待确认' AND EmployeeNo = '"+strEmpNo+"'";
                 DataTable dtDiff = conn.GetDataTable(strSQL);

                 int diffCount = dtDiff.Rows.Count;

                 //扣减积分算法
                 for (int i = 0; i < diffCount; i++) {
                     int diff = Int32.Parse(dtDiff.Rows[i]["WaitCredits"].ToString());  //待确认积分
                     int used = Int32.Parse(dtDiff.Rows[i]["UseCredits"].ToString());//已用积分
                     int unused = Int32.Parse(dtDiff.Rows[i]["UnusedCredits"].ToString());//可用积分

                     int iResult = iAmount-diff;
                     if (Type == "AllowOrder")
                     {

                         if (iResult == 0)
                         {
                             dtDiff.Rows[i]["WaitCredits"] = 0;
                             dtDiff.Rows[i]["UseCredits"] = diff + used;
                             if (unused == 0)
                             {
                                 dtDiff.Rows[i]["Status"] = "已兑换";
                             }
                             else {
                                 dtDiff.Rows[i]["Status"] = "可兑换";
                             }
                             dtDiff.Rows[i]["LmUser"] = hzyMessage.User_Name;
                             dtDiff.Rows[i]["LmDt"] = now;
                             break;
                         }
                         else if (iResult > 0)
                         {
                             dtDiff.Rows[i]["WaitCredits"] = 0;
                             dtDiff.Rows[i]["UseCredits"] = diff + used;
                             if (unused == 0)
                             {
                                 dtDiff.Rows[i]["Status"] = "已兑换";
                             }
                             else
                             {
                                 dtDiff.Rows[i]["Status"] = "可兑换";
                             };
                             dtDiff.Rows[i]["LmUser"] = hzyMessage.User_Name;
                             dtDiff.Rows[i]["LmDt"] = now;
                             iAmount = iResult;
                         }
                         else if (iResult < 0)
                         {
                             dtDiff.Rows[i]["WaitCredits"] = Math.Abs(iResult);
                             dtDiff.Rows[i]["UseCredits"] = used + iAmount;
                             dtDiff.Rows[i]["Status"] = "待确认";
                             dtDiff.Rows[i]["LmUser"] = hzyMessage.User_Name;
                             dtDiff.Rows[i]["LmDt"] = now;
                             break;
                         };

                     } 
                     else {//驳回
                         if (iResult <= 0)
                         {
                             dtDiff.Rows[i]["UnusedCredits"] = unused + diff;
                             dtDiff.Rows[i]["WaitCredits"] = 0;
                             dtDiff.Rows[i]["Status"] = "可兑换";
                             dtDiff.Rows[i]["LmUser"] = hzyMessage.User_Name;
                             dtDiff.Rows[i]["LmDt"] = now;
                             break;
                         }
                         else if (iResult > 0)
                         {
                             dtDiff.Rows[i]["UnusedCredits"] = unused + diff;
                             dtDiff.Rows[i]["WaitCredits"] = 0;

                             dtDiff.Rows[i]["Status"] = "可兑换";
                             dtDiff.Rows[i]["LmUser"] = hzyMessage.User_Name;
                             dtDiff.Rows[i]["LmDt"] = now;
                             iAmount = iResult;
                         };
                     };
                     i++;
                 };
                 if (Type == "AllowOrder")
                 {
                     for (int i = 0, j = dtCart.Rows.Count; i < j; i++) {
                         dtCart.Rows[i]["Status"] = "已确认";
                     };
                 } 
                 else {
                     for (int i = 0, j = dtCart.Rows.Count; i < j; i++) {
                         dtCart.Rows[i]["Status"] = "已驳回";
                     };
                 };

                 ArrayList aListEmp = new ArrayList();
                 ArrayList aListCart = new ArrayList();
                 aListEmp.Add("ID");
                 aListCart.Add("CartID");

                conn.BeginTransaction(); // 开启事务
                conn.LockTableList.Add("[dbo].[EmployeeInfo]");
                conn.LockTableList.Add("[dbo].[Cart]");

                bResult = conn.Update("[dbo].[EmployeeInfo]", dtDiff, aListEmp);
                if (bResult) {
                    bResult = conn.Update("[dbo].[Cart]", dtCart, aListCart);
                }
                conn.CommitTransaction();
              }
             return bResult;
         }
        #endregion

        #region SearchOrder
         private void SearchOrder() {
             string strEmpNo = dt_List.Rows[0]["EmployeeNo"].ToString();
             string strBegin = dt_List.Rows[0]["LmdtBegin"].ToString();
             string strEnd = dt_List.Rows[0]["LmdtEnd"].ToString();
             string where = "";

             if (strEmpNo != "") { 
                 where += " AND [EmployeeNo] = '"+strEmpNo+"'";
             };
             if (strBegin != "") {
                 where += " AND LmDt Between '" + strBegin + "' AND '" + strEnd + "'";
             };

             GetOrder(where);
         }
        #endregion

        #region SearchHistory
         private void SearchHistory() {
             string strEmpNo = dt_List.Rows[0]["EmployeeNo"].ToString(),
                         strBegin = dt_List.Rows[0]["LmdtBegin"].ToString(),
                         strEnd = dt_List.Rows[0]["LmdtEnd"].ToString(),
                         strStatus = dt_List.Rows[0]["Status"].ToString(),
                         where = "";

             if (strEmpNo != "")
             {
                 where += " AND [EmployeeNo] = '" + strEmpNo + "'";
             };
             if (strBegin != "")
             {
                 where += " AND LmDt Between '" + strBegin + "' AND '" + strEnd + "'";
             };
             if (strStatus != "") { 
                 where += " AND [Status] = '" +strStatus+ "'";
             }

             GetHistory(where);
         }
        #endregion

        #endregion
    }
}
