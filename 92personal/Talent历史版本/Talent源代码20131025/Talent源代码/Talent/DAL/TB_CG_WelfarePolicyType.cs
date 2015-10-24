using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Talent.DAL
{
    /// <summary>
    /// 数据访问类:TB_RC_TalentClass
    /// </summary>
    public partial class TB_CG_WelfarePolicyType
    {
        private DbHelperSQLP dbhelp = null;

        public TB_CG_WelfarePolicyType()
        {
            this.dbhelp = new DbHelperSQLP(PubConstant.CGConnectionString);
        }
        #region  Method

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Talent.Model.TB_CG_WelfarePolicyType model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into TB_CG_WelfarePolicyType(");
            strSql.Append("WT_WPType,WT_Color)");
            strSql.Append(" values (");
            strSql.Append("@WT_WPType,@WT_Color)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
					new SqlParameter("@WT_WPType", SqlDbType.VarChar,100),
					new SqlParameter("@WT_Color", SqlDbType.VarChar,10)};
            parameters[0].Value = model.WT_WPType;
            parameters[1].Value = model.WT_Color;

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
        public bool Update(Talent.Model.TB_CG_WelfarePolicyType model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update TB_CG_WelfarePolicyType set ");
            strSql.Append("WT_WPType=@WT_WPType,");
            strSql.Append("WT_Color=@WT_Color");
            strSql.Append(" where WT_No=@WT_No");
            SqlParameter[] parameters = {
					new SqlParameter("@WT_WPType", SqlDbType.VarChar,100),
					new SqlParameter("@WT_Color", SqlDbType.VarChar,10),
					new SqlParameter("@WT_No", SqlDbType.Int,4)};
            parameters[0].Value = model.WT_WPType;
            parameters[1].Value = model.WT_Color;
            parameters[2].Value = model.WT_No;

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

        public bool Delete(int CT_CB_No)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from TB_CG_WelfarePolicyType ");
            strSql.Append(" where WT_No=@WT_No ");
            SqlParameter[] parameters = {
					new SqlParameter("@WT_No", SqlDbType.Int,4)	};
            parameters[0].Value = CT_CB_No;

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
        public bool DeleteList(string TC_Nolist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from TB_CG_WelfarePolicyType ");
            strSql.Append(" where WT_No in (" + TC_Nolist + ")  ");
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
        public Talent.Model.TB_CG_WelfarePolicyType GetModel(int TC_No)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 WT_No,WT_WPType,WT_Color from TB_CG_WelfarePolicyType ");
            strSql.Append(" where WT_No=@WT_No");
            SqlParameter[] parameters = {
					new SqlParameter("@WT_No", SqlDbType.Int,4)
			};
            parameters[0].Value = TC_No;

            Talent.Model.TB_CG_WelfarePolicyType model = new Talent.Model.TB_CG_WelfarePolicyType();
            DataSet ds = dbhelp.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["WT_No"] != null && ds.Tables[0].Rows[0]["WT_No"].ToString() != "")
                {
                    model.WT_No = int.Parse(ds.Tables[0].Rows[0]["WT_No"].ToString());
                }
                if (ds.Tables[0].Rows[0]["WT_WPType"] != null && ds.Tables[0].Rows[0]["WT_WPType"].ToString() != "")
                {
                    model.WT_WPType = ds.Tables[0].Rows[0]["WT_WPType"].ToString();
                }
                if (ds.Tables[0].Rows[0]["WT_Color"] != null && ds.Tables[0].Rows[0]["WT_Color"].ToString() != "")
                {
                    model.WT_Color = ds.Tables[0].Rows[0]["WT_Color"].ToString();
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
            strSql.Append("select WT_No,WT_WPType,WT_Color ");
            strSql.Append(" FROM TB_CG_WelfarePolicyType ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }

            strSql.Append(" order by  WT_No asc ");
            return dbhelp.Query(strSql.ToString());
        }


        public DataSet GetList(int PageSize, int PageIndex, string strWhere, int pager)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  WT_No,WT_WPType,WT_Color from (");
            strSql.Append(" select top " + pager + " * from ( ");
            strSql.Append(" select top " + (PageIndex * PageSize).ToString() + " * from ");
            strSql.Append(" TB_CG_WelfarePolicyType ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by  WT_No asc ");
            strSql.Append(") as tmp1  order by WT_No desc ");
            strSql.Append(") as tmp2  order by WT_No asc  ");

            return dbhelp.Query(strSql.ToString());
        }

        public Object GetTotal(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(*) from ");
            strSql.Append(" TB_CG_WelfarePolicyType ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }

            return dbhelp.GetSingle(strSql.ToString());
        }

        public DataSet GetListByRelate(string CT_CB_No)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select WT_No,WT_WPType,WT_Color ");
            strSql.Append(" FROM TB_CG_WelfarePolicyType,TB_CG_SocialWelfareLink ");
            strSql.Append(" where  WT_No=SW_WT_No  and SW_CB_NO=@CT_CB_No ");
            strSql.Append(" order by  WT_No asc ");
            SqlParameter[] parameters = {
					new SqlParameter("@CT_CB_No", SqlDbType.Int,4)};
            parameters[0].Value = CT_CB_No;
            return dbhelp.Query(strSql.ToString(), parameters);
        }

        #endregion  Method
    }
}

