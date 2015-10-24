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
	public partial class TB_RC_TalentClass
	{
        private DbHelperSQLP dbhelp = null;

		public TB_RC_TalentClass()
		{
            this.dbhelp = new DbHelperSQLP(PubConstant.TalentConnectionString);
        }
		#region  Method

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(Talent.Model.TB_RC_TalentClass model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into TB_RC_TalentClass(");
			strSql.Append("TC_Class,TC_Color)");
			strSql.Append(" values (");
			strSql.Append("@TC_Class,@TC_Color)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@TC_Class", SqlDbType.VarChar,100),
					new SqlParameter("@TC_Color", SqlDbType.VarChar,10)};
			parameters[0].Value = model.TC_Class;
			parameters[1].Value = model.TC_Color;

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
		public bool Update(Talent.Model.TB_RC_TalentClass model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update TB_RC_TalentClass set ");
			strSql.Append("TC_Class=@TC_Class,");
			strSql.Append("TC_Color=@TC_Color");
			strSql.Append(" where TC_No=@TC_No");
			SqlParameter[] parameters = {
					new SqlParameter("@TC_Class", SqlDbType.VarChar,100),
					new SqlParameter("@TC_Color", SqlDbType.VarChar,10),
					new SqlParameter("@TC_No", SqlDbType.Int,4)};
			parameters[0].Value = model.TC_Class;
			parameters[1].Value = model.TC_Color;
			parameters[2].Value = model.TC_No;

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
		public bool DeleteList(string TC_Nolist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from TB_RC_TalentClass ");
			strSql.Append(" where TC_No in ("+TC_Nolist + ")  ");
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
		public Talent.Model.TB_RC_TalentClass GetModel(int TC_No)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 TC_No,TC_Class,TC_Color from TB_RC_TalentClass ");
			strSql.Append(" where TC_No=@TC_No");
			SqlParameter[] parameters = {
					new SqlParameter("@TC_No", SqlDbType.Int,4)
			};
			parameters[0].Value = TC_No;

			Talent.Model.TB_RC_TalentClass model=new Talent.Model.TB_RC_TalentClass();
            DataSet ds = dbhelp.Query(strSql.ToString(), parameters);
			if(ds.Tables[0].Rows.Count>0)
			{
				if(ds.Tables[0].Rows[0]["TC_No"]!=null && ds.Tables[0].Rows[0]["TC_No"].ToString()!="")
				{
					model.TC_No=int.Parse(ds.Tables[0].Rows[0]["TC_No"].ToString());
				}
				if(ds.Tables[0].Rows[0]["TC_Class"]!=null && ds.Tables[0].Rows[0]["TC_Class"].ToString()!="")
				{
					model.TC_Class=ds.Tables[0].Rows[0]["TC_Class"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TC_Color"]!=null && ds.Tables[0].Rows[0]["TC_Color"].ToString()!="")
				{
					model.TC_Color=ds.Tables[0].Rows[0]["TC_Color"].ToString();
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
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select TC_No,TC_Class,TC_Color ");
			strSql.Append(" FROM TB_RC_TalentClass ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}

            strSql.Append(" order by  TC_No asc ");
            return dbhelp.Query(strSql.ToString());
		}


        public DataSet GetList(int PageSize, int PageIndex, string strWhere, int pager)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select TC_No,TC_Class,TC_Color from (");
            strSql.Append(" select top " + pager + " * from ( ");
            strSql.Append(" select top " + (PageIndex * PageSize).ToString() + " * from ");
            strSql.Append(" TB_RC_TalentClass ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by  TC_No asc ");
            strSql.Append(") as tmp1  order by TC_No desc ");
            strSql.Append(") as tmp2  order by TC_No asc  ");

            return dbhelp.Query(strSql.ToString());
        }

        public Object GetTotal(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(*) from ");
            strSql.Append(" TB_RC_TalentClass ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }

            return dbhelp.GetSingle(strSql.ToString());
        }

        public DataSet GetListByRelate(string CT_CB_No)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select TC_No,TC_Class,TC_Color ");
            strSql.Append(" FROM TB_RC_TalentClass,TB_RC_CompanyTalentClassRelate ");
            strSql.Append(" where  CT_TC_No=TC_No  and CT_CB_No=@CT_CB_No ");
            strSql.Append(" order by  TC_No asc ");
            SqlParameter[] parameters = {
					new SqlParameter("@CT_CB_No", SqlDbType.Int,4)};
            parameters[0].Value = CT_CB_No;
            return dbhelp.Query(strSql.ToString(),parameters);
        }

		#endregion  Method
	}
}

