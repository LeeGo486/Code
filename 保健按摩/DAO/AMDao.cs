using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DBUtility;
using System.Data;
using System.Data.SqlClient;

namespace DAO
{
    public class AMDao
    {
        public static string connectionString = PubConstant.AMConnectionString112;



        public bool AddAmDetail(string receiver, string sender, string subject, string content)
        {
            string SqlString = "insert into AMAutoSendMsg( MsgReceiver	,MsgSender,	MsgSubject,	MsgContent,	MsgType,isRead,InsertDate) "
                             + "values('" + receiver + " ','" + sender + "','" + subject + "','" + content + "','Text/Html','0',getdate())";
            if (DBUtility.DbHelperSQL.ConnectExecuteSql(connectionString, SqlString) > 0)
            {
                return true;
            }
            return false;
        }

        public DataTable GetInfo(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            strSql.Append("TN_SYS_EM_USER.CN_LOGIN,TN_SYS_EM_USER.CN_NOTE,TN_SYS_EM_USER_PROP.CN_DEPTINFO,TN_SYS_EM_USER_PROP.CN_HANDSET,TN_SYS_EM_USER_PROP.CN_O_PHONE ");
            strSql.Append(" FROM TN_SYS_EM_USER INNER JOIN TN_SYS_EM_USER_PROP ON TN_SYS_EM_USER.CN_ID = TN_SYS_EM_USER_PROP.CN_USERID ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append("order by TN_SYS_EM_USER.CN_LOGIN");
            return DbHelperSQL.Query(connectionString, strSql.ToString()).Tables[0];
        }



        public bool Login(string loginname, string password)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select CN_LOGIN,CN_PASSWORD FROM TN_SYS_EM_USER where CN_LOGIN = '" + loginname + "'");
            SqlDataReader dr = (SqlDataReader)DbHelperSQL.ExecuteReader(connectionString, strSql.ToString(), null);
            bool flag = false;

            if (dr.Read())
            {
                string pwd = dr.GetString(1);
                if (password.Equals(pwd))
                {
                    flag = true;
                }
            }
            return flag;
        }
    }
}
