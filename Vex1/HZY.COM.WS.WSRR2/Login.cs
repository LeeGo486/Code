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

/// 类名：Login
/// 类说明：用户登录入口，登录成功后，会返回一个SessionID
/// 创建人：马卫清
/// 创建日期：2014-04-14
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{

    public class Login : HZYLogicBase, ILogicGetData
    {
        public Login()
        {
            this.m_SessionCheck = false;
        }

        private Dbconn conn = new Dbconn("WSRR");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                string strUserName = m_request.Tables[0].Rows[0]["UserName"].ToString();
                string strPassWord = m_request.Tables[0].Rows[0]["PassWord"].ToString();
                if (strUserName == "" || strPassWord == "")
                {
                    throw new Exception("传入的参数为空！");
                }
                string strSessionID = "";

                conn.BeginTransaction();
                string strSQL = @"
                            SELECT   1 as a
                            FROM    F01_Cert.[User] 
                            WHERE  UserName=@Param0 AND PassWord=@Param1 ";
                int nCount = conn.GetDataTableRowCount(strSQL, new string[] { strUserName, strPassWord });

                //登录成功
                if (nCount == 1)
                {
                    strSessionID = Guid.NewGuid().ToString();
                    strSQL = "INSERT INTO F01_Cert.Login(LoginSessionID,LoginUser,PassWord,LoginTime,LastVisitTime)VALUES(@Param0,@Param1,@Param2,GETDATE(),GETDATE())";
                    conn.ExcuteQuerryByTran(strSQL, new string[] { strSessionID, strUserName, strPassWord });
                }
                //登录失败
                else
                {
                    throw new Exception("错误的用户名或者密码！");

                }

                conn.CommitTransaction();
                DataTable dt = new DataTable();
                dt.Columns.Add("SessionID");
                dt.Rows.Add(new object[] { strSessionID });

                ds_Return.Tables.Add(dt);
                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
    }
}
