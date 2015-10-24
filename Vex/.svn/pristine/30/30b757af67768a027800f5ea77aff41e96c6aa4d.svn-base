using System;
using System.Collections.Generic;
using System.Web;
using System.Diagnostics;
using System.Reflection;
using System.Data;
using System.Security.Cryptography; 
using System.Collections;
using System.ComponentModel; 
using System.Xml;
using System.Xml.Serialization;
using System.Net;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using System.Configuration;
using HZY.COM.Common.Base;

/// 类名：WS_Deploy 
/// 类说明：部署WS
/// 创建人：马卫清
/// 创建日期：2013-08-17
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{
    /// <summary>
    ///WS_Deploy 部署WS
    /// </summary>
    public class WS_Deploy : LogicBase, ILogicExecute
    {
        public WS_Deploy()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 部署WS
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("WSRR");
            Dbconn connDeploy = new Dbconn("WSRR_Deploy");

            try
            {
                if(m_request == null
                    || m_request.Tables.Count==0
                    || m_request.Tables[0].Rows.Count == 0)
                {
                    return true;
                }
                string strWS_ID = m_request.Tables[0].Rows[0]["WS_ID"].ToString();

                string strSQL = "";

                DataSet ds = conn.GetDataSet(@"
                            SELECT * FROM dbo.WS
                            WHERE WS_ID=@param0;

                            SELECT * FROM dbo.WS_Param
                            WHERE WS_ID=@param0",new string[]{strWS_ID});

                if (ds.Tables.Count !=2 || ds.Tables[0].Rows.Count == 0)
                {
                    throw new Exception("WS_ID的信息不正确！");
                }
                string strENV =  ConfigurationManager.AppSettings["WSRR_ENV"];

                if (strENV.ToLower() == "prod")
                {
                    ds.Tables[0].Rows[0]["WS_Host"] = ds.Tables[0].Rows[0]["WS_Host_Test"].ToString();
                }
                else
                {
                    ds.Tables[0].Rows[0]["WS_Host"] = ds.Tables[0].Rows[0]["WS_Host_Prod"].ToString();
                }

                ArrayList tableList = new ArrayList();
                tableList.Add("WS");
                tableList.Add("WS_Param");
                connDeploy.BeginTransaction();
                connDeploy.TableLock(tableList);

                connDeploy.Delete("WS", "WS_ID='" + strWS_ID + "'");
                connDeploy.Delete("WS_Param", "WS_ID='" + strWS_ID + "'");

                connDeploy.Insert("WS", ds.Tables[0]);
                connDeploy.Insert("WS_Param", ds.Tables[1]);
                connDeploy.CommitTransaction();

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