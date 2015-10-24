using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：SessionTimeOutClear
/// 类说明：清除过期的SesionID
/// 创建人：马卫清
/// 创建日期：2013-11-14
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.SSO
{

    public class SessionTimeOutClear : LogicBase,ILogicExecute
    {
        public SessionTimeOutClear()
        {
            this.m_SessionCheck = false;

        }

        private Dbconn conn = new Dbconn("VexSSO");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        /// <summary>
        /// 对CFG_RequestType的CRUD,为Easyui专用
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {

            DateTime time = DateTime.Now;

            Dbconn conn = new Dbconn("VexSSO");
            conn.LockTableList.Add("SSO_Login");
            conn.BeginTransaction();
            conn.TableLock();

            string strSQL = @"
                                UPDATE dbo.SSO_Login
                                SET Logout_Time='" + time.ToString("yyyy-MM-dd HH:mm:ss.fff")+ @"',
                                MARK='SYSTEM'
                                WHERE Last_Request_Time<='" + time.AddDays(-1).ToString("yyyy-MM-dd HH:mm:ss.fff") + @"'
                                    AND Logout_Time IS NULL
                            ";

            conn.ExcuteQuerryByTran(strSQL);
            conn.CommitTransaction();


            return true ;
        }
    }

}