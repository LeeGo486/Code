using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Talent.DAL
{
    /// <summary>
    /// 数据访问类:TB_RC_CompanyTalentClassRelate
    /// </summary>
    public partial class TB_CG_SocialWelfareLink
    {
        private DbHelperSQLP dbhelp = null;

        public TB_CG_SocialWelfareLink()
        {
            this.dbhelp = new DbHelperSQLP(PubConstant.CGConnectionString);
        }
        #region  Method

        public bool Exists(Talent.Model.TB_CG_SocialWelfareLink model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from TB_CG_SocialWelfareLink");
            strSql.Append(" where SW_CB_NO=@CT_CB_No and SW_WT_No=@CT_TC_No ");
            SqlParameter[] parameters = {
					new SqlParameter("@CT_CB_No", SqlDbType.Int,4),
					new SqlParameter("@CT_TC_No", SqlDbType.Int,4)};
            parameters[0].Value = model.CT_CB_No;
            parameters[1].Value = model.CT_TC_No;

            return dbhelp.Exists(strSql.ToString(), parameters);
        }

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public bool Add(Talent.Model.TB_CG_SocialWelfareLink model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into TB_CG_SocialWelfareLink(");
            strSql.Append("SW_CB_NO,SW_WT_No)");
            strSql.Append(" values (");
            strSql.Append("@CT_CB_No,@CT_TC_No)");
            SqlParameter[] parameters = {
					new SqlParameter("@CT_CB_No", SqlDbType.Int,4),
					new SqlParameter("@CT_TC_No", SqlDbType.Int,4)};
            parameters[0].Value = model.CT_CB_No;
            parameters[1].Value = model.CT_TC_No;

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

        public bool Add1(Talent.Model.TB_CG_SocialWelfareLink model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update TB_CG_CityBase set WP_WelfarePolicyOne = (select WT_WPType from TB_CG_WelfarePolicyType where wt_no=@CT_TC_No)");
            strSql.Append(" where CB_NO=@CT_CB_No ");
            SqlParameter[] parameters = {
					new SqlParameter("@CT_CB_No", SqlDbType.Int,4),
					new SqlParameter("@CT_TC_No", SqlDbType.Int,4)};
            parameters[0].Value = model.CT_CB_No;
            parameters[1].Value = model.CT_TC_No;
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

        public bool Add2(Talent.Model.TB_CG_SocialWelfareLink model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update TB_CG_CityBase set WP_WelfarePolicyTwo = (select WT_WPType from TB_CG_WelfarePolicyType where wt_no=@CT_TC_No)");
            strSql.Append(" where CB_NO=@CT_CB_No ");
            SqlParameter[] parameters = {
					new SqlParameter("@CT_CB_No", SqlDbType.Int,4),
					new SqlParameter("@CT_TC_No", SqlDbType.Int,4)};
            parameters[0].Value = model.CT_CB_No;
            parameters[1].Value = model.CT_TC_No;
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
        public bool Delete(int CT_CB_No)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from TB_CG_SocialWelfareLink ");
            strSql.Append(" where SW_CB_NO=@CT_CB_No ");
            SqlParameter[] parameters = {
					new SqlParameter("@CT_CB_No", SqlDbType.Int,4)	};
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

        #endregion  Method
    }
}

