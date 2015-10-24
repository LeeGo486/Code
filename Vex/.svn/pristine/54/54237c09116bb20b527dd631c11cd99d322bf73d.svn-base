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

/// 类名：Feedback
/// 类说明：对CMT_Feedback(任务管理)的CRUD,为Easyui专用
/// 创建人：刘洪
/// 创建日期：2014-07-10
/// 修改人：
/// 修改日期： 
/// 修改内容：
/// 

namespace HZY.COM.WS.HZY_CMT
{
    public class Feedback : HZYLogicBase, ILogicGetData
    {
        #region 构造函数

        public Feedback()
        {
            this.m_SessionCheck = true;
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
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET".ToUpper())//主界面Datagrid
                {
                    Get("");
                }
                else
                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetFruit".ToUpper())//预约反馈下拉
                    {
                        GetFruit();
                    }
                    else
                        if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Refuse".ToUpper())//拒绝原因
                        {
                            Refuse();
                        }
                        else
                            if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Submit".ToUpper()) //保存任务
                            {
                                Submit();
                            }
                            else
                                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "History".ToUpper()) //历史记录
                                {
                                    History();
                                }
                                else
                                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetSearch".ToUpper()) //降级品打印数据的查询
                                    {
                                        GetSearch();
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

            #region DataGrid
                private void Get(string pstrWhere) {
                    string strDepotid = dt_MainList.Rows[0]["Depotid"].ToString();
                    string strSQL = @"
                        SELECT [ID]
                          ,[TK1_ID]
                          ,[Seq]
                          ,[Name]
                          ,[Desp]
                          ,[Status]
                          ,[ValidateState]
                          ,[ValidateFrom]
                          ,[ValidateTo]
                          ,[CUS1_ID]
                          ,[Depotid]
                          ,CONVERT(varchar(100), [ReservationDate], 23) [ReservationDate]
                          ,[DICP_ID_Result]
                          ,[DICP_ID_Reason]
                          ,[ValueInformation]
                          ,[Feedback]
                          ,CONVERT(varchar(100), [InvitationDate], 23) [InvitationDate]
                          ,[ReservationDateAgain]
                          ,CONVERT(varchar(100), [SubmitTime], 23) [SubmitTime]
                          ,[Rgdt]
                          ,[RgUser]
                          ,[LmDt]
                          ,[LmUser]
                          ,[UptNo]
                          ,[Type]
                          ,[Code]
                          ,[Customer]
                          ,[VIPCard]
                          ,[MobileNum]
                          ,[Age]
                          ,CONVERT(varchar(100), [Birthday], 23) [Birthday]
                          ,[Level]
                          ,[CustomerManager]
                          ,[LoyaltyType]
                          ,[Points]
                          ,CONVERT(varchar(100), [SeekDate], 23) [SeekDate]
                          ,CONVERT(varchar(100), [RecentConsumptionDate], 23) [RecentConsumptionDate]
                          ,[RecentConsumptionAmount]
                          ,[ThisYearConsumptionAmount]
                          ,[LastYearConsumpitonAmount]
                          ,[TwelveMonthsConsumptionAmount]
                          ,[TwelveMonthsConsumptionNum]
                          ,[TotalNum]
                          ,[TotalAmount]
                          ,[PreDate]
						  ,[PostDate]
                      FROM [dbo].[View_FbMain]
                      WHERE  [Depotid] = '" + strDepotid + "' AND GETDATE() BETWEEN [ValidateFrom] AND [ValidateTo]" + pstrWhere;
                    m_ReturnData = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                }
                #endregion

            #region 预约查询
                private void GetSearch() {
                    string strDepotid = dt_MainList.Rows[0]["Depotid"].ToString();
                    string strStart = dt_MainList.Rows[0]["StartTime"].ToString();
                    string strEnd = dt_MainList.Rows[0]["EndTime"].ToString();
                    string strManager = dt_MainList.Rows[0]["CustomerManager"].ToString();
                    string strPlanName = dt_MainList.Rows[0]["PlanName"].ToString();
                    string strWhere = "";
                    if (strManager != "") {
                        strWhere += " AND [CustomerManager] LIKE '%" + strManager + "%'";
                    };
                    if (strStart != "") {
                        strWhere += " AND ReservationDate >= cast('" + strStart + "' as datetime) AND ReservationDate <=cast('" + strEnd + "' as datetime)";
                    };
                    if (strPlanName != "") {
                        strWhere += " AND Name LIKE '%" + strPlanName + "%' ";
                    };
                    
                    //调用Get方法（DRY原则）
                    Get(strWhere);
                }
            #endregion

            #region 预约反馈下拉
            private void GetFruit() {
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
                private void Refuse() {
                        string strType = dt_MainList.Rows[0]["Type"].ToString();
                        string strSQL = @"
                            SELECT [ID]  
                                  ,[Name]
                              FROM [M01_CONF].[DICP_Dictionary]
                              WHERE [Type] = '" + strType + "'";
                        m_ReturnData = conn.GetDataSet(strSQL);
                    }
            #endregion

            #region 保存方法

                #region 提交保存
                private void Submit()
                {
                    //任务ID
                    string strID = dt_MainList.Rows[0]["ID"].ToString();
                    //客户策略
                    string strPreDate = dt_MainList.Rows[0]["PreDate"].ToString();
                    string strPostDate = dt_MainList.Rows[0]["PostDate"].ToString();
                    //任务类型
                    string strTask = dt_MainList.Rows[0]["Task"].ToString();
                    //反馈结果
                    string strFruitName = dt_MainList.Rows[0]["FruitName"].ToString();
                    //再次预约时间
                    string strTimeAgain = dt_MainList.Rows[0]["ReservationDateAgain"].ToString();

                    DataTable dsUpdate = new DataTable();
                    DataTable dtTD = new DataTable();

                    string strSQL = @"
                        SELECT [ID]
                                ,[TK1_ID]
                                ,[Seq]
                                ,[Name]
                                ,[Desp]
                                ,[Status]
                                ,[ValidateState]
                                ,[ValidateFrom]
                                ,[ValidateTo]
                                ,[CUS1_ID]
                                ,[Depotid]
                                ,[ReservationDate]
                                ,[DICP_ID_Result]
                                ,[DICP_ID_Reason]
                                ,[ValueInformation]
                                ,[Feedback]
                                ,[InvitationDate]
                                ,[ReservationDateAgain]
                                ,[SubmitTime]
                                ,[Rgdt]
                                ,[RgUser]
                                ,[LmDt]
                                ,[LmUser]
                        FROM [M02_BPM].[TK2_TaskDetail]
                        WHERE [ID] = '" + strID + "'";
                    dsUpdate = conn.GetDataTable(strSQL);

                    if (strTask == "客户关怀")
                    {
                        if (strFruitName == "接收关怀")
                        {
                            //状态
                            dsUpdate.Rows[0]["Status"] = "已预约";
                            //是否有价值
                            dsUpdate.Rows[0]["ValueInformation"] = dt_MainList.Rows[0]["ValueInformation"];
                            //应邀日期
                            dsUpdate.Rows[0]["InvitationDate"] = dsUpdate.Rows[0]["ReservationDate"];
                            //预约结果
                            dsUpdate.Rows[0]["DICP_ID_Result"] = dt_MainList.Rows[0]["Fruit"];
                            //反馈意见
                            dsUpdate.Rows[0]["Feedback"] = dt_MainList.Rows[0]["Feedback"];
                            //提交时间
                            dsUpdate.Rows[0]["SubmitTime"] = now;
                            //修改时间
                            dsUpdate.Rows[0]["LmDt"] = now;
                            //修改人
                            dsUpdate.Rows[0]["LmUser"] = this.hzyMessage.User_Name_CN;
                        }
                        else if (strFruitName == "空号/号码已更换")
                        {
                            dsUpdate.Rows[0]["Status"] = "已预约";

                            //提交时间
                            dsUpdate.Rows[0]["SubmitTime"] = now;

                            dsUpdate.Rows[0]["DICP_ID_Result"] = dt_MainList.Rows[0]["Fruit"];

                            dsUpdate.Rows[0]["LmDt"] = now;

                            dsUpdate.Rows[0]["LmUser"] = this.hzyMessage.User_Name_CN;
                        }
                        else if (strFruitName == "拒绝")
                        {
                            dsUpdate.Rows[0]["Status"] = "已预约";

                            dsUpdate.Rows[0]["ValueInformation"] = dt_MainList.Rows[0]["ValueInformation"];

                            dsUpdate.Rows[0]["Feedback"] = dt_MainList.Rows[0]["Feedback"];

                            dsUpdate.Rows[0]["DICP_ID_Result"] = dt_MainList.Rows[0]["Fruit"];
                            //拒绝原因
                            dsUpdate.Rows[0]["DICP_ID_Reason"] = dt_MainList.Rows[0]["Reason"];
                            //提交时间
                            dsUpdate.Rows[0]["SubmitTime"] = now;

                            dsUpdate.Rows[0]["LmDt"] = now;

                            dsUpdate.Rows[0]["LmUser"] = this.hzyMessage.User_Name_CN;
                        }
                        else
                        {
                            if (strTimeAgain != "")
                            {
                                //生成需要新建的dt
                                dtTD = TaskDetailData(strTimeAgain, strPreDate, strPostDate, dsUpdate);
                                string strGUID = System.Guid.NewGuid().ToString();
                                dtTD.Rows[0]["ID"] = strGUID;
                                dtTD.Rows[0]["ReservationDate"] = strTimeAgain;
                                dsUpdate.Rows[0]["ReservationDateAgain"] = strTimeAgain;
                            };
                            dsUpdate.Rows[0]["Status"] = "已预约";
                            dsUpdate.Rows[0]["DICP_ID_Result"] = dt_MainList.Rows[0]["Fruit"];
                            dsUpdate.Rows[0]["SubmitTime"] = now;
                            dsUpdate.Rows[0]["LmDt"] = now;
                            dsUpdate.Rows[0]["LmUser"] = this.hzyMessage.User_Name_CN;
                        };
                    }
                    else       //销售预约或者活动预约
                    {
                        if (strFruitName == "无应答")
                        {
                            if (strTimeAgain != "")
                            {
                                //生成需要新建的dt
                                dtTD = TaskDetailData(strTimeAgain, strPreDate, strPostDate, dsUpdate);
                                string strGUID = System.Guid.NewGuid().ToString();
                                dtTD.Rows[0]["ID"] = strGUID;
                                dtTD.Rows[0]["ReservationDate"] = strTimeAgain;
                                dsUpdate.Rows[0]["ReservationDateAgain"] = strTimeAgain;
                            };
                            dsUpdate.Rows[0]["Status"] = "已预约";
                            dsUpdate.Rows[0]["DICP_ID_Result"] = dt_MainList.Rows[0]["Fruit"];
                            dsUpdate.Rows[0]["SubmitTime"] = now;
                            dsUpdate.Rows[0]["LmDt"] = now;
                            dsUpdate.Rows[0]["LmUser"] = this.hzyMessage.User_Name_CN;
                        }
                        else if (strFruitName == "拒绝" || strFruitName == "不确定")
                        {
                            if (strTimeAgain != "")
                            {
                                //生成需要新建的dt
                                dtTD = TaskDetailData(strTimeAgain, strPreDate, strPostDate, dsUpdate);
                                string strGUID = System.Guid.NewGuid().ToString();
                                dtTD.Rows[0]["ID"] = strGUID;
                                dtTD.Rows[0]["ReservationDate"] = strTimeAgain;
                                dsUpdate.Rows[0]["ReservationDateAgain"] = strTimeAgain;
                            };
                            dsUpdate.Rows[0]["Status"] = "已预约";
                            dsUpdate.Rows[0]["DICP_ID_Reason"] = dt_MainList.Rows[0]["Reason"];
                            dsUpdate.Rows[0]["DICP_ID_Result"] = dt_MainList.Rows[0]["Fruit"];
                            dsUpdate.Rows[0]["SubmitTime"] = now;
                            dsUpdate.Rows[0]["LmDt"] = now;
                            dsUpdate.Rows[0]["LmUser"] = this.hzyMessage.User_Name_CN;
                        }
                        else if (strFruitName == "空号/号码已更换")
                        {
                            dsUpdate.Rows[0]["Status"] = "已预约";

                            //提交时间
                            dsUpdate.Rows[0]["SubmitTime"] = now;

                            dsUpdate.Rows[0]["DICP_ID_Result"] = dt_MainList.Rows[0]["Fruit"];

                            dsUpdate.Rows[0]["LmDt"] = now;

                            dsUpdate.Rows[0]["LmUser"] = this.hzyMessage.User_Name_CN;
                        }
                        else if (strFruitName == "应邀")
                        {
                            dsUpdate.Rows[0]["Status"] = "已预约";
                            dsUpdate.Rows[0]["InvitationDate"] = dt_MainList.Rows[0]["InvitationDate"];
                            dsUpdate.Rows[0]["DICP_ID_Result"] = dt_MainList.Rows[0]["Fruit"];
                            dsUpdate.Rows[0]["SubmitTime"] = now;
                            dsUpdate.Rows[0]["LmDt"] = now;
                            dsUpdate.Rows[0]["LmUser"] = this.hzyMessage.User_Name_CN;
                        };
                    };

                    bool bResult = false;

                    ArrayList listKey = new ArrayList();
                    listKey.Add("ID");

                    if (dtTD.Rows.Count != 0)
                    {
                        conn.BeginTransaction(); // 开启事务
                        bResult = conn.Insert("[M02_BPM].[TK2_TaskDetail]", dtTD);
                        bResult = conn.Update("[M02_BPM].[TK2_TaskDetail]", dsUpdate, listKey);
                        conn.CommitTransaction();
                    }
                    else
                    {
                        conn.BeginTransaction(); // 开启事务
                        bResult = conn.Update("[M02_BPM].[TK2_TaskDetail]", dsUpdate, listKey);
                        conn.CommitTransaction();
                    };

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

                #region 创建Table
                private DataTable CreatTable()
                {
                    DataTable dtTD = new DataTable();

                    //添加列
                    dtTD.Columns.Add("ID");
                    dtTD.Columns.Add("TK1_ID");
                    dtTD.Columns.Add("Seq");
                    dtTD.Columns.Add("Name");
                    dtTD.Columns.Add("Desp");
                    dtTD.Columns.Add("Status");
                    dtTD.Columns.Add("ValidateState");
                    dtTD.Columns.Add("ValidateFrom");
                    dtTD.Columns.Add("ValidateTo");
                    dtTD.Columns.Add("CUS1_ID");
                    dtTD.Columns.Add("Depotid");
                    dtTD.Columns.Add("ReservationDate");
                    dtTD.Columns.Add("DICP_ID_Result");
                    dtTD.Columns.Add("DICP_ID_Reason");
                    dtTD.Columns.Add("ValueInformation");
                    dtTD.Columns.Add("Feedback");
                    dtTD.Columns.Add("InvitationDate");
                    dtTD.Columns.Add("ReservationDateAgain");
                    dtTD.Columns.Add("SubmitTime");
                    dtTD.Columns.Add("Rgdt");
                    dtTD.Columns.Add("RgUser");
                    dtTD.Columns.Add("LmDt");
                    dtTD.Columns.Add("LmUser");
                    dtTD.Columns.Add("UptNo");

                    dtTD.TableName = "dtTD";
                    return dtTD;
                }
                #endregion

                #region 再次预约数据创建
                /// <summary>
                /// 创建再次预约所需要的dt
                /// </summary>
                /// <param name="strTimeAgain">再次预约时间</param>
                /// <param name="strPreDate">策略</param>
                /// <param name="strPostDate">策略</param>
                /// <param name="dsUpdate">需要的dt</param>
                /// <returns>新dt</returns>
                /// 
                private DataTable TaskDetailData(string strTimeAgain, string strPreDate, string strPostDate, DataTable dsUpdate)
                {
                    DataTable dtTD = CreatTable();//新建表
                    //根据策略计算时间

                    //再次预约时间
                    DateTime dateAgain = Convert.ToDateTime(strTimeAgain);
                    //策略天数    
                    int iPreDate = Convert.ToInt32(strPreDate);
                    int iPostDate = Convert.ToInt32(strPostDate);
                    //时间范围
                    string strValidateFrom = dateAgain.AddDays(-iPreDate).ToString();
                    string strValidateTo = dateAgain.AddDays(iPostDate).ToString();
                    //GUID
                    string strGUID = System.Guid.NewGuid().ToString();

                    //表中行数据复制
                    DataRow drTD = dtTD.NewRow();
                    drTD = dsUpdate.Rows[0];
                    dtTD.ImportRow(drTD);

                    //更新数据
                    dtTD.Rows[0]["ID"] = strGUID;
                    dtTD.Rows[0]["ValidateFrom"] = strValidateFrom;
                    dtTD.Rows[0]["ValidateTo"] = strValidateTo;
                    dtTD.Rows[0]["ReservationDate"] = strTimeAgain;
                    dtTD.Rows[0]["Rgdt"] = now;
                    dtTD.Rows[0]["RgUser"] = this.hzyMessage.User_Name;
                    dtTD.Rows[0]["LmDt"] = now;
                    dtTD.Rows[0]["LmUser"] = this.hzyMessage.User_Name;
                    return dtTD;
                }
                #endregion

            #endregion

            #region 历史信息
            /// <summary>
            /// 历史信息
            /// </summary>
                private void History() {

                    string strDeportID = dt_MainList.Rows[0]["DeportId"].ToString();
                    string strCUS1_ID = dt_MainList.Rows[0]["CUS1_ID"].ToString();

                    string strSQL = @"
                            SELECT [MaintenanceContent]
                                  ,[SubmitTime]
                                  ,[JobName]
                                  ,[LmUser]
                            FROM [dbo].[View_History]
                            WHERE [Depotid] = '" + strDeportID + "' AND [CUS1_ID] = '" + strCUS1_ID + "'";

                    m_ReturnData = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                }
            #endregion


        #endregion


    }
}
