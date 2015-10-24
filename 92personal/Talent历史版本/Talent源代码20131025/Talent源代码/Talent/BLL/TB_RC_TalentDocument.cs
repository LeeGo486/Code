using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using Talent.Model;
namespace Talent.BLL
{
	/// <summary>
	/// TB_RC_TalentDocument
	/// </summary>
	public partial class TB_RC_TalentDocument
	{
		private readonly Talent.DAL.TB_RC_TalentDocument dal=new Talent.DAL.TB_RC_TalentDocument();
		public TB_RC_TalentDocument()
		{}
		#region  Method

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int  Add(Talent.Model.TB_RC_TalentDocument model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(Talent.Model.TB_RC_TalentDocument model)
		{
			return dal.Update(model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int TD_No)
		{
			
			return dal.Delete(TD_No);
		}

        public bool DeleteByCB_NO(int CB_NO)
        {
            return dal.DeleteByCB_NO(CB_NO);
        }
		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool DeleteList(string TD_Nolist )
		{
			return dal.DeleteList(TD_Nolist );
		}

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public Talent.Model.TB_RC_TalentDocument GetModel(int TD_No)
		{
			
			return dal.GetModel(TD_No);
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
		public List<Talent.Model.TB_RC_TalentDocument> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<Talent.Model.TB_RC_TalentDocument> DataTableToList(DataTable dt)
		{
			List<Talent.Model.TB_RC_TalentDocument> modelList = new List<Talent.Model.TB_RC_TalentDocument>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				Talent.Model.TB_RC_TalentDocument model;
				for (int n = 0; n < rowsCount; n++)
				{
					model = new Talent.Model.TB_RC_TalentDocument();
					if(dt.Rows[n]["TD_No"]!=null && dt.Rows[n]["TD_No"].ToString()!="")
					{
						model.TD_No=int.Parse(dt.Rows[n]["TD_No"].ToString());
					}
					if(dt.Rows[n]["TD_CB_No"]!=null && dt.Rows[n]["TD_CB_No"].ToString()!="")
					{
						model.TD_CB_No=int.Parse(dt.Rows[n]["TD_CB_No"].ToString());
					}
					if(dt.Rows[n]["TD_TI_No"]!=null && dt.Rows[n]["TD_TI_No"].ToString()!="")
					{
						model.TD_TI_No=int.Parse(dt.Rows[n]["TD_TI_No"].ToString());
					}
					if(dt.Rows[n]["TD_DocName"]!=null && dt.Rows[n]["TD_DocName"].ToString()!="")
					{
					model.TD_DocName=dt.Rows[n]["TD_DocName"].ToString();
					}
					if(dt.Rows[n]["TD_docPath"]!=null && dt.Rows[n]["TD_docPath"].ToString()!="")
					{
					model.TD_docPath=dt.Rows[n]["TD_docPath"].ToString();
					}
					if(dt.Rows[n]["TD_CreatePer"]!=null && dt.Rows[n]["TD_CreatePer"].ToString()!="")
					{
					model.TD_CreatePer=dt.Rows[n]["TD_CreatePer"].ToString();
					}
					if(dt.Rows[n]["TD_CreateDate"]!=null && dt.Rows[n]["TD_CreateDate"].ToString()!="")
					{
						model.TD_CreateDate=DateTime.Parse(dt.Rows[n]["TD_CreateDate"].ToString());
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

