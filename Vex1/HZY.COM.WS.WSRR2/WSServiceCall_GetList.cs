using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

/// 类名：WSServiceCall_ForEasyUI 
/// 类说明：任务列表项目列表获取操作
/// 创建人：HWA-沈加华
/// 创建日期：2014-11-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{
    /// <summary>
    /// 任务列表项目列表获取操作
    /// </summary>
    public class WSServiceCall_GetList : HZYLogicBase, ILogicGetData
    {
        public WSServiceCall_GetList()
        {
            this.m_SessionCheck = false;
        }

        /// <summary>
        /// 任务列表项目列表获取
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strWhere = string.Empty; //where条件
                string strSearchFilter = string.Empty;  //筛选条件

                if (m_request != null && m_request.Tables.Contains("Page_Info"))
                {
                    strWhere = m_request.Tables[0].Rows[0]["where"].ToString() ;    //获取where条件

                    if (m_request.Tables[0].Columns.Contains("searchFilter"))   //获取筛选条件
                    {
                        strSearchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : strSearchFilter;
                    }
                    if (strWhere.Trim() != "")
                    {
                        strWhere = " AND " + strWhere;
                    }

                    if (strSearchFilter.Trim() != "")
                    {
                        strWhere = " AND " + strSearchFilter;
                    }
                    if (string.IsNullOrEmpty(m_hzyPageInfo.Sort)) {
                        m_hzyPageInfo.Sort = "UpdateTime";
                        m_hzyPageInfo.Order =  "desc ";
                    }
                    
                }

                Dbconn conn = new Dbconn("WSRR");    //创建连接类
                string strSQL = @"   
                    SELECT 
                               [TASK_ID]
                              ,[WS_ID]
                              ,[URL]
                              ,[WS_Name]
                              ,[WS_LogicName]
                              ,[WS_PID]
                              ,[Execute_Type]
                              ,[Execute_StartTime]
                              ,[Execute_EndTime]
                              ,[Execute_Cycle]
                              ,[Execute_DayStartTime]
                              ,[Execute_DayEndTime]
                              ,[Execute_WeekTime]
                              ,[Execute_MonthTime]
                              ,[Enabled]
                              ,[IsDeleted]
                              ,[Last_Execute_Time]
                              ,[Last_Execute_Right_Time]
                              ,[Error_Count]
                              ,[Remind_ErrorCount]
                              ,[Remind_UserName]
                              ,[CreateUser]
                              ,[CreateTime]
                              ,[UpdateUser]
                              ,[UpdateTime]
                    FROM    WS_Scheduling WITH ( NOLOCK ) WHERE 1=1  AND IsDeleted='False' " + strWhere;
                DataSet ds = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);  //调用方法，获取分页数据

                return ds;
            }
            catch
            {
                throw;
            }
        }

    }
}
