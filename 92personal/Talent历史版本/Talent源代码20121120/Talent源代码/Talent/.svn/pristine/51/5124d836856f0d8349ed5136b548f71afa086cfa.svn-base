using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using Talent.Model;
namespace Talent.BLL
{
	/// <summary>
	/// TB_RC_CompanyBasic
	/// </summary>
	public partial class TB_RC_CompanyBasic
	{
		private readonly Talent.DAL.TB_RC_CompanyBasic dal=new Talent.DAL.TB_RC_CompanyBasic();
		public TB_RC_CompanyBasic()
		{}
		#region  Method

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int  Add(Talent.Model.TB_RC_CompanyBasic model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(Talent.Model.TB_RC_CompanyBasic model)
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
		public Talent.Model.TB_RC_CompanyBasic GetModel(int CB_No)
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
		public List<Talent.Model.TB_RC_CompanyBasic> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<Talent.Model.TB_RC_CompanyBasic> DataTableToList(DataTable dt)
		{
			List<Talent.Model.TB_RC_CompanyBasic> modelList = new List<Talent.Model.TB_RC_CompanyBasic>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				Talent.Model.TB_RC_CompanyBasic model;
				for (int n = 0; n < rowsCount; n++)
				{
					model = new Talent.Model.TB_RC_CompanyBasic();
					if(dt.Rows[n]["CB_No"]!=null && dt.Rows[n]["CB_No"].ToString()!="")
					{
						model.CB_No=int.Parse(dt.Rows[n]["CB_No"].ToString());
					}
					if(dt.Rows[n]["CB_Des"]!=null && dt.Rows[n]["CB_Des"].ToString()!="")
					{
					model.CB_Des=dt.Rows[n]["CB_Des"].ToString();
					}
					if(dt.Rows[n]["CB_Name"]!=null && dt.Rows[n]["CB_Name"].ToString()!="")
					{
					model.CB_Name=dt.Rows[n]["CB_Name"].ToString();
					}
					if(dt.Rows[n]["CB_Position"]!=null && dt.Rows[n]["CB_Position"].ToString()!="")
					{
					model.CB_Position=dt.Rows[n]["CB_Position"].ToString();
					}
					if(dt.Rows[n]["CB_Num"]!=null && dt.Rows[n]["CB_Num"].ToString()!="")
					{
						model.CB_Num=int.Parse(dt.Rows[n]["CB_Num"].ToString());
					}
					if(dt.Rows[n]["CB_SetUp"]!=null && dt.Rows[n]["CB_SetUp"].ToString()!="")
					{
						model.CB_SetUp=DateTime.Parse(dt.Rows[n]["CB_SetUp"].ToString()).ToString("yyyy-MM-dd");
					}
					if(dt.Rows[n]["CB_Je"]!=null && dt.Rows[n]["CB_Je"].ToString()!="")
					{
					model.CB_Je=dt.Rows[n]["CB_Je"].ToString();
					}
					if(dt.Rows[n]["CB_Scale"]!=null && dt.Rows[n]["CB_Scale"].ToString()!="")
					{
					model.CB_Scale=dt.Rows[n]["CB_Scale"].ToString();
					}
					if(dt.Rows[n]["CB_BrandName"]!=null && dt.Rows[n]["CB_BrandName"].ToString()!="")
					{
					model.CB_BrandName=dt.Rows[n]["CB_BrandName"].ToString();
					}
					if(dt.Rows[n]["CB_PriceSection"]!=null && dt.Rows[n]["CB_PriceSection"].ToString()!="")
					{
					model.CB_PriceSection=dt.Rows[n]["CB_PriceSection"].ToString();
					}
					if(dt.Rows[n]["CB_Category"]!=null && dt.Rows[n]["CB_Category"].ToString()!="")
					{
					model.CB_Category=dt.Rows[n]["CB_Category"].ToString();
					}
					if(dt.Rows[n]["CB_ModeOperation"]!=null && dt.Rows[n]["CB_ModeOperation"].ToString()!="")
					{
					model.CB_ModeOperation=dt.Rows[n]["CB_ModeOperation"].ToString();
					}
					if(dt.Rows[n]["CB_ShopNum"]!=null && dt.Rows[n]["CB_ShopNum"].ToString()!="")
					{
						model.CB_ShopNum=int.Parse(dt.Rows[n]["CB_ShopNum"].ToString());
					}
					if(dt.Rows[n]["CB_Founder"]!=null && dt.Rows[n]["CB_Founder"].ToString()!="")
					{
					model.CB_Founder=dt.Rows[n]["CB_Founder"].ToString();
					}
					if(dt.Rows[n]["CB_Advantage"]!=null && dt.Rows[n]["CB_Advantage"].ToString()!="")
					{
					model.CB_Advantage=dt.Rows[n]["CB_Advantage"].ToString();
					}
					if(dt.Rows[n]["CB_OrgStructure"]!=null && dt.Rows[n]["CB_OrgStructure"].ToString()!="")
					{
					model.CB_OrgStructure=dt.Rows[n]["CB_OrgStructure"].ToString();
					}
					if(dt.Rows[n]["CB_KeyPerson"]!=null && dt.Rows[n]["CB_KeyPerson"].ToString()!="")
					{
					model.CB_KeyPerson=dt.Rows[n]["CB_KeyPerson"].ToString();
					}
					if(dt.Rows[n]["CB_HumanSrc"]!=null && dt.Rows[n]["CB_HumanSrc"].ToString()!="")
					{
					model.CB_HumanSrc=dt.Rows[n]["CB_HumanSrc"].ToString();
					}
					if(dt.Rows[n]["CB_CreatePer"]!=null && dt.Rows[n]["CB_CreatePer"].ToString()!="")
					{
					model.CB_CreatePer=dt.Rows[n]["CB_CreatePer"].ToString();
					}
					if(dt.Rows[n]["CB_CreateDate"]!=null && dt.Rows[n]["CB_CreateDate"].ToString()!="")
					{
						model.CB_CreateDate=DateTime.Parse(dt.Rows[n]["CB_CreateDate"].ToString());
					}
                    if (dt.Rows[n]["CB_Province"] != null && dt.Rows[n]["CB_Province"].ToString() != "")
					{
                        model.CB_Province = dt.Rows[n]["CB_Province"].ToString();
					}
                    if (dt.Rows[n]["CB_X"] != null && dt.Rows[n]["CB_X"].ToString() != "")
                    {
                        model.CB_X = dt.Rows[n]["CB_X"].ToString();
                    }
                    if (dt.Rows[n]["CB_Y"] != null && dt.Rows[n]["CB_Y"].ToString() != "")
                    {
                        model.CB_Y = dt.Rows[n]["CB_Y"].ToString();
                    }
                    if (dt.Rows[n]["CB_Img"] != null && dt.Rows[n]["CB_Img"].ToString() != "")
                    {
                        model.CB_Img = dt.Rows[n]["CB_Img"].ToString();
                    }
                    if (dt.Rows[n]["CB_Css"] != null && dt.Rows[n]["CB_Css"].ToString() != "")
                    {
                        model.CB_Css = dt.Rows[n]["CB_Css"].ToString();
                    }
                    if (dt.Rows[n]["CB_BrandStyle"] != null && dt.Rows[n]["CB_BrandStyle"].ToString() != "")
                    {
                        model.CB_BrandStyle = dt.Rows[n]["CB_BrandStyle"].ToString();
                    }
					modelList.Add(model);
				}
			}
			return modelList;
		}


