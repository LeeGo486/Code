using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Talent.DAL
{
	/// <summary>
	/// 数据访问类:TB_RC_TalentDocument
	/// </summary>
	public partial class TB_RC_TalentDocument
	{
        private DbHelperSQLP dbhelp = null;

		public TB_RC_TalentDocument()
		{
            this.dbhelp = new DbHelperSQLP(PubConstant.TalentConnectionString);
        }
		#region  Method



		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(Talent.Model.TB_RC_TalentDocument model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into TB_RC_TalentDocument(");
			strSql.Append("TD_CB_No,TD_TI_No,TD_DocName,TD_docPath,TD_CreatePer,TD_CreateDate)");
			strSql.Append(" values (");
			strSql.Append("@TD_CB_No,@TD_TI_No,@TD_DocName,@TD_docPath,@TD_CreatePer,@TD_CreateDate)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@TD_CB_No", SqlDbType.Int,4),
					new SqlParameter("@TD_TI_No", SqlDbType.Int,4),
					new SqlParameter("@TD_DocName", SqlDbType.VarChar,200),
					new SqlParameter("@TD_docPath", SqlDbType.VarChar,500),
					new SqlParameter("@TD_CreatePer", SqlDbType.VarChar,20),
					new SqlParameter("@TD_CreateDate", SqlDbType.DateTime)};
			parameters[0].Value = model.TD_CB_No;
			parameters[1].Value = model.TD_TI_No;
			parameters[2].Value = model.TD_DocName;
			parameters[3].Value = model.TD_docPath;
			parameters[4].Value = model.TD_CreatePer;
			parameters[5].Value = model.TD_CreateDate;

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
		public bool Update(Talent.Model.TB_RC_TalentDocument model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update TB_RC_TalentDocument set ");
			strSql.Append("TD_CB_No=@TD_CB_No,");
			strSql.Append("TD_TI_No=@TD_TI_No,");
			strSql.Append("TD_DocName=@TD_DocName,");
			strSql.Append("TD_docPath=@TD_docPath,");
			strSql.Append("TD_CreatePer=@TD_CreatePer,");
			strSql.Append("TD_CreateDate=@TD_CreateDate");
			strSql.Append(" where TD_No=@TD_No");
			SqlParameter[] parameters = {
					new SqlParameter("@TD_CB_No", SqlDbType.Int,4),
					new SqlParameter("@TD_TI_No", SqlDbType.Int,4),
					new SqlParameter("@TD_DocName", SqlDbType.VarChar,200),
					new SqlParameter("@TD_docPath", SqlDbType.VarChar,500),
					new SqlParameter("@TD_CreatePer", SqlDbType.VarChar,20),
					new SqlParameter("@TD_CreateDate", SqlDbType.DateTime),
					new SqlParameter("@TD_No", SqlDbType.Int,4)};
			parameters[0].Value = model.TD_CB_No;
			parameters[1].Value = model.TD_TI_No;
			parameters[2].Value = model.TD_DocName;
			parameters[3].Value = model.TD_docPath;
			parameters[4].Value = model.TD_CreatePer;
			parameters[5].Value = model.TD_CreateDate;
			parameters[6].Value = model.TD_No;

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
		public bool Delete(int TD_No)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from TB_RC_TalentDocument ");
			strSql.Append(" where TD_No=@TD_No");
			SqlParameter[] parameters = {
					new SqlParameter("@TD_No", SqlDbType.Int,4)
			};
			parameters[0].Value = TD_No;

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

        public bool DeleteByCB_NO(int CB_NO)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from TB_RC_TalentDocument ");
            strSql.Append(" where TD_CB_No=@TD_CB_No");
            SqlParameter[] parameters = {
					new SqlParameter("@TD_CB_No", SqlDbType.Int,4)
			};
            parameters[0].Value = CB_NO;

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
		public bool DeleteList(string TD_Nolist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from TB_RC_TalentDocument ");
			strSql.Append(" where TD_No in ("+TD_Nolist + ")  ");
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
		public Talent.Model.TB_RC_TalentDocument GetModel(int TD_No)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 TD_No,TD_CB_No,TD_TI_No,TD_DocName,TD_docPath,TD_CreatePer,TD_CreateDate from TB_RC_TalentDocument ");
			strSql.Append(" where TD_No=@TD_No");
			SqlParameter[] parameters = {
					new SqlParameter("@TD_No", SqlDbType.Int,4)
			};
			parameters[0].Value = TD_No;

			Talent.Model.TB_RC_TalentDocument model=new Talent.Model.TB_RC_TalentDocument();
            DataSet ds = dbhelp.Query(strSql.ToString(), parameters);
			if(ds.Tables[0].Rows.Count>0)
			{
				if(ds.Tables[0].Rows[0]["TD_No"]!=null && ds.Tables[0].Rows[0]["TD_No"].ToString()!="")
				{
					model.TD_No=int.Parse(ds.Tables[0].Rows[0]["TD_No"].ToString());
				}
				if(ds.Tables[0].Rows[0]["TD_CB_No"]!=null && ds.Tables[0].Rows[0]["TD_CB_No"].ToString()!="")
				{
					model.TD_CB_No=int.Parse(ds.Tables[0].Rows[0]["TD_CB_No"].ToString());
				}
				if(ds.Tables[0].Rows[0]["TD_TI_No"]!=null && ds.Tables[0].Rows[0]["TD_TI_No"].ToString()!="")
				{
					model.TD_TI_No=int.Parse(ds.Tables[0].Rows[0]["TD_TI_No"].ToString());
				}
				if(ds.Tables[0].Rows[0]["TD_DocName"]!=null && ds.Tables[0].Rows[0]["TD_DocName"].ToString()!="")
				{
					model.TD_DocName=ds.Tables[0].Rows[0]["TD_DocName"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TD_docPath"]!=null && ds.Tables[0].Rows[0]["TD_docPath"].ToString()!="")
				{
					model.TD_docPath=ds.Tables[0].Rows[0]["TD_docPath"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TD_CreatePer"]!=null && ds.Tables[0].Rows[0]["TD_CreatePer"].ToString()!="")
				{
					model.TD_CreatePer=ds.Tables[0].Rows[0]["TD_CreatePer"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TD_CreateDate"]!=null && ds.Tables[0].Rows[0]["TD_CreateDate"].ToString()!="")
				{
					model.TD_CreateDate=DateTime.Parse(ds.Tables[0].Rows[0]["TD_CreateDate"].ToString());
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
			strSql.Append("select TD_No,TD_CB_No,TD_TI_No,TD_DocName,TD_docPath,TD_CreatePer,TD_CreateDate ");
			strSql.Append(" FROM TB_RC_TalentDocument ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
            strSql.Append(" order by TD_No asc ");
            return dbhelp.Query(strSql.ToString());
		}

        public Object GetTotal(int CB_NO, int TI_NO)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(*) from ");
            strSql.Append(" TB_RC_TalentDocument ");
            strSql.Append(" where TD_CB_No='" + CB_NO + "' and TD_TI_No='" + TI_NO + "'");
            return dbhelp.GetSingle(strSql.ToString());
        }

		#endregion  Method
	}
}

