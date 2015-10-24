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
/// 类说明：对Goods(商品管理)的CRUD,为Easyui专用
/// 创建人：刘洪
/// 创建日期：2015-01-28
/// 修改人：
/// 修改日期： 
/// 修改内容：
/// WSID: 881346c3-1b26-4530-a894-c90dcb4d8344
namespace HZY.COM.WS.Present
{
    public class Goods : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Goods()
        {
                this.m_SessionCheck = false;
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

                if (strTag == "Get".ToUpper()) {
                    Get("");
                }
                else if (strTag == "SaveNew".ToUpper())
                {
                    SaveNew();
                }
                else if (strTag == "Search".ToUpper())
                {
                    Search();
                }
                else if (strTag == "SaveEdit".ToUpper())
                {
                    SaveEdit();
                }
                else if (strTag == "UptStatus".ToUpper())
                {
                    UptStatus();
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

            #region Get
            private void Get(string where) {
                string strSQL = @"SELECT  [GoodsID]
                                                    ,[GoodsNo]
                                                    ,T1.[Name]
                                                    ,[CategoryCode]
                                                    ,T2.[Name] AS [CategoryName]
                                                    ,[Description]
                                                    ,[Detail]
                                                    ,[Price]
                                                    ,[RetailPrice]
                                                    ,[Spec]
                                                    ,[PicPath]
                                                    ,[Status]
                                                    ,T1.[CreateUser]
                                                    ,T1.[CreateTime]
                                                    ,T1.[LmUser]
                                                    ,T1.[LmDt]
                                                FROM [dbo].[Goods] T1,[dbo].[Category] T2 WITH(NOLOCK)
                                                WHERE T1.CategoryCode = T2.Code AND T1.Status <> '已删除' " + where + m_hzyPageInfo.Where;
                m_ReturnData = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
            }
            #endregion

            #region Search
                private void Search(){
                    string where = " ";
                    string GoodsNo = dt_List.Rows[0]["GoodsNo"].ToString();
                    string GoodsName = dt_List.Rows[0]["Name"].ToString();
                    if (GoodsNo.Length != 0) { where += " AND T1.GoodsNo Like '%" + GoodsNo + "%' "; };
                    if (GoodsName.Length != 0) { where += " AND T1.Name Like '%" + GoodsName + "%' "; };
                    
                    Get(where);
                }
            #endregion

            #region SaveNew
            private void SaveNew() {
                    //验证
                    this.hzyMessage = Common.Common.CheckUser(hzyMessage.Session_ID);
                    
                    string Guid = System.Guid.NewGuid().ToString();      //直接返回字符串类型
                    string strCategory = dt_List.Rows[0]["CategoryCode"].ToString();  //品类
                    dt_List.Columns.Add("GoodsID");
                    dt_List.Columns.Add("GoodsNo");
                    dt_List.Columns.Add("Status");
                    dt_List.Columns.Add("CreateUser");
                    dt_List.Columns.Add("CreateTime");
                    dt_List.Columns.Add("LmUser");
                    dt_List.Columns.Add("LmDt");

                    //dt_List.Columns.Remove("CategoryCode");

                    dt_List.Rows[0]["GoodsID"] = Guid;
                    dt_List.Rows[0]["GoodsNo"] = MaxNo(strCategory);
                    dt_List.Rows[0]["Status"] = "未上架";
                    dt_List.Rows[0]["CreateUser"] = m_hzyMessage.User_Name;
                    dt_List.Rows[0]["CreateTime"] = now;
                    dt_List.Rows[0]["LmUser"] = m_hzyMessage.User_Name;
                    dt_List.Rows[0]["LmDt"] = now;

                    Submit("Insert", dt_List);
                }
            #endregion

            #region SaveEdit
                private void SaveEdit() {
                    dt_List.Columns.Add("LmUser");
                    dt_List.Columns.Add("LmDt");
                    dt_List.Rows[0]["LmUser"] = m_hzyMessage.User_Name;
                    dt_List.Rows[0]["LmDt"] = now;

                    Submit("Update", dt_List);
                }
            #endregion

            #region MaxNo
            private string MaxNo(string category)
                    {
                        string rtnMaxNo = "";
                        string result = "";
                        string strYear = now.Year.ToString();
                        string strMonth = now.Month.ToString();
                        string strDay = now.Day.ToString();

                        if (strMonth.Length == 1) { strMonth = "0" + strMonth; };
                        if (strDay.Length == 1) { strDay = "0" + strDay; };

                        string strWhere = category + strYear + strMonth + strDay;
                        string strSQL = @"SELECT MAX(GoodsNo) 
                                                          FROM [dbo].[Goods]  WITH(NOLOCK)
                                                          WHERE [GoodsNo] LIKE '%" + strWhere+"%'";
                        result = conn.GetDataTableFirstValue(strSQL).ToString();
                        if (result.Length == 0)
                        {
                            rtnMaxNo = strWhere + "001";
                        }
                        else {
                            int maxNo = int.Parse(result.Substring(9));
                            maxNo++;
                            if (maxNo < 10) {
                                rtnMaxNo = strWhere + "00" + maxNo;
                            }
                            else if (maxNo >= 10 && maxNo < 100) {
                                rtnMaxNo = strWhere + "0" + maxNo;
                            }
                            else if (maxNo >= 100) {
                                rtnMaxNo = strWhere + maxNo;
                            }
                        };
                        return rtnMaxNo;
                    }
            #endregion

            #region UptStatus
            private void UptStatus()
            {
                        dt_List.Columns.Add("LmUser");
                        dt_List.Columns.Add("LmDt");

                        dt_List.Rows[0]["LmUser"] = m_hzyMessage.User_Name;
                        dt_List.Rows[0]["LmDt"] = now;

                        Submit("Update", dt_List);
                    }
            #endregion

            #region Submit
            private void Submit(string sbtType,DataTable sbtDT) {
                bool bResult = false;

                conn.BeginTransaction(); // 开启事务
                conn.LockTableList.Add("[dbo].[Goods]");

                if (sbtType == "Insert")
                {
                    bResult = conn.Insert("[dbo].[Goods]", sbtDT);
                }
                else if (sbtType == "Update")
                {
                    ArrayList listKey = new ArrayList();
                    listKey.Add("GoodsID");
                    bResult = conn.Update("[dbo].[Goods]", sbtDT, listKey);
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
