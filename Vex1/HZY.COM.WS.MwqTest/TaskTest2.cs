using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Collections;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：TaskTest1
/// 类说明：调度程序测试
/// 创建人：马卫清
/// 创建日期：2014-11-15
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MwqTest
{

    public class TaskTest2 : HZYLogicBase, ILogicExecute
    {
        public TaskTest2()
        {
            this.m_SessionCheck = false;
        }

        private Dbconn conn = new Dbconn("Mwq_test");
        DateTime timeNow = DateTime.Now;

        public bool  Execute()
        {
            try
            {

                string strParam1 = "";
                string strParam2 = "";
                string strParam0 = "";
                string strTaskType = "";

                strParam1 = m_request.Tables[0].Rows[0]["Param1"].ToString();
                strParam2 = m_request.Tables[0].Rows[0]["Param2"].ToString();
                strParam0 = m_request.Tables[0].Rows[0]["Param0"].ToString();
                strTaskType = m_request.Tables[0].Rows[0]["TaskType"].ToString();

                DataTable dt = new DataTable();
                dt.Columns.Add("ExecuteType");
                dt.Columns.Add("Param0");
                dt.Columns.Add("Param1");
                dt.Columns.Add("Param2");
                dt.Columns.Add("TaskType");

                dt.Rows.Add(new object[] { "Execute", strParam0, strParam1, strParam2, strTaskType });
                conn.BeginTransaction();
                conn.Insert("Log_Task", dt);
                conn.CommitTransaction();

                return true;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
    }
}
