using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using Talent.Model;
namespace Talent.BLL
{
    /// <summary>
    /// TB_CG_SocialWelfareLink
    /// </summary>
    public partial class TB_CG_SocialWelfareLink
    {
        private readonly Talent.DAL.TB_CG_SocialWelfareLink dal = new Talent.DAL.TB_CG_SocialWelfareLink();
        public TB_CG_SocialWelfareLink()
        { }
        #region  Method

        public bool Exists(Talent.Model.TB_CG_SocialWelfareLink model)
        {
            return dal.Exists(model);
        }
        /// <summary>
        /// 增加一条数据
        /// </summary>
        public bool Add(Talent.Model.TB_CG_SocialWelfareLink model)
        {
            return dal.Add(model);
            
        }
        public bool Add1(Talent.Model.TB_CG_SocialWelfareLink model1)
        {
            return dal.Add1(model1);
            
        }

        public bool Add2(Talent.Model.TB_CG_SocialWelfareLink model1)
        {
            return dal.Add2(model1);

        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int CT_CB_No)
        {

            return dal.Delete(CT_CB_No);
        }

        #endregion  Method
    }
}

