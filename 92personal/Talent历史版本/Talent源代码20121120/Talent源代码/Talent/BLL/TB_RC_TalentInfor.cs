﻿using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using Talent.Model;
namespace Talent.BLL
{
	/// <summary>
	/// TB_RC_TalentInfor
	/// </summary>
	public partial class TB_RC_TalentInfor
	{
		private readonly Talent.DAL.TB_RC_TalentInfor dal=new Talent.DAL.TB_RC_TalentInfor();
		public TB_RC_TalentInfor()
		{}
		#region  Method

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int  Add(Talent.Model.TB_RC_TalentInfor model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(Talent.Model.TB_RC_TalentInfor model)
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
		public bool DeleteList(string TI_Nolist )
		{
			return dal.DeleteList(TI_Nolist );
		}

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public Talent.Model.TB_RC_TalentInfor GetModel(int TI_No)
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
		public List<Talent.Model.TB_RC_TalentInfor> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<Talent.Model.TB_RC_TalentInfor> DataTableToList(DataTable dt)
		{
			List<Talent.Model.TB_RC_TalentInfor> modelList = new List<Talent.Model.TB_RC_TalentInfor>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				Talent.Model.TB_RC_TalentInfor model;
				for (int n = 0; n < rowsCount; n++)
				{
					model = new Talent.Model.TB_RC_TalentInfor();
					if(dt.Rows[n]["TI_No"]!=null && dt.Rows[n]["TI_No"].ToString()!="")
					{
						model.TI_No=int.Parse(dt.Rows[n]["TI_No"].ToString());
					}
					if(dt.Rows[n]["TI_CB_No"]!=null && dt.Rows[n]["TI_CB_No"].ToString()!="")
					{
						model.TI_CB_No=int.Parse(dt.Rows[n]["TI_CB_No"].ToString());
					}
					if(dt.Rows[n]["TI_BrandName"]!=null && dt.Rows[n]["TI_BrandName"].ToString()!="")
					{
					model.TI_BrandName=dt.Rows[n]["TI_BrandName"].ToString();
					}
					if(dt.Rows[n]["TI_TalentClass"]!=null && dt.Rows[n]["TI_TalentClass"].ToString()!="")
					{
					model.TI_TalentClass=dt.Rows[n]["TI_TalentClass"].ToString();
					}
					if(dt.Rows[n]["TI_Name"]!=null && dt.Rows[n]["TI_Name"].ToString()!="")
					{
					model.TI_Name=dt.Rows[n]["TI_Name"].ToString();
					}
					if(dt.Rows[n]["TI_Sex"]!=null && dt.Rows[n]["TI_Sex"].ToString()!="")
					{
					model.TI_Sex=dt.Rows[n]["TI_Sex"].ToString();
					}
					if(dt.Rows[n]["TI_Phone"]!=null && dt.Rows[n]["TI_Phone"].ToString()!="")
					{
					model.TI_Phone=dt.Rows[n]["TI_Phone"].ToString();
					}
					if(dt.Rows[n]["TI_Src"]!=null && dt.Rows[n]["TI_Src"].ToString()!="")
					{
					model.TI_Src=dt.Rows[n]["TI_Src"].ToString();
					}
					if(dt.Rows[n]["TI_RecommendPost"]!=null && dt.Rows[n]["TI_RecommendPost"].ToString()!="")
					{
					model.TI_RecommendPost=dt.Rows[n]["TI_RecommendPost"].ToString();
					}
					if(dt.Rows[n]["TI_Audition"]!=null && dt.Rows[n]["TI_Audition"].ToString()!="")
					{
					model.TI_Audition=dt.Rows[n]["TI_Audition"].ToString();
					}
					if(dt.Rows[n]["TI_AuditionResult"]!=null && dt.Rows[n]["TI_AuditionResult"].ToString()!="")
					{
					model.TI_AuditionResult=dt.Rows[n]["TI_AuditionResult"].ToString();
					}
					if(dt.Rows[n]["TI_FollowUpPeople"]!=null && dt.Rows[n]["TI_FollowUpPeople"].ToString()!="")
					{
					model.TI_FollowUpPeople=dt.Rows[n]["TI_FollowUpPeople"].ToString();
					}
					if(dt.Rows[n]["TI_MaintainDate"]!=null && dt.Rows[n]["TI_MaintainDate"].ToString()!="")
					{
						model.TI_MaintainDate=DateTime.Parse(dt.Rows[n]["TI_MaintainDate"].ToString());
					}
					if(dt.Rows[n]["TI_MaintainResult"]!=null && dt.Rows[n]["TI_MaintainResult"].ToString()!="")
					{
					model.TI_MaintainResult=dt.Rows[n]["TI_MaintainResult"].ToString();
					}
					if(dt.Rows[n]["TI_CreatePer"]!=null && dt.Rows[n]["TI_CreatePer"].ToString()!="")
					{
					model.TI_CreatePer=dt.Rows[n]["TI_CreatePer"].ToString();
					}
					if(dt.Rows[n]["TI_CreateDate"]!=null && dt.Rows[n]["TI_CreateDate"].ToString()!="")
					{
						model.TI_CreateDate=DateTime.Parse(dt.Rows[n]["TI_CreateDate"].ToString());
					}
                    if (dt.Rows[n]["TI_Mark"] != null && dt.Rows[n]["TI_Mark"].ToString() != "")
					{
                        model.TI_Mark = dt.Rows[n]["TI_Mark"].ToString();
					}
                    if (dt.Rows[n]["TI_Work"] != null && dt.Rows[n]["TI_Work"].ToString() != "")
                    {
                        model.TI_Work = dt.Rows[n]["TI_Work"].ToString();
                    }
                    if (dt.Rows[n]["TI_Industry"] != null && dt.Rows[n]["TI_Industry"].ToString() != "")
                    {
                        model.TI_Industry = dt.Rows[n]["TI_Industry"].ToString();
                    }
                    if (dt.Rows[n]["TI_Recommend"] != null && dt.Rows[n]["TI_Recommend"].ToString() != "")
                    {
                        model.TI_Recommend = dt.Rows[n]["TI_Recommend"].ToString();
                    }
                    if (dt.Rows[n]["TI_RecommendDate"] != null && dt.Rows[n]["TI_RecommendDate"].ToString() != "")
                    {
                        model.TI_RecommendDate = DateTime.Parse(dt.Rows[n]["TI_RecommendDate"].ToString());
                    }
					modelList.Add(model);
				}
			}
			return modelList;
		}


