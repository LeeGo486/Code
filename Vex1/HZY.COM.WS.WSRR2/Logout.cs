using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System.Collections;
using HZY.COM.Common.Base;

/// 类名：Logout
/// 类说明：用户登录入口，登录成功后，会返回一个SessionID
/// 创建人：马卫清
/// 创建日期：2014-04-14
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{

    public class Logout : HZYLogicBase, ILogicGetData
    {
        public Logout()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn = new Dbconn("WSRR");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;

        public DataSet GetData()
        {
            DataSet ds = new DataSet();
            DataSet ds_Return = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add("Result");
            dt.Rows.Add(new object[] { true });

            ds_Return.Tables.Add(dt);
            try
            {
                string strSessionID = hzyMessage.Session_ID;
                
                conn.BeginTransaction();
                string strSQL = "";

                strSQL = "Update  F01_Cert.Login SET LogoutTime=getdate() where LoginSessionID=@param0";
                conn.ExcuteQuerryByTran(strSQL, new string[] { strSessionID });
               
                conn.CommitTransaction();
              
            }
            catch
            {
                conn.RollbackTransaction();
            }
            return ds_Return;
          
        }
    }
}
