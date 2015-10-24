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
	/// Userinfo
	/// </summary>
	public partial class Userinfo
	{
		private readonly IUserinfo dal=DataAccess.CreateUserinfo();
		public Userinfo()
		{}
		#region  Method

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
			return dal.GetMaxId();
		}

        public bool Login(string loginname, string password)
        {
            return dal.Login(loginname, password);
        }

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(EPReper.Model.Userinfo model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(EPReper.Model.Userinfo model)
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
		public EPReper.Model.Userinfo GetModel(int id)
		{
			
			return dal.GetModel(id);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public EPReper.Model.Userinfo GetModelByCache(int id)
		{
			
			string CacheKey = "UserinfoModel-" + id;
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
			return (EPReper.Model.Userinfo)objModel;
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

        public DataTable GetInfo(string strWhere)
        {
            return dal.GetInfo(strWhere);
        }
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<EPReper.Model.Userinfo> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<EPReper.Model.Userinfo> DataTableToList(DataTable dt)
		{
			List<EPReper.Model.Userinfo> modelList = new List<EPReper.Model.Userinfo>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				EPReper.Model.Userinfo model;
				for (int n = 0; n < rowsCount; n++)
				{
					model = new EPReper.Model.Userinfo();
					if(dt.Rows[n]["id"]!=null && dt.Rows[n]["id"].ToString()!="")
					{
						model.id=int.Parse(dt.Rows[n]["id"].ToString());
					}
					if(dt.Rows[n]["username"]!=null && dt.Rows[n]["username"].ToString()!="")
					{
					model.username=dt.Rows[n]["username"].ToString();
					}
					if(dt.Rows[n]["department"]!=null && dt.Rows[n]["department"].ToString()!="")
					{
					model.department=dt.Rows[n]["department"].ToString();
					}
					if(dt.Rows[n]["phone"]!=null && dt.Rows[n]["phone"].ToString()!="")
					{
					model.phone=dt.Rows[n]["phone"].ToString();
					}
					if(dt.Rows[n]["AMNum"]!=null && dt.Rows[n]["AMNum"].ToString()!="")
					{
					model.AMNum=dt.Rows[n]["AMNum"].ToString();
					}
					if(dt.Rows[n]["QQ"]!=null && dt.Rows[n]["QQ"].ToString()!="")
					{
					model.QQ=dt.Rows[n]["QQ"].ToString();
					}
					if(dt.Rows[n]["Email"]!=null && dt.Rows[n]["Email"].ToString()!="")
					{
					model.Email=dt.Rows[n]["Email"].ToString();
					}
					if(dt.Rows[n]["URole"]!=null && dt.Rows[n]["URole"].ToString()!="")
					{
						model.URole=int.Parse(dt.Rows[n]["URole"].ToString());
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

        public DataTable GetTable(string strWhere,string filedOrder)
        {
            return dal.GetTable(strWhere,filedOrder);
        }
        /// <summary>
        /// 向小翅膀添加信息
        /// </summary>
        /// <param name="username"></param>
        /// <param name="subject"></param>
        /// <param name="content"></param>
        /// <returns></returns>
        public bool AddAmDetail(string username, string subject, string content)
        {
            return dal.AddAmDetail(username, subject, content);
        }
        public bool SendMSG(string MessageContent, string DestinationAddress)
        {
            return dal.SendMSG(MessageContent, DestinationAddress);
        }
		#endregion  Method

    }
}

