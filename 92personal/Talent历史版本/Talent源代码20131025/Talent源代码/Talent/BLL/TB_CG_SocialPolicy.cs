using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using Talent.Model;
namespace Talent.BLL
{
    public partial class TB_CG_SocialPolicy
    {
        private readonly Talent.DAL.TB_CG_SocialPolicy dal = new Talent.DAL.TB_CG_SocialPolicy();
        public TB_CG_SocialPolicy()
        { }
        #region  Method

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Talent.Model.TB_CG_SocialPolicy model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(Talent.Model.TB_CG_SocialPolicy model)
        {
            return dal.Update(model);
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
        public Talent.Model.TB_CG_SocialPolicy GetModel(int CB_No)
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
        public List<Talent.Model.TB_CG_SocialPolicy> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<Talent.Model.TB_CG_SocialPolicy> DataTableToList(DataTable dt)
        {
            List<Talent.Model.TB_CG_SocialPolicy> modelList = new List<Talent.Model.TB_CG_SocialPolicy>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TB_CG_SocialPolicy model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TB_CG_SocialPolicy();
                    if (dt.Rows[n]["SP_No"] != null && dt.Rows[n]["SP_No"].ToString() != "")
                    {
                        model.CB_No = int.Parse(dt.Rows[n]["SP_No"].ToString());
                    }
                    if (dt.Rows[n]["SP_Mode"] != null && dt.Rows[n]["SP_Mode"].ToString() != "")
                    {
                        model.CB_Des = dt.Rows[n]["SP_Mode"].ToString();
                    }
                    if (dt.Rows[n]["SP_AVGBase"] != null && dt.Rows[n]["SP_AVGBase"].ToString() != "")
                    {
                        model.CB_Name = dt.Rows[n]["SP_AVGBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_MAXBase"] != null && dt.Rows[n]["SP_MAXBase"].ToString() != "")
                    {
                        model.CB_Position = dt.Rows[n]["SP_MAXBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_MINBase"] != null && dt.Rows[n]["SP_MINBase"].ToString() != "")
                    {
                        model.CB_Num = dt.Rows[n]["SP_MINBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyParRatio"] != null && dt.Rows[n]["SP_CompanyParRatio"].ToString() != "")
                    {
                        model.CB_SetUp =  dt.Rows[n]["SP_CompanyParRatio"].ToString() ;
                    }
                    if (dt.Rows[n]["SP_PersonalParRatio"] != null && dt.Rows[n]["SP_PersonalParRatio"].ToString() != "")
                    {
                        model.CB_Je = dt.Rows[n]["SP_PersonalParRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyWorkRatio"] != null && dt.Rows[n]["SP_CompanyWorkRatio"].ToString() != "")
                    {
                        model.CB_Scale = dt.Rows[n]["SP_CompanyWorkRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalWorkRatio"] != null && dt.Rows[n]["SP_PersonalWorkRatio"].ToString() != "")
                    {
                        model.CB_BrandName = dt.Rows[n]["SP_PersonalWorkRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyBirthRatio"] != null && dt.Rows[n]["SP_CompanyBirthRatio"].ToString() != "")
                    {
                        model.CB_PriceSection = dt.Rows[n]["SP_CompanyBirthRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalInjuryRatio"] != null && dt.Rows[n]["SP_PersonalInjuryRatio"].ToString() != "")
                    {
                        model.CB_Category = dt.Rows[n]["SP_PersonalInjuryRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyMedicalRatio"] != null && dt.Rows[n]["SP_CompanyMedicalRatio"].ToString() != "")
                    {
                        model.CB_ModeOperation = dt.Rows[n]["SP_CompanyMedicalRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalMedicalRatio"] != null && dt.Rows[n]["SP_PersonalMedicalRatio"].ToString() != "")
                    {
                        model.CB_ShopNum = dt.Rows[n]["SP_PersonalMedicalRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanySimulateRatio"] != null && dt.Rows[n]["SP_CompanySimulateRatio"].ToString() != "")
                    {
                        model.CB_Founder = dt.Rows[n]["SP_CompanySimulateRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalSimulateRatio"] != null && dt.Rows[n]["SP_PersonalSimulateRatio"].ToString() != "")
                    {
                        model.CB_Advantage = dt.Rows[n]["SP_PersonalSimulateRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialDate"] != null && dt.Rows[n]["SP_SocialDate"].ToString() != "")
                    {
                        model.CB_OrgStructure = DateTime.Parse(dt.Rows[n]["SP_SocialDate"].ToString());
                    }
                    if (dt.Rows[n]["SP_HealthDate"] != null && dt.Rows[n]["SP_HealthDate"].ToString() != "")
                    {
                        model.CB_KeyPerson = DateTime.Parse(dt.Rows[n]["SP_HealthDate"].ToString());
                    }
                    if (dt.Rows[n]["SP_SocialAMDate"] != null && dt.Rows[n]["SP_SocialAMDate"].ToString() != "")
                    {
                        model.CB_HumanSrc = DateTime.Parse(dt.Rows[n]["SP_SocialAMDate"].ToString());
                    }
                    if (dt.Rows[n]["SP_SocialData"] != null && dt.Rows[n]["SP_SocialData"].ToString() != "")
                    {
                        model.CB_CreatePer = dt.Rows[n]["SP_SocialData"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialLocalPolicy"] != null && dt.Rows[n]["SP_SocialLocalPolicy"].ToString() != "")
                    {
                        model.CB_CreateDate = dt.Rows[n]["SP_SocialLocalPolicy"].ToString();
                    }
                    if (dt.Rows[n]["SP_BusinessTransact"] != null && dt.Rows[n]["SP_BusinessTransact"].ToString() != "")
                    {
                        model.CB_Province = dt.Rows[n]["SP_BusinessTransact"].ToString();
                    }
                    if (dt.Rows[n]["SP_Remark1"] != null && dt.Rows[n]["SP_Remark1"].ToString() != "")
                    {
                        model.CB_X = dt.Rows[n]["SP_Remark1"].ToString();
                    }
                    
                    
                    modelList.Add(model);
                }
            }
            return modelList;
        }


        public List<Talent.Model.TB_CG_SocialPolicy> GetModelListAndClass(string strWhere)
        {
            DataSet ds = dal.GetListAndClass(strWhere);
            return DataTableToList2(ds.Tables[0]);
        }

        /*增加颜色*/
        public List<Talent.Model.TB_CG_SocialPolicy> DataTableToList2(DataTable dt)
        {
            List<Talent.Model.TB_CG_SocialPolicy> modelList = new List<Talent.Model.TB_CG_SocialPolicy>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TB_CG_SocialPolicy model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TB_CG_SocialPolicy();
                    if (dt.Rows[n]["SP_No"] != null && dt.Rows[n]["SP_No"].ToString() != "")
                    {
                        model.CB_No = int.Parse(dt.Rows[n]["SP_No"].ToString());
                    }
                    if (dt.Rows[n]["SP_Mode"] != null && dt.Rows[n]["SP_Mode"].ToString() != "")
                    {
                        model.CB_Des = dt.Rows[n]["SP_Mode"].ToString();
                    }
                    if (dt.Rows[n]["SP_AVGBase"] != null && dt.Rows[n]["SP_AVGBase"].ToString() != "")
                    {
                        model.CB_Name = dt.Rows[n]["SP_AVGBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_MAXBase"] != null && dt.Rows[n]["SP_MAXBase"].ToString() != "")
                    {
                        model.CB_Position = dt.Rows[n]["SP_MAXBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_MINBase"] != null && dt.Rows[n]["SP_MINBase"].ToString() != "")
                    {
                        model.CB_Num = dt.Rows[n]["SP_MINBase"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyParRatio"] != null && dt.Rows[n]["SP_CompanyParRatio"].ToString() != "")
                    {
                        model.CB_SetUp = dt.Rows[n]["SP_CompanyParRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalParRatio"] != null && dt.Rows[n]["SP_PersonalParRatio"].ToString() != "")
                    {
                        model.CB_Je = dt.Rows[n]["SP_PersonalParRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyWorkRatio"] != null && dt.Rows[n]["SP_CompanyWorkRatio"].ToString() != "")
                    {
                        model.CB_Scale = dt.Rows[n]["SP_CompanyWorkRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalWorkRatio"] != null && dt.Rows[n]["SP_PersonalWorkRatio"].ToString() != "")
                    {
                        model.CB_BrandName = dt.Rows[n]["SP_PersonalWorkRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyBirthRatio"] != null && dt.Rows[n]["SP_CompanyBirthRatio"].ToString() != "")
                    {
                        model.CB_PriceSection = dt.Rows[n]["SP_CompanyBirthRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalInjuryRatio"] != null && dt.Rows[n]["SP_PersonalInjuryRatio"].ToString() != "")
                    {
                        model.CB_Category = dt.Rows[n]["SP_PersonalInjuryRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanyMedicalRatio"] != null && dt.Rows[n]["SP_CompanyMedicalRatio"].ToString() != "")
                    {
                        model.CB_ModeOperation = dt.Rows[n]["SP_CompanyMedicalRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalMedicalRatio"] != null && dt.Rows[n]["SP_PersonalMedicalRatio"].ToString() != "")
                    {
                        model.CB_ShopNum = dt.Rows[n]["SP_PersonalMedicalRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_CompanySimulateRatio"] != null && dt.Rows[n]["SP_CompanySimulateRatio"].ToString() != "")
                    {
                        model.CB_Founder = dt.Rows[n]["SP_CompanySimulateRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_PersonalSimulateRatio"] != null && dt.Rows[n]["SP_PersonalSimulateRatio"].ToString() != "")
                    {
                        model.CB_Advantage = dt.Rows[n]["SP_PersonalSimulateRatio"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialDate"] != null && dt.Rows[n]["SP_SocialDate"].ToString() != "")
                    {
                        model.CB_OrgStructure = DateTime.Parse(dt.Rows[n]["SP_SocialDate"].ToString());
                    }
                    if (dt.Rows[n]["SP_HealthDate"] != null && dt.Rows[n]["SP_HealthDate"].ToString() != "")
                    {
                        model.CB_KeyPerson = DateTime.Parse(dt.Rows[n]["SP_HealthDate"].ToString());
                    }
                    if (dt.Rows[n]["SP_SocialAMDate"] != null && dt.Rows[n]["SP_SocialAMDate"].ToString() != "")
                    {
                        model.CB_HumanSrc = DateTime.Parse(dt.Rows[n]["SP_SocialAMDate"].ToString());
                    }
                    if (dt.Rows[n]["SP_SocialData"] != null && dt.Rows[n]["SP_SocialData"].ToString() != "")
                    {
                        model.CB_CreatePer = dt.Rows[n]["SP_SocialData"].ToString();
                    }
                    if (dt.Rows[n]["SP_SocialLocalPolicy"] != null && dt.Rows[n]["SP_SocialLocalPolicy"].ToString() != "")
                    {
                        model.CB_CreateDate = dt.Rows[n]["SP_SocialLocalPolicy"].ToString();
                    }
                    if (dt.Rows[n]["SP_BusinessTransact"] != null && dt.Rows[n]["SP_BusinessTransact"].ToString() != "")
                    {
                        model.CB_Province = dt.Rows[n]["SP_BusinessTransact"].ToString();
                    }
                    if (dt.Rows[n]["SP_Remark1"] != null && dt.Rows[n]["SP_Remark1"].ToString() != "")
                    {
                        model.CB_X = dt.Rows[n]["SP_Remark1"].ToString();
                    }
                    

                    modelList.Add(model);
                }
            }
            return modelList;
        }

        #endregion  Method
    }
}