        public List<Talent.Model.TB_RC_CompanyBasic> GetModelListAndClass(string strWhere)
        {
            DataSet ds = dal.GetListAndClass(strWhere);
            return DataTableToList2(ds.Tables[0]);
        }

        /*增加颜色*/
        public List<Talent.Model.TB_RC_CompanyBasic> DataTableToList2(DataTable dt)
        {
            List<Talent.Model.TB_RC_CompanyBasic> modelList = new List<Talent.Model.TB_RC_CompanyBasic>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TB_RC_CompanyBasic model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TB_RC_CompanyBasic();
                    if (dt.Rows[n]["CB_No"] != null && dt.Rows[n]["CB_No"].ToString() != "")
                    {
                        model.CB_No = int.Parse(dt.Rows[n]["CB_No"].ToString());
                    }
                    if (dt.Rows[n]["CB_Des"] != null && dt.Rows[n]["CB_Des"].ToString() != "")
                    {
                        model.CB_Des = dt.Rows[n]["CB_Des"].ToString();
                    }
                    if (dt.Rows[n]["CB_Name"] != null && dt.Rows[n]["CB_Name"].ToString() != "")
                    {
                        model.CB_Name = dt.Rows[n]["CB_Name"].ToString();
                    }
                    if (dt.Rows[n]["CB_Position"] != null && dt.Rows[n]["CB_Position"].ToString() != "")
                    {
                        model.CB_Position = dt.Rows[n]["CB_Position"].ToString();
                    }
                    if (dt.Rows[n]["CB_Num"] != null && dt.Rows[n]["CB_Num"].ToString() != "")
                    {
                        model.CB_Num = int.Parse(dt.Rows[n]["CB_Num"].ToString());
                    }
                    if (dt.Rows[n]["CB_SetUp"] != null && dt.Rows[n]["CB_SetUp"].ToString() != "")
                    {
                        model.CB_SetUp = DateTime.Parse(dt.Rows[n]["CB_SetUp"].ToString()).ToString("yyyy-MM-dd");
                    }
                    if (dt.Rows[n]["CB_Je"] != null && dt.Rows[n]["CB_Je"].ToString() != "")
                    {
                        model.CB_Je = dt.Rows[n]["CB_Je"].ToString();
                    }
                    if (dt.Rows[n]["CB_Scale"] != null && dt.Rows[n]["CB_Scale"].ToString() != "")
                    {
                        model.CB_Scale = dt.Rows[n]["CB_Scale"].ToString();
                    }
                    if (dt.Rows[n]["CB_BrandName"] != null && dt.Rows[n]["CB_BrandName"].ToString() != "")
                    {
                        model.CB_BrandName = dt.Rows[n]["CB_BrandName"].ToString();
                    }
                    if (dt.Rows[n]["CB_PriceSection"] != null && dt.Rows[n]["CB_PriceSection"].ToString() != "")
                    {
                        model.CB_PriceSection = dt.Rows[n]["CB_PriceSection"].ToString();
                    }
                    if (dt.Rows[n]["CB_Category"] != null && dt.Rows[n]["CB_Category"].ToString() != "")
                    {
                        model.CB_Category = dt.Rows[n]["CB_Category"].ToString();
                    }
                    if (dt.Rows[n]["CB_ModeOperation"] != null && dt.Rows[n]["CB_ModeOperation"].ToString() != "")
                    {
                        model.CB_ModeOperation = dt.Rows[n]["CB_ModeOperation"].ToString();
                    }
                    if (dt.Rows[n]["CB_ShopNum"] != null && dt.Rows[n]["CB_ShopNum"].ToString() != "")
                    {
                        model.CB_ShopNum = int.Parse(dt.Rows[n]["CB_ShopNum"].ToString());
                    }
                    if (dt.Rows[n]["CB_Founder"] != null && dt.Rows[n]["CB_Founder"].ToString() != "")
                    {
                        model.CB_Founder = dt.Rows[n]["CB_Founder"].ToString();
                    }
                    if (dt.Rows[n]["CB_Advantage"] != null && dt.Rows[n]["CB_Advantage"].ToString() != "")
                    {
                        model.CB_Advantage = dt.Rows[n]["CB_Advantage"].ToString();
                    }
                    if (dt.Rows[n]["CB_OrgStructure"] != null && dt.Rows[n]["CB_OrgStructure"].ToString() != "")
                    {
                        model.CB_OrgStructure = dt.Rows[n]["CB_OrgStructure"].ToString();
                    }
                    if (dt.Rows[n]["CB_KeyPerson"] != null && dt.Rows[n]["CB_KeyPerson"].ToString() != "")
                    {
                        model.CB_KeyPerson = dt.Rows[n]["CB_KeyPerson"].ToString();
                    }
                    if (dt.Rows[n]["CB_HumanSrc"] != null && dt.Rows[n]["CB_HumanSrc"].ToString() != "")
                    {
                        model.CB_HumanSrc = dt.Rows[n]["CB_HumanSrc"].ToString();
                    }
                    if (dt.Rows[n]["CB_CreatePer"] != null && dt.Rows[n]["CB_CreatePer"].ToString() != "")
                    {
                        model.CB_CreatePer = dt.Rows[n]["CB_CreatePer"].ToString();
                    }
                    if (dt.Rows[n]["CB_CreateDate"] != null && dt.Rows[n]["CB_CreateDate"].ToString() != "")
                    {
                        model.CB_CreateDate = DateTime.Parse(dt.Rows[n]["CB_CreateDate"].ToString());
                    }
                    if (dt.Rows[n]["CB_Province"] != null && dt.Rows[n]["CB_Province"].ToString() != "")
                    {
                        model.CB_Province = dt.Rows[n]["CB_Province"].ToString();
                    }
                    if (dt.Rows[n]["CB_X"] != null && dt.Rows[n]["CB_X"].ToString() != "")
                    {
                        model.CB_X = dt.Rows[n]["CB_X"].ToString();
                    }
                    if (dt.Rows[n]["CB_Y"] != null && dt.Rows[n]["CB_Y"].ToString() != "")
                    {
                        model.CB_Y = dt.Rows[n]["CB_Y"].ToString();
                    }
                    if (dt.Rows[n]["CB_Img"] != null && dt.Rows[n]["CB_Img"].ToString() != "")
                    {
                        model.CB_Img = dt.Rows[n]["CB_Img"].ToString();
                    }
                    if (dt.Rows[n]["CB_Css"] != null && dt.Rows[n]["CB_Css"].ToString() != "")
                    {
                        model.CB_Css = dt.Rows[n]["CB_Css"].ToString();
                    }
                    if (dt.Rows[n]["TC_Class"] != null && dt.Rows[n]["TC_Class"].ToString() != "")
                    {
                        model.TC_Class = dt.Rows[n]["TC_Class"].ToString();
                    }
                    if (dt.Rows[n]["TC_Color"] != null && dt.Rows[n]["TC_Color"].ToString() != "")
                    {
                        model.TC_Color = dt.Rows[n]["TC_Color"].ToString();
                    }
                    if (dt.Rows[n]["CB_BrandStyle"] != null && dt.Rows[n]["CB_BrandStyle"].ToString() != "")
                    {
                        model.CB_BrandStyle = dt.Rows[n]["CB_BrandStyle"].ToString();
                    }
                    
                    modelList.Add(model);
                }
            }
            return modelList;
        }

		#endregion  Method
	}
}

