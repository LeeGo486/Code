using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using EPReper.Model;
using EPReper.DALFactory;
using EPReper.IDAL;
namespace EPReper.BLL
{
	/// <summary>
	/// RepairInfo
	/// </summary>
	public partial class RepairInfo
	{
		private readonly IRepairInfo dal=DataAccess.CreateRepairInfo();
		public RepairInfo()
		{}
		#region  Method

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
			return dal.GetMaxId();
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int  Add(EPReper.Model.RepairInfo model)
		{
			return dal.Add(model);
		}


        public bool UpdateDal(string id,string userid,string repairphone)
        {
            return dal.UpdateDal(id,userid,repairphone);
        }
        public bool UpdateEnd(string id, string endComment)
        {
            return dal.UpdateEnd(id,endComment);
        }
        public bool UpCode(string bigid, string code)
        {
            return dal.UpCode(bigid, code);
        }
		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(EPReper.Model.RepairInfo model)
		{
			return dal.Update(model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int id)
		{
			
			return dal.Delete(id);
		}
		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool DeleteList(string idlist )
		{
			return dal.DeleteList(idlist );
		}

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public EPReper.Model.RepairInfo GetModel(int id)
		{
			
			return dal.GetModel(id);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public EPReper.Model.RepairInfo GetModelByCache(int id)
		{
			
			string CacheKey = "RepairInfoModel-" + id;
			object objModel = Maticsoft.Common.DataCache.GetCache(CacheKey);
			if (objModel == null)
			{
				try
				{
					objModel = dal.GetModel(id);
					if (objModel != null)
					{
						int ModelCache = Maticsoft.Common.ConfigHelper.GetConfigInt("ModelCache");
						Maticsoft.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
					}
				}
				catch{}
			}
			return (EPReper.Model.RepairInfo)objModel;
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public DataSet GetList(string strWhere)
		{
			return dal.GetList(strWhere);
		}
		/// <summary>
		/// 获得前几行数据
		/// </summary>
		public DataSet GetList(int Top,string strWhere,string filedOrder)
		{
			return dal.GetList(Top,strWhere,filedOrder);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<EPReper.Model.RepairInfo> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<EPReper.Model.RepairInfo> DataTableToList(DataTable dt)
		{
			List<EPReper.Model.RepairInfo> modelList = new List<EPReper.Model.RepairInfo>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				EPReper.Model.RepairInfo model;
				for (int n = 0; n < rowsCount; n++)
				{
					model = new EPReper.Model.RepairInfo();
					if(dt.Rows[n]["id"]!=null && dt.Rows[n]["id"].ToString()!="")
					{
						model.id=int.Parse(dt.Rows[n]["id"].ToString());
					}
                    if (dt.Rows[n]["BaseCode"] != null && dt.Rows[n]["BaseCode"].ToString() != "")
                    {
                        model.BaseCode = dt.Rows[n]["BaseCode"].ToString();
                    }
                    if (dt.Rows[n]["BigID"] != null && dt.Rows[n]["BigID"].ToString() != "")
                    {
                        model.BigID = int.Parse(dt.Rows[n]["BigID"].ToString());
                    }
					if(dt.Rows[n]["ClassID"]!=null && dt.Rows[n]["ClassID"].ToString()!="")
					{
						model.ClassID=int.Parse(dt.Rows[n]["ClassID"].ToString());
					}
					if(dt.Rows[n]["userID"]!=null && dt.Rows[n]["userID"].ToString()!="")
					{
						model.userID=int.Parse(dt.Rows[n]["userID"].ToString());
					}
					if(dt.Rows[n]["point"]!=null && dt.Rows[n]["point"].ToString()!="")
					{
						model.point=int.Parse(dt.Rows[n]["point"].ToString());
					}
					if(dt.Rows[n]["UpTime"]!=null && dt.Rows[n]["UpTime"].ToString()!="")
					{
						model.UpTime=DateTime.Parse(dt.Rows[n]["UpTime"].ToString());
					}
					if(dt.Rows[n]["DoTime"]!=null && dt.Rows[n]["DoTime"].ToString()!="")
					{
						model.DoTime=DateTime.Parse(dt.Rows[n]["DoTime"].ToString());
					}
					if(dt.Rows[n]["OverTime"]!=null && dt.Rows[n]["OverTime"].ToString()!="")
					{
						model.OverTime=DateTime.Parse(dt.Rows[n]["OverTime"].ToString());
					}
					if(dt.Rows[n]["Times"]!=null && dt.Rows[n]["Times"].ToString()!="")
					{
					model.Times=dt.Rows[n]["Times"].ToString();
					}
					if(dt.Rows[n]["StartComment"]!=null && dt.Rows[n]["StartComment"].ToString()!="")
					{
					model.StartComment=dt.Rows[n]["StartComment"].ToString();
					}
					if(dt.Rows[n]["OverComment"]!=null && dt.Rows[n]["OverComment"].ToString()!="")
					{
					model.OverComment=dt.Rows[n]["OverComment"].ToString();
					}
					if(dt.Rows[n]["Finish"]!=null && dt.Rows[n]["Finish"].ToString()!="")
					{
						model.Finish=int.Parse(dt.Rows[n]["Finish"].ToString());
					}
					if(dt.Rows[n]["isDel"]!=null && dt.Rows[n]["isDel"].ToString()!="")
					{
						model.isDel=int.Parse(dt.Rows[n]["isDel"].ToString());
					}
					modelList.Add(model);
				}
			}
			return modelList;
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public DataSet GetAllList()
		{
			return GetList("");
		}

		/// <summary>
		/// 分页获取数据列表
		/// </summary>
		//public DataSet GetList(int PageSize,int PageIndex,string strWhere)
		//{
			//return dal.GetList(PageSize,PageIndex,strWhere);
		//}

        public DataTable GetPage(string sqlWhere, int PageIndex, int PageSize, out int RecordCount, out int PageCount)
        {
            return dal.GetPage(sqlWhere, PageIndex, PageSize, out RecordCount, out PageCount);
        }


        ///得到大类数量
        public int counts(int bigid)
        {
            return dal.counts(bigid);
        }
        
		#endregion  Method
	}
}

