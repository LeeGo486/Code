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
	/// Class
	/// </summary>
	public partial class ReperClass
	{
		private readonly IReperClass dal=DataAccess.CreateReperClass();
		public ReperClass()
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
		public int  Add(EPReper.Model.ReperClass model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(EPReper.Model.ReperClass model)
		{
			return dal.Update(model);
		}
        public bool Update(int id)
        {
            return dal.Update(id);
        }
        public bool UpdateDel(int id)
        {
            return dal.UpdateDel(id);
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
		public EPReper.Model.ReperClass GetModel(int id)
		{
			
			return dal.GetModel(id);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public EPReper.Model.ReperClass GetModelByCache(int id)
		{
			
			string CacheKey = "ClassModel-" + id;
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
			return (EPReper.Model.ReperClass)objModel;
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
		public List<EPReper.Model.ReperClass> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<EPReper.Model.ReperClass> DataTableToList(DataTable dt)
		{
			List<EPReper.Model.ReperClass> modelList = new List<EPReper.Model.ReperClass>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				EPReper.Model.ReperClass model;
				for (int n = 0; n < rowsCount; n++)
				{
					model = new EPReper.Model.ReperClass();
					if(dt.Rows[n]["id"]!=null && dt.Rows[n]["id"].ToString()!="")
					{
						model.id=int.Parse(dt.Rows[n]["id"].ToString());
					}
					if(dt.Rows[n]["classname"]!=null && dt.Rows[n]["classname"].ToString()!="")
					{
					model.classname=dt.Rows[n]["classname"].ToString();
					}
					if(dt.Rows[n]["parentID"]!=null && dt.Rows[n]["parentID"].ToString()!="")
					{
						model.parentID=int.Parse(dt.Rows[n]["parentID"].ToString());
					}
					if(dt.Rows[n]["SubNum"]!=null && dt.Rows[n]["SubNum"].ToString()!="")
					{
						model.SubNum=int.Parse(dt.Rows[n]["SubNum"].ToString());
					}
					if(dt.Rows[n]["orderNum"]!=null && dt.Rows[n]["orderNum"].ToString()!="")
					{
						model.orderNum=int.Parse(dt.Rows[n]["orderNum"].ToString());
					}
					if(dt.Rows[n]["PoPlist"]!=null && dt.Rows[n]["PoPlist"].ToString()!="")
					{
					model.PoPlist=dt.Rows[n]["PoPlist"].ToString();
					}
					if(dt.Rows[n]["men"]!=null && dt.Rows[n]["men"].ToString()!="")
					{
					model.men=dt.Rows[n]["men"].ToString();
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

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataTable GetTable(int Top, string strWhere, string filedOrder)
        {
            return dal.GetTable(Top, strWhere, filedOrder);
        }

        public DataTable GetPage(string sqlWhere, int PageIndex, int PageSize, out int RecordCount, out int PageCount)
        {
            return dal.GetPage(sqlWhere, PageIndex, PageSize, out RecordCount, out PageCount);
        }
		#endregion  Method

        public DataSet GetLists(string id)
        {
            return dal.GetLists(id);
        }
    }
}

