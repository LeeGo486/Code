using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Xml;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.WSRR
{

    /// <summary>
    ///WSRR分析
    /// </summary>
    public class WSRR_LogAnalysis : LogicBase, ILogicGetData
    {

        public WSRR_LogAnalysis()
        {
            this.m_SessionCheck = false;
        }

        public DataSet GetData()
        {

            DataSet ds_Return = null;
            Dbconn conn = new Dbconn("WSRR_Log");
            conn.BeginTransaction();
            conn.LockTableList.Add("Log_CallByXML");
            conn.LockTableList.Add("Log_CallByXML_His");

            string time = DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd HH:mm:ss.fff");

            DataSet ds = conn.GetDataSetInTrans(@"  SELECT 
                                                        *,
                                                        NULL AS ElapsedTime,
                                                        NULL AS WS_ID,
                                                        NULL AS Session_ID,
                                                        NULL AS AppSN
                                                    FROM Log_CallByXML WHERE Log_Time<'" + time + "'");
            conn.ExcuteQuerryByTran("INSERT INTO Log_CallByXML_HIS SELECT * FROM Log_CallByXML WHERE Log_Time<'" + time + "'");
            conn.CommitTransaction();

            //开始分析
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string strXML = ds.Tables[0].Rows[i]["XmlInput"].ToString();
                string strWS_ID = "";
                string strSession_ID = "";
                string strAppSN = "";
                try
                {
                    XmlDocument xmlDoc = new XmlDocument();
                    xmlDoc.LoadXml(strXML);
                    XmlNode xml = xmlDoc.DocumentElement;
                    strAppSN = xml.Attributes["App"].Value;
                    strWS_ID = xml.Attributes["WSID"].Value;
                    strSession_ID = xml.Attributes["SessionID"].Value;
                    xml = null;
                    xmlDoc = null;
                }
                catch (Exception)
                {

                }

                //ds.Tables[0].Rows
            }

            return ds_Return;
        }
    }

}
