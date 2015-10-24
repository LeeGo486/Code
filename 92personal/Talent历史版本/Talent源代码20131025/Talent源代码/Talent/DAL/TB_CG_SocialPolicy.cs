using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Talent.DAL
{
    public partial class TB_CG_SocialPolicy
    {
        private DbHelperSQLP dbhelp = null;

        public TB_CG_SocialPolicy()
        {
            this.dbhelp = new DbHelperSQLP(PubConstant.CGConnectionString);
        }
        #region  Method
        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Talent.Model.TB_CG_SocialPolicy model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into TB_CG_SocialPolicy(");
            strSql.Append("SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio,SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio,SP_CompanyMedicalRatio,");
            strSql.Append("SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio,SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,");
            strSql.Append("SP_BusinessTransact,SP_Remark1)");
            strSql.Append(" values (");
            strSql.Append("@SP_Mode,@SP_AVGBase,@SP_MAXBase,@SP_MINBase,@SP_CompanyParRatio,@SP_PersonalParRatio,@SP_CompanyWorkRatio,@SP_PersonalWorkRatio,@SP_CompanyBirthRatio,@SP_PersonalInjuryRatio,@SP_CompanyMedicalRatio,");
            strSql.Append("@SP_PersonalMedicalRatio,@SP_CompanySimulateRatio,@SP_PersonalSimulateRatio,@SP_SocialDate,@SP_HealthDate,@SP_SocialAMDate,@SP_SocialData,@SP_SocialLocalPolicy,");
            strSql.Append("@SP_BusinessTransact,@SP_Remark1)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
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
					new SqlParameter("@SP_SocialDate", SqlDbType.DateTime),
					new SqlParameter("@SP_HealthDate", SqlDbType.DateTime),
					new SqlParameter("@SP_SocialAMDate", SqlDbType.DateTime),
					new SqlParameter("@SP_SocialData", SqlDbType.VarChar,200),
					new SqlParameter("@SP_SocialLocalPolicy", SqlDbType.VarChar,1000),
					new SqlParameter("@SP_BusinessTransact", SqlDbType.DateTime),
                    new SqlParameter("@SP_Remark1", SqlDbType.VarChar,200)};
            parameters[0].Value = model.CB_Des;
            parameters[1].Value = model.CB_Name;
            parameters[2].Value = model.CB_Position;
            parameters[3].Value = model.CB_Num;
            parameters[4].Value = model.CB_SetUp;
            parameters[5].Value = model.CB_Je;
            parameters[6].Value = model.CB_Scale;
            parameters[7].Value = model.CB_BrandName;
            parameters[8].Value = model.CB_PriceSection;
            parameters[9].Value = model.CB_Category;
            parameters[10].Value = model.CB_ModeOperation;
            parameters[11].Value = model.CB_ShopNum;
            parameters[12].Value = model.CB_Founder;
            parameters[13].Value = model.CB_Advantage;
            parameters[14].Value = model.CB_OrgStructure;
            parameters[15].Value = model.CB_KeyPerson;
            parameters[16].Value = model.CB_HumanSrc;
            parameters[17].Value = model.CB_CreatePer;
            parameters[18].Value = model.CB_CreateDate;
            parameters[19].Value = model.CB_Province;
            parameters[20].Value = model.CB_X;
            parameters[21].Value = model.CB_Y;
            

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
        public bool Update(Talent.Model.TB_CG_SocialPolicy model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update TB_CG_SocialPolicy set ");
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
             
            strSql.Append(" where SP_Mode=@SP_Mode");
            SqlParameter[] parameters = {
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
					new SqlParameter("@SP_SocialDate", SqlDbType.DateTime),
					new SqlParameter("@SP_HealthDate", SqlDbType.DateTime),
					new SqlParameter("@SP_SocialAMDate", SqlDbType.DateTime),
					new SqlParameter("@SP_SocialData", SqlDbType.VarChar,200),
					new SqlParameter("@SP_SocialLocalPolicy", SqlDbType.VarChar,1000),
					new SqlParameter("@SP_BusinessTransact", SqlDbType.DateTime),
                    new SqlParameter("@SP_Remark1", SqlDbType.VarChar,200)};
       			 
            parameters[0].Value = model.CB_Des;
            parameters[1].Value = model.CB_Name;
            parameters[2].Value = model.CB_Position;
            parameters[3].Value = model.CB_Num;
            parameters[4].Value = model.CB_SetUp;
            parameters[5].Value = model.CB_Je;
            parameters[6].Value = model.CB_Scale;
            parameters[7].Value = model.CB_BrandName;
            parameters[8].Value = model.CB_PriceSection;
            parameters[9].Value = model.CB_Category;
            parameters[10].Value = model.CB_ModeOperation;
            parameters[11].Value = model.CB_ShopNum;
            parameters[12].Value = model.CB_Founder;
            parameters[13].Value = model.CB_Advantage;
            parameters[14].Value = model.CB_OrgStructure;
            parameters[15].Value = model.CB_KeyPerson;
            parameters[16].Value = model.CB_HumanSrc;
            parameters[17].Value = model.CB_CreatePer;
            parameters[18].Value = model.CB_CreateDate;
            parameters[19].Value = model.CB_Province;
            parameters[20].Value = model.CB_Des;

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
        public bool Delete(int CB_No)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from TB_CG_SocialPolicy ");
            strSql.Append(" where SP_Mode=@SP_Mode");
            SqlParameter[] parameters = {
					new SqlParameter("@SP_Mode", SqlDbType.Int,4)
			};
            parameters[0].Value = CB_No;

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
        /*	public bool DeleteList(string CB_Nolist )
            {
                StringBuilder strSql=new StringBuilder();
                strSql.Append("delete from TB_RC_CompanyBasic ");
                strSql.Append(" where CB_No in ("+CB_Nolist + ")  ");
                int rows = dbhelp.ExecuteSql(strSql.ToString());
                if (rows > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }  */


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Talent.Model.TB_CG_SocialPolicy GetModel(int CB_No)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 ");
            strSql.Append("SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio,SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio,SP_CompanyMedicalRatio,");
            strSql.Append("SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio,SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,");
            strSql.Append("SP_BusinessTransact,SP_Remark1)");
            strSql.Append("from TB_CG_SocialPolicy ");
            strSql.Append(" where SP_Mode=@SP_Mode");
            SqlParameter[] parameters = {
					new SqlParameter("@SP_Mode", SqlDbType.Int,4)
			};
            parameters[0].Value = CB_No;

            Talent.Model.TB_CG_SocialPolicy model = new Talent.Model.TB_CG_SocialPolicy();
            DataSet ds = dbhelp.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["SP_Mode"] != null && ds.Tables[0].Rows[0]["SP_Mode"].ToString() != "")
                {
                    model.CB_No =  int.Parse(ds.Tables[0].Rows[0]["SP_Mode"].ToString());
                }
                if (ds.Tables[0].Rows[0]["SP_AVGBase"] != null && ds.Tables[0].Rows[0]["SP_AVGBase"].ToString() != "")
                {
                    model.CB_Des = ds.Tables[0].Rows[0]["SP_AVGBase"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_MAXBase"] != null && ds.Tables[0].Rows[0]["SP_MAXBase"].ToString() != "")
                {
                    model.CB_Name = ds.Tables[0].Rows[0]["SP_MAXBase"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_MINBase"] != null && ds.Tables[0].Rows[0]["SP_MINBase"].ToString() != "")
                {
                    model.CB_Position = ds.Tables[0].Rows[0]["SP_MINBase"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_CompanyParRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanyParRatio"].ToString() != "")
                {
                    model.CB_Num = ds.Tables[0].Rows[0]["SP_CompanyParRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_PersonalParRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalParRatio"].ToString() != "")
                {
                    model.CB_SetUp = ds.Tables[0].Rows[0]["SP_PersonalParRatio"].ToString();
                    //model.CB_SetUp = DateTime.Parse(ds.Tables[0].Rows[0]["SP_PersonalParRatio"].ToString()).ToString("yyyy-MM-dd");
                }
                if (ds.Tables[0].Rows[0]["SP_CompanyWorkRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanyWorkRatio"].ToString() != "")
                {
                    model.CB_Je = ds.Tables[0].Rows[0]["SP_CompanyWorkRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_PersonalWorkRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalWorkRatio"].ToString() != "")
                {
                    model.CB_Scale = ds.Tables[0].Rows[0]["SP_PersonalWorkRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_CompanyBirthRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanyBirthRatio"].ToString() != "")
                {
                    model.CB_BrandName = ds.Tables[0].Rows[0]["SP_CompanyBirthRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_PersonalInjuryRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalInjuryRatio"].ToString() != "")
                {
                    model.CB_PriceSection = ds.Tables[0].Rows[0]["SP_PersonalInjuryRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_CompanyMedicalRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanyMedicalRatio"].ToString() != "")
                {
                    model.CB_Category = ds.Tables[0].Rows[0]["SP_CompanyMedicalRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_PersonalMedicalRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalMedicalRatio"].ToString() != "")
                {
                    model.CB_ModeOperation = ds.Tables[0].Rows[0]["SP_PersonalMedicalRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_CompanySimulateRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanySimulateRatio"].ToString() != "")
                {
                    model.CB_ShopNum =  ds.Tables[0].Rows[0]["SP_CompanySimulateRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_PersonalSimulateRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalSimulateRatio"].ToString() != "")
                {
                    model.CB_Founder = ds.Tables[0].Rows[0]["SP_PersonalSimulateRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_SocialDate"] != null && ds.Tables[0].Rows[0]["SP_SocialDate"].ToString() != "")
                {
                    model.CB_Advantage = ds.Tables[0].Rows[0]["SP_SocialDate"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_HealthDate"] != null && ds.Tables[0].Rows[0]["SP_HealthDate"].ToString() != "")
                {
                    model.CB_OrgStructure = DateTime.Parse(ds.Tables[0].Rows[0]["SP_HealthDate"].ToString());
                }
                if (ds.Tables[0].Rows[0]["SP_SocialAMDate"] != null && ds.Tables[0].Rows[0]["SP_SocialAMDate"].ToString() != "")
                {
                    model.CB_KeyPerson = DateTime.Parse(ds.Tables[0].Rows[0]["SP_SocialAMDate"].ToString());
                }
                if (ds.Tables[0].Rows[0]["SP_SocialData"] != null && ds.Tables[0].Rows[0]["SP_SocialData"].ToString() != "")
                {
                    model.CB_CreateDate =  ds.Tables[0].Rows[0]["SP_SocialData"].ToString() ;  
                }
                if (ds.Tables[0].Rows[0]["SP_SocialLocalPolicy"] != null && ds.Tables[0].Rows[0]["SP_SocialLocalPolicy"].ToString() != "")
                {
                    model.CB_CreatePer = ds.Tables[0].Rows[0]["SP_SocialLocalPolicy"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_BusinessTransact"] != null && ds.Tables[0].Rows[0]["SP_BusinessTransact"].ToString() != "")
                {
                    model.CB_HumanSrc = DateTime.Parse(ds.Tables[0].Rows[0]["SP_BusinessTransact"].ToString());
                }
                if (ds.Tables[0].Rows[0]["SP_Remark1"] != null && ds.Tables[0].Rows[0]["SP_Remark1"].ToString() != "")
                {
                    model.CB_Province = ds.Tables[0].Rows[0]["SP_Remark1"].ToString();
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

            strSql.Append("select SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio,SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio,SP_CompanyMedicalRatio,");
            strSql.Append("SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio,SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,");
            strSql.Append("SP_BusinessTransact,SP_Remark1)");
            strSql.Append(" FROM TB_CG_SocialPolicy ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return dbhelp.Query(strSql.ToString());
        }


        public DataSet GetListAndClass(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio,SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio,SP_CompanyMedicalRatio,");
            strSql.Append("SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio,SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,");
            strSql.Append("SP_BusinessTransact,SP_Remark1");
            strSql.Append(" FROM TB_CG_SocialPolicy ");
            //strSql.Append("select CB_No,CB_Des,CB_Name,CB_Position,CB_Num,CB_SetUp,CB_Je,CB_Scale,CB_BrandName,CB_PriceSection,CB_Category,CB_ModeOperation,CB_ShopNum,CB_Founder,CB_Advantage,CB_OrgStructure,CB_KeyPerson,CB_HumanSrc,CB_CreatePer,CB_CreateDate,CB_Province,CB_X,CB_Y,CB_Img,CB_Css,TC_Class,TC_Color,CB_BrandStyle ");
            //strSql.Append(" FROM TB_RC_CompanyBasic left join TB_RC_CompanyTalentClassRelate on CB_No=CT_CB_No  left join TB_RC_TalentClass on CT_TC_No=TC_No");
            strSql.Append(" where 1=1 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            strSql.Append(" order by SP_Mode asc ");
            return dbhelp.Query(strSql.ToString());
        }

        #endregion  Method
    } 
}
