using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using Talent.Model;
namespace Talent.BLL
{
    /// <summary>
    /// TB_RC_TalentClass
    /// </summary>
    public partial class TB_CG_WelfarePolicyType
    {
        private readonly Talent.DAL.TB_CG_WelfarePolicyType dal = new Talent.DAL.TB_CG_WelfarePolicyType();
        public TB_CG_WelfarePolicyType()
        { }
        #region  Method

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Talent.Model.TB_CG_WelfarePolicyType model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(Talent.Model.TB_CG_WelfarePolicyType model)
        {
            return dal.Update(model);
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool DeleteList(string TC_Nolist)
        {
            return dal.DeleteList(TC_Nolist);
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Talent.Model.TB_CG_WelfarePolicyType GetModel(int TC_No)
        {

            return dal.GetModel(TC_No);
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
        public List<Talent.Model.TB_CG_WelfarePolicyType> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<Talent.Model.TB_CG_WelfarePolicyType> DataTableToList(DataTable dt)
        {
            List<Talent.Model.TB_CG_WelfarePolicyType> modelList = new List<Talent.Model.TB_CG_WelfarePolicyType>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TB_CG_WelfarePolicyType model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TB_CG_WelfarePolicyType();
                    if (dt.Rows[n]["WT_No"] != null && dt.Rows[n]["WT_No"].ToString() != "")
                    {
                        model.WT_No = int.Parse(dt.Rows[n]["WT_No"].ToString());
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

        public List<Talent.Model.TB_CG_WelfarePolicyType> GetModelList(int PageSize, int PageIndex, string strWhere, int pager)
        {
            DataSet ds = dal.GetList(PageSize, PageIndex, strWhere, pager);
            return DataTableToList(ds.Tables[0]);
        }

        public int GetTotal(string strWhere)
        {
            Object obj = dal.GetTotal(strWhere);
            if (obj == null) return 0;
            return Convert.ToInt32(obj);
        }

        public List<Talent.Model.TB_CG_WelfarePolicyType> GetModelListByRelate(string CT_CB_No)
        {
            DataSet ds = dal.GetListByRelate(CT_CB_No);
            return DataTableToList(ds.Tables[0]);
        }

        #endregion  Method
    }
}

