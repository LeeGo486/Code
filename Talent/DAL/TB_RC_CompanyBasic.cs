using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Talent.DAL
{
	/// <summary>
	/// 数据访问类:TB_RC_CompanyBasic
	/// </summary>
	public partial class TB_RC_CompanyBasic
	{
        private DbHelperSQLP dbhelp = null;

		public TB_RC_CompanyBasic()
		{
            this.dbhelp = new DbHelperSQLP(PubConstant.TalentConnectionString);
        }
		#region  Method



		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(Talent.Model.TB_RC_CompanyBasic model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into TB_RC_CompanyBasic(");
            strSql.Append("CB_Des,CB_Name,CB_Position,CB_Num,CB_SetUp,CB_Je,CB_Scale,CB_BrandName,CB_PriceSection,CB_Category,CB_ModeOperation,CB_ShopNum,CB_Founder,CB_Advantage,CB_OrgStructure,CB_KeyPerson,CB_HumanSrc,CB_CreatePer,CB_CreateDate,CB_Province,CB_X,CB_Y,CB_Img,CB_Css,CB_BrandStyle)");
			strSql.Append(" values (");
            strSql.Append("@CB_Des,@CB_Name,@CB_Position,@CB_Num,@CB_SetUp,@CB_Je,@CB_Scale,@CB_BrandName,@CB_PriceSection,@CB_Category,@CB_ModeOperation,@CB_ShopNum,@CB_Founder,@CB_Advantage,@CB_OrgStructure,@CB_KeyPerson,@CB_HumanSrc,@CB_CreatePer,@CB_CreateDate,@CB_Province,@CB_X,@CB_Y,@CB_Img,@CB_Css,@CB_BrandStyle)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@CB_Des", SqlDbType.Text),
					new SqlParameter("@CB_Name", SqlDbType.VarChar,100),
					new SqlParameter("@CB_Position", SqlDbType.VarChar,400),
					new SqlParameter("@CB_Num", SqlDbType.Int,4),
					new SqlParameter("@CB_SetUp", SqlDbType.DateTime),
					new SqlParameter("@CB_Je", SqlDbType.VarChar,50),
					new SqlParameter("@CB_Scale", SqlDbType.VarChar,400),
					new SqlParameter("@CB_BrandName", SqlDbType.VarChar,100),
					new SqlParameter("@CB_PriceSection", SqlDbType.VarChar,200),
					new SqlParameter("@CB_Category", SqlDbType.VarChar,200),
					new SqlParameter("@CB_ModeOperation", SqlDbType.VarChar,400),
					new SqlParameter("@CB_ShopNum", SqlDbType.Int,4),
					new SqlParameter("@CB_Founder", SqlDbType.Text),
					new SqlParameter("@CB_Advantage", SqlDbType.Text),
					new SqlParameter("@CB_OrgStructure", SqlDbType.Text),
					new SqlParameter("@CB_KeyPerson", SqlDbType.Text),
					new SqlParameter("@CB_HumanSrc", SqlDbType.Text),
					new SqlParameter("@CB_CreatePer", SqlDbType.VarChar,20),
					new SqlParameter("@CB_CreateDate", SqlDbType.DateTime),
                    new SqlParameter("@CB_Province", SqlDbType.VarChar,50),
                    new SqlParameter("@CB_X", SqlDbType.VarChar,50),
                    new SqlParameter("@CB_Y", SqlDbType.VarChar,50),
                    new SqlParameter("@CB_Img", SqlDbType.VarChar,200),
                    new SqlParameter("@CB_Css", SqlDbType.VarChar,1000),
                    new SqlParameter("@CB_BrandStyle", SqlDbType.VarChar,200)};
			parameters[0].Value = model.CB_Des;
			parameters[1].Value = model.CB_Name;
			parameters[2].Value = model.CB_Position;
			parameters[3].Value = model.CB_Num;
			parameters[4].Value = model.CB_SetUp;
			parameters[5].Value = model.CB_Je;
			parameters[6].Value = model.CB_Scale;
			parameters[7].Value = model.CB_BrandName;
			parameters[8].Value = model.CB_PriceSection;
			parameters[9].Value = model.CB_Category;
			parameters[10].Value = model.CB_ModeOperation;
			parameters[11].Value = model.CB_ShopNum;
			parameters[12].Value = model.CB_Founder;
			parameters[13].Value = model.CB_Advantage;
			parameters[14].Value = model.CB_OrgStructure;
			parameters[15].Value = model.CB_KeyPerson;
			parameters[16].Value = model.CB_HumanSrc;
			parameters[17].Value = model.CB_CreatePer;
			parameters[18].Value = model.CB_CreateDate;
            parameters[19].Value = model.CB_Province;
            parameters[20].Value = model.CB_X;
            parameters[21].Value = model.CB_Y;
            parameters[22].Value = model.CB_Img;
            parameters[23].Value = model.CB_Css;
            parameters[24].Value = model.CB_BrandStyle;

            object obj = dbhelp.GetSingle(strSql.ToString(), parameters);
			if (obj == null)
			{
				return 0;
			}
			else
			{
				return Convert.ToInt32(obj);
			}
		}
		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(Talent.Model.TB_RC_CompanyBasic model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update TB_RC_CompanyBasic set ");
			strSql.Append("CB_Des=@CB_Des,");
			strSql.Append("CB_Name=@CB_Name,");
			strSql.Append("CB_Position=@CB_Position,");
			strSql.Append("CB_Num=@CB_Num,");
			strSql.Append("CB_SetUp=@CB_SetUp,");
			strSql.Append("CB_Je=@CB_Je,");
			strSql.Append("CB_Scale=@CB_Scale,");
			strSql.Append("CB_BrandName=@CB_BrandName,");
			strSql.Append("CB_PriceSection=@CB_PriceSection,");
			strSql.Append("CB_Category=@CB_Category,");
			strSql.Append("CB_ModeOperation=@CB_ModeOperation,");
			strSql.Append("CB_ShopNum=@CB_ShopNum,");
			strSql.Append("CB_Founder=@CB_Founder,");
			strSql.Append("CB_Advantage=@CB_Advantage,");
			strSql.Append("CB_OrgStructure=@CB_OrgStructure,");
			strSql.Append("CB_KeyPerson=@CB_KeyPerson,");
			strSql.Append("CB_HumanSrc=@CB_HumanSrc,");
			strSql.Append("CB_CreatePer=@CB_CreatePer,");
			strSql.Append("CB_CreateDate=@CB_CreateDate,");
            strSql.Append("CB_Province=@CB_Province,");
            strSql.Append("CB_X=@CB_X,");
            strSql.Append("CB_Y=@CB_Y,");
            strSql.Append("CB_Img=@CB_Img,");
            strSql.Append("CB_Css=@CB_Css,");
            strSql.Append("CB_BrandStyle=@CB_BrandStyle");
			strSql.Append(" where CB_No=@CB_No");
			SqlParameter[] parameters = {
					new SqlParameter("@CB_Des", SqlDbType.Text),
					new SqlParameter("@CB_Name", SqlDbType.VarChar,100),
					new SqlParameter("@CB_Position", SqlDbType.VarChar,400),
					new SqlParameter("@CB_Num", SqlDbType.Int,4),
					new SqlParameter("@CB_SetUp", SqlDbType.DateTime),
					new SqlParameter("@CB_Je", SqlDbType.VarChar,50),
					new SqlParameter("@CB_Scale", SqlDbType.VarChar,400),
					new SqlParameter("@CB_BrandName", SqlDbType.VarChar,100),
					new SqlParameter("@CB_PriceSection", SqlDbType.VarChar,200),
					new SqlParameter("@CB_Category", SqlDbType.VarChar,200),
					new SqlParameter("@CB_ModeOperation", SqlDbType.VarChar,400),
					new SqlParameter("@CB_ShopNum", SqlDbType.Int,4),
					new SqlParameter("@CB_Founder", SqlDbType.Text),
					new SqlParameter("@CB_Advantage", SqlDbType.Text),
					new SqlParameter("@CB_OrgStructure", SqlDbType.Text),
					new SqlParameter("@CB_KeyPerson", SqlDbType.Text),
					new SqlParameter("@CB_HumanSrc", SqlDbType.Text),
					new SqlParameter("@CB_CreatePer", SqlDbType.VarChar,20),
					new SqlParameter("@CB_CreateDate", SqlDbType.DateTime),
                    new SqlParameter("@CB_Province", SqlDbType.VarChar,50),
                    new SqlParameter("@CB_X", SqlDbType.VarChar,50),
                    new SqlParameter("@CB_Y", SqlDbType.VarChar,50),
                    new SqlParameter("@CB_Img", SqlDbType.VarChar,200),
                    new SqlParameter("@CB_Css", SqlDbType.VarChar,1000),
                    new SqlParameter("@CB_BrandStyle", SqlDbType.VarChar,200),
					new SqlParameter("@CB_No", SqlDbType.Int,4)};
			parameters[0].Value = model.CB_Des;
			parameters[1].Value = model.CB_Name;
			parameters[2].Value = model.CB_Position;
			parameters[3].Value = model.CB_Num;
			parameters[4].Value = model.CB_SetUp;
			parameters[5].Value = model.CB_Je;
			parameters[6].Value = model.CB_Scale;
			parameters[7].Value = model.CB_BrandName;
			parameters[8].Value = model.CB_PriceSection;
			parameters[9].Value = model.CB_Category;
			parameters[10].Value = model.CB_ModeOperation;
			parameters[11].Value = model.CB_ShopNum;
			parameters[12].Value = model.CB_Founder;
			parameters[13].Value = model.CB_Advantage;
			parameters[14].Value = model.CB_OrgStructure;
			parameters[15].Value = model.CB_KeyPerson;
			parameters[16].Value = model.CB_HumanSrc;
			parameters[17].Value = model.CB_CreatePer;
			parameters[18].Value = model.CB_CreateDate;
            parameters[19].Value = model.CB_Province;
            parameters[20].Value = model.CB_X;
            parameters[21].Value = model.CB_Y;
            parameters[22].Value = model.CB_Img;
            parameters[23].Value = model.CB_Css;
            parameters[24].Value = model.CB_BrandStyle;
            parameters[25].Value = model.CB_No;

            int rows = dbhelp.ExecuteSql(strSql.ToString(), parameters);
			if (rows > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int CB_No)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from TB_RC_CompanyBasic ");
			strSql.Append(" where CB_No=@CB_No");
			SqlParameter[] parameters = {
					new SqlParameter("@CB_No", SqlDbType.Int,4)
			};
			parameters[0].Value = CB_No;

            int rows = dbhelp.ExecuteSql(strSql.ToString(), parameters);
			if (rows > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		/// <summary>
		/// 批量删除数据
		/// </summary>
	/*	public bool DeleteList(string CB_Nolist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from TB_RC_CompanyBasic ");
			strSql.Append(" where CB_No in ("+CB_Nolist + ")  ");
            int rows = dbhelp.ExecuteSql(strSql.ToString());
			if (rows > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}  */


		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public Talent.Model.TB_RC_CompanyBasic GetModel(int CB_No)
		{
			
			StringBuilder strSql=new StringBuilder();
            strSql.Append("select  top 1 CB_No,CB_Des,CB_Name,CB_Position,CB_Num,CB_SetUp,CB_Je,CB_Scale,CB_BrandName,CB_PriceSection,CB_Category,CB_ModeOperation,CB_ShopNum,CB_Founder,CB_Advantage,CB_OrgStructure,CB_KeyPerson,CB_HumanSrc,CB_CreatePer,CB_CreateDate,CB_Province,CB_X,CB_Y,CB_Img,CB_Css,CB_BrandStyle from TB_RC_CompanyBasic ");
			strSql.Append(" where CB_No=@CB_No");
			SqlParameter[] parameters = {
					new SqlParameter("@CB_No", SqlDbType.Int,4)
			};
			parameters[0].Value = CB_No;

			Talent.Model.TB_RC_CompanyBasic model=new Talent.Model.TB_RC_CompanyBasic();
            DataSet ds = dbhelp.Query(strSql.ToString(), parameters);
			if(ds.Tables[0].Rows.Count>0)
			{
				if(ds.Tables[0].Rows[0]["CB_No"]!=null && ds.Tables[0].Rows[0]["CB_No"].ToString()!="")
				{
					model.CB_No=int.Parse(ds.Tables[0].Rows[0]["CB_No"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CB_Des"]!=null && ds.Tables[0].Rows[0]["CB_Des"].ToString()!="")
				{
					model.CB_Des=ds.Tables[0].Rows[0]["CB_Des"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_Name"]!=null && ds.Tables[0].Rows[0]["CB_Name"].ToString()!="")
				{
					model.CB_Name=ds.Tables[0].Rows[0]["CB_Name"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_Position"]!=null && ds.Tables[0].Rows[0]["CB_Position"].ToString()!="")
				{
					model.CB_Position=ds.Tables[0].Rows[0]["CB_Position"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_Num"]!=null && ds.Tables[0].Rows[0]["CB_Num"].ToString()!="")
				{
					model.CB_Num=int.Parse(ds.Tables[0].Rows[0]["CB_Num"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CB_SetUp"]!=null && ds.Tables[0].Rows[0]["CB_SetUp"].ToString()!="")
				{
					model.CB_SetUp=DateTime.Parse(ds.Tables[0].Rows[0]["CB_SetUp"].ToString()).ToString("yyyy-MM-dd");
				}
				if(ds.Tables[0].Rows[0]["CB_Je"]!=null && ds.Tables[0].Rows[0]["CB_Je"].ToString()!="")
				{
					model.CB_Je=ds.Tables[0].Rows[0]["CB_Je"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_Scale"]!=null && ds.Tables[0].Rows[0]["CB_Scale"].ToString()!="")
				{
					model.CB_Scale=ds.Tables[0].Rows[0]["CB_Scale"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_BrandName"]!=null && ds.Tables[0].Rows[0]["CB_BrandName"].ToString()!="")
				{
					model.CB_BrandName=ds.Tables[0].Rows[0]["CB_BrandName"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_PriceSection"]!=null && ds.Tables[0].Rows[0]["CB_PriceSection"].ToString()!="")
				{
					model.CB_PriceSection=ds.Tables[0].Rows[0]["CB_PriceSection"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_Category"]!=null && ds.Tables[0].Rows[0]["CB_Category"].ToString()!="")
				{
					model.CB_Category=ds.Tables[0].Rows[0]["CB_Category"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_ModeOperation"]!=null && ds.Tables[0].Rows[0]["CB_ModeOperation"].ToString()!="")
				{
					model.CB_ModeOperation=ds.Tables[0].Rows[0]["CB_ModeOperation"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_ShopNum"]!=null && ds.Tables[0].Rows[0]["CB_ShopNum"].ToString()!="")
				{
					model.CB_ShopNum=int.Parse(ds.Tables[0].Rows[0]["CB_ShopNum"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CB_Founder"]!=null && ds.Tables[0].Rows[0]["CB_Founder"].ToString()!="")
				{
					model.CB_Founder=ds.Tables[0].Rows[0]["CB_Founder"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_Advantage"]!=null && ds.Tables[0].Rows[0]["CB_Advantage"].ToString()!="")
				{
					model.CB_Advantage=ds.Tables[0].Rows[0]["CB_Advantage"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_OrgStructure"]!=null && ds.Tables[0].Rows[0]["CB_OrgStructure"].ToString()!="")
				{
					model.CB_OrgStructure=ds.Tables[0].Rows[0]["CB_OrgStructure"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_KeyPerson"]!=null && ds.Tables[0].Rows[0]["CB_KeyPerson"].ToString()!="")
				{
					model.CB_KeyPerson=ds.Tables[0].Rows[0]["CB_KeyPerson"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_HumanSrc"]!=null && ds.Tables[0].Rows[0]["CB_HumanSrc"].ToString()!="")
				{
					model.CB_HumanSrc=ds.Tables[0].Rows[0]["CB_HumanSrc"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_CreatePer"]!=null && ds.Tables[0].Rows[0]["CB_CreatePer"].ToString()!="")
				{
					model.CB_CreatePer=ds.Tables[0].Rows[0]["CB_CreatePer"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CB_CreateDate"]!=null && ds.Tables[0].Rows[0]["CB_CreateDate"].ToString()!="")
				{
					model.CB_CreateDate=DateTime.Parse(ds.Tables[0].Rows[0]["CB_CreateDate"].ToString());
				}
                if (ds.Tables[0].Rows[0]["CB_Province"] != null && ds.Tables[0].Rows[0]["CB_Province"].ToString() != "")
				{
                    model.CB_Province = ds.Tables[0].Rows[0]["CB_Province"].ToString();
				}
                if (ds.Tables[0].Rows[0]["CB_X"] != null && ds.Tables[0].Rows[0]["CB_X"].ToString() != "")
                {
                    model.CB_X = ds.Tables[0].Rows[0]["CB_X"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CB_Y"] != null && ds.Tables[0].Rows[0]["CB_Y"].ToString() != "")
                {
                    model.CB_Y = ds.Tables[0].Rows[0]["CB_Y"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CB_Img"] != null && ds.Tables[0].Rows[0]["CB_Img"].ToString() != "")
                {
                    model.CB_Img = ds.Tables[0].Rows[0]["CB_Img"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CB_Css"] != null && ds.Tables[0].Rows[0]["CB_Css"].ToString() != "")
                {
                    model.CB_Css = ds.Tables[0].Rows[0]["CB_Css"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CB_BrandStyle"] != null && ds.Tables[0].Rows[0]["CB_BrandStyle"].ToString() != "")
                {
                    model.CB_BrandStyle = ds.Tables[0].Rows[0]["CB_BrandStyle"].ToString();
                }
                
				return model;
			}
			else
			{
				return null;
			}
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public DataSet GetList(string strWhere)
		{
			StringBuilder strSql=new StringBuilder();
            strSql.Append("select CB_No,CB_Des,CB_Name,CB_Position,CB_Num,CB_SetUp,CB_Je,CB_Scale,CB_BrandName,CB_PriceSection,CB_Category,CB_ModeOperation,CB_ShopNum,CB_Founder,CB_Advantage,CB_OrgStructure,CB_KeyPerson,CB_HumanSrc,CB_CreatePer,CB_CreateDate,CB_Province,CB_X,CB_Y,CB_Img,CB_Css,CB_BrandStyle  ");
			strSql.Append(" FROM TB_RC_CompanyBasic ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
            return dbhelp.Query(strSql.ToString());
		}


        public DataSet GetListAndClass(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select CB_No,CB_Des,CB_Name,CB_Position,CB_Num,CB_SetUp,CB_Je,CB_Scale,CB_BrandName,CB_PriceSection,CB_Category,CB_ModeOperation,CB_ShopNum,CB_Founder,CB_Advantage,CB_OrgStructure,CB_KeyPerson,CB_HumanSrc,CB_CreatePer,CB_CreateDate,CB_Province,CB_X,CB_Y,CB_Img,CB_Css,TC_Class,TC_Color,CB_BrandStyle ");
            strSql.Append(" FROM TB_RC_CompanyBasic left join TB_RC_CompanyTalentClassRelate on CB_No=CT_CB_No  left join TB_RC_TalentClass on CT_TC_No=TC_No");
            strSql.Append(" where 1=1 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            strSql.Append(" order by CB_No asc ");
            return dbhelp.Query(strSql.ToString());
        }

		#endregion  Method
	}
}

