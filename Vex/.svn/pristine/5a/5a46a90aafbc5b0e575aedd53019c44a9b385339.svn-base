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

/// 类名：Order
/// 类说明：对客户订单的CRUD,只对订单专用
/// 创建人：刘洪
/// 创建日期：2015-02-05
/// 修改人：
/// 修改日期： 
/// 修改内容：
/// WSID: 
namespace HZY.COM.WS.Present
{
    public class Cart : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Cart()
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

        #region 入口
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

                if (strTag == "saveCart".ToUpper())
                {
                    saveCart();
                }
                else if (strTag == "setNum".ToUpper())
                {
                    setNum();
                }
                else if (strTag == "GetCart".ToUpper())
                {
                    GetCart();
                }
                else if (strTag == "DelGoods".ToUpper())
                {
                    DelGoods();
                }
                else if (strTag == "buildOrder".ToUpper())
                {
                    buildOrder();
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

        #region 内部函数
            #region saveCart
                private void saveCart() {//this.hzyMessage = Common.Common.CheckUser(hzyMessage.Session_ID);
                    string strGoodsNo = dt_List.Rows[0]["GoodsNo"].ToString();
                    string strSQL = @"SELECT  [CartID]
                                                        ,[GoodsNum]
                                                      FROM [HZY_Present].[dbo].[Cart]
                                                      WHERE [Status]='未确认' AND GoodsNo = '" + strGoodsNo + "' AND Employeeno = '" + m_hzyMessage.User_Name + "'";
                    DataTable dt = conn.GetDataTable(strSQL);
                    ArrayList alist = new ArrayList();
                    if (dt.Rows.Count == 0)
                    {
                        dt_List.Columns.Add("CartID");
                        dt_List.Columns.Add("Status");
                        dt_List.Columns.Add("EmployeeNo");
                        dt_List.Columns.Add("CreateUser");
                        dt_List.Columns.Add("CreateDate");
                        dt_List.Columns.Add("GoodsNum");
                        dt_List.Columns.Add("LmUser");
                        dt_List.Columns.Add("LmDt");

                        string ID = System.Guid.NewGuid().ToString();
                        dt_List.Rows[0]["CartID"] = ID;
                        dt_List.Rows[0]["Status"] = "未确认";
                        dt_List.Rows[0]["GoodsNum"] = "1";
                        dt_List.Rows[0]["EmployeeNo"] = m_hzyMessage.User_Name;
                        dt_List.Rows[0]["CreateUser"] = m_hzyMessage.User_Name;
                        dt_List.Rows[0]["CreateDate"] = now;
                        dt_List.Rows[0]["LmUser"] = m_hzyMessage.User_Name;
                        dt_List.Rows[0]["LmDt"] = now;

                        Sumbit("Insert", dt_List, alist);
                    }
                    else { 
                        
                        int num =Int32.Parse(dt.Rows[0]["GoodsNum"].ToString());
                        num++;

                        dt.Columns.Add("LmUser");
                        dt.Columns.Add("LmDt");

                        dt.Rows[0]["LmUser"] = m_hzyMessage.User_Name;
                        dt.Rows[0]["LmDt"] = now;
                        dt.Rows[0]["GoodsNum"] = num;
                        alist.Add("CartID");
                        Sumbit("Update", dt, alist);
                    };
                }
            #endregion

            #region GetCart
                private void GetCart()
                {
                    string strSQL = @"SELECT T1.[CartID]
                                                        ,T1.[GoodsNo]
	                                                     ,T2.[Name]
	                                                    ,T2.[Spec]
	                                                    ,T2.[RetailPrice]
                                                        ,T2.[PicPath]
	                                                    ,SUM([GoodsNum]) AS [GoodsNum]
	                                                    ,(SUM(T1.[GoodsNum]) * T2.[RetailPrice]) AS [Count]
                                                    FROM [dbo].[Cart] T1,[dbo].[Goods] T2 WITH(NOLOCK)
                                                    WHERE T1.GoodsNo= T2.GoodsNo AND 
                                                    T1.[Status] = '未确认' AND T2.[Status] = '已上架'  AND T1.EmployeeNo = '" + hzyMessage.User_Name+@"'
                                                    GROUP BY T1.[GoodsNo],T2.Name,T2.Spec,T2.RetailPrice,T2.[PicPath],T1.[CartID]";
                    m_ReturnData = conn.GetDataSet(strSQL);
                }
            #endregion

            #region DelGoods
                private void DelGoods() {
                    dt_List.Columns.Add("EmployeeNo");
                    dt_List.Columns.Add("Status");

                    for (int i = 0; i < dt_List.Rows.Count; i++) {
                        dt_List.Rows[i]["EmployeeNo"] = hzyMessage.User_Name;
                        dt_List.Rows[i]["Status"] = "未确认";
                    };

                    ArrayList aList = new ArrayList();
                    aList.Add("EmployeeNo");
                    aList.Add("GoodsNo");
                    aList.Add("Status");
                    Sumbit("DelGoods", dt_List, aList);
                }
        #endregion

            #region setNum
                private void setNum()
                {
                    ArrayList aList = new ArrayList();
                    string strGoodsNo = dt_List.Rows[0]["GoodsNo"].ToString();
                    string Type = dt_List.Rows[0]["Type"].ToString();
                    string strSQL = @"SELECT CartID
                                                                  ,GoodsNum 
                                                        FROM [dbo].[Cart] WITH(NOLOCK)
                                                        WHERE [Status] = '未确认' AND GoodsNo = '" + strGoodsNo + @"'
                                                        AND EmployeeNo = '" +hzyMessage.User_Name + "'";
                    DataTable dt = conn.GetDataTable(strSQL);

                    if (dt.Rows.Count != 0) {
                        int num = Int32.Parse(dt.Rows[0]["GoodsNum"].ToString());

                        if (Type == "up") { 
                            num++; 
                        }
                        else if (Type == "down") {
                            if (num > 1)
                            {
                                num--;
                            };
                        }
                        else { num = Int32.Parse(dt_List.Rows[0]["Num"].ToString()); };
                        
                        dt.Columns.Add("LmUser");
                        dt.Columns.Add("LmDt");

                        dt.Rows[0]["GoodsNum"] = num.ToString();
                        dt.Rows[0]["LmUser"] = hzyMessage.User_Name;
                        dt.Rows[0]["LmDt"] = now;

                        aList.Add("CartID");
                        Sumbit("Update", dt, aList);
                    };

                }
            #endregion

            #region buildOrder
                private void buildOrder() {
                    dt_List.Columns.Add("LmUser");
                    dt_List.Columns.Add("LmDt");
                    dt_List.Columns.Add("EmployeeNo");
                    dt_List.Columns.Add("Status");
                    

                    //花销积分计算
                    int dt_ListRowCount = dt_List.Rows.Count;
                    int iAmount = 0;
                    for (int i = 0; i < dt_ListRowCount; i++) {
                       int GoodsNum = Int32.Parse(dt_List.Rows[i]["GoodsNum"].ToString());
                       int Retailprice = Int32.Parse(dt_List.Rows[i]["Retailprice"].ToString());
                       iAmount += GoodsNum * Retailprice;
                    };
                    dt_List.Columns.Remove("Retailprice");
                    //扣减积分
                    UpPoint(iAmount);
                    

                    for (int i = 0; i < dt_List.Rows.Count; i++)
                    {
                        dt_List.Rows[i]["EmployeeNo"] = hzyMessage.User_Name;
                        dt_List.Rows[i]["Status"] = "已申请";
                        dt_List.Rows[i]["LmUser"] = hzyMessage.User_Name;
                        dt_List.Rows[i]["LmDt"] = now;
                    };

                    ArrayList aList = new ArrayList();
                    aList.Add("CartID");

                    Sumbit("Update", dt_List, aList);
                }
            #endregion

            #region UpPoint
                private bool UpPoint(int Amount) {
                

                //存放现有数据表格
                DataTable dtPointALL = new DataTable();
                //存放筛选后的数据表格
                DataTable dtResult = new DataTable();

                dtResult.Columns.Add("ID");
                dtResult.Columns.Add("Status");
                dtResult.Columns.Add("UnusedCredits");
                dtResult.Columns.Add("WaitCredits");
                dtResult.Columns.Add("LmUser");
                dtResult.Columns.Add("LmDt");
                dtResult.TableName = "dtResult";

                string strSQL = @"SELECT [ID]
                                                                ,[UnusedCredits]
                                                                ,[WaitCredits]
                                                                ,[Status]
                                                    FROM [dbo].[EmployeeInfo] WITH(NOLOCK)
                                                    WHERE [EmployeeNo] = '" + hzyMessage.User_Name + @"' AND [UnusedCredits] <>0
                                                                   AND [Status] in ('可兑换','待确认')";
                dtPointALL = conn.GetDataTable(strSQL);

                int count = dtPointALL.Rows.Count;
                int i = 0;
                do
                {
                    DataRow dr = dtPointALL.Rows[i];
                    DataRow drNew = dtResult.NewRow();

                    int diff = Int32.Parse(dr["UnusedCredits"].ToString());
                    int wait = Int32.Parse(dr["WaitCredits"].ToString());
                    int amountRlt = diff - Amount;

                    if (amountRlt >= 0)
                    {
                            
                        drNew["ID"] = dtPointALL.Rows[i]["ID"].ToString();
                        drNew["UnusedCredits"] = amountRlt;
                        drNew["WaitCredits"] = wait + Amount;
                        drNew["Status"] = "待确认";
                        drNew["LmUser"] = hzyMessage.User_Name;
                        drNew["LmDt"] = now;
                        dtResult.Rows.Add(drNew);
                        break;
                    }
                    else if (amountRlt < 0)
                    {
                        drNew["ID"] = dtPointALL.Rows[i]["ID"].ToString();
                        drNew["Status"] = "待确认";
                        drNew["UnusedCredits"] = 0;
                        drNew["WaitCredits"] = wait + diff;
                        drNew["LmUser"] = hzyMessage.User_Name;
                        drNew["LmDt"] = now;
                        dtResult.Rows.Add(drNew);
                        Amount = Amount - diff;
                    };
                    i++;
                } while (i < count);

                ArrayList aList = new ArrayList();
                aList.Add("ID");

                conn.BeginTransaction(); // 开启事务
                conn.LockTableList.Add("[dbo].[EmployeeInfo]");
                bool bResult;
                bResult = conn.Update("[dbo].[EmployeeInfo]", dtResult, aList);
                conn.CommitTransaction();
                return bResult;
            }
            #endregion

            #region Sumbit
                private void Sumbit(string sbtType, DataTable sbtDT, ArrayList listKey)
            {

                bool bResult = false;

                conn.BeginTransaction(); // 开启事务
                conn.LockTableList.Add("[dbo].[Cart]");

                if (sbtType == "Insert")
                {
                    bResult = conn.Insert("[dbo].[Cart]", sbtDT);
                }
                else if (sbtType == "DelGoods")
                {

                    bResult = conn.Delete("[dbo].[Cart]", sbtDT, listKey);
                        GetCart();
                }
                else if (sbtType == "Update")
                {
                    bResult = conn.Update("[dbo].[Cart]", sbtDT, listKey);
                };

                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "操作失败" });
                };

                conn.CommitTransaction();
                m_ReturnData.Tables.Add(dt_EditResult);
            }
            #endregion
        #endregion
    }
}
