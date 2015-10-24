using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Talent.DAL
{
    /// <summary>
    /// 数据访问类:TB_CG_CityBase
    /// </summary>
    public partial class TB_CG_CityBase
    {
        private DbHelperSQLP dbhelp = null;

        public TB_CG_CityBase()
        {
            this.dbhelp = new DbHelperSQLP(PubConstant.CGConnectionString);
        }
        #region  Method



        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Talent.Model.TB_CG_CityBase model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into TB_CG_CityBase(");
            strSql.Append("CB_Des,CB_Name,cb_shopnum,CB_Num,cb_setup,CB_Je,CB_X,CB_Y)");
            strSql.Append(" values (");
            strSql.Append("@CB_Des,@CB_Name,@cb_shopnum,@CB_Num,@cb_setup,@CB_Je,@CB_X,@CB_Y)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
					new SqlParameter("@CB_Des", SqlDbType.Text),
					new SqlParameter("@CB_Name", SqlDbType.VarChar,100),
					new SqlParameter("@cb_shopnum", SqlDbType.VarChar,400),
					new SqlParameter("@CB_Num", SqlDbType.Int,4),
					new SqlParameter("@cb_setup", SqlDbType.DateTime),
					new SqlParameter("@CB_Je", SqlDbType.VarChar,50),
					new SqlParameter("@CB_X", SqlDbType.VarChar,400),
                    new SqlParameter("@CB_Y", SqlDbType.VarChar,400)};
					 
            parameters[0].Value = model.CB_Des;
            parameters[1].Value = model.CB_Name;
            parameters[2].Value = model.cb_shopnum;
            parameters[3].Value = model.CB_Num;
            parameters[4].Value = model.cb_setup;
            parameters[5].Value = model.CB_Je;
            parameters[6].Value = model.CB_X;
            parameters[7].Value = model.CB_Y;
            
 
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
        //更新社保相关信息
        public bool Update(Talent.Model.TB_CG_CityBase model)
        {   

            StringBuilder strSql = new StringBuilder();
            strSql.Append("update TB_CG_CityBase set ");
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
             
            strSql.Append(" where CB_No=@CB_No");  
            SqlParameter[] parameters = {
                    
                    new SqlParameter("@CB_No", SqlDbType.Int,4), 
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
            parameters[0].Value = model.CB_No;
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

        public bool ADDHistory(Talent.Model.TB_CG_CityBase model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into TB_CG_CityBaseHistory( ");
            strSql.Append("  SP_No,SP_Area,SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio");
            strSql.Append(" ,SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio");
            strSql.Append(" ,SP_CompanyMedicalRatio,SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio");
            strSql.Append(" ,SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,SP_BusinessTransact,SP_Remark1)");
            strSql.Append(" values (");
            strSql.Append(" @SP_No,@SP_Mode,@SP_Mode,@SP_AVGBase,@SP_MAXBase,@SP_MINBase,@SP_CompanyParRatio,@SP_PersonalParRatio,@SP_CompanyWorkRatio");
            strSql.Append(" ,@SP_PersonalWorkRatio,@SP_CompanyBirthRatio,@SP_PersonalInjuryRatio,@SP_CompanyMedicalRatio,@SP_PersonalMedicalRatio");
            strSql.Append(" ,@SP_CompanySimulateRatio,@SP_PersonalSimulateRatio,@SP_SocialDate,@SP_HealthDate,@SP_SocialAMDate,@SP_SocialData");
            strSql.Append(" ,@SP_SocialLocalPolicy,@SP_BusinessTransact,@SP_Remark1 )");

            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
                    
                    new SqlParameter("@SP_No", SqlDbType.Int,4),
					new SqlParameter("@SP_Area", SqlDbType.Text),
                    new SqlParameter("@SP_Mode", SqlDbType.Text),
					new SqlParameter("@SP_AVGBase", SqlDbType.VarChar,20),
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
            parameters[0].Value = model.CB_No;
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
        
        //更新公积金相关数据
        public bool Update1(Talent.Model.TB_CG_CityBase model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update TB_CG_CityBase set ");
             
            strSql.Append("MP_Mode=@MP_Mode,");
            strSql.Append("MP_MAXBase=@MP_MAXBase,");
            strSql.Append("MP_MINBase=@MP_MINBase,");
            strSql.Append("MP_CompanyRatio=@MP_CompanyRatio,");
            strSql.Append("MP_PersonalRatio=@MP_PersonalRatio,");
            strSql.Append("MP_MPFAdjustDate=@MP_MPFAdjustDate,");
            strSql.Append("MP_MPFAMDate=@MP_MPFAMDate,");
            strSql.Append("MP_MPFLocalPolicy=@MP_MPFLocalPolicy");
 

            strSql.Append(" where CB_No=@CB_No");
            SqlParameter[] parameters = {
                    new SqlParameter("@CB_No", SqlDbType.Int,4),
                    new SqlParameter("@MP_Mode", SqlDbType.VarChar,30),
					new SqlParameter("@MP_MAXBase", SqlDbType.VarChar,30),
					new SqlParameter("@MP_MINBase", SqlDbType.VarChar,30),
					new SqlParameter("@MP_CompanyRatio", SqlDbType.VarChar,30),
					new SqlParameter("@MP_PersonalRatio", SqlDbType.VarChar,30),
					new SqlParameter("@MP_MPFAdjustDate", SqlDbType.VarChar,30),
                    new SqlParameter("@MP_MPFAMDate", SqlDbType.VarChar,30),
                    new SqlParameter("@MP_MPFLocalPolicy", SqlDbType.VarChar,1000) 
                    };
            parameters[0].Value = model.CB_No;
            parameters[1].Value = model.MP_Mode;
            parameters[2].Value = model.MP_MAXBase;
            parameters[3].Value = model.MP_MINBase;
            parameters[4].Value = model.MP_CompanyRatio;
            parameters[5].Value = model.MP_PersonalRatio;
            parameters[6].Value = model.MP_MPFAdjustDate;
            parameters[7].Value = model.MP_MPFAMDate;
            parameters[8].Value = model.MP_MPFLocalPolicy;
             
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
        //更新人力劳动信息
        public bool Update2(Talent.Model.TB_CG_CityBase model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update TB_CG_CityBase set ");
             
            strSql.Append("PP_PerPolicyOne=@PP_PerPolicyOne,");
            strSql.Append("PP_PerPolicyTwo=@PP_PerPolicyTwo");
           
            strSql.Append(" where CB_No=@CB_No");
            SqlParameter[] parameters = {
                    
                    new SqlParameter("@CB_No", SqlDbType.Int,4),
					 
 
					new SqlParameter("@PP_PerPolicyOne", SqlDbType.VarChar,1000),
					new SqlParameter("@PP_PerPolicyTwo", SqlDbType.VarChar,1000),
                    
                  
                    };
            parameters[0].Value = model.CB_No;
             
            parameters[1].Value = model.PP_PerPolicyOne;
            parameters[2].Value = model.PP_PerPolicyTwo;
             

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
            strSql.Append("delete from TB_CG_CityBase ");
            strSql.Append(" where CB_No=@CB_No");
            SqlParameter[] parameters = {
					new SqlParameter("@CB_No", SqlDbType.Int,4)
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


        public Object GetTotalMerge(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(*) from ");
            strSql.Append(" TB_CG_CityBase where 1=1 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            return dbhelp.GetSingle(strSql.ToString());
        }


        public DataSet GetListMerge(int PageSize, int PageIndex, string strWhere, int pager)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select CB_No, CB_Name,SP_Area,SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio");
            strSql.Append(" ,SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio");
            strSql.Append(" ,SP_CompanyMedicalRatio,SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio");
            strSql.Append(" ,SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,SP_BusinessTransact");
            strSql.Append(" ,MP_Mode,MP_MAXBase,MP_MINBase,MP_CompanyRatio,MP_PersonalRatio,MP_MPFAdjustDate,MP_MPFAMDate");
            strSql.Append(" ,MP_MPFLocalPolicy,PP_PerPolicyOne,PP_PerPolicyTwo,WP_WelfarePolicyOne,WP_WelfarePolicyTwo,SP_Remark1");
            strSql.Append(" from (");
            strSql.Append(" select top " + pager + " * from ( ");
            strSql.Append(" select top " + (PageIndex * PageSize).ToString() + " * from ");
            strSql.Append(" TB_CG_CityBase  where 1=1 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            strSql.Append(" order by  CB_No desc  ");
            strSql.Append(") as tmp1  order by CB_No asc  ");
            strSql.Append(") as tmp2  order by CB_No desc   ");
            return dbhelp.Query(strSql.ToString());
        }

        public DataSet GetListMerge(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();

            strSql.Append("select CB_No, CB_Name,SP_Area,SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio");
            strSql.Append(" ,SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio");
            strSql.Append(" ,SP_CompanyMedicalRatio,SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio");
            strSql.Append(" ,SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,SP_BusinessTransact");
            strSql.Append(" ,MP_Mode,MP_MAXBase,MP_MINBase,MP_CompanyRatio,MP_PersonalRatio,MP_MPFAdjustDate,MP_MPFAMDate");
            strSql.Append(" ,MP_MPFLocalPolicy,PP_PerPolicyOne,PP_PerPolicyTwo,WP_WelfarePolicyOne,WP_WelfarePolicyTwo,SP_Remark1");

            strSql.Append(" from TB_CG_CityBase  where 1=1 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
  
            strSql.Append(" order by  CB_No desc  ");
            return dbhelp.Query(strSql.ToString());
        }

        public DataSet GetListMergeSocialPolicyDetail(int PageSize, int PageIndex, string strWhere, int pager)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select SP_No,SP_Area,SP_Mode,SP_AVGBase,SP_MAXBase,SP_MINBase,SP_CompanyParRatio,SP_PersonalParRatio");
            strSql.Append(" ,SP_CompanyWorkRatio,SP_PersonalWorkRatio,SP_CompanyBirthRatio,SP_PersonalInjuryRatio");
            strSql.Append(" ,SP_CompanyMedicalRatio,SP_PersonalMedicalRatio,SP_CompanySimulateRatio,SP_PersonalSimulateRatio");
            strSql.Append(" ,SP_SocialDate,SP_HealthDate,SP_SocialAMDate,SP_SocialData,SP_SocialLocalPolicy,SP_BusinessTransact");
            strSql.Append(" ,SP_Remark1,CONVERT(VARCHAR(30),SP_DateTime,23) SP_DateTime ");
            strSql.Append(" from (");
            strSql.Append(" select top " + pager + " * from ( ");
            strSql.Append(" select top " + (PageIndex * PageSize).ToString() + " * from ");
            strSql.Append(" TB_CG_SocialPolicyDetail  where 1=1 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            strSql.Append(" order by  SP_No desc  ");
            strSql.Append(") as tmp1  order by SP_No asc  ");
            strSql.Append(") as tmp2  order by SP_No descS,SP_DateTime desc  ");
            return dbhelp.Query(strSql.ToString());
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Talent.Model.TB_CG_CityBase GetModel(int CB_No)
        {

            StringBuilder strSql = new StringBuilder();

            strSql.Append("select top 1 * from TB_CG_CityBase ");
            strSql.Append(" where CB_NO=@CB_No");
            SqlParameter[] parameters = {
					new SqlParameter("@CB_No", SqlDbType.Int,4)
			};
            parameters[0].Value = CB_No;


            Talent.Model.TB_CG_CityBase model = new Talent.Model.TB_CG_CityBase();
            DataSet ds = dbhelp.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["CB_NO"] != null && ds.Tables[0].Rows[0]["CB_NO"].ToString() != "")
                {
                    model.CB_No = int.Parse(ds.Tables[0].Rows[0]["CB_NO"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CB_Name"] != null && ds.Tables[0].Rows[0]["CB_Name"].ToString() != "")
                {
                    model.CB_Name = ds.Tables[0].Rows[0]["CB_Name"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CB_ShopNum"] != null && ds.Tables[0].Rows[0]["CB_ShopNum"].ToString() != "")
                {
                    model.cb_shopnum = ds.Tables[0].Rows[0]["CB_ShopNum"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CB_Num"] != null && ds.Tables[0].Rows[0]["CB_Num"].ToString() != "")
                {
                    model.CB_Num = ds.Tables[0].Rows[0]["CB_Num"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CB_SetUp"] != null && ds.Tables[0].Rows[0]["CB_SetUp"].ToString() != "")
                {
                    model.cb_setup = ds.Tables[0].Rows[0]["CB_SetUp"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CB_Je"] != null && ds.Tables[0].Rows[0]["CB_Je"].ToString() != "")
                {
                    model.CB_Je = ds.Tables[0].Rows[0]["CB_Je"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CB_Des"] != null && ds.Tables[0].Rows[0]["CB_Des"].ToString() != "")
                {
                    model.CB_Des = ds.Tables[0].Rows[0]["CB_Des"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CB_X"] != null && ds.Tables[0].Rows[0]["CB_X"].ToString() != "")
                {
                    model.CB_X = ds.Tables[0].Rows[0]["CB_X"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CB_Y"] != null && ds.Tables[0].Rows[0]["CB_Y"].ToString() != "")
                {
                    model.CB_Y = ds.Tables[0].Rows[0]["CB_Y"].ToString();
                }
                //
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
                if (ds.Tables[0].Rows[0]["MP_Mode"] != null && ds.Tables[0].Rows[0]["MP_Mode"].ToString() != "")
                {
                    model.MP_Mode = ds.Tables[0].Rows[0]["MP_Mode"].ToString();
                }
                if (ds.Tables[0].Rows[0]["MP_MAXBase"] != null && ds.Tables[0].Rows[0]["MP_MAXBase"].ToString() != "")
                {
                    model.MP_MAXBase = ds.Tables[0].Rows[0]["MP_MAXBase"].ToString();
                }
                if (ds.Tables[0].Rows[0]["MP_MINBase"] != null && ds.Tables[0].Rows[0]["MP_MINBase"].ToString() != "")
                {
                    model.MP_MINBase = ds.Tables[0].Rows[0]["MP_MINBase"].ToString();
                }
                if (ds.Tables[0].Rows[0]["MP_CompanyRatio"] != null && ds.Tables[0].Rows[0]["MP_CompanyRatio"].ToString() != "")
                {
                    model.MP_CompanyRatio = ds.Tables[0].Rows[0]["MP_CompanyRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["MP_PersonalRatio"] != null && ds.Tables[0].Rows[0]["MP_PersonalRatio"].ToString() != "")
                {
                    model.MP_PersonalRatio = ds.Tables[0].Rows[0]["MP_PersonalRatio"].ToString();
                }
                if (ds.Tables[0].Rows[0]["MP_MPFAdjustDate"] != null && ds.Tables[0].Rows[0]["MP_MPFAdjustDate"].ToString() != "")
                {
                    model.MP_MPFAdjustDate = ds.Tables[0].Rows[0]["MP_MPFAdjustDate"].ToString();
                }
                if (ds.Tables[0].Rows[0]["MP_MPFAMDate"] != null && ds.Tables[0].Rows[0]["MP_MPFAMDate"].ToString() != "")
                {
                    model.MP_MPFAMDate = ds.Tables[0].Rows[0]["MP_MPFAMDate"].ToString();
                    //DateTime.Parse(ds.Tables[0].Rows[0]["MP_MPFAMDate"].ToString()).ToString("yyyy-MM-dd"); 
                }
                if (ds.Tables[0].Rows[0]["MP_MPFLocalPolicy"] != null && ds.Tables[0].Rows[0]["MP_MPFLocalPolicy"].ToString() != "")
                {
                    model.MP_MPFLocalPolicy = ds.Tables[0].Rows[0]["MP_MPFLocalPolicy"].ToString();
                }
                if (ds.Tables[0].Rows[0]["PP_PerPolicyOne"] != null && ds.Tables[0].Rows[0]["PP_PerPolicyOne"].ToString() != "")
                {
                    model.PP_PerPolicyOne = ds.Tables[0].Rows[0]["PP_PerPolicyOne"].ToString();
                }
                if (ds.Tables[0].Rows[0]["PP_PerPolicyTwo"] != null && ds.Tables[0].Rows[0]["PP_PerPolicyTwo"].ToString() != "")
                {
                    model.PP_PerPolicyTwo = ds.Tables[0].Rows[0]["PP_PerPolicyTwo"].ToString();
                }
                if (ds.Tables[0].Rows[0]["WP_WelfarePolicyOne"] != null && ds.Tables[0].Rows[0]["WP_WelfarePolicyOne"].ToString() != "")
                {
                    model.WP_WelfarePolicyOne = ds.Tables[0].Rows[0]["WP_WelfarePolicyOne"].ToString();
                }
                if (ds.Tables[0].Rows[0]["WP_WelfarePolicyTwo"] != null && ds.Tables[0].Rows[0]["WP_WelfarePolicyTwo"].ToString() != "")
                {
                    model.WP_WelfarePolicyTwo = ds.Tables[0].Rows[0]["WP_WelfarePolicyTwo"].ToString();
                }
                if (ds.Tables[0].Rows[0]["SP_Remark1"] != null && ds.Tables[0].Rows[0]["SP_Remark1"].ToString() != "")
                {
                    model.SP_Remark1 = ds.Tables[0].Rows[0]["SP_Remark1"].ToString();
                }
                 
                return model;
            }
            else
            {
                return null;
            }
        }

        //public Talent.Model.TB_CG_CityBase GetListHistory(string strWhere)
         
        //{
        //    StringBuilder strSql = new StringBuilder();
        //    //CB_NO,CB_Name,CB_ShopNum,CB_Num,CB_SetUp,CB_Je,CB_Des,CB_X,CB_Y
             
        //    strSql.Append("select top 1 * from TB_CG_CityBaseHistory ");
        //    strSql.Append(" where 1=1 @CB_No");
        //    SqlParameter[] parameters = {
        //            new SqlParameter("@CB_No", SqlDbType.Int,4)
        //    };
        //    parameters[0].Value = strWhere;

             
        //    Talent.Model.TB_CG_CityBase model = new Talent.Model.TB_CG_CityBase();

        //    DataSet ds = dbhelp.Query(strSql.ToString(), parameters);

        //    if (ds.Tables[0].Rows.Count > 0)
        //    {
        //        if (ds.Tables[0].Rows[0]["CB_NO"] != null && ds.Tables[0].Rows[0]["CB_NO"].ToString() != "")
        //        {
        //            model.CB_No = int.Parse(ds.Tables[0].Rows[0]["CB_NO"].ToString());
        //        }
        //        if (ds.Tables[0].Rows[0]["CB_Name"] != null && ds.Tables[0].Rows[0]["CB_Name"].ToString() != "")
        //        {
        //            model.CB_Name = ds.Tables[0].Rows[0]["CB_Name"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["CB_ShopNum"] != null && ds.Tables[0].Rows[0]["CB_ShopNum"].ToString() != "")
        //        {
        //            model.cb_shopnum = ds.Tables[0].Rows[0]["CB_ShopNum"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["CB_Num"] != null && ds.Tables[0].Rows[0]["CB_Num"].ToString() != "")
        //        {
        //            model.CB_Num = ds.Tables[0].Rows[0]["CB_Num"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["CB_SetUp"] != null && ds.Tables[0].Rows[0]["CB_SetUp"].ToString() != "")
        //        {
        //            model.cb_setup = DateTime.Parse(ds.Tables[0].Rows[0]["CB_SetUp"].ToString()).ToString("yyyy-MM-dd");
        //        }
        //        if (ds.Tables[0].Rows[0]["CB_Je"] != null && ds.Tables[0].Rows[0]["CB_Je"].ToString() != "")
        //        {
        //            model.CB_Je = ds.Tables[0].Rows[0]["CB_Je"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["CB_Des"] != null && ds.Tables[0].Rows[0]["CB_Des"].ToString() != "")
        //        {
        //            model.CB_Des = ds.Tables[0].Rows[0]["CB_Des"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["CB_X"] != null && ds.Tables[0].Rows[0]["CB_X"].ToString() != "")
        //        {
        //            model.CB_X = ds.Tables[0].Rows[0]["CB_X"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["CB_Y"] != null && ds.Tables[0].Rows[0]["CB_Y"].ToString() != "")
        //        {
        //            model.CB_Y = ds.Tables[0].Rows[0]["CB_Y"].ToString();
        //        }
        //        //
        //        if (ds.Tables[0].Rows[0]["SP_Mode"] != null && ds.Tables[0].Rows[0]["SP_Mode"].ToString() != "")
        //        {
        //            model.SP_Mode = ds.Tables[0].Rows[0]["SP_Mode"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_AVGBase"] != null && ds.Tables[0].Rows[0]["SP_AVGBase"].ToString() != "")
        //        {
        //            model.SP_AVGBase = ds.Tables[0].Rows[0]["SP_AVGBase"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_MAXBase"] != null && ds.Tables[0].Rows[0]["SP_MAXBase"].ToString() != "")
        //        {
        //            model.SP_MAXBase = ds.Tables[0].Rows[0]["SP_MAXBase"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_MINBase"] != null && ds.Tables[0].Rows[0]["SP_MINBase"].ToString() != "")
        //        {
        //            model.SP_MINBase = ds.Tables[0].Rows[0]["SP_MINBase"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_CompanyParRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanyParRatio"].ToString() != "")
        //        {
        //            model.SP_CompanyParRatio = ds.Tables[0].Rows[0]["SP_CompanyParRatio"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_PersonalParRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalParRatio"].ToString() != "")
        //        {
        //            model.SP_PersonalParRatio = ds.Tables[0].Rows[0]["SP_PersonalParRatio"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_CompanyWorkRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanyWorkRatio"].ToString() != "")
        //        {
        //            model.SP_CompanyWorkRatio = ds.Tables[0].Rows[0]["SP_CompanyWorkRatio"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_PersonalWorkRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalWorkRatio"].ToString() != "")
        //        {
        //            model.SP_PersonalWorkRatio = ds.Tables[0].Rows[0]["SP_PersonalWorkRatio"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_CompanyBirthRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanyBirthRatio"].ToString() != "")
        //        {
        //            model.SP_CompanyBirthRatio = ds.Tables[0].Rows[0]["SP_CompanyBirthRatio"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_PersonalInjuryRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalInjuryRatio"].ToString() != "")
        //        {
        //            model.SP_PersonalInjuryRatio = ds.Tables[0].Rows[0]["SP_PersonalInjuryRatio"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_CompanyMedicalRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanyMedicalRatio"].ToString() != "")
        //        {
        //            model.SP_CompanyMedicalRatio = ds.Tables[0].Rows[0]["SP_CompanyMedicalRatio"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_PersonalMedicalRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalMedicalRatio"].ToString() != "")
        //        {
        //            model.SP_PersonalMedicalRatio = ds.Tables[0].Rows[0]["SP_PersonalMedicalRatio"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_CompanySimulateRatio"] != null && ds.Tables[0].Rows[0]["SP_CompanySimulateRatio"].ToString() != "")
        //        {
        //            model.SP_CompanySimulateRatio = ds.Tables[0].Rows[0]["SP_CompanySimulateRatio"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_PersonalSimulateRatio"] != null && ds.Tables[0].Rows[0]["SP_PersonalSimulateRatio"].ToString() != "")
        //        {
        //            model.SP_PersonalSimulateRatio = ds.Tables[0].Rows[0]["SP_PersonalSimulateRatio"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_SocialDate"] != null && ds.Tables[0].Rows[0]["SP_SocialDate"].ToString() != "")
        //        {
        //            model.SP_SocialDate = DateTime.Parse(ds.Tables[0].Rows[0]["SP_SocialDate"].ToString()).ToString("yyyy-MM-dd");
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_HealthDate"] != null && ds.Tables[0].Rows[0]["SP_HealthDate"].ToString() != "")
        //        {
        //            model.SP_HealthDate = DateTime.Parse(ds.Tables[0].Rows[0]["SP_HealthDate"].ToString()).ToString("yyyy-MM-dd");
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_SocialAMDate"] != null && ds.Tables[0].Rows[0]["SP_SocialAMDate"].ToString() != "")
        //        {
        //            model.SP_SocialAMDate = DateTime.Parse(ds.Tables[0].Rows[0]["SP_SocialAMDate"].ToString()).ToString("yyyy-MM-dd");
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_SocialData"] != null && ds.Tables[0].Rows[0]["SP_SocialData"].ToString() != "")
        //        {
        //            model.SP_SocialData = ds.Tables[0].Rows[0]["SP_SocialData"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_SocialLocalPolicy"] != null && ds.Tables[0].Rows[0]["SP_SocialLocalPolicy"].ToString() != "")
        //        {
        //            model.SP_SocialLocalPolicy = ds.Tables[0].Rows[0]["SP_SocialLocalPolicy"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_BusinessTransact"] != null && ds.Tables[0].Rows[0]["SP_BusinessTransact"].ToString() != "")
        //        {
        //            model.SP_BusinessTransact = ds.Tables[0].Rows[0]["SP_BusinessTransact"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["MP_Mode"] != null && ds.Tables[0].Rows[0]["MP_Mode"].ToString() != "")
        //        {
        //            model.MP_Mode = ds.Tables[0].Rows[0]["MP_Mode"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["MP_MAXBase"] != null && ds.Tables[0].Rows[0]["MP_MAXBase"].ToString() != "")
        //        {
        //            model.MP_MAXBase = ds.Tables[0].Rows[0]["MP_MAXBase"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["MP_MINBase"] != null && ds.Tables[0].Rows[0]["MP_MINBase"].ToString() != "")
        //        {
        //            model.MP_MINBase = ds.Tables[0].Rows[0]["MP_MINBase"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["MP_CompanyRatio"] != null && ds.Tables[0].Rows[0]["MP_CompanyRatio"].ToString() != "")
        //        {
        //            model.MP_CompanyRatio = ds.Tables[0].Rows[0]["MP_CompanyRatio"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["MP_PersonalRatio"] != null && ds.Tables[0].Rows[0]["MP_PersonalRatio"].ToString() != "")
        //        {
        //            model.MP_PersonalRatio = ds.Tables[0].Rows[0]["MP_PersonalRatio"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["MP_MPFAdjustDate"] != null && ds.Tables[0].Rows[0]["MP_MPFAdjustDate"].ToString() != "")
        //        {
        //            model.MP_MPFAdjustDate = ds.Tables[0].Rows[0]["MP_MPFAdjustDate"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["MP_MPFAMDate"] != null && ds.Tables[0].Rows[0]["MP_MPFAMDate"].ToString() != "")
        //        {
        //            model.MP_MPFAMDate = ds.Tables[0].Rows[0]["MP_MPFAMDate"].ToString();
        //            //DateTime.Parse(ds.Tables[0].Rows[0]["MP_MPFAMDate"].ToString()).ToString("yyyy-MM-dd"); 
        //        }
        //        if (ds.Tables[0].Rows[0]["MP_MPFLocalPolicy"] != null && ds.Tables[0].Rows[0]["MP_MPFLocalPolicy"].ToString() != "")
        //        {
        //            model.MP_MPFLocalPolicy = ds.Tables[0].Rows[0]["MP_MPFLocalPolicy"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["PP_PerPolicyOne"] != null && ds.Tables[0].Rows[0]["PP_PerPolicyOne"].ToString() != "")
        //        {
        //            model.PP_PerPolicyOne = ds.Tables[0].Rows[0]["PP_PerPolicyOne"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["PP_PerPolicyTwo"] != null && ds.Tables[0].Rows[0]["PP_PerPolicyTwo"].ToString() != "")
        //        {
        //            model.PP_PerPolicyTwo = ds.Tables[0].Rows[0]["PP_PerPolicyTwo"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["WP_WelfarePolicyOne"] != null && ds.Tables[0].Rows[0]["WP_WelfarePolicyOne"].ToString() != "")
        //        {
        //            model.WP_WelfarePolicyOne = ds.Tables[0].Rows[0]["WP_WelfarePolicyOne"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["WP_WelfarePolicyTwo"] != null && ds.Tables[0].Rows[0]["WP_WelfarePolicyTwo"].ToString() != "")
        //        {
        //            model.WP_WelfarePolicyTwo = ds.Tables[0].Rows[0]["WP_WelfarePolicyTwo"].ToString();
        //        }
        //        if (ds.Tables[0].Rows[0]["SP_Remark1"] != null && ds.Tables[0].Rows[0]["SP_Remark1"].ToString() != "")
        //        {
        //            model.SP_Remark1 = ds.Tables[0].Rows[0]["SP_Remark1"].ToString();
        //        }


        //        return model;
        //    }
        //    else
        //    {
        //        return null;
        //    }

        //}
        

        /*用于历史查询*/
         

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            //CB_NO,CB_Name,CB_ShopNum,CB_Num,CB_SetUp,CB_Je,CB_Des,CB_X,CB_Y
            strSql.Append("select *  ");
            strSql.Append("FROM TB_CG_CityBase ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return dbhelp.Query(strSql.ToString());
        }


        public DataSet GetListAndClass(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            //CB_NO,CB_Name,CB_ShopNum,CB_Num,CB_SetUp,CB_Je,CB_Des,CB_X,CB_Y
            strSql.Append("select TB_CG_CityBase.*,WT_WPType,WT_Color ");
            strSql.Append(" FROM TB_CG_CityBase left join TB_CG_SocialWelfareLink   on CB_No=SW_CB_NO  left join TB_CG_WelfarePolicyType on SW_WT_No=WT_No");
            strSql.Append(" where 1=1 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            strSql.Append(" order by CB_No asc ");
            return dbhelp.Query(strSql.ToString());
        }



        public DataSet GetListHistory(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            //CB_NO,CB_Name,CB_ShopNum,CB_Num,CB_SetUp,CB_Je,CB_Des,CB_X,CB_Y
            strSql.Append("select top 1 *  ");
            strSql.Append("FROM TB_CG_CityBaseHistory ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where 1=1 " + strWhere);
            }
            return dbhelp.Query(strSql.ToString());
        }




        #endregion  Method
    }
}

