using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using Talent.Model;
namespace Talent.BLL
{
	/// <summary>
	/// TB_RC_UpkeepDate
	/// </summary>
	public partial class TB_RC_UpkeepDate
	{
		private readonly Talent.DAL.TB_RC_UpkeepDate dal=new Talent.DAL.TB_RC_UpkeepDate();
		public TB_RC_UpkeepDate()
		{}
		#region  Method

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int  Add(Talent.Model.TB_RC_UpkeepDate model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(Talent.Model.TB_RC_UpkeepDate model)
		{
			return dal.Update(model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int UD_No)
		{
			
			return dal.Delete(UD_No);
		}
		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool DeleteList(string UD_Nolist )
		{
			return dal.DeleteList(UD_Nolist );
		}

        public bool DeleteByWhere(string strWhere)
        {
            return dal.DeleteByWhere(strWhere);
        }

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public Talent.Model.TB_RC_UpkeepDate GetModel(int UD_No)
		{
			
			return dal.GetModel(UD_No);
		}

		
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<Talent.Model.TB_RC_UpkeepDate> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<Talent.Model.TB_RC_UpkeepDate> DataTableToList(DataTable dt)
		{
			List<Talent.Model.TB_RC_UpkeepDate> modelList = new List<Talent.Model.TB_RC_UpkeepDate>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				Talent.Model.TB_RC_UpkeepDate model;
				for (int n = 0; n < rowsCount; n++)
				{
					model = new Talent.Model.TB_RC_UpkeepDate();
					if(dt.Rows[n]["UD_No"]!=null && dt.Rows[n]["UD_No"].ToString()!="")
					{
						model.UD_No=int.Parse(dt.Rows[n]["UD_No"].ToString());
					}
					if(dt.Rows[n]["UD_CB_No"]!=null && dt.Rows[n]["UD_CB_No"].ToString()!="")
					{
						model.UD_CB_No=int.Parse(dt.Rows[n]["UD_CB_No"].ToString());
					}
					if(dt.Rows[n]["UD_TI_No"]!=null && dt.Rows[n]["UD_TI_No"].ToString()!="")
					{
						model.UD_TI_No=int.Parse(dt.Rows[n]["UD_TI_No"].ToString());
					}
					if(dt.Rows[n]["UD_Date"]!=null && dt.Rows[n]["UD_Date"].ToString()!="")
					{
						model.UD_Date=DateTime.Parse(dt.Rows[n]["UD_Date"].ToString());
					}
					if(dt.Rows[n]["UD_Result"]!=null && dt.Rows[n]["UD_Result"].ToString()!="")
					{
					model.UD_Result=dt.Rows[n]["UD_Result"].ToString();
					}
					if(dt.Rows[n]["UD_CreatePer"]!=null && dt.Rows[n]["UD_CreatePer"].ToString()!="")
					{
					model.UD_CreatePer=dt.Rows[n]["UD_CreatePer"].ToString();
					}
					if(dt.Rows[n]["UD_CreateDate"]!=null && dt.Rows[n]["UD_CreateDate"].ToString()!="")
					{
						model.UD_CreateDate=DateTime.Parse(dt.Rows[n]["UD_CreateDate"].ToString());
					}
					modelList.Add(model);
				}
			}
			return modelList;
		}

        public int GetTotal(int CB_NO, int TI_NO)
        {
            Object obj = dal.GetTotal(CB_NO, TI_NO);
            if (obj == null) return 0;
            return Convert.ToInt32(obj);
        }

		#endregion  Method
	}
}

