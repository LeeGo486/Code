using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Talent.DAL
{
    /// <summary>
    /// 数据访问类:TB_CG_Permission
    /// </summary>
    public partial class TB_CG_Permission
    {
        private DbHelperSQLP dbhelp = null;

        public TB_CG_Permission()
        {
            this.dbhelp = new DbHelperSQLP(PubConstant.CGConnectionString);
        }
        #region  Method

        public bool isAdmin(string name)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from TB_CG_Permission");
            strSql.Append(" where PM_Login=@PM_Login and PM_Level=1 ");  //管理员1
            SqlParameter[] parameters = {
					new SqlParameter("@PM_Login", SqlDbType.VarChar,50)	};
            parameters[0].Value = name;

            return dbhelp.Exists(strSql.ToString(), parameters);
        }

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Talent.Model.TB_CG_Permission model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into TB_CG_Permission(");
            strSql.Append("PM_Login,PM_Level,PM_Province)");
            strSql.Append(" values (");
            strSql.Append("@PM_Login,@PM_Level,@PM_Province)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
					new SqlParameter("@PM_Login", SqlDbType.VarChar,50),
					new SqlParameter("@PM_Level", SqlDbType.Int,4),
					new SqlParameter("@PM_Province", SqlDbType.VarChar,1000)};
            parameters[0].Value = model.PM_Login;
            parameters[1].Value = model.PM_Level;
            parameters[2].Value = model.PM_Province;

            object obj = dbhelp.GetSingle(strSql.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(Talent.Model.TB_CG_Permission model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update TB_CG_Permission set ");
            strSql.Append("PM_Login=@PM_Login,");
            strSql.Append("PM_Level=@PM_Level,");
            strSql.Append("PM_Province=@PM_Province");
            strSql.Append(" where PM_No=@PM_No");
            SqlParameter[] parameters = {
					new SqlParameter("@PM_Login", SqlDbType.VarChar,50),
					new SqlParameter("@PM_Level", SqlDbType.Int,4),
					new SqlParameter("@PM_Province", SqlDbType.VarChar,1000),
					new SqlParameter("@PM_No", SqlDbType.Int,4)};
            parameters[0].Value = model.PM_Login;
            parameters[1].Value = model.PM_Level;
            parameters[2].Value = model.PM_Province;
            parameters[3].Value = model.PM_No;

            int rows = dbhelp.ExecuteSql(strSql.ToString(), parameters);
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
        public bool Delete(int PM_No)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from TB_CG_Permission ");
            strSql.Append(" where PM_No=@PM_No");
            SqlParameter[] parameters = {
					new SqlParameter("@PM_No", SqlDbType.Int,4)
			};
            parameters[0].Value = PM_No;

            int rows = dbhelp.ExecuteSql(strSql.ToString(), parameters);
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
        public bool DeleteList(string PM_Nolist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from TB_CG_Permission ");
            strSql.Append(" where PM_No in (" + PM_Nolist + ")  ");
            int rows = dbhelp.ExecuteSql(strSql.ToString());
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
        public Talent.Model.TB_CG_Permission GetModel(int PM_No)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 PM_No,PM_Login,PM_Level,PM_Province from TB_CG_Permission ");
            strSql.Append(" where PM_No=@PM_No");
            SqlParameter[] parameters = {
					new SqlParameter("@PM_No", SqlDbType.Int,4)
			};
            parameters[0].Value = PM_No;

            Talent.Model.TB_CG_Permission model = new Talent.Model.TB_CG_Permission();
            DataSet ds = dbhelp.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["PM_No"] != null && ds.Tables[0].Rows[0]["PM_No"].ToString() != "")
                {
                    model.PM_No = int.Parse(ds.Tables[0].Rows[0]["PM_No"].ToString());
                }
                if (ds.Tables[0].Rows[0]["PM_Login"] != null && ds.Tables[0].Rows[0]["PM_Login"].ToString() != "")
                {
                    model.PM_Login = ds.Tables[0].Rows[0]["PM_Login"].ToString();
                }
                if (ds.Tables[0].Rows[0]["PM_Level"] != null && ds.Tables[0].Rows[0]["PM_Level"].ToString() != "")
                {
                    model.PM_Level = int.Parse(ds.Tables[0].Rows[0]["PM_Level"].ToString());
                }
                if (ds.Tables[0].Rows[0]["PM_Province"] != null && ds.Tables[0].Rows[0]["PM_Province"].ToString() != "")
                {
                    model.PM_Province = ds.Tables[0].Rows[0]["PM_Province"].ToString();
                }
                return model;
            }
            else
            {
                return null;
            }
        }


        public Talent.Model.TB_CG_Permission GetModel(string PM_Login)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 PM_No,PM_Login,PM_Level,PM_Province from TB_CG_Permission ");
            strSql.Append(" where PM_Login=@PM_Login");
            SqlParameter[] parameters = {
					new SqlParameter("@PM_Login", SqlDbType.VarChar,50)
			};
            parameters[0].Value = PM_Login;

            Talent.Model.TB_CG_Permission model = new Talent.Model.TB_CG_Permission();
            DataSet ds = dbhelp.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["PM_No"] != null && ds.Tables[0].Rows[0]["PM_No"].ToString() != "")
                {
                    model.PM_No = int.Parse(ds.Tables[0].Rows[0]["PM_No"].ToString());
                }
                if (ds.Tables[0].Rows[0]["PM_Login"] != null && ds.Tables[0].Rows[0]["PM_Login"].ToString() != "")
                {
                    model.PM_Login = ds.Tables[0].Rows[0]["PM_Login"].ToString();
                }
                if (ds.Tables[0].Rows[0]["PM_Level"] != null && ds.Tables[0].Rows[0]["PM_Level"].ToString() != "")
                {
                    model.PM_Level = int.Parse(ds.Tables[0].Rows[0]["PM_Level"].ToString());
                }
                if (ds.Tables[0].Rows[0]["PM_Province"] != null && ds.Tables[0].Rows[0]["PM_Province"].ToString() != "")
                {
                    model.PM_Province = ds.Tables[0].Rows[0]["PM_Province"].ToString();
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
            strSql.Append("select PM_No,PM_Login,PM_Level,PM_Province ");
            strSql.Append(" FROM TB_CG_Permission  where PM_Level!=9 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
            }
            strSql.Append(" order by  PM_No desc ");
            return dbhelp.Query(strSql.ToString());
        }


        public DataSet GetList(int PageSize, int PageIndex, string strWhere, int pager)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select PM_No,PM_Login,PM_Level,PM_Province from (");
            strSql.Append(" select top " + pager + " * from ( ");
            strSql.Append(" select top " + (PageIndex * PageSize).ToString() + " * from ");
            strSql.Append(" TB_CG_Permission where PM_Level!=9 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
            }
            strSql.Append(" order by  PM_No desc ");
            strSql.Append(") as tmp1  order by PM_No asc ");
            strSql.Append(") as tmp2  order by PM_No desc  ");

            return dbhelp.Query(strSql.ToString());
        }

        public Object GetTotal(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(*) from ");
            strSql.Append(" TB_CG_Permission ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }

            return dbhelp.GetSingle(strSql.ToString());
        }


        #endregion  Method
    }
}



