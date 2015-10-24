using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EPReper.IDAL;
using System.Data.SqlClient;
using System.Data;
using EPReper.DBUtility;

namespace EPReper.SQLServerDAL
{
    public partial class Manager : IManager
    {
        public Manager() { }


        public int Add(Model.Manager model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into Manager(");
            strSql.Append("username,isAdmin,repair,phonenum,works)");
            strSql.Append(" values(");
            strSql.Append("@username,@isAdmin,@repair,@phonenum,@works)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters ={
                new SqlParameter("@username",SqlDbType.NVarChar,50),
                new SqlParameter("@isAdmin",SqlDbType.Int,4),
                new SqlParameter("@repair",SqlDbType.NVarChar,50),
                new SqlParameter("@phonenum",SqlDbType.NChar,20),
                new SqlParameter("@works",SqlDbType.Int,4)};
            parameters[0].Value = model.UserName;
            parameters[1].Value = model.isAdmin;
            parameters[2].Value = model.repair;
            parameters[3].Value = model.phonenum;
            parameters[4].Value = 0;


            object obj = DbHelper.ExecuteNonQuery(CommandType.Text, strSql.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        public int uPAdmin(int id)
        {
            string strSql = ("update Manager set isAdmin=1 where id =" + id);
            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql, null);
            if (rows > 0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        public int downAdmin(int id)
        {
            string strSql = ("update Manager set isAdmin=0 where id =" + id);
            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql, null);
            if (rows > 0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        public System.Data.DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select id,username,isAdmin,repair,phonenum ");
            strSql.Append(" FROM Manager ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelper.ExecuteDataSet(CommandType.Text, strSql.ToString(), null);
        }

        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Top > 0)
            {
                strSql.Append(" top " + Top.ToString());
            }
            strSql.Append(" id,username,isAdmin,repair,phonenum ");
            strSql.Append(" FROM Manager ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return DbHelper.ExecuteDataSet(CommandType.Text, strSql.ToString(), null);
        }

        public int has(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select id,username,isAdmin,repair,phonenum ");
            strSql.Append(" FROM Manager ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            object obj = DbHelper.ExecuteScalar(CommandType.Text, strSql.ToString(), null);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }
        public bool Delete(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from Manager ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
};
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


        public DataTable GetPage(string sqlWhere, int PageIndex, int PageSize, out int RecordCount, out int PageCount)
        {
            string SqlAllFields = " id,username,isAdmin,repair,phonenum ";
            string SqlTabelsAndWhere = " Manager Where " + sqlWhere;
            string IndexField = " id";
            string OrderFields = " Order by id  ";
            return DbHelper.ExecutePage(SqlAllFields, SqlTabelsAndWhere, IndexField, OrderFields, PageIndex, PageSize, out RecordCount, out PageCount, null);
        }

        public EPReper.Model.Manager GetModel(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 id,username,isAdmin,repair,phonenum from Manager ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
};
            parameters[0].Value = id;

            EPReper.Model.Manager model = new EPReper.Model.Manager();
            DataSet ds = DbHelper.ExecuteDataSet(CommandType.Text, strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["id"] != null && ds.Tables[0].Rows[0]["id"].ToString() != "")
                {
                    model.id = ds.Tables[0].Rows[0]["id"].ToString();
                }
                if (ds.Tables[0].Rows[0]["username"] != null && ds.Tables[0].Rows[0]["username"].ToString() != "")
                {
                    model.UserName = ds.Tables[0].Rows[0]["username"].ToString();
                }
                if (ds.Tables[0].Rows[0]["isAdmin"] != null && ds.Tables[0].Rows[0]["isAdmin"].ToString() != "")
                {
                    model.isAdmin = Convert.ToInt32(ds.Tables[0].Rows[0]["isAdmin"].ToString());
                }
                if (ds.Tables[0].Rows[0]["repair"] != null && ds.Tables[0].Rows[0]["repair"].ToString() != "")
                {
                    model.repair = ds.Tables[0].Rows[0]["repair"].ToString();
                }
                if (ds.Tables[0].Rows[0]["phonenum"] != null && ds.Tables[0].Rows[0]["phonenum"].ToString() != "")
                {
                    model.phonenum = ds.Tables[0].Rows[0]["phonenum"].ToString();
                }
                return model;
            }
            else
            {
                return null;
            }
        }


        public bool Update(Model.Manager model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update Manager set ");
            strSql.Append("phonenum=@phonenum, ");
            strSql.Append("repair=@repair, ");
            strSql.Append("isAdmin=@isAdmin ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@phonenum", SqlDbType.NVarChar,50),
					new SqlParameter("@repair", SqlDbType.NVarChar,50),
                    new SqlParameter("@isAdmin", SqlDbType.Int,4),
                    new SqlParameter("@id",SqlDbType.Int,4)};
            parameters[0].Value = model.phonenum;
            parameters[1].Value = model.repair;
            parameters[2].Value = model.isAdmin;
            parameters[3].Value = model.id;

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


        public bool changes(string repair)
        {
            StringBuilder strSql = new StringBuilder();
            DataTable dt = null;
            using (SqlDataAdapter da = new SqlDataAdapter())
            {
                SqlCommand cmdGetNeedSendSms = new SqlCommand();
                SqlConnection ep = new SqlConnection(EPReper.Config.DBConfig.EPErperString);
                cmdGetNeedSendSms.Connection = ep;
                cmdGetNeedSendSms.CommandText = "BEGIN TRAN " +
                    "update manager set works = 77 where repair like '%" + repair + "%' and works =0 and isadmin = 0; " +
                    "select id,username,isadmin,repair,phonenum,works from manager where repair like '%" + repair + "%' and works = 77; " +
                    "update manager set works = 1 where repair like '%" + repair + "%' and works = 77 " +
                    "COMMIT TRAN";
                da.SelectCommand = cmdGetNeedSendSms;
                DataSet ds = new DataSet();
                try
                {
                    da.Fill(ds);
                    dt = ds.Tables[0];
                    strSql.Append("update manager set works = 0 where isadmin = 0 and repair like '%"+repair+"%' and id !=" + dt.Rows[0]["id"]);
                    int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql.ToString(), null);
                    if (rows > 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }

                }
                catch (Exception ex)
                {
                    return false;
                }
            }
        }


        public bool upworks(string username)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update Manager set ");
            strSql.Append("works=0 ");
            strSql.Append(" where username = '"+username+"'");
            

            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql.ToString(), null);
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
