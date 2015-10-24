using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.ST0000A
{
    /// <summary>
    ///WSScheduling_GetCurrentExecuteList 取到任务的当前需要执行的列表 
    /// </summary>
    public class WSScheduling_GetCurrentExecuteList : LogicBase, ILogicGetData
    {
        public WSScheduling_GetCurrentExecuteList()
        {
            this.m_SessionCheck = false;
        }

        public DataSet GetData()
        {
            DataSet ds = null;

            Dbconn conn = new Dbconn("MDM");
            string strSQL = @" SELECT t1.WS_ID ,
                                            TASK_ID,
                                            WS_LogicName,
                                            WS_Name,
                                            URL,
                                            Execute_type,
                                            Execute_StartTime,
                                            Execute_EndTime,
                                            Execute_cycle,
                                            Execute_DayStartTime,
                                            Execute_DayEndTime,
                                            Execute_WeekTime,
                                            Execute_MonthTime,
                                            Enabled
                                     FROM   dbo.WS_Scheduling t1 WITH ( NOLOCK )
                                     WHERE  
		                                    ISNULL(t1.Error_Count, 0) < 5";
            if (m_request.Tables[0].Rows.Count >0 && m_request.Tables[0].Rows[0][0] != null)
            {
                strSQL += " AND UpdateTime > '" + Convert.ToDateTime(m_request.Tables[0].Rows[0][0]).ToString("yyyy-MM-dd HH:mm:ss") + "' ";
            }
            strSQL += "; SELECT * FROM WS_SchedulingParam;";
            ds = conn.GetDataSet(strSQL);

            return ds;
        }

    }

}