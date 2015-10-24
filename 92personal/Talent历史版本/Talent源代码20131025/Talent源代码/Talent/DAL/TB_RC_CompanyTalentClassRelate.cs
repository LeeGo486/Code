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
	public partial class TB_RC_CompanyTalentClassRelate
	{
        private DbHelperSQLP dbhelp = null;

		public TB_RC_CompanyTalentClassRelate()
		{
                this.dbhelp = new DbHelperSQLP(PubConstant.TalentConnectionString);
        }
		#region  Method

        public bool Exists(Talent.Model.TB_RC_CompanyTalentClassRelate model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from TB_RC_CompanyTalentClassRelate");
            strSql.Append(" where CT_CB_No=@CT_CB_No and CT_TC_No=@CT_TC_No ");  
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
		public bool Add(Talent.Model.TB_RC_CompanyTalentClassRelate model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into TB_RC_CompanyTalentClassRelate(");
			strSql.Append("CT_CB_No,CT_TC_No)");
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


		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int CT_CB_No)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from TB_RC_CompanyTalentClassRelate ");
			strSql.Append(" where CT_CB_No=@CT_CB_No ");
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

