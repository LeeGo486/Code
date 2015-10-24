using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using Talent.Model;
namespace Talent.BLL
{
    /// <summary>
    /// TB_RC_TalentInfor
    /// </summary>
    public partial class TB_CG_SocialPolicyDetail
    {
        private readonly Talent.DAL.TB_CG_SocialPolicyDetail dal = new Talent.DAL.TB_CG_SocialPolicyDetail();
        public TB_CG_SocialPolicyDetail()
        { }
        #region  Method

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Talent.Model.TB_CG_SocialPolicyDetail model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(Talent.Model.TB_CG_SocialPolicyDetail model)
        {
            return dal.Update(model);
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int TI_No)
        {

            return dal.Delete(TI_No);
        }

        public bool DeleteByCB_NO(int CB_NO)
        {
            return dal.DeleteByCB_NO(CB_NO);
        }
        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool DeleteList(string TI_Nolist)
        {
            return dal.DeleteList(TI_Nolist);
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Talent.Model.TB_CG_SocialPolicyDetail GetModel(int TI_No)
        {

            return dal.GetModel(TI_No);
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
        public List<Talent.Model.TB_CG_SocialPolicyDetail> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        

        public List<Talent.Model.TB_CG_SocialPolicyDetail> GetModelListMerge(int PageSize, int PageIndex, string strWhere, int pager)
        {
            DataSet ds = dal.GetListMerge(PageSize, PageIndex, strWhere, pager);
            return DataTableToList2(ds.Tables[0]);
        }

        public List<Talent.Model.TB_CG_SocialPolicyDetail> GetModelListMerge(string strWhere)
        {
            DataSet ds = dal.GetListMerge(strWhere);
            return DataTableToList2(ds.Tables[0]);
        }

        public List<Talent.Model.TB_CG_SocialPolicyDetail> DataTableToList2(DataTable dt)
        {
            List<Talent.Model.TB_CG_SocialPolicyDetail> modelList = new List<Talent.Model.TB_CG_SocialPolicyDetail>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TB_CG_SocialPolicyDetail model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TB_CG_SocialPolicyDetail();
                    if (dt.Rows[n]["No"] != null && dt.Rows[n]["No"].ToString() != "")
                    {
                        model.No =  dt.Rows[n]["No"].ToString() ;
                    }
                    if (dt.Rows[n]["SP_No"] != null && dt.Rows[n]["SP_No"].ToString() != "")
                    {
                        model.SP_No = int.Parse(dt.Rows[n]["SP_No"].ToString());
                    }
                    if (dt.Rows[n]["SP_Area"] != null && dt.Rows[n]["SP_Area"].ToString() != "")
                    {
                        model.SP_Area = dt.Rows[n]["SP_Area"].ToString();
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
                    modelList.Add(model);
                }
            }
            return modelList;
        }


        public int GetTotalMerge(string strWhere)
        {
            Object obj = dal.GetTotalMerge(strWhere);
            if (obj == null) return 0;
            return Convert.ToInt32(obj);
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        


        public List<Talent.Model.TB_CG_SocialPolicyDetail> GetModelList(int PageSize, int PageIndex, string strWhere, int pager)
        {
            DataSet ds = dal.GetList(PageSize, PageIndex, strWhere, pager);
            return DataTableToList(ds.Tables[0]);
        }

        public List<Talent.Model.TB_CG_SocialPolicyDetail> DataTableToList(DataTable dt)
        {
            List<Talent.Model.TB_CG_SocialPolicyDetail> modelList = new List<Talent.Model.TB_CG_SocialPolicyDetail>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TB_CG_SocialPolicyDetail model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TB_CG_SocialPolicyDetail();
                    if (dt.Rows[n]["No"] != null && dt.Rows[n]["No"].ToString() != "")
                    {
                        model.No =  dt.Rows[n]["No"].ToString() ;
                    }
                    if (dt.Rows[n]["SP_No"] != null && dt.Rows[n]["SP_No"].ToString() != "")
                    {
                        model.SP_No = int.Parse(dt.Rows[n]["SP_No"].ToString());
                    }
                    if (dt.Rows[n]["SP_Area"] != null && dt.Rows[n]["SP_Area"].ToString() != "")
                    {
                        model.SP_Area = dt.Rows[n]["SP_Area"].ToString();
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
                    modelList.Add(model);
                }
            }
            return modelList;
        }


        public int GetTotal(string strWhere)
        {
            Object obj = dal.GetTotal(strWhere);
            if (obj == null) return 0;
            return Convert.ToInt32(obj);
        }

        #endregion  Method
    }
}

