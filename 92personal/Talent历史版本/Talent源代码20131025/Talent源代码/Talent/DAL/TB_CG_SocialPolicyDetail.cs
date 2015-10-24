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
    public partial class TB_CG_SocialPolicyDetail
    {
        private DbHelperSQLP dbhelp = null;

        public TB_CG_SocialPolicyDetail()
        {
            this.dbhelp = new DbHelperSQLP(PubConstant.CGConnectionString);
        }

        #region  Method

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Talent.Model.TB_CG_SocialPolicyDetail model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into TB_CG_SocialPolicyDetail(");
            strSql.Append("SP_No,SP_Area,SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio");
            strSql.Append(",SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio");
            strSql.Append(",SP_CompanyMedicalRatio,SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio");
            strSql.Append(",SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,SP_BusinessTransact");
            strSql.Append(",SP_Remark1)");
            strSql.Append(" values (");
            strSql.Append("@SP_No,@SP_Area,@SP_Mode,@SP_AVGBase,@SP_MAXBase,@SP_MINBase,@SP_CompanyParRatio,@SP_PersonalParRatio,");
            strSql.Append("@SP_CompanyWorkRatio,@SP_PersonalWorkRatio,@SP_CompanyBirthRatio,@SP_PersonalInjuryRatio,");
            strSql.Append("@SP_CompanyMedicalRatio,@SP_PersonalMedicalRatio,@SP_CompanySimulateRatio,@SP_PersonalSimulateRatio,");
            strSql.Append("@SP_SocialDate,@SP_HealthDate,@SP_SocialAMDate,@SP_SocialData,@SP_SocialLocalPolicy,@SP_BusinessTransact,@SP_Remark1)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
					new SqlParameter("@SP_No", SqlDbType.Int,4), 
                    new SqlParameter("@SP_Area", SqlDbType.VarChar,100),
                    new SqlParameter("@SP_Mode", SqlDbType.VarChar,30),
					new SqlParameter("@SP_AVGBase", SqlDbType.VarChar,30),
					new SqlParameter("@SP_MAXBase", SqlDbType.VarChar,30),
					new SqlParameter("@SP_MINBase", SqlDbType.VarChar,30),
					new SqlParameter("@SP_CompanyParRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_PersonalParRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_CompanyWorkRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_PersonalWorkRatio", SqlDbType.VarChar,30),
                    new SqlParameter("@SP_CompanyBirthRatio", SqlDbType.VarChar,30),
                    
                    new SqlParameter("@SP_PersonalInjuryRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_CompanyMedicalRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_PersonalMedicalRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_CompanySimulateRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_PersonalSimulateRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_SocialDate", SqlDbType.VarChar,30),
                    new SqlParameter("@SP_HealthDate", SqlDbType.VarChar,30),

                    new SqlParameter("@SP_SocialAMDate", SqlDbType.VarChar,30),
					new SqlParameter("@SP_SocialData", SqlDbType.VarChar,200),
					new SqlParameter("@SP_SocialLocalPolicy", SqlDbType.VarChar,1000),
                    new SqlParameter("@SP_BusinessTransact", SqlDbType.VarChar,200),
                    new SqlParameter("@SP_Remark1", SqlDbType.VarChar,200)

                                        };
            parameters[0].Value = model.SP_No;
            parameters[1].Value = model.SP_Area;
            parameters[2].Value = model.SP_Mode;
            parameters[3].Value = model.SP_AVGBase;
            parameters[4].Value = model.SP_MAXBase;
            parameters[5].Value = model.SP_MINBase;
            parameters[6].Value = model.SP_CompanyParRatio;
            parameters[7].Value = model.SP_PersonalParRatio;
            parameters[8].Value = model.SP_CompanyWorkRatio;
            parameters[9].Value = model.SP_PersonalWorkRatio;
            parameters[10].Value = model.SP_CompanyBirthRatio;
            parameters[11].Value = model.SP_PersonalInjuryRatio;
            parameters[12].Value = model.SP_CompanyMedicalRatio;
            parameters[13].Value = model.SP_PersonalMedicalRatio;
            parameters[14].Value = model.SP_CompanySimulateRatio;
            parameters[15].Value = model.SP_PersonalSimulateRatio;
            parameters[16].Value = model.SP_SocialDate;
            parameters[17].Value = model.SP_HealthDate;
            parameters[18].Value = model.SP_SocialAMDate;
            parameters[19].Value = model.SP_SocialData; 
            parameters[20].Value = model.SP_SocialLocalPolicy;
            parameters[21].Value = model.SP_BusinessTransact;
            parameters[22].Value = model.SP_Remark1;

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
        public bool Update(Talent.Model.TB_CG_SocialPolicyDetail model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update TB_CG_SocialPolicyDetail set ");
            strSql.Append("SP_No=@SP_No,");
            strSql.Append("SP_Area=@SP_Area,");
            strSql.Append("SP_Mode=@SP_Mode,");
            strSql.Append("SP_AVGBase=@SP_AVGBase,");
            strSql.Append("SP_MAXBase=@SP_MAXBase,");
            strSql.Append("SP_MINBase=@SP_MINBase,");
            strSql.Append("SP_CompanyParRatio=@SP_CompanyParRatio,");
            strSql.Append("SP_PersonalParRatio=@SP_PersonalParRatio,");
            strSql.Append("SP_CompanyWorkRatio=@SP_CompanyWorkRatio,");
            strSql.Append("SP_PersonalWorkRatio=@SP_PersonalWorkRatio,");
            strSql.Append("SP_CompanyBirthRatio=@SP_CompanyBirthRatio,");
            strSql.Append("SP_PersonalInjuryRatio=@SP_PersonalInjuryRatio,");
            strSql.Append("SP_CompanyMedicalRatio=@SP_CompanyMedicalRatio,");
            strSql.Append("SP_PersonalMedicalRatio=@SP_PersonalMedicalRatio,");
            strSql.Append("SP_CompanySimulateRatio=@SP_CompanySimulateRatio,");
            strSql.Append("SP_PersonalSimulateRatio=@SP_PersonalSimulateRatio,");
            strSql.Append("SP_SocialDate=@SP_SocialDate,");
            strSql.Append("SP_HealthDate=@SP_HealthDate,");
            strSql.Append("SP_SocialAMDate=@SP_SocialAMDate,");
            strSql.Append("SP_SocialData=@SP_SocialData,");
            strSql.Append("SP_SocialLocalPolicy=@SP_SocialLocalPolicy,");
            strSql.Append("SP_BusinessTransact=@SP_BusinessTransact,");
            strSql.Append("SP_Remark1=@SP_Remark1");
            strSql.Append(" where No=@No ");
            SqlParameter[] parameters = {
                    new SqlParameter("@No", SqlDbType.Int,4),
					new SqlParameter("@SP_No", SqlDbType.Int,4),
					new SqlParameter("@SP_Area", SqlDbType.VarChar,100),
                    new SqlParameter("@SP_Mode", SqlDbType.VarChar,30),
					new SqlParameter("@SP_AVGBase", SqlDbType.VarChar,30),
					new SqlParameter("@SP_MAXBase", SqlDbType.VarChar,30),
					new SqlParameter("@SP_MINBase", SqlDbType.VarChar,30),
					new SqlParameter("@SP_CompanyParRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_PersonalParRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_CompanyWorkRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_PersonalWorkRatio", SqlDbType.VarChar,30),
                    new SqlParameter("@SP_CompanyBirthRatio", SqlDbType.VarChar,30),
                    
                    new SqlParameter("@SP_PersonalInjuryRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_CompanyMedicalRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_PersonalMedicalRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_CompanySimulateRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_PersonalSimulateRatio", SqlDbType.VarChar,30),
					new SqlParameter("@SP_SocialDate", SqlDbType.VarChar,30),
                    new SqlParameter("@SP_HealthDate", SqlDbType.VarChar,30),

                    new SqlParameter("@SP_SocialAMDate", SqlDbType.VarChar,30),
					new SqlParameter("@SP_SocialData", SqlDbType.VarChar,200),
					new SqlParameter("@SP_SocialLocalPolicy", SqlDbType.VarChar,1000),
                    new SqlParameter("@SP_BusinessTransact", SqlDbType.VarChar,200),
                    new SqlParameter("@SP_Remark1", SqlDbType.VarChar,200)};
            parameters[0].Value = model.No;
            parameters[1].Value = model.SP_No;
            parameters[2].Value = model.SP_Area;
            parameters[3].Value = model.SP_Mode;
            parameters[4].Value = model.SP_AVGBase;
            parameters[5].Value = model.SP_MAXBase;
            parameters[6].Value = model.SP_MINBase;
            parameters[7].Value = model.SP_CompanyParRatio;
            parameters[8].Value = model.SP_PersonalParRatio;
            parameters[9].Value = model.SP_CompanyWorkRatio;
            parameters[10].Value = model.SP_PersonalWorkRatio;
            parameters[11].Value = model.SP_CompanyBirthRatio;
            parameters[12].Value = model.SP_PersonalInjuryRatio;
            parameters[13].Value = model.SP_CompanyMedicalRatio;
            parameters[14].Value = model.SP_PersonalMedicalRatio;
            parameters[15].Value = model.SP_CompanySimulateRatio;
            parameters[16].Value = model.SP_PersonalSimulateRatio;
            parameters[17].Value = model.SP_SocialDate;
            parameters[18].Value = model.SP_HealthDate;
            parameters[19].Value = model.SP_SocialAMDate;
            parameters[20].Value = model.SP_SocialData;
            parameters[21].Value = model.SP_SocialLocalPolicy;
            parameters[22].Value = model.SP_BusinessTransact;
            parameters[23].Value = model.SP_Remark1;

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
        public bool Delete(int CB_NO)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from TB_CG_SocialPolicyDetail ");
            strSql.Append(" where  No=@No   ");
            SqlParameter[] parameters = {
					new SqlParameter("@No", SqlDbType.Int,4)
                     
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

        public bool DeleteByCB_NO(int CB_NO)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from TB_RC_TalentInfor ");
            strSql.Append(" where SP_No=@SP_No");
            SqlParameter[] parameters = {
					new SqlParameter("@SP_No", SqlDbType.Int,4)
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
            strSql.Append("delete from TB_CG_SocialPolicyDetail ");
            strSql.Append(" where SP_No in (" + TI_Nolist + ")  ");
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
        public Talent.Model.TB_CG_SocialPolicyDetail GetModel(int TI_No)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1  ");
            strSql.Append(" No,SP_No,SP_Area,SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio");
            strSql.Append(",SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio");
            strSql.Append(",SP_CompanyMedicalRatio,SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio");
            strSql.Append(",SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,SP_BusinessTransact");
            strSql.Append(",SP_Remark1,CONVERT(VARCHAR(30),SP_DateTime,23) as SP_DateTime from TB_CG_SocialPolicyDetail   ");
            strSql.Append(" where No=@SP_No order by No desc  ");
            SqlParameter[] parameters = {
					new SqlParameter("@SP_No", SqlDbType.Int,4)
			};
            parameters[0].Value = TI_No;

            Talent.Model.TB_CG_SocialPolicyDetail model = new Talent.Model.TB_CG_SocialPolicyDetail();
            DataSet ds = dbhelp.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["No"] != null && ds.Tables[0].Rows[0]["No"].ToString() != "")
                {
                    model.No =  ds.Tables[0].Rows[0]["No"].ToString() ;
                }
                if (ds.Tables[0].Rows[0]["SP_No"] != null && ds.Tables[0].Rows[0]["SP_No"].ToString() != "")
                {
                    model.SP_No = int.Parse(ds.Tables[0].Rows[0]["SP_No"].ToString());
                }
                if (ds.Tables[0].Rows[0]["SP_Area"] != null && ds.Tables[0].Rows[0]["SP_Area"].ToString() != "")
                {
                    model.SP_Area = ds.Tables[0].Rows[0]["SP_Area"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_Mode"] != null && ds.Tables[0].Rows[0]["SP_Mode"].ToString() != "")
                {
                    model.SP_Mode = ds.Tables[0].Rows[0]["SP_Mode"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_AVGBase"] != null && ds.Tables[0].Rows[0]["SP_AVGBase"].ToString() != "")
                {
                    model.SP_AVGBase = ds.Tables[0].Rows[0]["SP_AVGBase"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_MAXBase"] != null && ds.Tables[0].Rows[0]["SP_MAXBase"].ToString() != "")
                {
                    model.SP_MAXBase = ds.Tables[0].Rows[0]["SP_MAXBase"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_MINBase"] != null && ds.Tables[0].Rows[0]["SP_MINBase"].ToString() != "")
                {
                    model.SP_MINBase = ds.Tables[0].Rows[0]["SP_MINBase"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_CompanyParRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanyParRatio"].ToString() != "")
                {
                    model.SP_CompanyParRatio = ds.Tables[0].Rows[0]["SP_CompanyParRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_PersonalParRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalParRatio"].ToString() != "")
                {
                    model.SP_PersonalParRatio = ds.Tables[0].Rows[0]["SP_PersonalParRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_CompanyWorkRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanyWorkRatio"].ToString() != "")
                {
                    model.SP_CompanyWorkRatio = ds.Tables[0].Rows[0]["SP_CompanyWorkRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_PersonalWorkRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalWorkRatio"].ToString() != "")
                {
                    model.SP_PersonalWorkRatio = ds.Tables[0].Rows[0]["SP_PersonalWorkRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_CompanyBirthRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanyBirthRatio"].ToString() != "")
                {
                    model.SP_CompanyBirthRatio = ds.Tables[0].Rows[0]["SP_CompanyBirthRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_PersonalInjuryRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalInjuryRatio"].ToString() != "")
                {
                    model.SP_PersonalInjuryRatio = ds.Tables[0].Rows[0]["SP_PersonalInjuryRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_CompanyMedicalRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanyMedicalRatio"].ToString() != "")
                {
                    model.SP_CompanyMedicalRatio = ds.Tables[0].Rows[0]["SP_CompanyMedicalRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_PersonalMedicalRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalMedicalRatio"].ToString() != "")
                {
                    model.SP_PersonalMedicalRatio = ds.Tables[0].Rows[0]["SP_PersonalMedicalRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_CompanySimulateRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanySimulateRatio"].ToString() != "")
                {
                    model.SP_CompanySimulateRatio = ds.Tables[0].Rows[0]["SP_CompanySimulateRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_PersonalSimulateRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalSimulateRatio"].ToString() != "")
                {
                    model.SP_PersonalSimulateRatio = ds.Tables[0].Rows[0]["SP_PersonalSimulateRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_SocialDate"] != null && ds.Tables[0].Rows[0]["SP_SocialDate"].ToString() != "")
                {
                    model.SP_SocialDate = DateTime.Parse(ds.Tables[0].Rows[0]["SP_SocialDate"].ToString()).ToString("yyyy-MM-dd");
                }
                if (ds.Tables[0].Rows[0]["SP_HealthDate"] != null && ds.Tables[0].Rows[0]["SP_HealthDate"].ToString() != "")
                {
                    model.SP_HealthDate = DateTime.Parse(ds.Tables[0].Rows[0]["SP_HealthDate"].ToString()).ToString("yyyy-MM-dd");
                }
                if (ds.Tables[0].Rows[0]["SP_SocialAMDate"] != null && ds.Tables[0].Rows[0]["SP_SocialAMDate"].ToString() != "")
                {
                    model.SP_SocialAMDate = DateTime.Parse(ds.Tables[0].Rows[0]["SP_SocialAMDate"].ToString()).ToString("yyyy-MM-dd");
                }
                if (ds.Tables[0].Rows[0]["SP_SocialData"] != null && ds.Tables[0].Rows[0]["SP_SocialData"].ToString() != "")
                {
                    model.SP_SocialData = ds.Tables[0].Rows[0]["SP_SocialData"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_SocialLocalPolicy"] != null && ds.Tables[0].Rows[0]["SP_SocialLocalPolicy"].ToString() != "")
                {
                    model.SP_SocialLocalPolicy = ds.Tables[0].Rows[0]["SP_SocialLocalPolicy"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_BusinessTransact"] != null && ds.Tables[0].Rows[0]["SP_BusinessTransact"].ToString() != "")
                {
                    model.SP_BusinessTransact = ds.Tables[0].Rows[0]["SP_BusinessTransact"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_Remark1"] != null && ds.Tables[0].Rows[0]["SP_Remark1"].ToString() != "")
                {
                    model.SP_Remark1 = ds.Tables[0].Rows[0]["SP_Remark1"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_DateTime"] != null && ds.Tables[0].Rows[0]["SP_DateTime"].ToString() != "")
                {
                    model.SP_DateTime = ds.Tables[0].Rows[0]["SP_DateTime"].ToString();
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
            strSql.Append("select ");
            strSql.Append("No,SP_No,SP_Area,SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio");
            strSql.Append(",SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio");
            strSql.Append(",SP_CompanyMedicalRatio,SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio");
            strSql.Append(",SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,SP_BusinessTransact");
            strSql.Append(",SP_Remark1,CONVERT(VARCHAR(30),SP_DateTime,23) as SP_DateTime     ");
            strSql.Append(" FROM TB_CG_SocialPolicyDetail ");
            
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where 1=1  " + strWhere);
            }
            strSql.Append(" order by SP_No desc,SP_DateTime DESC ");

            return dbhelp.Query(strSql.ToString());
        }

        public DataSet GetListMerge(int PageSize, int PageIndex, string strWhere, int pager)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  ");
            strSql.Append("No,SP_No,SP_Area,SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio");
            strSql.Append(",SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio");
            strSql.Append(",SP_CompanyMedicalRatio,SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio");
            strSql.Append(",SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,SP_BusinessTransact");
            strSql.Append(",SP_Remark1,CONVERT(VARCHAR(30),SP_DateTime,23) as SP_DateTime    from (  ");
            strSql.Append(" select top " + pager + " * from ( ");
            strSql.Append(" select top " + (PageIndex * PageSize).ToString() + " * from ");
            strSql.Append(" TB_CG_SocialPolicyDetail  where 1=1 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            strSql.Append(" order by  SP_No desc,SP_DateTime desc ");
            strSql.Append(") as tmp1  order by SP_No asc,SP_DateTime asc ");
            strSql.Append(") as tmp2  order by SP_No desc,SP_DateTime desc  ");
            return dbhelp.Query(strSql.ToString());
        }

        public Object GetTotalMerge(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(*) from ");
            strSql.Append(" TB_CG_SocialPolicyDetail   where 1=1 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            return dbhelp.GetSingle(strSql.ToString());
        }

        public DataSet GetListMerge(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            strSql.Append("No,SP_No,SP_Area,SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio");
            strSql.Append(",SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio");
            strSql.Append(",SP_CompanyMedicalRatio,SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio");
            strSql.Append(",SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,SP_BusinessTransact");
            strSql.Append(",SP_Remark1,CONVERT(VARCHAR(30),SP_DateTime,23) as SP_DateTime     ");
            strSql.Append(" TB_CG_SocialPolicyDetail   where 1=1 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            strSql.Append(" order by  SP_No desc,SP_DateTime desc ");
            return dbhelp.Query(strSql.ToString());
        }

        public DataSet GetList(int PageSize, int PageIndex, string strWhere, int pager)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  ");
            strSql.Append("No,SP_No,SP_Area,SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio");
            strSql.Append(",SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio");
            strSql.Append(",SP_CompanyMedicalRatio,SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio");
            strSql.Append(",SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,SP_BusinessTransact");
            strSql.Append(",SP_Remark1,CONVERT(VARCHAR(30),SP_DateTime,23) as SP_DateTime    from (  ");
            strSql.Append(" select top " + pager + " * from ( ");
            strSql.Append(" select top " + (PageIndex * PageSize).ToString() + " * from ");
            strSql.Append(" TB_CG_SocialPolicyDetail ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by  SP_No desc,SP_DateTime DESC ");
            strSql.Append(") as tmp1  order by SP_No asc,SP_DateTime DESC ");
            strSql.Append(") as tmp2  order by SP_No desc,SP_DateTime DESC  ");
            return dbhelp.Query(strSql.ToString());
        }

        public Object GetTotal(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(*) from ");
            strSql.Append(" TB_CG_SocialPolicyDetail ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return dbhelp.GetSingle(strSql.ToString());
        }


        #endregion  Method
    }
}

