using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;
using HZY.COM.WS.AMSendWS;

namespace HZY.COM.WS.WSExePlan
{
    /// <summary>
    ///WSScheduling_AddNewExecute 添加新执行任务
    /// </summary>
    public class WSScheduling_AddNewExecute : LogicBase, ILogicExecute
    {
        public WSScheduling_AddNewExecute()
        {
            this.m_SessionCheck = false;
        }

        public bool Execute()
        {
            bool bSendAMMessage = false;
            Dbconn conn = new Dbconn("MDM");
            string strWS_ID = base.m_request.Tables[0].Rows[0]["WS_ID"].ToString();
            bool strExecute_Result = Convert.ToBoolean(base.m_request.Tables[0].Rows[0]["Execute_Result"]);
            string Execute_StartTime = base.m_request.Tables[0].Rows[0]["Execute_StartTime"].ToString();
            DataTable dtWS_Scheduling = new DataTable();
            dtWS_Scheduling.Columns.Add("WS_ID");
            dtWS_Scheduling.Columns.Add("Last_Execute_Time");
            if (strExecute_Result)
            {
                dtWS_Scheduling.Columns.Add("Last_Execute_Right_Time");
            }
            dtWS_Scheduling.Columns.Add("Error_Count");
            dtWS_Scheduling.Columns.Add("UpdateTime", typeof(DateTime));
            DataRow dr = dtWS_Scheduling.NewRow();
            dr["WS_ID"] = strWS_ID;
            dr["Last_Execute_Time"] = Execute_StartTime;
            if (strExecute_Result)
            {
                dr["Last_Execute_Right_Time"] = Execute_StartTime;
                dr["Error_Count"] = 0;
            }
            else
            {
                DataTable dtOld = conn.GetDataTable("SELECT Error_Count FROM dbo.WS_Scheduling WHERE WS_ID = @Param0", new string[] { strWS_ID });
                if (dtOld.Rows.Count == 0)
                {
                    return false;
                }
                int nError_Count = (dtOld.Rows[0]["Error_Count"] == DBNull.Value) ? 0 : Convert.ToInt32(dtOld.Rows[0]["Error_Count"]);
                dr["Error_Count"] = nError_Count + 1;
                if (nError_Count == 4)
                {
                    bSendAMMessage = true;
                }
            }
            dr["UpdateTime"] = DateTime.Now;
            dtWS_Scheduling.Rows.Add(dr);
            DataTable dtWS_Scheduling_Execute_log = base.m_request.Tables[0].Copy();
            ArrayList listLockTable = new ArrayList();
            listLockTable.Add("WS_Scheduling");
            listLockTable.Add("WS_Scheduling_Execute_log");
            try
            {
                conn.TableLock(listLockTable);
                conn.BeginTransaction();
                conn.Update("WS_Scheduling", dtWS_Scheduling, "WS_ID=" + strWS_ID);
                conn.Insert("WS_Scheduling_Execute_log", dtWS_Scheduling_Execute_log);
                conn.CommitTransaction();
            }
            catch
            {
                conn.RollbackTransaction();
            }
            dtWS_Scheduling_Execute_log = null;
            dtWS_Scheduling = null;
            if (bSendAMMessage)
            {
                new MsgCenter().SendMsg("AM", "WEB Service调用程序", "马卫清", "信息部服务中心", "WEB Service调用程序相关任务出错：\\r\\n\r\n                                                                                    任务号为“" + strWS_ID + "”在重试5次之后仍然出错，请查看192.168.0.64:MDM数据库的WS_Scheduling\r\n                                                                                    发生时间为：" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"), DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            }
            return true;

        }

    }

}