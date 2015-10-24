using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.WS.WSExePlan
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
            Dbconn conn = new Dbconn("MDM");
            return conn.GetDataSet(@"
                       SELECT t1.WS_ID ,
                                WS_LogicName
                         FROM   dbo.WS_Scheduling t1 WITH ( NOLOCK )
                         WHERE  t1.Enabled = 1
                                AND ( t1.Last_Execute_Right_Time IS NULL
                                      OR ( DATEDIFF(s, t1.Last_Execute_Right_Time, GETDATE()) > t1.Excute_cycle
                                           AND ISNULL(t1.Error_Count, 0) < 5
                                           AND ISNULL(Execute_type, 'cycle') = 'cycle'
                                         )

				                        --按日
                                      OR ( ( t1.Last_Execute_Right_Time IS NULL
					                        --取今天没有跑过的数据
                                             OR t1.Last_Execute_Right_Time < CONVERT(VARCHAR(10), GETDATE(), 23)
                                             + ' ' + t1.Execute_StartTime

					                        --取今天跑过了，但是到了下一次的执行时间
                                             OR DATEDIFF(s, t1.Last_Execute_Right_Time, GETDATE()) > t1.Excute_cycle
                                           )
                                           AND ISNULL(t1.Error_Count, 0) < 5
                                           AND CONVERT(VARCHAR(8), GETDATE(), 14) > Execute_StartTime
                                           AND ISNULL(Execute_type, 'cycle') = 'day'
                                         )
                                    )
                         ORDER BY WS_ID ;
                         SELECT *
                         FROM   WS_SchedulingParam

");

        }

    }

}