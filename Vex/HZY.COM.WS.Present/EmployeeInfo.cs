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


/// 类名：Main
/// 类说明：对EmployeeInfo(员工导入)的CRUD,为Easyui专用
/// 创建人：刘洪
/// 创建日期：2015-01-22
/// 修改人：
/// 修改日期： 
/// 修改内容：
/// WSID: 94032146-87d3-47c3-b6da-93423349a73f
namespace HZY.COM.WS.Present
{
    public class EmployeeInfo:HZYLogicBase, ILogicGetData
    {
        #region 构造函数
            public  EmployeeInfo() {
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
            public DataSet GetData() {
                try
                {
                    //接收XML的内容
                    string strXML = "";
                    strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                    m_RequestXML = Common.Common.GetDSByExcelXML(strXML);

                    DataTable dt_OPTYPE = m_RequestXML.Tables["OPTYPE"];
                                               dt_List = m_RequestXML.Tables["List"];
                    string strTag = dt_OPTYPE.Rows[0][0].ToString().ToUpper().ToString();
                    
                    if (strTag == "Excel".ToUpper())        //Excel导入
                    {
                        Excel();
                    }
                    else if (strTag == "GetYear".ToUpper()) {
                        GetYear();
                    }
                    else if (strTag == "GetMonth".ToUpper()) {
                        GetMonth();
                    }
                    else if (strTag == "GetSearch".ToUpper()) {
                        GetSerch();
                    }
                    else if (strTag == "SaveEmp".ToUpper()) {
                        SaveEmp();
                    }
                    else if (strTag == "DelEmp".ToUpper()) {
                        DelEmp();
                    }
                    return m_ReturnData;
                }
                catch {
                    conn.RollbackTransaction();
                    throw;
                };
            }
        #endregion

        #region 内部函数

            #region Excel导入
                private void Excel() {
                   DataTable dt = m_RequestBak.Tables[0];
                   dt.Columns["年份"].ColumnName = "Year";
                   dt.Columns["月份"].ColumnName = "Month";
                   dt.Columns["员工号"].ColumnName = "EmployeeNo";
                   dt.Columns["身份证号"].ColumnName = "EmployeeID";
                   dt.Columns["员工姓名"].ColumnName = "EmployeeName";
                   dt.Columns["员工生日"].ColumnName = "Birthday";
                   dt.Columns["积分"].ColumnName = "Credits";

                   dt.Columns.Add("ID");
                   dt.Columns.Add("TaskID");
                   dt.Columns.Add("Status");
                   dt.Columns.Add("CreateUser");
                   dt.Columns.Add("CreateDate");
                   dt.Columns.Add("UseCredits");
                   dt.Columns.Add("WaitCredits");
                   dt.Columns.Add("UnusedCredits");
                   dt.Columns.Add("LmUser");
                   dt.Columns.Add("LmDt");


                   int rowCount = dt.Rows.Count;
                   string GUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型

                   for (int i = 0; i < rowCount; i++) {
                       string id = System.Guid.NewGuid().ToString();      //直接返回字符串类型
                       dt.Rows[i]["ID"] = id;
                       dt.Rows[i]["TaskID"] = GUID;
                       dt.Rows[i]["Status"] = "可兑换";
                       dt.Rows[i]["UseCredits"] = 0;
                       dt.Rows[i]["WaitCredits"] = 0;
                       dt.Rows[i]["UnusedCredits"] = dt.Rows[i]["Credits"].ToString();
                       dt.Rows[i]["CreateUser"] = m_hzyMessage.User_Name;
                       dt.Rows[i]["CreateDate"] = now;
                       dt.Rows[i]["LmUser"] = m_hzyMessage.User_Name;
                       dt.Rows[i]["LmDt"] = now;
                   };

                   Sumbit("Insert", dt);
                }
            #endregion

            #region GetYear
                    private void GetYear() {
                        string strSQL = @"SELECT Distinct [Year]
                                                            ,[Year]
                                                        FROM [dbo].[EmployeeInfo] WITH(NOLOCK)";
                        m_ReturnData = conn.GetDataSet(strSQL);
                    }
            #endregion

            #region GetMonth
                    private void GetMonth()
                    {
                        string strSQL = @"SELECT Distinct [Month]
                                                            ,[Month]
                                                        FROM [dbo].[EmployeeInfo] WITH(NOLOCK)";
                        m_ReturnData = conn.GetDataSet(strSQL);
                    }
            #endregion

            #region GetSearch
                    private void GetSerch() {
                        string strYear = dt_List.Rows[0]["year"].ToString();
                        string strMonth = dt_List.Rows[0]["month"].ToString();
                        string strEmpNo = dt_List.Rows[0]["empCode"].ToString();
                        string where = " ";
                        if (strYear != "") {
                            where += "AND Year = '" + strYear + "' ";
                        };
                        if (strMonth != "") {
                            where += "AND Month = '" + strMonth + "' ";
                        };
                        if (strEmpNo != "")
                        {
                            where += "AND EmployeeNo = '" + strEmpNo + "' ";
                        };
                        GetDg(where);
                    }
            #endregion

            #region GetDg
            private void GetDg(string where){
            string strSQL = @"SELECT [TaskID]
                                                  ,[Year]
                                                  ,[Month]
                                                  ,[EmployeeNo]
                                                  ,[EmployeeID]
                                                  ,[EmployeeName]
                                                  ,[Birthday]
                                                  ,[Credits]
                                                  ,[UseCredits]
                                                  ,[UnusedCredits]
                                                  ,[Status]
                                                  ,[CreateUser]
                                                  ,[CreateDate]
                                                  ,[LmUser]
                                                  ,[LmDt]
                                              FROM [dbo].[EmployeeInfo] WITH(NOLOCK)
                                              WHERE 1=1 " + where;
            m_ReturnData = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

            #region SaveEmp
                private void SaveEmp() {
                    string strYear = dt_List.Rows[0]["Year"].ToString();
                    string strMonth = dt_List.Rows[0]["Month"].ToString();

                    string strTaskID = conn.GetDataTableFirstValue("SELECT  [TaskID] FROM [dbo].[EmployeeInfo] WHERE [Status] = '可兑换' AND [Year] = '" + strYear + "' AND [Month] = '" + strMonth + "'").ToString();
                    string GUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型

                    dt_List.Columns.Add("ID");
                    dt_List.Columns.Add("TaskID");
                    dt_List.Columns.Add("Status");
                    dt_List.Columns.Add("UnusedCredits");
                    dt_List.Columns.Add("WaitCredits");
                    dt_List.Columns.Add("UseCredits");
                    dt_List.Columns.Add("CreateUser");
                    dt_List.Columns.Add("CreateDate");
                    dt_List.Columns.Add("LmUser");
                    dt_List.Columns.Add("LmDt");

                    dt_List.Rows[0]["ID"] = GUID;
                    dt_List.Rows[0]["TaskID"] = strTaskID;
                    dt_List.Rows[0]["UnusedCredits"] = Int32.Parse(dt_List.Rows[0]["Credits"].ToString());
                    dt_List.Rows[0]["WaitCredits"] = 0;
                    dt_List.Rows[0]["UseCredits"] = 0;
                    dt_List.Rows[0]["Status"] = "可兑换";
                    dt_List.Rows[0]["CreateUser"] = m_hzyMessage.User_Name;
                    dt_List.Rows[0]["CreateDate"] = now;
                    dt_List.Rows[0]["LmUser"] = m_hzyMessage.User_Name;
                    dt_List.Rows[0]["LmDt"] = now;

                    Sumbit("Insert", dt_List);

                }
            #endregion

            #region DelEmp
                private void DelEmp() {
                    dt_List.Columns.Remove("Year");
                    dt_List.Columns.Remove("Month");
                    dt_List.Columns.Remove("EmployeeID");
                    dt_List.Columns.Remove("EmployeeName");
                    dt_List.Columns.Remove("Birthday");
                    dt_List.Columns.Remove("Credits");
                    dt_List.Columns.Remove("UseCredits");
                    dt_List.Columns.Remove("Status");
                    dt_List.Columns.Remove("CreateUser");
                    dt_List.Columns.Remove("CreateDate");
                    dt_List.Columns.Remove("LmUser");
                    dt_List.Columns.Remove("LmDt");
                    dt_List.Columns.Remove("UnusedCredits");
                    dt_List.Columns.Remove("rowIndex");

                    Sumbit("Delete", dt_List);
                }
            #endregion

            #region Sumbit
                private void Sumbit(string sbtType,DataTable sbtDT) {

                        bool bResult = false;

                        conn.BeginTransaction(); // 开启事务
                        conn.LockTableList.Add("[dbo].[EmployeeInfo]");

                        if (sbtType == "Insert") {
                            bResult = conn.Insert("[dbo].[EmployeeInfo]", sbtDT);
                        }
                        else if (sbtType == "Delete") {
                        ArrayList listKey = new ArrayList();
                            listKey.Add("taskid");
                            listKey.Add("employeeno");
                            bResult = conn.Delete("[dbo].[EmployeeInfo]", sbtDT, listKey);
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
