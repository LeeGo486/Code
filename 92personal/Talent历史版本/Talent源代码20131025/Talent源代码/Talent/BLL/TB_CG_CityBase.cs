using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using Talent.Model;
namespace Talent.BLL
{
    /// <summary>
    /// TB_RC_CompanyBasic
    /// </summary>
    public partial class TB_CG_CityBase
    {
        private readonly Talent.DAL.TB_CG_CityBase dal = new Talent.DAL.TB_CG_CityBase();
        public TB_CG_CityBase()
        { }
        #region  Method

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Talent.Model.TB_CG_CityBase model)
        {
            return dal.Add(model);
        }

        //用于政策信息查询
        public int GetTotalMerge(string strWhere)
        {
            Object obj = dal.GetTotalMerge(strWhere);
            if (obj == null) return 0;
            return Convert.ToInt32(obj);
        }
      
        public List<Talent.Model.TB_CG_CityBase> GetModelListMerge(int PageSize, int PageIndex, string strWhere, int pager)
        {
            DataSet ds = dal.GetListMerge(PageSize, PageIndex, strWhere, pager);
            return DataTableToList3(ds.Tables[0]);
        }
         
        public List<Talent.Model.TB_CG_CityBase> GetModelListMerge(string strWhere)
        {
            DataSet ds = dal.GetListMerge(strWhere);
            return DataTableToList3(ds.Tables[0]);
        }

