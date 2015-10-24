using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Talent.DAL
{
	/// <summary>
	/// 数据访问类:TB_RC_TalentInfor
	/// </summary>
	public partial class TB_RC_TalentInfor
	{
        private DbHelperSQLP dbhelp = null;

		public TB_RC_TalentInfor()
		{
            this.dbhelp = new DbHelperSQLP(PubConstant.TalentConnectionString);
        }

		#region  Method

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(Talent.Model.TB_RC_TalentInfor model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into TB_RC_TalentInfor(");
            strSql.Append("TI_CB_No,TI_OtherCBName,TI_BrandName,TI_TalentClass,TI_Name,TI_Sex,TI_Phone,TI_Src,TI_RecommendPost,TI_OtherRecommendPost,TI_Audition,TI_AuditionResult,TI_FollowUpPeople,TI_MaintainDate,TI_MaintainResult,TI_CreatePer,TI_CreateDate,TI_Mark,TI_Work,TI_Industry,TI_Recommend,TI_RecommendDate,TI_Email,TI_Reason,TI_Interviewer)");
			strSql.Append(" values (");
            strSql.Append("@TI_CB_No,@TI_BrandName,@TI_OtherCBName,@TI_TalentClass,@TI_Name,@TI_Sex,@TI_Phone,@TI_Src,@TI_RecommendPost,@TI_OtherRecommendPost,@TI_Audition,@TI_AuditionResult,@TI_FollowUpPeople,@TI_MaintainDate,@TI_MaintainResult,@TI_CreatePer,@TI_CreateDate,@TI_Mark,@TI_Work,@TI_Industry,@TI_Recommend,@TI_RecommendDate,@TI_Email,@TI_Reason,@TI_Interviewer)");
			strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
					new SqlParameter("@TI_CB_No", SqlDbType.Int,4),
                    new SqlParameter("@TI_BrandName", SqlDbType.VarChar,100),
                    new SqlParameter("@TI_OtherCBName", SqlDbType.VarChar,150),
					new SqlParameter("@TI_TalentClass", SqlDbType.VarChar,100),
					new SqlParameter("@TI_Name", SqlDbType.VarChar,50),
					new SqlParameter("@TI_Sex", SqlDbType.VarChar,10),
					new SqlParameter("@TI_Phone", SqlDbType.VarChar,100),
					new SqlParameter("@TI_Src", SqlDbType.VarChar,100),
					new SqlParameter("@TI_RecommendPost", SqlDbType.VarChar,100),
                    new SqlParameter("@TI_OtherRecommendPost", SqlDbType.VarChar,100),
					new SqlParameter("@TI_Audition", SqlDbType.VarChar,10),
					new SqlParameter("@TI_AuditionResult", SqlDbType.VarChar,200),
					new SqlParameter("@TI_FollowUpPeople", SqlDbType.VarChar,200),
					new SqlParameter("@TI_MaintainDate", SqlDbType.DateTime),
					new SqlParameter("@TI_MaintainResult", SqlDbType.VarChar,200),
					new SqlParameter("@TI_CreatePer", SqlDbType.VarChar,20),
					new SqlParameter("@TI_CreateDate", SqlDbType.DateTime),
                    new SqlParameter("@TI_Mark", SqlDbType.VarChar,100),
                    new SqlParameter("@TI_Work", SqlDbType.VarChar,1000),
                    new SqlParameter("@TI_Industry", SqlDbType.VarChar,400),
                    new SqlParameter("@TI_Recommend", SqlDbType.VarChar,100),
                    new SqlParameter("@TI_RecommendDate", SqlDbType.DateTime),
                    new SqlParameter("@TI_Email", SqlDbType.VarChar,100),
                    new SqlParameter("@TI_Reason", SqlDbType.VarChar,200),
                    new SqlParameter("@TI_Interviewer", SqlDbType.VarChar,50)};
			parameters[0].Value = model.TI_CB_No;
            parameters[1].Value = model.TI_BrandName;
            parameters[2].Value = model.TI_OtherCBName;
			parameters[3].Value = model.TI_TalentClass;
			parameters[4].Value = model.TI_Name;
			parameters[5].Value = model.TI_Sex;
			parameters[6].Value = model.TI_Phone;
			parameters[7].Value = model.TI_Src;
			parameters[8].Value = model.TI_RecommendPost;
            parameters[9].Value = model.TI_OtherRecommendPost;
			parameters[10].Value = model.TI_Audition;
			parameters[11].Value = model.TI_AuditionResult;
			parameters[12].Value = model.TI_FollowUpPeople;
			parameters[13].Value = model.TI_MaintainDate;
			parameters[14].Value = model.TI_MaintainResult;
			parameters[15].Value = model.TI_CreatePer;
			parameters[16].Value = model.TI_CreateDate;
            parameters[17].Value = model.TI_Mark;
            parameters[18].Value = model.TI_Work;
            parameters[19].Value = model.TI_Industry;
            parameters[20].Value = model.TI_Recommend;
            parameters[21].Value = model.TI_RecommendDate;
            parameters[22].Value = model.TI_Email;
            parameters[23].Value = model.TI_Reason;
            parameters[24].Value = model.TI_Interviewer;
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
		public bool Update(Talent.Model.TB_RC_TalentInfor model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update TB_RC_TalentInfor set ");
			strSql.Append("TI_CB_No=@TI_CB_No,");
            strSql.Append("TI_OtherCBName=@TI_OtherCBName,");
			strSql.Append("TI_BrandName=@TI_BrandName,");
			strSql.Append("TI_TalentClass=@TI_TalentClass,");
			strSql.Append("TI_Name=@TI_Name,");
			strSql.Append("TI_Sex=@TI_Sex,");
			strSql.Append("TI_Phone=@TI_Phone,");
			strSql.Append("TI_Src=@TI_Src,");
			strSql.Append("TI_RecommendPost=@TI_RecommendPost,");
			strSql.Append("TI_Audition=@TI_Audition,");
			strSql.Append("TI_AuditionResult=@TI_AuditionResult,");
			strSql.Append("TI_FollowUpPeople=@TI_FollowUpPeople,");
			strSql.Append("TI_MaintainDate=@TI_MaintainDate,");
			strSql.Append("TI_MaintainResult=@TI_MaintainResult,");
			strSql.Append("TI_CreatePer=@TI_CreatePer,");
			strSql.Append("TI_CreateDate=@TI_CreateDate,");
            strSql.Append("TI_Mark=@TI_Mark,");
            strSql.Append("TI_Work=@TI_Work,");
            strSql.Append("TI_Industry=@TI_Industry,");
            strSql.Append("TI_Recommend=@TI_Recommend,");
            strSql.Append("TI_RecommendDate=@TI_RecommendDate,");
            strSql.Append("TI_Email=@TI_Email,");
            strSql.Append("TI_Reason=@TI_Reason,");
            strSql.Append("TI_Interviewer=@TI_Interviewer,");
            strSql.Append("TI_OtherRecommendPost=@TI_OtherRecommendPost");
			strSql.Append(" where TI_No=@TI_No");
			SqlParameter[] parameters = {
					new SqlParameter("@TI_CB_No", SqlDbType.Int,4),
                    new SqlParameter("@TI_OtherCBName", SqlDbType.VarChar,150),
					new SqlParameter("@TI_BrandName", SqlDbType.VarChar,100),
					new SqlParameter("@TI_TalentClass", SqlDbType.VarChar,100),
					new SqlParameter("@TI_Name", SqlDbType.VarChar,50),
					new SqlParameter("@TI_Sex", SqlDbType.VarChar,10),
					new SqlParameter("@TI_Phone", SqlDbType.VarChar,100),
					new SqlParameter("@TI_Src", SqlDbType.VarChar,100),
					new SqlParameter("@TI_RecommendPost", SqlDbType.VarChar,100),
					new SqlParameter("@TI_Audition", SqlDbType.VarChar,10),
					new SqlParameter("@TI_AuditionResult", SqlDbType.VarChar,200),
					new SqlParameter("@TI_FollowUpPeople", SqlDbType.VarChar,200),
					new SqlParameter("@TI_MaintainDate", SqlDbType.DateTime),
					new SqlParameter("@TI_MaintainResult", SqlDbType.VarChar,200),
					new SqlParameter("@TI_CreatePer", SqlDbType.VarChar,20),
					new SqlParameter("@TI_CreateDate", SqlDbType.DateTime),
                    new SqlParameter("@TI_Mark", SqlDbType.VarChar,100),
                    new SqlParameter("@TI_Work", SqlDbType.VarChar,1000),
                    new SqlParameter("@TI_Industry", SqlDbType.VarChar,400),
                    new SqlParameter("@TI_Recommend", SqlDbType.VarChar,100),
                    new SqlParameter("@TI_RecommendDate", SqlDbType.DateTime),
                    new SqlParameter("@TI_Email", SqlDbType.VarChar,100),
                    new SqlParameter("@TI_Reason", SqlDbType.VarChar,200),
                    new SqlParameter("@TI_Interviewer", SqlDbType.VarChar,50),
                    new SqlParameter("@TI_OtherRecommendPost", SqlDbType.VarChar,100),
					new SqlParameter("@TI_No", SqlDbType.Int,4)};
			parameters[0].Value = model.TI_CB_No;
            parameters[1].Value = model.TI_OtherCBName;
			parameters[2].Value = model.TI_BrandName;
			parameters[3].Value = model.TI_TalentClass;
			parameters[4].Value = model.TI_Name;
			parameters[5].Value = model.TI_Sex;
			parameters[6].Value = model.TI_Phone;
			parameters[7].Value = model.TI_Src;
			parameters[8].Value = model.TI_RecommendPost;
			parameters[9].Value = model.TI_Audition;
			parameters[10].Value = model.TI_AuditionResult;
			parameters[11].Value = model.TI_FollowUpPeople;
			parameters[12].Value = model.TI_MaintainDate;
			parameters[13].Value = model.TI_MaintainResult;
			parameters[14].Value = model.TI_CreatePer;
			parameters[15].Value = model.TI_CreateDate;
            parameters[16].Value = model.TI_Mark;
            parameters[17].Value = model.TI_Work;
            parameters[18].Value = model.TI_Industry;
            parameters[19].Value = model.TI_Recommend;
            parameters[20].Value = model.TI_RecommendDate;
            parameters[21].Value = model.TI_Email;
            parameters[22].Value = model.TI_Reason;
            parameters[23].Value = model.TI_Interviewer;
            parameters[24].Value = model.TI_OtherRecommendPost;
            parameters[25].Value = model.TI_No;

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
		public bool Delete(int TI_No)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from TB_RC_TalentInfor ");
			strSql.Append(" where TI_No=@TI_No");
			SqlParameter[] parameters = {
					new SqlParameter("@TI_No", SqlDbType.Int,4)
			};
			parameters[0].Value = TI_No;

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
            strSql.Append("delete from TB_RC_TalentInfor ");
            strSql.Append(" where TI_CB_No=@TI_CB_No");
            SqlParameter[] parameters = {
					new SqlParameter("@TI_CB_No", SqlDbType.Int,4)
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
        public bool DeleteList(string TI_Nolist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from TB_RC_TalentInfor ");
            strSql.Append(" where TI_No in (" + TI_Nolist + ")  ");
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
		public Talent.Model.TB_RC_TalentInfor GetModel(int TI_No)
		{
			
			StringBuilder strSql=new StringBuilder();
            strSql.Append("select  top 1 TI_No,TI_CB_No,TI_BrandName,TI_OtherCBName,TI_TalentClass,TI_Name,TI_Sex,TI_Phone,TI_Src,TI_RecommendPost,TI_OtherRecommendPost,TI_Audition,TI_AuditionResult,TI_FollowUpPeople,TI_MaintainDate,TI_MaintainResult,TI_CreatePer,TI_CreateDate,TI_Mark,TI_Work,TI_Industry,TI_Recommend,TI_RecommendDate,TI_Email,TI_Reason,TI_Interviewer from TB_RC_TalentInfor ");
			strSql.Append(" where TI_No=@TI_No");
			SqlParameter[] parameters = {
					new SqlParameter("@TI_No", SqlDbType.Int,4)
			};
			parameters[0].Value = TI_No;

			Talent.Model.TB_RC_TalentInfor model=new Talent.Model.TB_RC_TalentInfor();
            DataSet ds = dbhelp.Query(strSql.ToString(), parameters);
			if(ds.Tables[0].Rows.Count>0)
			{
				if(ds.Tables[0].Rows[0]["TI_No"]!=null && ds.Tables[0].Rows[0]["TI_No"].ToString()!="")
				{
					model.TI_No=int.Parse(ds.Tables[0].Rows[0]["TI_No"].ToString());
				}
				if(ds.Tables[0].Rows[0]["TI_CB_No"]!=null && ds.Tables[0].Rows[0]["TI_CB_No"].ToString()!="")
				{
					model.TI_CB_No=int.Parse(ds.Tables[0].Rows[0]["TI_CB_No"].ToString());
				}
				if(ds.Tables[0].Rows[0]["TI_BrandName"]!=null && ds.Tables[0].Rows[0]["TI_BrandName"].ToString()!="")
				{
					model.TI_BrandName=ds.Tables[0].Rows[0]["TI_BrandName"].ToString();
				}
                //if (ds.Tables[0].Rows[0]["TI_OtherCBName"] != null && ds.Tables[0].Rows[0]["TI_OtherCBName"].ToString() != "")
                //{
                    model.TI_OtherCBName = ds.Tables[0].Rows[0]["TI_OtherCBName"].ToString();
                //}
				if(ds.Tables[0].Rows[0]["TI_TalentClass"]!=null && ds.Tables[0].Rows[0]["TI_TalentClass"].ToString()!="")
				{
					model.TI_TalentClass=ds.Tables[0].Rows[0]["TI_TalentClass"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TI_Name"]!=null && ds.Tables[0].Rows[0]["TI_Name"].ToString()!="")
				{
					model.TI_Name=ds.Tables[0].Rows[0]["TI_Name"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TI_Sex"]!=null && ds.Tables[0].Rows[0]["TI_Sex"].ToString()!="")
				{
					model.TI_Sex=ds.Tables[0].Rows[0]["TI_Sex"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TI_Phone"]!=null && ds.Tables[0].Rows[0]["TI_Phone"].ToString()!="")
				{
					model.TI_Phone=ds.Tables[0].Rows[0]["TI_Phone"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TI_Src"]!=null && ds.Tables[0].Rows[0]["TI_Src"].ToString()!="")
				{
					model.TI_Src=ds.Tables[0].Rows[0]["TI_Src"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TI_RecommendPost"]!=null && ds.Tables[0].Rows[0]["TI_RecommendPost"].ToString()!="")
				{
					model.TI_RecommendPost=ds.Tables[0].Rows[0]["TI_RecommendPost"].ToString();
				}
                if (ds.Tables[0].Rows[0]["TI_OtherRecommendPost"] != null && ds.Tables[0].Rows[0]["TI_OtherRecommendPost"].ToString() != "")
                {
                    model.TI_OtherRecommendPost = ds.Tables[0].Rows[0]["TI_OtherRecommendPost"].ToString();
                }
				if(ds.Tables[0].Rows[0]["TI_Audition"]!=null && ds.Tables[0].Rows[0]["TI_Audition"].ToString()!="")
				{
					model.TI_Audition=ds.Tables[0].Rows[0]["TI_Audition"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TI_AuditionResult"]!=null && ds.Tables[0].Rows[0]["TI_AuditionResult"].ToString()!="")
				{
					model.TI_AuditionResult=ds.Tables[0].Rows[0]["TI_AuditionResult"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TI_FollowUpPeople"]!=null && ds.Tables[0].Rows[0]["TI_FollowUpPeople"].ToString()!="")
				{
					model.TI_FollowUpPeople=ds.Tables[0].Rows[0]["TI_FollowUpPeople"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TI_MaintainDate"]!=null && ds.Tables[0].Rows[0]["TI_MaintainDate"].ToString()!="")
				{
					model.TI_MaintainDate=DateTime.Parse(ds.Tables[0].Rows[0]["TI_MaintainDate"].ToString());
				}
				if(ds.Tables[0].Rows[0]["TI_MaintainResult"]!=null && ds.Tables[0].Rows[0]["TI_MaintainResult"].ToString()!="")
				{
					model.TI_MaintainResult=ds.Tables[0].Rows[0]["TI_MaintainResult"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TI_CreatePer"]!=null && ds.Tables[0].Rows[0]["TI_CreatePer"].ToString()!="")
				{
					model.TI_CreatePer=ds.Tables[0].Rows[0]["TI_CreatePer"].ToString();
				}
				if(ds.Tables[0].Rows[0]["TI_CreateDate"]!=null && ds.Tables[0].Rows[0]["TI_CreateDate"].ToString()!="")
				{
					model.TI_CreateDate=DateTime.Parse(ds.Tables[0].Rows[0]["TI_CreateDate"].ToString());
				}
                if (ds.Tables[0].Rows[0]["TI_Mark"] != null && ds.Tables[0].Rows[0]["TI_Mark"].ToString() != "")
				{
                    model.TI_Mark = ds.Tables[0].Rows[0]["TI_Mark"].ToString();
				}
                if (ds.Tables[0].Rows[0]["TI_Work"] != null && ds.Tables[0].Rows[0]["TI_Work"].ToString() != "")
                {
                    model.TI_Work = ds.Tables[0].Rows[0]["TI_Work"].ToString();
                }
                if (ds.Tables[0].Rows[0]["TI_Industry"] != null && ds.Tables[0].Rows[0]["TI_Industry"].ToString() != "")
                {
                    model.TI_Industry = ds.Tables[0].Rows[0]["TI_Industry"].ToString();
                }
                if (ds.Tables[0].Rows[0]["TI_Recommend"] != null && ds.Tables[0].Rows[0]["TI_Recommend"].ToString() != "")
                {
                    model.TI_Recommend = ds.Tables[0].Rows[0]["TI_Recommend"].ToString();
                }
                if (ds.Tables[0].Rows[0]["TI_Recommend"] != null && ds.Tables[0].Rows[0]["TI_Recommend"].ToString() != "")
                {
                    model.TI_Recommend = ds.Tables[0].Rows[0]["TI_Recommend"].ToString();
                }
                if (ds.Tables[0].Rows[0]["TI_Email"] != null && ds.Tables[0].Rows[0]["TI_Email"].ToString() != "")
                {
                    model.TI_Email = ds.Tables[0].Rows[0]["TI_Email"].ToString();
                }
                if (ds.Tables[0].Rows[0]["TI_Reason"] != null && ds.Tables[0].Rows[0]["TI_Reason"].ToString() != "")
                {
                    model.TI_Reason = ds.Tables[0].Rows[0]["TI_Reason"].ToString();
                }
                if (ds.Tables[0].Rows[0]["TI_Interviewer"] != null && ds.Tables[0].Rows[0]["TI_Interviewer"].ToString() != "")
                {
                    model.TI_Interviewer = ds.Tables[0].Rows[0]["TI_Interviewer"].ToString();
                }
                if (ds.Tables[0].Rows[0]["TI_RecommendDate"] != null && ds.Tables[0].Rows[0]["TI_RecommendDate"].ToString() != "")
                {
                    model.TI_RecommendDate = DateTime.Parse(ds.Tables[0].Rows[0]["TI_RecommendDate"].ToString());
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
            strSql.Append("select TI_No,TI_CB_No,TI_BrandName,TI_OtherCBName,TI_TalentClass,TI_Name,TI_Sex,TI_Phone,TI_Src,TI_RecommendPost,TI_OtherRecommendPost,TI_Audition,TI_AuditionResult,TI_FollowUpPeople,TI_MaintainDate,TI_MaintainResult,TI_CreatePer,TI_CreateDate,TI_Mark,TI_Work,TI_Industry,TI_Recommend,TI_RecommendDate,TI_Email,TI_Reason,TI_Interviewer ");
			strSql.Append(" FROM TB_RC_TalentInfor ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
            strSql.Append(" order by TI_No desc");
            
            return dbhelp.Query(strSql.ToString());
		}

        public DataSet GetListMerge(int PageSize, int PageIndex, string strWhere, int pager)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select CB_Name,CB_Position,TI_No,TI_CB_No,TI_OtherCBName,TI_BrandName,TI_TalentClass,TI_Name,TI_Sex,TI_Phone,TI_Src,TI_RecommendPost,TI_OtherRecommendPost,TI_Audition,TI_AuditionResult,TI_FollowUpPeople,TI_MaintainDate,TI_MaintainResult,TI_CreatePer,TI_CreateDate,TI_Mark,TI_Work,TI_Industry,TI_Recommend,TI_RecommendDate,TI_Email,TI_Reason,TI_Interviewer  from (");
            strSql.Append(" select top " + pager + " * from ( ");
            strSql.Append(" select top " + (PageIndex * PageSize).ToString() + " * from ");
            strSql.Append(" TB_RC_TalentInfor,TB_RC_CompanyBasic  where TI_CB_No=CB_No ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            strSql.Append(" order by  TI_CB_No desc,TI_No desc ");
            strSql.Append(") as tmp1  order by TI_CB_No asc,TI_No asc ");
            strSql.Append(") as tmp2  order by TI_CB_No desc,TI_No desc  ");
            return dbhelp.Query(strSql.ToString());
        }

        public Object GetTotalMerge(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(*) from ");
            strSql.Append(" TB_RC_TalentInfor,TB_RC_CompanyBasic  where TI_CB_No=CB_No ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            return dbhelp.GetSingle(strSql.ToString());
        }

        public DataSet GetListMerge(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select CB_Name,CB_Position,TI_No,TI_CB_No,TI_BrandName,TI_OtherCBName,TI_TalentClass,TI_Name,TI_Sex,TI_Phone,TI_Src,TI_RecommendPost,TI_OtherRecommendPost,TI_Audition,TI_AuditionResult,TI_FollowUpPeople,TI_MaintainDate,TI_MaintainResult,TI_CreatePer,TI_CreateDate,TI_Mark,TI_Work,TI_Industry,TI_Recommend,TI_RecommendDate,TI_Email,TI_Reason,TI_Interviewer  from ");
            strSql.Append(" TB_RC_TalentInfor,TB_RC_CompanyBasic  where TI_CB_No=CB_No ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            strSql.Append(" order by  TI_CB_No desc,TI_No desc ");
            return dbhelp.Query(strSql.ToString());
        }

        public DataSet GetList(int PageSize, int PageIndex, string strWhere, int pager)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  TI_No,TI_CB_No,TI_BrandName,TI_OtherCBName,TI_TalentClass,TI_Name,TI_Sex,TI_Phone,TI_Src,TI_RecommendPost,TI_OtherRecommendPost,TI_Audition,TI_AuditionResult,TI_FollowUpPeople,TI_MaintainDate,TI_MaintainResult,TI_CreatePer,TI_CreateDate,TI_Mark,TI_Work,TI_Industry,TI_Recommend,TI_RecommendDate,TI_Email,TI_Reason,TI_Interviewer  from (");
            strSql.Append(" select top " + pager + " * from ( ");
            strSql.Append(" select top " + (PageIndex * PageSize).ToString() + " * from ");
            strSql.Append(" TB_RC_TalentInfor ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere );
            }
            strSql.Append(" order by  TI_No desc ");
            strSql.Append(") as tmp1  order by TI_No asc ");
            strSql.Append(") as tmp2  order by TI_No desc  ");
            return dbhelp.Query(strSql.ToString());
        }

        public Object GetTotal(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(*) from ");
            strSql.Append(" TB_RC_TalentInfor ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return dbhelp.GetSingle(strSql.ToString());
        }


		#endregion  Method
	}
}

