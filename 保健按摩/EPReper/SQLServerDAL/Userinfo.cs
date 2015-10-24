using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using EPReper.IDAL;
using EPReper.DBUtility;
using EPReper.Config;
using System.Data.Common;//Please add references
namespace EPReper.SQLServerDAL
{
    /// <summary>
    /// 数据访问类:Userinfo
    /// </summary>
    public partial class Userinfo : IUserinfo
    {
        public Userinfo()
        { }
        #region  Method

        /// <summary>
        /// 得到最大ID
        /// </summary>
        public int GetMaxId()
        {
            return DbHelper.GetMaxID("id", "Userinfo");
        }




        /// <summary>
        /// 增加一条数据
        /// </summary>
        public bool Add(EPReper.Model.Userinfo model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into Userinfo(");
            strSql.Append("id,username,department,phone,AMNum,QQ,Email,URole)");
            strSql.Append(" values (");
            strSql.Append("@id,@username,@department,@phone,@AMNum,@QQ,@Email,@URole)");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4),
					new SqlParameter("@username", SqlDbType.NVarChar,50),
					new SqlParameter("@department", SqlDbType.NVarChar,50),
					new SqlParameter("@phone", SqlDbType.NVarChar,20),
					new SqlParameter("@AMNum", SqlDbType.NVarChar,50),
					new SqlParameter("@QQ", SqlDbType.NVarChar,50),
					new SqlParameter("@Email", SqlDbType.NVarChar,50),
					new SqlParameter("@URole", SqlDbType.Int,4)};
            parameters[0].Value = model.id;
            parameters[1].Value = model.username;
            parameters[2].Value = model.department;
            parameters[3].Value = model.phone;
            parameters[4].Value = model.AMNum;
            parameters[5].Value = model.QQ;
            parameters[6].Value = model.Email;
            parameters[7].Value = model.URole;

            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(EPReper.Model.Userinfo model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update Userinfo set ");
            strSql.Append("username=@username,");
            strSql.Append("department=@department,");
            strSql.Append("phone=@phone,");
            strSql.Append("AMNum=@AMNum,");
            strSql.Append("QQ=@QQ,");
            strSql.Append("Email=@Email,");
            strSql.Append("URole=@URole");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@username", SqlDbType.NVarChar,50),
					new SqlParameter("@department", SqlDbType.NVarChar,50),
					new SqlParameter("@phone", SqlDbType.NVarChar,20),
					new SqlParameter("@AMNum", SqlDbType.NVarChar,50),
					new SqlParameter("@QQ", SqlDbType.NVarChar,50),
					new SqlParameter("@Email", SqlDbType.NVarChar,50),
					new SqlParameter("@URole", SqlDbType.Int,4),
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = model.username;
            parameters[1].Value = model.department;
            parameters[2].Value = model.phone;
            parameters[3].Value = model.AMNum;
            parameters[4].Value = model.QQ;
            parameters[5].Value = model.Email;
            parameters[6].Value = model.URole;
            parameters[7].Value = model.id;

            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from Userinfo ");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = id;

            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /// <summary>
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string idlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from Userinfo ");
            strSql.Append(" where id in (" + idlist + ")  ");
            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql.ToString());
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public EPReper.Model.Userinfo GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 id,username,department,phone,AMNum,QQ,Email,URole from Userinfo ");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = id;

