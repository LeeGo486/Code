using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using Talent.Model;
namespace Talent.BLL
{
	/// <summary>
	/// TB_RC_Permission
	/// </summary>
	public partial class TB_RC_Permission
	{
        private readonly Talent.DAL.TB_RC_Permission dal = new Talent.DAL.TB_RC_Permission();
		public TB_RC_Permission()
		{}
		#region  Method

        public bool isAdmin(string name)
        {
            return dal.isAdmin(name);
        }

		/// <summary>
		/// 增加一条数据
		/// </summary>
        public int Add(Talent.Model.TB_RC_Permission model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
        public bool Update(Talent.Model.TB_RC_Permission model)
		{
			return dal.Update(model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int PM_No)
		{
			
			return dal.Delete(PM_No);
		}
		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool DeleteList(string PM_Nolist )
		{
			return dal.DeleteList(PM_Nolist );
		}

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
        public Talent.Model.TB_RC_Permission GetModel(int PM_No)
		{
			
			return dal.GetModel(PM_No);
		}

        public Talent.Model.TB_RC_Permission GetModel(string PM_Login)
        {

            return dal.GetModel(PM_Login);
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
        public List<Talent.Model.TB_RC_Permission> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
        public List<Talent.Model.TB_RC_Permission> DataTableToList(DataTable dt)
		{
            List<Talent.Model.TB_RC_Permission> modelList = new List<Talent.Model.TB_RC_Permission>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
                Talent.Model.TB_RC_Permission model;
				for (int n = 0; n < rowsCount; n++)
				{
                    model = new Talent.Model.TB_RC_Permission();
					if(dt.Rows[n]["PM_No"]!=null && dt.Rows[n]["PM_No"].ToString()!="")
					{
						model.PM_No=int.Parse(dt.Rows[n]["PM_No"].ToString());
					}
					if(dt.Rows[n]["PM_Login"]!=null && dt.Rows[n]["PM_Login"].ToString()!="")
					{
					model.PM_Login=dt.Rows[n]["PM_Login"].ToString();
					}
					if(dt.Rows[n]["PM_Level"]!=null && dt.Rows[n]["PM_Level"].ToString()!="")
					{
						model.PM_Level=int.Parse(dt.Rows[n]["PM_Level"].ToString());
					}
					if(dt.Rows[n]["PM_Province"]!=null && dt.Rows[n]["PM_Province"].ToString()!="")
					{
					model.PM_Province=dt.Rows[n]["PM_Province"].ToString();
					}
					modelList.Add(model);
				}
			}
			return modelList;
		}


        public List<Talent.Model.TB_RC_Permission> GetModelList(int PageSize, int PageIndex, string strWhere, int pager)
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

