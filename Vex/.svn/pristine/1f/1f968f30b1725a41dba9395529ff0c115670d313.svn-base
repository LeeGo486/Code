using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using System.Data.SqlClient;

namespace HZY.COM.WS.DRP
{
    class Log
    {
        private string m_logId = "";
        Dbconn conn_log = new Dbconn("DRP_EC");


        public string WritePostLog(string pstrType, string pstrUrl, string pstrInputData)
        {
            try
            {
                m_logId = System.Guid.NewGuid().ToString();
                DataTable dtLog = new DataTable();
                dtLog.Columns.Add("Log_Id");
                dtLog.Columns.Add("Log_Time");
                dtLog.Columns.Add("Type");
                dtLog.Columns.Add("Url");
                dtLog.Columns.Add("InputData");

                dtLog.Rows.Add(new object[] { m_logId, DateTime.Now, pstrType, pstrUrl, pstrInputData });
                conn_log.BeginTransaction();
                conn_log.Insert("Log_Interface_PostData", dtLog);
                conn_log.CommitTransaction();
                return m_logId;
            }
            catch
            {
                conn_log.RollbackTransaction();
                return "";

            }
        }

        public void WritePostLogUpdateResult(string pstrResult)
        {
            if (m_logId != "")
            {
                try
                {
                    DataTable dtLog = new DataTable();
                    dtLog.Columns.Add("Result");
                    dtLog.Columns.Add("Update_time");

                    dtLog.Rows.Add(new object[] { pstrResult, DateTime.Now });
                    conn_log.BeginTransaction();
                    conn_log.Update("Log_Interface_PostData", dtLog, "Log_Id='" + m_logId + "'");
                    conn_log.CommitTransaction();

                }
                catch
                {

                    conn_log.RollbackTransaction();

                }
                
            }
        }
    }
}
