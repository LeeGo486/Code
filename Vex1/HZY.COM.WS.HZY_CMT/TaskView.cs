using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;
using System.Web;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.ST1005A;

/// 类名：Main
/// 类说明：对TaskView的CRUD,为微信专用
/// 创建人：刘洪
/// 创建日期：2014-09-30
/// 修改人：
/// 修改日期： 
/// 修改内容：0078b5a7-2209-4d82-90a1-907ee84c5c03
/// 

namespace HZY.COM.WS.HZY_CMT
{
    public class TaskView : HZYLogicBase, ILogicGetData
    {
        #region 构造函数

        public TaskView()
        {
            this.m_SessionCheck = false;
        }

        #endregion

        #region 内部变量

        private Dbconn conn = new Dbconn("HZY_CMT");
        
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime now = DateTime.Now;
        private DataTable dt_MainList = new dsCommon.dtResultDataTable();
        private DataSet m_RequestXML = new DataSet();
        private DataSet m_ReturnData = new DataSet();

        #endregion

        #region GetData 主入口
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
               {
                //接收XML的内容
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                m_RequestXML = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = m_RequestXML.Tables["OPTYPE"];
                dt_MainList = m_RequestXML.Tables["List"];
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCustomerInfo".ToUpper())//获取客户信息
                {
                    GetCustomerInfo();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetFruit".ToUpper())//获取预约结果
                {
                    GetFruit();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Refuse".ToUpper())//拒绝原因
                {
                    Refuse();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Submit".ToUpper())//保存反馈
                {
                    Submit();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "SubmitArrival".ToUpper())//保存反馈
                {
                    SubmitArrival();
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

        

            #region 查询客户信息
                /// <summary>
                /// 查询客户信息
                /// </summary>
                private void GetCustomerInfo() 
                {
                    string strSQL = @"
                        SELECT [Name]
                              ,[VIPCard]
                              ,[MobileNum]
                              ,[BatchNo]
                              ,[DeptID]
                              ,[Depotid]
                              ,[deptName]
                              ,[CompanyName]
                              ,[points]
                              ,[LoyaltyType]
                              ,[Age]
                              ,[TwelveMonthsConsumptionNum]
                              ,CONVERT(varchar(100), [Birthday], 23) AS [Birthday]
                              ,[Level]
                              ,[CustomerManager]
                              ,CONVERT(varchar(100), [SeekDate], 23) AS [SeekDate]
                              ,[CustomerManagerID]
                              ,[VIPID]
                              ,CONVERT(varchar(100), [RecentConsumptionDate], 23) AS [RecentConsumptionDate]
                              ,[RecentConsumptionAmount]
                              ,[ThisYearConsumptionAmount]
                              ,[LastYearConsumpitonAmount]
                              ,[TwelveMonthsConsumptionAmount]
                              ,[TotalNum]
                              ,[TotalAmount]
                          FROM [B01_MDM].[CUS1_CustomerDoc]
                          WHERE 1=1" + m_hzyPageInfo.Where;
                    m_ReturnData = conn.GetDataSet(strSQL);
                }
            #endregion
            
            #region 取预约结果
                private void GetFruit()
                {
                    string strType = dt_MainList.Rows[0]["Type"].ToString();
                    string strSQL = @"
                        SELECT [ID]
                                ,[Name]
                        FROM [M01_CONF].[DICP_Dictionary]
                        WHERE [Type] = '" + strType + "'";
                    m_ReturnData = conn.GetDataSet(strSQL);
                }
            #endregion

            #region 拒绝原因
                /// <summary>
                /// 返回拒绝原因数据集
                /// </summary>
                private void Refuse()
                {
                    string strType = dt_MainList.Rows[0]["Type"].ToString();
                    string strSQL = @"
                            SELECT [ID]  
                                  ,[Name]
                              FROM [M01_CONF].[DICP_Dictionary]
                              WHERE [Type] = '" + strType + "'";
                    m_ReturnData = conn.GetDataSet(strSQL);
                }
            #endregion

            #region 保存反馈

                private void Submit() {
                    
                    string strTimeAgain = dt_MainList.Rows[0]["ReservationDateAgain"].ToString();
                    //再次预约
                    DataTable dtAgain = new DataTable();
                    if (strTimeAgain != "")
                    {

                        //再次预约时间
                        DateTime dateAgain = Convert.ToDateTime(strTimeAgain);
                        //任务ID
                        string strID = dt_MainList.Rows[0]["ID"].ToString();

                        string strSQL = @"SELECT [ID]
                                    ,[TK1_ID]
                                    ,[Seq]
                                    ,[Name]
                                    ,[Desp]
                                    ,[Depotid]
                                    ,[Status]
                                    ,[ReservationDate]
                                    ,[ValidateState]
                                    ,[ValidateFrom]
                                    ,[ValidateTo]
                                    ,[CUS1_ID]
                                    ,[Rgdt]
                                    ,[RgUser]
                                  FROM [M02_BPM].[TK2_TaskDetail]
                                  WHERE ID='" + strID + "'";
                        dtAgain = conn.GetDataTable(strSQL);

                        //任务名ID
                        string strTskID = dtAgain.Rows[0]["TK1_ID"].ToString();

                        //策略
                        string strSQL1 = @"
                            SELECT 
                                ISNULL(T2.[PostDate],0) AS [PostDate]
                               ,ISNULL(T2.[PreDate],0) AS [PreDate]
                            FROM [M02_BPM].[TK1_TaskHead] T1
                            LEFT JOIN [M01_CONF].[DIST_DistributeStrategy] T2 ON T1.DIST_ID = T2.ID
                            WHERE T1.[ID] = '" + strTskID + "'";
                        //策略
                        DataTable dt = conn.GetDataTable(strSQL1);

                        //策略天数    
                        int iPreDate = Convert.ToInt32(dt.Rows[0]["PostDate"].ToString());
                        int iPostDate = Convert.ToInt32(dt.Rows[0]["PreDate"].ToString());
                        //时间范围
                        string strValidateFrom = dateAgain.AddDays(-iPreDate).ToString();
                        string strValidateTo = dateAgain.AddDays(iPostDate).ToString();
                        //GUID
                        string strGUID = System.Guid.NewGuid().ToString();

                        dtAgain.Rows[0]["ID"] = strGUID;
                        dtAgain.Rows[0]["ValidateFrom"] = strValidateFrom;
                        dtAgain.Rows[0]["ValidateTo"] = strValidateTo;
                        dtAgain.Rows[0]["ReservationDate"] = dateAgain;
                        dtAgain.Rows[0]["Rgdt"] = now;
                        dtAgain.Rows[0]["RgUser"] = dt_MainList.Rows[0]["LmUser"].ToString();
                    }
                    else {
                        dt_MainList.Columns.Remove("ReservationDateAgain");
                    };

                    dt_MainList.Columns.Add("LmDt");
                    dt_MainList.Columns.Add("SubmitTime");
                    dt_MainList.Rows[0]["LmDt"] = now;
                    dt_MainList.Rows[0]["SubmitTime"] = now;

                    bool bResult = false;

                    ArrayList listKey = new ArrayList();
                    listKey.Add("ID");

                    if (dtAgain.Rows.Count != 0)
                    {
                        conn.BeginTransaction(); // 开启事务
                        bResult = conn.Insert("[M02_BPM].[TK2_TaskDetail]", dtAgain);
                        bResult = conn.Update("[M02_BPM].[TK2_TaskDetail]", dt_MainList, listKey);
                        conn.CommitTransaction();
                    }
                    else
                    {
                        conn.BeginTransaction(); // 开启事务
                        bResult = conn.Update("[M02_BPM].[TK2_TaskDetail]", dt_MainList, listKey);
                        conn.CommitTransaction();
                    };

                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
                        dt_EditResult.Rows.Add(new object[] { "再次预约", strTimeAgain });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "提交失败" });
                    }
                    m_ReturnData.Tables.Add(dt_EditResult);
                }

            #endregion

            #region 到店反馈
                private void SubmitArrival() {
                    bool bResult = false;

                    dt_MainList.Columns.Add("LmDt");
                    dt_MainList.Rows[0]["LmDt"] = now;

                    ArrayList listKey = new ArrayList();
                    listKey.Add("ID");


                    conn.BeginTransaction(); // 开启事务
                    bResult = conn.Update("[M02_BPM].[TK2_TaskDetail]", dt_MainList, listKey);
                    conn.CommitTransaction();
           

                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "提交失败" });
                    }
                    m_ReturnData.Tables.Add(dt_EditResult);

                }
            #endregion

            #endregion

                public string strConn { get; set; }
    }
}