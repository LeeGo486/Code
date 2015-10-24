﻿using System;
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


//WSID：bd09e2d8-cbf8-4e9b-9c23-f5bfeb4acd7f
namespace HZY.COM.WS.HZY_Joreal_CMT
{
    public class Feedback: HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Feedback()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("HZY_JorealCMT");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime now = DateTime.Now;
        private DataTable dt_MainList = new dsCommon.dtResultDataTable();
        private DataSet m_RequestXML = new DataSet();
        private DataSet m_ReturnData = new DataSet();
        #endregion

        #region 主入口
        public DataSet GetData() {
            try
            {
                //接收XML的内容
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                m_RequestXML = Common.Common.GetDSByExcelXML(strXML);
                dt_MainList = m_RequestXML.Tables["List"];

                string strOPTYPE = m_RequestXML.Tables["OPTYPE"].Rows[0]["OPTYPE"].ToString();

                switch (strOPTYPE)
                {
                    case "GetTask": GetTask(""); break;
                    case "Search": Search(); break;
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

        #region GetTask
        private void GetTask(string pstrWhere)
        {
            string strDepotID = m_hzyMessage.User_Name_CN,
                    strDeotID = strDepotID.Substring(0, 8).ToString();
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
                      WHERE  [Depotid] = '" + strDeotID + "' " + pstrWhere;
                      //WHERE  [Depotid] = '" + strDepotid + "' AND GETDATE() BETWEEN [ValidateFrom] AND [ValidateTo]" + pstrWhere;
            m_ReturnData = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region Search
        private void Search()
        {
            
            string strStart = dt_MainList.Rows[0]["StartTime"].ToString();
            string strEnd = dt_MainList.Rows[0]["EndTime"].ToString();
            string strManager = dt_MainList.Rows[0]["CustomerManager"].ToString();
            string strPlanName = dt_MainList.Rows[0]["PlanName"].ToString();
            string strWhere = "";
            if (strManager != "")
            {
                strWhere += " AND [CustomerManager] LIKE '%" + strManager + "%'";
            };
            if (strStart != "")
            {
                strWhere += " AND ReservationDate >= cast('" + strStart + "' as datetime) AND ReservationDate <=cast('" + strEnd + "' as datetime)";
            };
            if (strPlanName != "")
            {
                strWhere += " AND Name LIKE '%" + strPlanName + "%' ";
            };

            //调用Get方法（DRY原则）
            GetTask(strWhere);
        }
        #endregion


        #endregion
    }
}