        public List<Talent.Model.TB_CG_CityBase> DataTableToList3(DataTable dt)
        {
            List<Talent.Model.TB_CG_CityBase> modelList = new List<Talent.Model.TB_CG_CityBase>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TB_CG_CityBase model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TB_CG_CityBase();
                    if (dt.Rows[n]["CB_No"] != null && dt.Rows[n]["CB_No"].ToString() != "")
                    {
                        model.CB_No = int.Parse(dt.Rows[n]["CB_No"].ToString());
                    }
                    if (dt.Rows[n]["CB_Name"] != null && dt.Rows[n]["CB_Name"].ToString() != "")
                    {
                        model.CB_Name = dt.Rows[n]["CB_Name"].ToString();
                    }
                    if (dt.Rows[n]["SP_Mode"] != null && dt.Rows[n]["SP_Mode"].ToString() != "")
                    {
                        model.SP_Mode = dt.Rows[n]["SP_Mode"].ToString();
                    }
                    if (dt.Rows[n]["SP_AVGBase"] != null && dt.Rows[n]["SP_AVGBase"].ToString() != "")
                    {
                        model.SP_AVGBase = dt.Rows[n]["SP_AVGBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_MAXBase"] != null && dt.Rows[n]["SP_MAXBase"].ToString() != "")
                    {
                        model.SP_MAXBase = dt.Rows[n]["SP_MAXBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_MINBase"] != null && dt.Rows[n]["SP_MINBase"].ToString() != "")
                    {
                        model.SP_MINBase = dt.Rows[n]["SP_MINBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyParRatio"] != null && dt.Rows[n]["SP_CompanyParRatio"].ToString() != "")
                    {
                        model.SP_CompanyParRatio = dt.Rows[n]["SP_CompanyParRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalParRatio"] != null && dt.Rows[n]["SP_PersonalParRatio"].ToString() != "")
                    {
                        model.SP_PersonalParRatio = dt.Rows[n]["SP_PersonalParRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyWorkRatio"] != null && dt.Rows[n]["SP_CompanyWorkRatio"].ToString() != "")
                    {
                        model.SP_CompanyWorkRatio = dt.Rows[n]["SP_CompanyWorkRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalWorkRatio"] != null && dt.Rows[n]["SP_PersonalWorkRatio"].ToString() != "")
                    {
                        model.SP_PersonalWorkRatio = dt.Rows[n]["SP_PersonalWorkRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyBirthRatio"] != null && dt.Rows[n]["SP_CompanyBirthRatio"].ToString() != "")
                    {
                        model.SP_CompanyBirthRatio = dt.Rows[n]["SP_CompanyBirthRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalInjuryRatio"] != null && dt.Rows[n]["SP_PersonalInjuryRatio"].ToString() != "")
                    {
                        model.SP_PersonalInjuryRatio = dt.Rows[n]["SP_PersonalInjuryRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyMedicalRatio"] != null && dt.Rows[n]["SP_CompanyMedicalRatio"].ToString() != "")
                    {
                        model.SP_CompanyMedicalRatio = dt.Rows[n]["SP_CompanyMedicalRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalMedicalRatio"] != null && dt.Rows[n]["SP_PersonalMedicalRatio"].ToString() != "")
                    {
                        model.SP_PersonalMedicalRatio = dt.Rows[n]["SP_PersonalMedicalRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanySimulateRatio"] != null && dt.Rows[n]["SP_CompanySimulateRatio"].ToString() != "")
                    {
                        model.SP_CompanySimulateRatio = dt.Rows[n]["SP_CompanySimulateRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalSimulateRatio"] != null && dt.Rows[n]["SP_PersonalSimulateRatio"].ToString() != "")
                    {
                        model.SP_PersonalSimulateRatio = dt.Rows[n]["SP_PersonalSimulateRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialDate"] != null && dt.Rows[n]["SP_SocialDate"].ToString() != "")
                    {
                        model.SP_SocialDate = dt.Rows[n]["SP_SocialDate"].ToString();
                    }
                    if (dt.Rows[n]["SP_HealthDate"] != null && dt.Rows[n]["SP_HealthDate"].ToString() != "")
                    {
                        model.SP_HealthDate = dt.Rows[n]["SP_HealthDate"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialAMDate"] != null && dt.Rows[n]["SP_SocialAMDate"].ToString() != "")
                    {
                        model.SP_SocialAMDate = dt.Rows[n]["SP_SocialAMDate"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialData"] != null && dt.Rows[n]["SP_SocialData"].ToString() != "")
                    {
                        model.SP_SocialData = dt.Rows[n]["SP_SocialData"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialLocalPolicy"] != null && dt.Rows[n]["SP_SocialLocalPolicy"].ToString() != "")
                    {
                        model.SP_SocialLocalPolicy = dt.Rows[n]["SP_SocialLocalPolicy"].ToString();
                    }
                    if (dt.Rows[n]["SP_BusinessTransact"] != null && dt.Rows[n]["SP_BusinessTransact"].ToString() != "")
                    {
                        model.SP_BusinessTransact = dt.Rows[n]["SP_BusinessTransact"].ToString();
                    }
                    if (dt.Rows[n]["MP_Mode"] != null && dt.Rows[n]["MP_Mode"].ToString() != "")
                    {
                        model.MP_Mode = dt.Rows[n]["MP_Mode"].ToString();
                    }
                    if (dt.Rows[n]["MP_MAXBase"] != null && dt.Rows[n]["MP_MAXBase"].ToString() != "")
                    {
                        model.MP_MAXBase = dt.Rows[n]["MP_MAXBase"].ToString();
                    }
                    if (dt.Rows[n]["MP_MINBase"] != null && dt.Rows[n]["MP_MINBase"].ToString() != "")
                    {
                        model.MP_MINBase = dt.Rows[n]["MP_MINBase"].ToString();
                    }
                    if (dt.Rows[n]["MP_CompanyRatio"] != null && dt.Rows[n]["MP_CompanyRatio"].ToString() != "")
                    {
                        model.MP_CompanyRatio = dt.Rows[n]["MP_CompanyRatio"].ToString();
                    }
                    if (dt.Rows[n]["MP_PersonalRatio"] != null && dt.Rows[n]["MP_PersonalRatio"].ToString() != "")
                    {
                        model.MP_PersonalRatio = dt.Rows[n]["MP_PersonalRatio"].ToString();
                    }
                    if (dt.Rows[n]["MP_MPFAdjustDate"] != null && dt.Rows[n]["MP_MPFAdjustDate"].ToString() != "")
                    {
                        model.MP_MPFAdjustDate = dt.Rows[n]["MP_MPFAdjustDate"].ToString();
                    }
                    if (dt.Rows[n]["MP_MPFAMDate"] != null && dt.Rows[n]["MP_MPFAMDate"].ToString() != "")
                    {
                        model.MP_MPFAMDate = dt.Rows[n]["MP_MPFAMDate"].ToString();
                    }
                    if (dt.Rows[n]["MP_MPFLocalPolicy"] != null && dt.Rows[n]["MP_MPFLocalPolicy"].ToString() != "")
                    {
                        model.MP_MPFLocalPolicy = dt.Rows[n]["MP_MPFLocalPolicy"].ToString();
                    }
                    if (dt.Rows[n]["PP_PerPolicyOne"] != null && dt.Rows[n]["PP_PerPolicyOne"].ToString() != "")
                    {
                        model.PP_PerPolicyOne = dt.Rows[n]["PP_PerPolicyOne"].ToString();
                    }
                    if (dt.Rows[n]["PP_PerPolicyTwo"] != null && dt.Rows[n]["PP_PerPolicyTwo"].ToString() != "")
                    {
                        model.PP_PerPolicyTwo = dt.Rows[n]["PP_PerPolicyTwo"].ToString();
                    }
                    if (dt.Rows[n]["WP_WelfarePolicyOne"] != null && dt.Rows[n]["WP_WelfarePolicyOne"].ToString() != "")
                    {
                        model.WP_WelfarePolicyOne = dt.Rows[n]["WP_WelfarePolicyOne"].ToString();
                    }
                    if (dt.Rows[n]["WP_WelfarePolicyTwo"] != null && dt.Rows[n]["WP_WelfarePolicyTwo"].ToString() != "")
                    {
                        model.WP_WelfarePolicyTwo = dt.Rows[n]["WP_WelfarePolicyTwo"].ToString();
                    }
                    if (dt.Rows[n]["SP_Remark1"] != null && dt.Rows[n]["SP_Remark1"].ToString() != "")
                    {
                        model.SP_Remark1 = dt.Rows[n]["SP_Remark1"].ToString();
                    }
                    
                    modelList.Add(model);
                }
            }
            return modelList;
        }


        //用于社保信息查询
        public List<Talent.Model.TB_CG_CityBase> GetListMergeSocialPolicyDetail(int PageSize, int PageIndex, string strWhere, int pager)
        {
            DataSet ds = dal.GetListMergeSocialPolicyDetail(PageSize, PageIndex, strWhere, pager);
            return DataTableToList5(ds.Tables[0]);
        }

        public List<Talent.Model.TB_CG_CityBase> DataTableToList5(DataTable dt)
        {
            List<Talent.Model.TB_CG_CityBase> modelList = new List<Talent.Model.TB_CG_CityBase>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TB_CG_CityBase model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TB_CG_CityBase();
                    if (dt.Rows[n]["SP_No"] != null && dt.Rows[n]["SP_No"].ToString() != "")
                    {
                        model.CB_No = int.Parse(dt.Rows[n]["SP_No"].ToString());
                    } 
                    if (dt.Rows[n]["SP_Mode"] != null && dt.Rows[n]["SP_Mode"].ToString() != "")
                    {
                        model.SP_Mode = dt.Rows[n]["SP_Mode"].ToString();
                    }
                    if (dt.Rows[n]["SP_AVGBase"] != null && dt.Rows[n]["SP_AVGBase"].ToString() != "")
                    {
                        model.SP_AVGBase = dt.Rows[n]["SP_AVGBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_MAXBase"] != null && dt.Rows[n]["SP_MAXBase"].ToString() != "")
                    {
                        model.SP_MAXBase = dt.Rows[n]["SP_MAXBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_MINBase"] != null && dt.Rows[n]["SP_MINBase"].ToString() != "")
                    {
                        model.SP_MINBase = dt.Rows[n]["SP_MINBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyParRatio"] != null && dt.Rows[n]["SP_CompanyParRatio"].ToString() != "")
                    {
                        model.SP_CompanyParRatio = dt.Rows[n]["SP_CompanyParRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalParRatio"] != null && dt.Rows[n]["SP_PersonalParRatio"].ToString() != "")
                    {
                        model.SP_PersonalParRatio = dt.Rows[n]["SP_PersonalParRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyWorkRatio"] != null && dt.Rows[n]["SP_CompanyWorkRatio"].ToString() != "")
                    {
                        model.SP_CompanyWorkRatio = dt.Rows[n]["SP_CompanyWorkRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalWorkRatio"] != null && dt.Rows[n]["SP_PersonalWorkRatio"].ToString() != "")
                    {
                        model.SP_PersonalWorkRatio = dt.Rows[n]["SP_PersonalWorkRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyBirthRatio"] != null && dt.Rows[n]["SP_CompanyBirthRatio"].ToString() != "")
                    {
                        model.SP_CompanyBirthRatio = dt.Rows[n]["SP_CompanyBirthRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalInjuryRatio"] != null && dt.Rows[n]["SP_PersonalInjuryRatio"].ToString() != "")
                    {
                        model.SP_PersonalInjuryRatio = dt.Rows[n]["SP_PersonalInjuryRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyMedicalRatio"] != null && dt.Rows[n]["SP_CompanyMedicalRatio"].ToString() != "")
                    {
                        model.SP_CompanyMedicalRatio = dt.Rows[n]["SP_CompanyMedicalRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalMedicalRatio"] != null && dt.Rows[n]["SP_PersonalMedicalRatio"].ToString() != "")
                    {
                        model.SP_PersonalMedicalRatio = dt.Rows[n]["SP_PersonalMedicalRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanySimulateRatio"] != null && dt.Rows[n]["SP_CompanySimulateRatio"].ToString() != "")
                    {
                        model.SP_CompanySimulateRatio = dt.Rows[n]["SP_CompanySimulateRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalSimulateRatio"] != null && dt.Rows[n]["SP_PersonalSimulateRatio"].ToString() != "")
                    {
                        model.SP_PersonalSimulateRatio = dt.Rows[n]["SP_PersonalSimulateRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialDate"] != null && dt.Rows[n]["SP_SocialDate"].ToString() != "")
                    {
                        model.SP_SocialDate = dt.Rows[n]["SP_SocialDate"].ToString();
                    }
                    if (dt.Rows[n]["SP_HealthDate"] != null && dt.Rows[n]["SP_HealthDate"].ToString() != "")
                    {
                        model.SP_HealthDate = dt.Rows[n]["SP_HealthDate"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialAMDate"] != null && dt.Rows[n]["SP_SocialAMDate"].ToString() != "")
                    {
                        model.SP_SocialAMDate = dt.Rows[n]["SP_SocialAMDate"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialData"] != null && dt.Rows[n]["SP_SocialData"].ToString() != "")
                    {
                        model.SP_SocialData = dt.Rows[n]["SP_SocialData"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialLocalPolicy"] != null && dt.Rows[n]["SP_SocialLocalPolicy"].ToString() != "")
                    {
                        model.SP_SocialLocalPolicy = dt.Rows[n]["SP_SocialLocalPolicy"].ToString();
                    }
                    if (dt.Rows[n]["SP_BusinessTransact"] != null && dt.Rows[n]["SP_BusinessTransact"].ToString() != "")
                    {
                        model.SP_BusinessTransact = dt.Rows[n]["SP_BusinessTransact"].ToString();
                    }
                     
                    if (dt.Rows[n]["SP_Remark1"] != null && dt.Rows[n]["SP_Remark1"].ToString() != "")
                    {
                        model.SP_Remark1 = dt.Rows[n]["SP_Remark1"].ToString();
                    }
                    if (dt.Rows[n]["SP_DateTime"] != null && dt.Rows[n]["SP_DateTime"].ToString() != "")
                    {
                        model.SP_DateTime = dt.Rows[n]["SP_DateTime"].ToString();
                    }


                    modelList.Add(model);
                }
            }
            return modelList;
        }


        //用于查询历史记录 
        public List<Talent.Model.TB_CG_CityBase> GetListHistory(string strWhere)
        {
            DataSet ds = dal.GetListHistory(strWhere);
            return DataTableToList4(ds.Tables[0]);
        }

        public List<Talent.Model.TB_CG_CityBase> DataTableToList4(DataTable dt)
        {
            List<Talent.Model.TB_CG_CityBase> modelList = new List<Talent.Model.TB_CG_CityBase>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TB_CG_CityBase model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TB_CG_CityBase();
                    if (dt.Rows[n]["SP_Mode"] != null && dt.Rows[n]["SP_Mode"].ToString() != "")
                    {
                        model.SP_Mode = dt.Rows[n]["SP_Mode"].ToString();
                    }
                    if (dt.Rows[n]["SP_AVGBase"] != null && dt.Rows[n]["SP_AVGBase"].ToString() != "")
                    {
                        model.SP_AVGBase = dt.Rows[n]["SP_AVGBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_MAXBase"] != null && dt.Rows[n]["SP_MAXBase"].ToString() != "")
                    {
                        model.SP_MAXBase = dt.Rows[n]["SP_MAXBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_MINBase"] != null && dt.Rows[n]["SP_MINBase"].ToString() != "")
                    {
                        model.SP_MINBase = dt.Rows[n]["SP_MINBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyParRatio"] != null && dt.Rows[n]["SP_CompanyParRatio"].ToString() != "")
                    {
                        model.SP_CompanyParRatio = dt.Rows[n]["SP_CompanyParRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalParRatio"] != null && dt.Rows[n]["SP_PersonalParRatio"].ToString() != "")
                    {
                        model.SP_PersonalParRatio = dt.Rows[n]["SP_PersonalParRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyWorkRatio"] != null && dt.Rows[n]["SP_CompanyWorkRatio"].ToString() != "")
                    {
                        model.SP_CompanyWorkRatio = dt.Rows[n]["SP_CompanyWorkRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalWorkRatio"] != null && dt.Rows[n]["SP_PersonalWorkRatio"].ToString() != "")
                    {
                        model.SP_PersonalWorkRatio = dt.Rows[n]["SP_PersonalWorkRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyBirthRatio"] != null && dt.Rows[n]["SP_CompanyBirthRatio"].ToString() != "")
                    {
                        model.SP_CompanyBirthRatio = dt.Rows[n]["SP_CompanyBirthRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalInjuryRatio"] != null && dt.Rows[n]["SP_PersonalInjuryRatio"].ToString() != "")
                    {
                        model.SP_PersonalInjuryRatio = dt.Rows[n]["SP_PersonalInjuryRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyMedicalRatio"] != null && dt.Rows[n]["SP_CompanyMedicalRatio"].ToString() != "")
                    {
                        model.SP_CompanyMedicalRatio = dt.Rows[n]["SP_CompanyMedicalRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalMedicalRatio"] != null && dt.Rows[n]["SP_PersonalMedicalRatio"].ToString() != "")
                    {
                        model.SP_PersonalMedicalRatio = dt.Rows[n]["SP_PersonalMedicalRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanySimulateRatio"] != null && dt.Rows[n]["SP_CompanySimulateRatio"].ToString() != "")
                    {
                        model.SP_CompanySimulateRatio = dt.Rows[n]["SP_CompanySimulateRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalSimulateRatio"] != null && dt.Rows[n]["SP_PersonalSimulateRatio"].ToString() != "")
                    {
                        model.SP_PersonalSimulateRatio = dt.Rows[n]["SP_PersonalSimulateRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialDate"] != null && dt.Rows[n]["SP_SocialDate"].ToString() != "")
                    {
                        model.SP_SocialDate = dt.Rows[n]["SP_SocialDate"].ToString();
                    }
                    if (dt.Rows[n]["SP_HealthDate"] != null && dt.Rows[n]["SP_HealthDate"].ToString() != "")
                    {
                        model.SP_HealthDate = dt.Rows[n]["SP_HealthDate"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialAMDate"] != null && dt.Rows[n]["SP_SocialAMDate"].ToString() != "")
                    {
                        model.SP_SocialAMDate = dt.Rows[n]["SP_SocialAMDate"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialData"] != null && dt.Rows[n]["SP_SocialData"].ToString() != "")
                    {
                        model.SP_SocialData = dt.Rows[n]["SP_SocialData"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialLocalPolicy"] != null && dt.Rows[n]["SP_SocialLocalPolicy"].ToString() != "")
                    {
                        model.SP_SocialLocalPolicy = dt.Rows[n]["SP_SocialLocalPolicy"].ToString();
                    }
                    if (dt.Rows[n]["SP_BusinessTransact"] != null && dt.Rows[n]["SP_BusinessTransact"].ToString() != "")
                    {
                        model.SP_BusinessTransact = dt.Rows[n]["SP_BusinessTransact"].ToString();
                    } 
                    if (dt.Rows[n]["SP_Remark1"] != null && dt.Rows[n]["SP_Remark1"].ToString() != "")
                    {
                        model.SP_Remark1 = dt.Rows[n]["SP_Remark1"].ToString();
                    }

                    modelList.Add(model);
                }
            }
            return modelList;
        }
 
        
        
        /// <summary>
        /// 更新一条数据
        /// </summary>
        //更新社保相关信息
        public bool Update(Talent.Model.TB_CG_CityBase model)
        {
            return dal.Update(model);
            
        }

        public bool ADDHistory(Talent.Model.TB_CG_CityBase model)
        {
            return dal.ADDHistory(model);
            
        }
        
        //更新公积金相关信息
        public bool Update1(Talent.Model.TB_CG_CityBase model)
        {
            return dal.Update1(model);
        }

        //更新人事劳动相关信息
        public bool Update2(Talent.Model.TB_CG_CityBase model)
        {
            return dal.Update2(model);
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int CB_No)
        {

            return dal.Delete(CB_No);
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Talent.Model.TB_CG_CityBase GetModel(int CB_No)
        {

            return dal.GetModel(CB_No);
        }

         
        
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }

       

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<Talent.Model.TB_CG_CityBase> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<Talent.Model.TB_CG_CityBase> DataTableToList(DataTable dt)
        {
            List<Talent.Model.TB_CG_CityBase> modelList = new List<Talent.Model.TB_CG_CityBase>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TB_CG_CityBase model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TB_CG_CityBase();
                    if (dt.Rows[n]["CB_No"] != null && dt.Rows[n]["CB_No"].ToString() != "")
                    {
                        model.CB_No = int.Parse(dt.Rows[n]["CB_No"].ToString());
                    }
                    if (dt.Rows[n]["CB_Des"] != null && dt.Rows[n]["CB_Des"].ToString() != "")
                    {
                        model.CB_Des = dt.Rows[n]["CB_Des"].ToString();
                    }
                    if (dt.Rows[n]["CB_Name"] != null && dt.Rows[n]["CB_Name"].ToString() != "")
                    {
                        model.CB_Name = dt.Rows[n]["CB_Name"].ToString();
                    }
                    if (dt.Rows[n]["CB_ShopNum"] != null && dt.Rows[n]["CB_ShopNum"].ToString() != "")
                    {
                        model.cb_shopnum = dt.Rows[n]["CB_ShopNum"].ToString();
                    }
                    if (dt.Rows[n]["CB_Num"] != null && dt.Rows[n]["CB_Num"].ToString() != "")
                    {
                        model.CB_Num = dt.Rows[n]["CB_Num"].ToString();
                    }
                    if (dt.Rows[n]["CB_SetUp"] != null && dt.Rows[n]["CB_SetUp"].ToString() != "")
                    {
                        model.cb_setup = DateTime.Parse(dt.Rows[n]["CB_SetUp"].ToString()).ToString("yyyy-MM-dd");
                    }
                    if (dt.Rows[n]["CB_Je"] != null && dt.Rows[n]["CB_Je"].ToString() != "")
                    {
                        model.CB_Je = dt.Rows[n]["CB_Je"].ToString();
                    }

                    if (dt.Rows[n]["CB_X"] != null && dt.Rows[n]["CB_X"].ToString() != "")
                    {
                        model.CB_X = dt.Rows[n]["CB_X"].ToString();
                    }
                    if (dt.Rows[n]["CB_Y"] != null && dt.Rows[n]["CB_Y"].ToString() != "")
                    {
                        model.CB_Y = dt.Rows[n]["CB_Y"].ToString();
                    }


                    modelList.Add(model);
                }
            }
            return modelList;
        }


        public List<Talent.Model.TB_CG_CityBase> GetModelListAndClass(string strWhere)
        {
            DataSet ds = dal.GetListAndClass(strWhere);
            return DataTableToList2(ds.Tables[0]);
        }

        /*增加颜色*/
        public List<Talent.Model.TB_CG_CityBase> DataTableToList2(DataTable dt)
        {
            List<Talent.Model.TB_CG_CityBase> modelList = new List<Talent.Model.TB_CG_CityBase>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TB_CG_CityBase model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TB_CG_CityBase();
                    if (dt.Rows[n]["CB_No"] != null && dt.Rows[n]["CB_No"].ToString() != "")
                    {
                        model.CB_No = int.Parse(dt.Rows[n]["CB_No"].ToString());
                    }
                    if (dt.Rows[n]["CB_Des"] != null && dt.Rows[n]["CB_Des"].ToString() != "")
                    {
                        model.CB_Des = dt.Rows[n]["CB_Des"].ToString();
                    }
                    if (dt.Rows[n]["CB_Name"] != null && dt.Rows[n]["CB_Name"].ToString() != "")
                    {
                        model.CB_Name = dt.Rows[n]["CB_Name"].ToString();
                    }
                    if (dt.Rows[n]["CB_ShopNum"] != null && dt.Rows[n]["CB_ShopNum"].ToString() != "")
                    {
                        model.cb_shopnum = dt.Rows[n]["CB_ShopNum"].ToString();
                    }
                    if (dt.Rows[n]["CB_Num"] != null && dt.Rows[n]["CB_Num"].ToString() != "")
                    {
                        model.CB_Num =dt.Rows[n]["CB_Num"].ToString();
                    }
                    if (dt.Rows[n]["CB_SetUp"] != null && dt.Rows[n]["CB_SetUp"].ToString() != "")
                    {
                        model.cb_setup = DateTime.Parse(dt.Rows[n]["CB_SetUp"].ToString()).ToString("yyyy-MM-dd");
                    }
                    if (dt.Rows[n]["CB_Je"] != null && dt.Rows[n]["CB_Je"].ToString() != "")
                    {
                        model.CB_Je = dt.Rows[n]["CB_Je"].ToString();
                    }
                    if (dt.Rows[n]["CB_X"] != null && dt.Rows[n]["CB_X"].ToString() != "")
                    {
                        model.CB_X = dt.Rows[n]["CB_X"].ToString();
                    }
                    if (dt.Rows[n]["CB_Y"] != null && dt.Rows[n]["CB_Y"].ToString() != "")
                    {
                        model.CB_Y = dt.Rows[n]["CB_Y"].ToString();
                    }

                    if (dt.Rows[n]["SP_Mode"] != null && dt.Rows[n]["SP_Mode"].ToString() != "")
                    {
                        model.SP_Mode = dt.Rows[n]["SP_Mode"].ToString();
                    }
                    if (dt.Rows[n]["SP_AVGBase"] != null && dt.Rows[n]["SP_AVGBase"].ToString() != "")
                    {
                        model.SP_AVGBase = dt.Rows[n]["SP_AVGBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_MAXBase"] != null && dt.Rows[n]["SP_MAXBase"].ToString() != "")
                    {
                        model.SP_MAXBase = dt.Rows[n]["SP_MAXBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_MINBase"] != null && dt.Rows[n]["SP_MINBase"].ToString() != "")
                    {
                        model.SP_MINBase = dt.Rows[n]["SP_MINBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyParRatio"] != null && dt.Rows[n]["SP_CompanyParRatio"].ToString() != "")
                    {
                        model.SP_CompanyParRatio = dt.Rows[n]["SP_CompanyParRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalParRatio"] != null && dt.Rows[n]["SP_PersonalParRatio"].ToString() != "")
                    {
                        model.SP_PersonalParRatio = dt.Rows[n]["SP_PersonalParRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyWorkRatio"] != null && dt.Rows[n]["SP_CompanyWorkRatio"].ToString() != "")
                    {
                        model.SP_CompanyWorkRatio = dt.Rows[n]["SP_CompanyWorkRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalWorkRatio"] != null && dt.Rows[n]["SP_PersonalWorkRatio"].ToString() != "")
                    {
                        model.SP_PersonalWorkRatio = dt.Rows[n]["SP_PersonalWorkRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyBirthRatio"] != null && dt.Rows[n]["SP_CompanyBirthRatio"].ToString() != "")
                    {
                        model.SP_CompanyBirthRatio = dt.Rows[n]["SP_CompanyBirthRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalInjuryRatio"] != null && dt.Rows[n]["SP_PersonalInjuryRatio"].ToString() != "")
                    {
                        model.SP_PersonalInjuryRatio = dt.Rows[n]["SP_PersonalInjuryRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyMedicalRatio"] != null && dt.Rows[n]["SP_CompanyMedicalRatio"].ToString() != "")
                    {
                        model.SP_CompanyMedicalRatio = dt.Rows[n]["SP_CompanyMedicalRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalMedicalRatio"] != null && dt.Rows[n]["SP_PersonalMedicalRatio"].ToString() != "")
                    {
                        model.SP_PersonalMedicalRatio = dt.Rows[n]["SP_PersonalMedicalRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanySimulateRatio"] != null && dt.Rows[n]["SP_CompanySimulateRatio"].ToString() != "")
                    {
                        model.SP_CompanySimulateRatio = dt.Rows[n]["SP_CompanySimulateRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalSimulateRatio"] != null && dt.Rows[n]["SP_PersonalSimulateRatio"].ToString() != "")
                    {
                        model.SP_PersonalSimulateRatio = dt.Rows[n]["SP_PersonalSimulateRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialDate"] != null && dt.Rows[n]["SP_SocialDate"].ToString() != "")
                    {
                        model.SP_SocialDate = dt.Rows[n]["SP_SocialDate"].ToString();
                    }
                    if (dt.Rows[n]["SP_HealthDate"] != null && dt.Rows[n]["SP_HealthDate"].ToString() != "")
                    {
                        model.SP_HealthDate = dt.Rows[n]["SP_HealthDate"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialAMDate"] != null && dt.Rows[n]["SP_SocialAMDate"].ToString() != "")
                    {
                        model.SP_SocialAMDate = dt.Rows[n]["SP_SocialAMDate"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialData"] != null && dt.Rows[n]["SP_SocialData"].ToString() != "")
                    {
                        model.SP_SocialData = dt.Rows[n]["SP_SocialData"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialLocalPolicy"] != null && dt.Rows[n]["SP_SocialLocalPolicy"].ToString() != "")
                    {
                        model.SP_SocialLocalPolicy = dt.Rows[n]["SP_SocialLocalPolicy"].ToString();
                    }
                    if (dt.Rows[n]["SP_BusinessTransact"] != null && dt.Rows[n]["SP_BusinessTransact"].ToString() != "")
                    {
                        model.SP_BusinessTransact = dt.Rows[n]["SP_BusinessTransact"].ToString();
                    }
                    if (dt.Rows[n]["MP_Mode"] != null && dt.Rows[n]["MP_Mode"].ToString() != "")
                    {
                        model.MP_Mode = dt.Rows[n]["MP_Mode"].ToString();
                    }
                    if (dt.Rows[n]["MP_MAXBase"] != null && dt.Rows[n]["MP_MAXBase"].ToString() != "")
                    {
                        model.MP_MAXBase = dt.Rows[n]["MP_MAXBase"].ToString();
                    }
                    if (dt.Rows[n]["MP_MINBase"] != null && dt.Rows[n]["MP_MINBase"].ToString() != "")
                    {
                        model.MP_MINBase = dt.Rows[n]["MP_MINBase"].ToString();
                    }
                    if (dt.Rows[n]["MP_CompanyRatio"] != null && dt.Rows[n]["MP_CompanyRatio"].ToString() != "")
                    {
                        model.MP_CompanyRatio = dt.Rows[n]["MP_CompanyRatio"].ToString();
                    }
                    if (dt.Rows[n]["MP_PersonalRatio"] != null && dt.Rows[n]["MP_PersonalRatio"].ToString() != "")
                    {
                        model.MP_PersonalRatio = dt.Rows[n]["MP_PersonalRatio"].ToString();
                    }
                    if (dt.Rows[n]["MP_MPFAdjustDate"] != null && dt.Rows[n]["MP_MPFAdjustDate"].ToString() != "")
                    {
                        model.MP_MPFAdjustDate = dt.Rows[n]["MP_MPFAdjustDate"].ToString();
                    }
                    if (dt.Rows[n]["MP_MPFAMDate"] != null && dt.Rows[n]["MP_MPFAMDate"].ToString() != "")
                    {
                        model.MP_MPFAMDate = dt.Rows[n]["MP_MPFAMDate"].ToString();
                    }
                    if (dt.Rows[n]["MP_MPFLocalPolicy"] != null && dt.Rows[n]["MP_MPFLocalPolicy"].ToString() != "")
                    {
                        model.MP_MPFLocalPolicy = dt.Rows[n]["MP_MPFLocalPolicy"].ToString();
                    }
                    if (dt.Rows[n]["PP_PerPolicyOne"] != null && dt.Rows[n]["PP_PerPolicyOne"].ToString() != "")
                    {
                        model.PP_PerPolicyOne = dt.Rows[n]["PP_PerPolicyOne"].ToString();
                    }
                    if (dt.Rows[n]["PP_PerPolicyTwo"] != null && dt.Rows[n]["PP_PerPolicyTwo"].ToString() != "")
                    {
                        model.PP_PerPolicyTwo = dt.Rows[n]["PP_PerPolicyTwo"].ToString();
                    }
                    if (dt.Rows[n]["WP_WelfarePolicyOne"] != null && dt.Rows[n]["WP_WelfarePolicyOne"].ToString() != "")
                    {
                        model.WP_WelfarePolicyOne = dt.Rows[n]["WP_WelfarePolicyOne"].ToString();
                    }
                    if (dt.Rows[n]["WP_WelfarePolicyTwo"] != null && dt.Rows[n]["WP_WelfarePolicyTwo"].ToString() != "")
                    {
                        model.WP_WelfarePolicyTwo = dt.Rows[n]["WP_WelfarePolicyTwo"].ToString();
                    }
                    if (dt.Rows[n]["WT_WPType"] != null && dt.Rows[n]["WT_WPType"].ToString() != "")
                    {
                        model.WT_WPType = dt.Rows[n]["WT_WPType"].ToString();
                    }
                    if (dt.Rows[n]["WT_Color"] != null && dt.Rows[n]["WT_Color"].ToString() != "")
                    {
                        model.WT_Color = dt.Rows[n]["WT_Color"].ToString();
                    }

                    modelList.Add(model);
                }
            }
            return modelList;
        }

        #endregion  Method
    }
}

