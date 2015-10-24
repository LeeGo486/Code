using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;
using System.Text;

namespace HZY.COM.ST0000A
{
    /// <summary>
    ///WSScheduling_AddNewExecute 添加执行任务日志，并更新任务项
    /// </summary>
    public class WSScheduling_AddNewExecute : LogicBase, ILogicExecute
    {
        public WSScheduling_AddNewExecute()
        {
            this.m_SessionCheck = false;
        }

        public bool Execute()
        {
            bool bSendAMMessage = false;    //变量，判断是否需要发送小翅膀信息
            Dbconn conn = new Dbconn("MDM");    //创建MDM的连接对象

            string strTask_ID = this.m_request.Tables[0].Rows[0]["TASK_ID"].ToString(); //获取参数任务ID
            bool strExecute_Result = Convert.ToBoolean(this.m_request.Tables[0].Rows[0]["Execute_Result"]);    //获取参数执行结果
            string Execute_StartTime = this.m_request.Tables[0].Rows[0]["Execute_StartTime"].ToString();      //获取参数执行开始时间
            int nRemind_ErrorCount = 1;//错误次数达到多少时提醒，默认设置1
            string strRemind_UserName = string.Empty;  //达到错误次数时，需要提醒的用户
            string strTaskName = string.Empty;

            //创建DataTable
            DataTable dtWS_Scheduling = new DataTable();
            dtWS_Scheduling.Columns.Add("TASK_ID");
            dtWS_Scheduling.Columns.Add("Last_Execute_Time");
            if (strExecute_Result)
            {
                dtWS_Scheduling.Columns.Add("Last_Execute_Right_Time");
            }
            dtWS_Scheduling.Columns.Add("Error_Count");

            //设置更新信息
            DataRow dr = dtWS_Scheduling.NewRow();
            dr["TASK_ID"] = strTask_ID;
            dr["Last_Execute_Time"] = Execute_StartTime;
            if (strExecute_Result)
            {
                dr["Last_Execute_Right_Time"] = Execute_StartTime;
                dr["Error_Count"] = 0;
            }
            else
            {
                //根据TaskID获取任务名称，错误次数，提醒错误次数，需提醒用户
                DataTable dtOld = conn.GetDataTable("SELECT WS_Name,Error_Count,Remind_ErrorCount, Remind_UserName FROM dbo.WS_Scheduling WHERE TASK_ID = @Param0", new string[] { strTask_ID });
                if (dtOld.Rows.Count == 0)
                {
                    return false;
                }

                int nError_Count = dtOld.Rows[0]["Error_Count"] == DBNull.Value ? 0 : Convert.ToInt32(dtOld.Rows[0]["Error_Count"]);
                nRemind_ErrorCount = dtOld.Rows[0]["Remind_ErrorCount"] == DBNull.Value ? 1 : Convert.ToInt32(dtOld.Rows[0]["Remind_ErrorCount"]);
                strRemind_UserName = dtOld.Rows[0]["Remind_UserName"] == DBNull.Value ? "郭琦琦" : dtOld.Rows[0]["Remind_UserName"].ToString();
                strTaskName = dtOld.Rows[0]["WS_Name"] == DBNull.Value ? string.Empty : dtOld.Rows[0]["WS_Name"].ToString();

                dr["Error_Count"] = nError_Count + 1;
                if (nError_Count == nRemind_ErrorCount)
                {
                    bSendAMMessage = true;
                }
            }
            dtWS_Scheduling.Rows.Add(dr);

            //创建插入日志表的DataTable
            DataTable dtWS_Scheduling_Execute_log = this.m_request.Tables[0].Copy();

            ArrayList listLockTable = new ArrayList();
            listLockTable.Add("WS_Scheduling");
            listLockTable.Add("WS_Scheduling_Execute_log");
            try
            {
                conn.TableLock(listLockTable);
                conn.BeginTransaction();

                //更新WS_Scheduling表
                conn.Update("WS_Scheduling", dtWS_Scheduling, "TASK_ID='" + strTask_ID + "'");

                //往dbo.WS_Scheduling_Execute_log表里面增加数据
                conn.Insert("WS_Scheduling_Execute_log", dtWS_Scheduling_Execute_log);
                conn.CommitTransaction();
            }
            catch
            {
                conn.RollbackTransaction();
            }

            dtWS_Scheduling_Execute_log = null; //清空
            dtWS_Scheduling = null; //清空

            if (bSendAMMessage)
            {
                //小翅膀发送信息对象
                AMSendWS.MsgCenter cls = new AMSendWS.MsgCenter();
                //发送信息
                StringBuilder sbContent = new StringBuilder();
                sbContent.Append(" 任务[");
                sbContent.Append(strTaskName);
                sbContent.Append("]在重试");
                sbContent.Append(nRemind_ErrorCount);
                sbContent.Append("次之后仍然出错，请查看192.168.0.64:MDM数据库的WS_Scheduling，发生时间为：");
                sbContent.Append(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                //发送信息
                cls.SendMsg("AM", "WEB Service调用程序", strRemind_UserName, "信息部服务中心", sbContent.ToString(), DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cls.SendMsg("SMS", "WEB Service调用程序", "13736814324", "", sbContent.ToString(), DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            }

            return true;
        }

    }

}