            EPReper.Model.Userinfo model = new EPReper.Model.Userinfo();
            DataSet ds = DbHelper.ExecuteDataSet(CommandType.Text, strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["id"] != null && ds.Tables[0].Rows[0]["id"].ToString() != "")
                {
                    model.id = int.Parse(ds.Tables[0].Rows[0]["id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["username"] != null && ds.Tables[0].Rows[0]["username"].ToString() != "")
                {
                    model.username = ds.Tables[0].Rows[0]["username"].ToString();
                }
                if (ds.Tables[0].Rows[0]["department"] != null && ds.Tables[0].Rows[0]["department"].ToString() != "")
                {
                    model.department = ds.Tables[0].Rows[0]["department"].ToString();
                }
                if (ds.Tables[0].Rows[0]["phone"] != null && ds.Tables[0].Rows[0]["phone"].ToString() != "")
                {
                    model.phone = ds.Tables[0].Rows[0]["phone"].ToString();
                }
                if (ds.Tables[0].Rows[0]["AMNum"] != null && ds.Tables[0].Rows[0]["AMNum"].ToString() != "")
                {
                    model.AMNum = ds.Tables[0].Rows[0]["AMNum"].ToString();
                }
                if (ds.Tables[0].Rows[0]["QQ"] != null && ds.Tables[0].Rows[0]["QQ"].ToString() != "")
                {
                    model.QQ = ds.Tables[0].Rows[0]["QQ"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Email"] != null && ds.Tables[0].Rows[0]["Email"].ToString() != "")
                {
                    model.Email = ds.Tables[0].Rows[0]["Email"].ToString();
                }
                if (ds.Tables[0].Rows[0]["URole"] != null && ds.Tables[0].Rows[0]["URole"].ToString() != "")
                {
                    model.URole = int.Parse(ds.Tables[0].Rows[0]["URole"].ToString());
                }
                return model;
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select CN_ID,CN_LOGIN ");
            strSql.Append(" FROM TN_SYS_EM_USER ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelper.ExecuteDataSet(DBConfig.UserInfoString, CommandType.Text, strSql.ToString(), null);
        }

        /// <summary>
        /// 获得前几行数据
        /// </summary>
        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Top > 0)
            {
                strSql.Append(" top " + Top.ToString());
            }
            strSql.Append(" id,username,department,phone,AMNum,QQ,Email,URole ");
            strSql.Append(" FROM Userinfo ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return DbHelper.ExecuteDataSet(CommandType.Text, strSql.ToString(), null);
        }

        public DataTable GetTable(string strWhere, string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            strSql.Append("CN_LOGIN,CN_NOTE ");
            strSql.Append(" FROM TN_SYS_EM_USER ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
                strSql.Append(" order by " + filedOrder);
            }
            return DbHelper.ExecuteTable(DBConfig.UserInfoString, CommandType.Text, strSql.ToString(), null);
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
            return DbHelper.ExecuteTable(DBConfig.UserInfoString, CommandType.Text, strSql.ToString(), null);
        }
        /*
        public DataTable GetTable( string strWhere,string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            strSql.Append("TN_SYS_EM_USER.CN_LOGIN,TN_SYS_EM_USER_PROP.CN_NOTE ");
            strSql.Append(" FROM TN_SYS_EM_USER INNER JOIN TN_SYS_EM_USER_PROP ON TN_SYS_EM_USER.CN_ID = TN_SYS_EM_USER_PROP.CN_USERID ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
                strSql.Append(" order by " + filedOrder);
            }
            return DbHelper.ExecuteTable(DBConfig.UserInfoString, CommandType.Text, strSql.ToString(), null);
        }*/
        /*
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetList(int PageSize,int PageIndex,string strWhere)
        {
            SqlParameter[] parameters = {
                    new SqlParameter("@tblName", SqlDbType.VarChar, 255),
                    new SqlParameter("@fldName", SqlDbType.VarChar, 255),
                    new SqlParameter("@PageSize", SqlDbType.Int),
                    new SqlParameter("@PageIndex", SqlDbType.Int),
                    new SqlParameter("@IsReCount", SqlDbType.Bit),
                    new SqlParameter("@OrderType", SqlDbType.Bit),
                    new SqlParameter("@strWhere", SqlDbType.VarChar,1000),
                    };
            parameters[0].Value = "Userinfo";
            parameters[1].Value = "id";
            parameters[2].Value = PageSize;
            parameters[3].Value = PageIndex;
            parameters[4].Value = 0;
            parameters[5].Value = 0;
            parameters[6].Value = strWhere;	
            return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
        }*/

        public bool AddAmDetail(string username,string subject,string content)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into AmDetail(InsertTime,Receivers,subject,Content,State,contenttype)");
            strSql.Append(" values (");
            strSql.Append("getdate(),'"+username+"','"+subject+"','"+content+"',0,'Text/html')");

            int rows = DbHelper.ExecuteNonQuery(DBConfig.AMString, CommandType.Text, strSql.ToString(), null);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;

            }
        }

        #endregion  Method


        public bool Login(string loginname, string password)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select CN_LOGIN,CN_PASSWORD FROM TN_SYS_EM_USER where CN_LOGIN = '" + loginname + "'");
            SqlDataReader dr = (SqlDataReader)DbHelper.ExecuteReader(DBConfig.UserInfoString, CommandType.Text, strSql.ToString(), null);
            bool flag = false;
                
            if (dr.Read())
            {
                string pwd=dr.GetString(1);
                if (password.Equals(pwd))
                {
                    flag = true;
                }
            }
            return flag;
        }


        public bool SendMSG(string MessageContent, string DestinationAddress)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into COM_SmsSent_4(");
            strSql.Append("MessageID,MessageContent,DestinationAddress,SendType,SendTime,CreateTime)");
            strSql.Append(" values (");
            strSql.Append("newid(),@MessageContent,@DestinationAddress,0,getdate(),getdate())");
            SqlParameter[] parameters = {
					new SqlParameter("@MessageContent", SqlDbType.Text),
					new SqlParameter("@DestinationAddress", SqlDbType.NVarChar,40)};
            parameters[0].Value = MessageContent;
            parameters[1].Value = DestinationAddress;

            int rows = DbHelper.ExecuteNonQuery(DBConfig.SendMSGString,CommandType.Text, strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}