        public List<Talent.Model.TB_RC_TalentInfor> GetModelListMerge(int PageSize, int PageIndex, string strWhere, int pager)
        {
            DataSet ds = dal.GetListMerge(PageSize, PageIndex, strWhere, pager);
            return DataTableToList2(ds.Tables[0]);
        }

        public List<Talent.Model.TB_RC_TalentInfor> GetModelListMerge(string strWhere)
        {
            DataSet ds = dal.GetListMerge(strWhere);
            return DataTableToList2(ds.Tables[0]);
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
        public List<Talent.Model.TB_RC_TalentInfor> DataTableToList2(DataTable dt)
        {
            List<Talent.Model.TB_RC_TalentInfor> modelList = new List<Talent.Model.TB_RC_TalentInfor>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TB_RC_TalentInfor model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TB_RC_TalentInfor();
                    if (dt.Rows[n]["TI_No"] != null && dt.Rows[n]["TI_No"].ToString() != "")
                    {
                        model.TI_No = int.Parse(dt.Rows[n]["TI_No"].ToString());
                    }
                    if (dt.Rows[n]["TI_CB_No"] != null && dt.Rows[n]["TI_CB_No"].ToString() != "")
                    {
                        model.TI_CB_No = int.Parse(dt.Rows[n]["TI_CB_No"].ToString());
                    }
                    if (dt.Rows[n]["TI_BrandName"] != null && dt.Rows[n]["TI_BrandName"].ToString() != "")
                    {
                        model.TI_BrandName = dt.Rows[n]["TI_BrandName"].ToString();
                    }
                    if (dt.Rows[n]["TI_TalentClass"] != null && dt.Rows[n]["TI_TalentClass"].ToString() != "")
                    {
                        model.TI_TalentClass = dt.Rows[n]["TI_TalentClass"].ToString();
                    }
                    if (dt.Rows[n]["TI_Name"] != null && dt.Rows[n]["TI_Name"].ToString() != "")
                    {
                        model.TI_Name = dt.Rows[n]["TI_Name"].ToString();
                    }
                    if (dt.Rows[n]["TI_Sex"] != null && dt.Rows[n]["TI_Sex"].ToString() != "")
                    {
                        model.TI_Sex = dt.Rows[n]["TI_Sex"].ToString();
                    }
                    if (dt.Rows[n]["TI_Phone"] != null && dt.Rows[n]["TI_Phone"].ToString() != "")
                    {
                        model.TI_Phone = dt.Rows[n]["TI_Phone"].ToString();
                    }
                    if (dt.Rows[n]["TI_Src"] != null && dt.Rows[n]["TI_Src"].ToString() != "")
                    {
                        model.TI_Src = dt.Rows[n]["TI_Src"].ToString();
                    }
                    if (dt.Rows[n]["TI_RecommendPost"] != null && dt.Rows[n]["TI_RecommendPost"].ToString() != "")
                    {
                        model.TI_RecommendPost = dt.Rows[n]["TI_RecommendPost"].ToString();
                    }
                    if (dt.Rows[n]["TI_Audition"] != null && dt.Rows[n]["TI_Audition"].ToString() != "")
                    {
                        model.TI_Audition = dt.Rows[n]["TI_Audition"].ToString();
                    }
                    if (dt.Rows[n]["TI_AuditionResult"] != null && dt.Rows[n]["TI_AuditionResult"].ToString() != "")
                    {
                        model.TI_AuditionResult = dt.Rows[n]["TI_AuditionResult"].ToString();
                    }
                    if (dt.Rows[n]["TI_FollowUpPeople"] != null && dt.Rows[n]["TI_FollowUpPeople"].ToString() != "")
                    {
                        model.TI_FollowUpPeople = dt.Rows[n]["TI_FollowUpPeople"].ToString();
                    }
                    if (dt.Rows[n]["TI_MaintainDate"] != null && dt.Rows[n]["TI_MaintainDate"].ToString() != "")
                    {
                        model.TI_MaintainDate = DateTime.Parse(dt.Rows[n]["TI_MaintainDate"].ToString());
                    }
                    if (dt.Rows[n]["TI_MaintainResult"] != null && dt.Rows[n]["TI_MaintainResult"].ToString() != "")
                    {
                        model.TI_MaintainResult = dt.Rows[n]["TI_MaintainResult"].ToString();
                    }
                    if (dt.Rows[n]["TI_CreatePer"] != null && dt.Rows[n]["TI_CreatePer"].ToString() != "")
                    {
                        model.TI_CreatePer = dt.Rows[n]["TI_CreatePer"].ToString();
                    }
                    if (dt.Rows[n]["TI_CreateDate"] != null && dt.Rows[n]["TI_CreateDate"].ToString() != "")
                    {
                        model.TI_CreateDate = DateTime.Parse(dt.Rows[n]["TI_CreateDate"].ToString());
                    }
                    if (dt.Rows[n]["CB_Name"] != null && dt.Rows[n]["CB_Name"].ToString() != "")
                    {
                        model.CB_Name = dt.Rows[n]["CB_Name"].ToString();
                    }
                    if (dt.Rows[n]["CB_Position"] != null && dt.Rows[n]["CB_Position"].ToString() != "")
                    {
                        model.CB_Position = dt.Rows[n]["CB_Position"].ToString();
                    }
                    if (dt.Rows[n]["TI_Mark"] != null && dt.Rows[n]["TI_Mark"].ToString() != "")
                    {
                        model.TI_Mark = dt.Rows[n]["TI_Mark"].ToString();
                    }
                    if (dt.Rows[n]["TI_Work"] != null && dt.Rows[n]["TI_Work"].ToString() != "")
                    {
                        model.TI_Work = dt.Rows[n]["TI_Work"].ToString();
                    }
                    if (dt.Rows[n]["TI_Industry"] != null && dt.Rows[n]["TI_Industry"].ToString() != "")
                    {
                        model.TI_Industry = dt.Rows[n]["TI_Industry"].ToString();
                    }
                    if (dt.Rows[n]["TI_Recommend"] != null && dt.Rows[n]["TI_Recommend"].ToString() != "")
                    {
                        model.TI_Recommend = dt.Rows[n]["TI_Recommend"].ToString();
                    }
                    if (dt.Rows[n]["TI_RecommendDate"] != null && dt.Rows[n]["TI_RecommendDate"].ToString() != "")
                    {
                        model.TI_RecommendDate = DateTime.Parse(dt.Rows[n]["TI_RecommendDate"].ToString());
                    }
                    modelList.Add(model);
                }
            }
            return modelList;
        }



        public List<Talent.Model.TB_RC_TalentInfor> GetModelList(int PageSize, int PageIndex, string strWhere, int pager)
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

		#endregion  Method
	}
}

