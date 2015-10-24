using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Talent.DAL
{
	/// <summary>
	/// 数据访问类:TN_SYS_EM_USER
	/// </summary>
	public partial class TN_SYS_EM_USER
	{
        private DbHelperSQLP dbhelp = null;
		public TN_SYS_EM_USER()
		{
            this.dbhelp = new DbHelperSQLP(PubConstant.LoginConnectionString);
        }
		#region  Method

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
        public Talent.Model.TN_SYS_EM_USER GetModel(string CN_LOGIN)
		{
			//该表无主键信息，请自定义主键/条件字段
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 CN_ID,CN_LOGIN,CN_USER_NAME,CN_PASSWORD,CN_ISSUPERUSER,CN_ISSYSTEM,CN_DISABLED,CN_ISLOCAL,CN_ISDELETE,CN_COMPANY_ID,CN_ENTYPE,CN_DOMAIN_ID,CN_LEVEL,CN_EMTYPE,CN_ONLINESTATE,CN_STATE,CN_MSGSERVER,CN_SIGNSERVER,CN_NOTE,CN_CREATE_DATE,CN_N_TACTIC_TYPE,CN_PASSKEY,CN_B_OPENNETDISK,CN_DT_LASTLOGIN,CN_N_VER,CN_S_JIANPIN,CN_S_LANDSCAPE from TN_SYS_EM_USER ");
            strSql.Append(" where CN_LOGIN=@CN_LOGIN ");
			SqlParameter[] parameters = {
                 new SqlParameter("@CN_LOGIN", SqlDbType.VarChar,50)
            };

            parameters[0].Value = CN_LOGIN;

            Talent.Model.TN_SYS_EM_USER model = new Talent.Model.TN_SYS_EM_USER();
            DataSet ds = dbhelp.Query(strSql.ToString(), parameters);
			if(ds.Tables[0].Rows.Count>0)
			{
				if(ds.Tables[0].Rows[0]["CN_ID"]!=null && ds.Tables[0].Rows[0]["CN_ID"].ToString()!="")
				{
					model.CN_ID=int.Parse(ds.Tables[0].Rows[0]["CN_ID"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_LOGIN"]!=null && ds.Tables[0].Rows[0]["CN_LOGIN"].ToString()!="")
				{
					model.CN_LOGIN=ds.Tables[0].Rows[0]["CN_LOGIN"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CN_USER_NAME"]!=null && ds.Tables[0].Rows[0]["CN_USER_NAME"].ToString()!="")
				{
					model.CN_USER_NAME=ds.Tables[0].Rows[0]["CN_USER_NAME"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CN_PASSWORD"]!=null && ds.Tables[0].Rows[0]["CN_PASSWORD"].ToString()!="")
				{
					model.CN_PASSWORD=ds.Tables[0].Rows[0]["CN_PASSWORD"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CN_ISSUPERUSER"]!=null && ds.Tables[0].Rows[0]["CN_ISSUPERUSER"].ToString()!="")
				{
					if((ds.Tables[0].Rows[0]["CN_ISSUPERUSER"].ToString()=="1")||(ds.Tables[0].Rows[0]["CN_ISSUPERUSER"].ToString().ToLower()=="true"))
					{
						model.CN_ISSUPERUSER=true;
					}
					else
					{
						model.CN_ISSUPERUSER=false;
					}
				}
				if(ds.Tables[0].Rows[0]["CN_ISSYSTEM"]!=null && ds.Tables[0].Rows[0]["CN_ISSYSTEM"].ToString()!="")
				{
					if((ds.Tables[0].Rows[0]["CN_ISSYSTEM"].ToString()=="1")||(ds.Tables[0].Rows[0]["CN_ISSYSTEM"].ToString().ToLower()=="true"))
					{
						model.CN_ISSYSTEM=true;
					}
					else
					{
						model.CN_ISSYSTEM=false;
					}
				}
				if(ds.Tables[0].Rows[0]["CN_DISABLED"]!=null && ds.Tables[0].Rows[0]["CN_DISABLED"].ToString()!="")
				{
					if((ds.Tables[0].Rows[0]["CN_DISABLED"].ToString()=="1")||(ds.Tables[0].Rows[0]["CN_DISABLED"].ToString().ToLower()=="true"))
					{
						model.CN_DISABLED=true;
					}
					else
					{
						model.CN_DISABLED=false;
					}
				}
				if(ds.Tables[0].Rows[0]["CN_ISLOCAL"]!=null && ds.Tables[0].Rows[0]["CN_ISLOCAL"].ToString()!="")
				{
					if((ds.Tables[0].Rows[0]["CN_ISLOCAL"].ToString()=="1")||(ds.Tables[0].Rows[0]["CN_ISLOCAL"].ToString().ToLower()=="true"))
					{
						model.CN_ISLOCAL=true;
					}
					else
					{
						model.CN_ISLOCAL=false;
					}
				}
				if(ds.Tables[0].Rows[0]["CN_ISDELETE"]!=null && ds.Tables[0].Rows[0]["CN_ISDELETE"].ToString()!="")
				{
					if((ds.Tables[0].Rows[0]["CN_ISDELETE"].ToString()=="1")||(ds.Tables[0].Rows[0]["CN_ISDELETE"].ToString().ToLower()=="true"))
					{
						model.CN_ISDELETE=true;
					}
					else
					{
						model.CN_ISDELETE=false;
					}
				}
				if(ds.Tables[0].Rows[0]["CN_COMPANY_ID"]!=null && ds.Tables[0].Rows[0]["CN_COMPANY_ID"].ToString()!="")
				{
					model.CN_COMPANY_ID=int.Parse(ds.Tables[0].Rows[0]["CN_COMPANY_ID"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_ENTYPE"]!=null && ds.Tables[0].Rows[0]["CN_ENTYPE"].ToString()!="")
				{
					model.CN_ENTYPE=int.Parse(ds.Tables[0].Rows[0]["CN_ENTYPE"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_DOMAIN_ID"]!=null && ds.Tables[0].Rows[0]["CN_DOMAIN_ID"].ToString()!="")
				{
					model.CN_DOMAIN_ID=int.Parse(ds.Tables[0].Rows[0]["CN_DOMAIN_ID"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_LEVEL"]!=null && ds.Tables[0].Rows[0]["CN_LEVEL"].ToString()!="")
				{
					model.CN_LEVEL=int.Parse(ds.Tables[0].Rows[0]["CN_LEVEL"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_EMTYPE"]!=null && ds.Tables[0].Rows[0]["CN_EMTYPE"].ToString()!="")
				{
					model.CN_EMTYPE=int.Parse(ds.Tables[0].Rows[0]["CN_EMTYPE"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_ONLINESTATE"]!=null && ds.Tables[0].Rows[0]["CN_ONLINESTATE"].ToString()!="")
				{
					model.CN_ONLINESTATE=int.Parse(ds.Tables[0].Rows[0]["CN_ONLINESTATE"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_STATE"]!=null && ds.Tables[0].Rows[0]["CN_STATE"].ToString()!="")
				{
					model.CN_STATE=int.Parse(ds.Tables[0].Rows[0]["CN_STATE"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_MSGSERVER"]!=null && ds.Tables[0].Rows[0]["CN_MSGSERVER"].ToString()!="")
				{
					model.CN_MSGSERVER=ds.Tables[0].Rows[0]["CN_MSGSERVER"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CN_SIGNSERVER"]!=null && ds.Tables[0].Rows[0]["CN_SIGNSERVER"].ToString()!="")
				{
					model.CN_SIGNSERVER=ds.Tables[0].Rows[0]["CN_SIGNSERVER"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CN_NOTE"]!=null && ds.Tables[0].Rows[0]["CN_NOTE"].ToString()!="")
				{
					model.CN_NOTE=ds.Tables[0].Rows[0]["CN_NOTE"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CN_CREATE_DATE"]!=null && ds.Tables[0].Rows[0]["CN_CREATE_DATE"].ToString()!="")
				{
					model.CN_CREATE_DATE=DateTime.Parse(ds.Tables[0].Rows[0]["CN_CREATE_DATE"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_N_TACTIC_TYPE"]!=null && ds.Tables[0].Rows[0]["CN_N_TACTIC_TYPE"].ToString()!="")
				{
					model.CN_N_TACTIC_TYPE=int.Parse(ds.Tables[0].Rows[0]["CN_N_TACTIC_TYPE"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_PASSKEY"]!=null && ds.Tables[0].Rows[0]["CN_PASSKEY"].ToString()!="")
				{
					model.CN_PASSKEY=ds.Tables[0].Rows[0]["CN_PASSKEY"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CN_B_OPENNETDISK"]!=null && ds.Tables[0].Rows[0]["CN_B_OPENNETDISK"].ToString()!="")
				{
					model.CN_B_OPENNETDISK=int.Parse(ds.Tables[0].Rows[0]["CN_B_OPENNETDISK"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_DT_LASTLOGIN"]!=null && ds.Tables[0].Rows[0]["CN_DT_LASTLOGIN"].ToString()!="")
				{
					model.CN_DT_LASTLOGIN=DateTime.Parse(ds.Tables[0].Rows[0]["CN_DT_LASTLOGIN"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_N_VER"]!=null && ds.Tables[0].Rows[0]["CN_N_VER"].ToString()!="")
				{
					model.CN_N_VER=int.Parse(ds.Tables[0].Rows[0]["CN_N_VER"].ToString());
				}
				if(ds.Tables[0].Rows[0]["CN_S_JIANPIN"]!=null && ds.Tables[0].Rows[0]["CN_S_JIANPIN"].ToString()!="")
				{
					model.CN_S_JIANPIN=ds.Tables[0].Rows[0]["CN_S_JIANPIN"].ToString();
				}
				if(ds.Tables[0].Rows[0]["CN_S_LANDSCAPE"]!=null && ds.Tables[0].Rows[0]["CN_S_LANDSCAPE"].ToString()!="")
				{
					model.CN_S_LANDSCAPE=ds.Tables[0].Rows[0]["CN_S_LANDSCAPE"].ToString();
				}
				return model;
			}
			else
			{
				return null;
			}
		}


        public Talent.Model.TN_SYS_EM_USER GetModelByID(string CN_ID)
        {
            //该表无主键信息，请自定义主键/条件字段
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 CN_ID,CN_LOGIN,CN_USER_NAME,CN_PASSWORD,CN_ISSUPERUSER,CN_ISSYSTEM,CN_DISABLED,CN_ISLOCAL,CN_ISDELETE,CN_COMPANY_ID,CN_ENTYPE,CN_DOMAIN_ID,CN_LEVEL,CN_EMTYPE,CN_ONLINESTATE,CN_STATE,CN_MSGSERVER,CN_SIGNSERVER,CN_NOTE,CN_CREATE_DATE,CN_N_TACTIC_TYPE,CN_PASSKEY,CN_B_OPENNETDISK,CN_DT_LASTLOGIN,CN_N_VER,CN_S_JIANPIN,CN_S_LANDSCAPE from TN_SYS_EM_USER ");
            strSql.Append(" where CN_ID=@CN_ID ");
            SqlParameter[] parameters = {
                 new SqlParameter("@CN_ID", SqlDbType.Int)
            };

            parameters[0].Value = CN_ID;

            Talent.Model.TN_SYS_EM_USER model = new Talent.Model.TN_SYS_EM_USER();
            DataSet ds = dbhelp.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["CN_ID"] != null && ds.Tables[0].Rows[0]["CN_ID"].ToString() != "")
                {
                    model.CN_ID = int.Parse(ds.Tables[0].Rows[0]["CN_ID"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_LOGIN"] != null && ds.Tables[0].Rows[0]["CN_LOGIN"].ToString() != "")
                {
                    model.CN_LOGIN = ds.Tables[0].Rows[0]["CN_LOGIN"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CN_USER_NAME"] != null && ds.Tables[0].Rows[0]["CN_USER_NAME"].ToString() != "")
                {
                    model.CN_USER_NAME = ds.Tables[0].Rows[0]["CN_USER_NAME"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CN_PASSWORD"] != null && ds.Tables[0].Rows[0]["CN_PASSWORD"].ToString() != "")
                {
                    model.CN_PASSWORD = ds.Tables[0].Rows[0]["CN_PASSWORD"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CN_ISSUPERUSER"] != null && ds.Tables[0].Rows[0]["CN_ISSUPERUSER"].ToString() != "")
                {
                    if ((ds.Tables[0].Rows[0]["CN_ISSUPERUSER"].ToString() == "1") || (ds.Tables[0].Rows[0]["CN_ISSUPERUSER"].ToString().ToLower() == "true"))
                    {
                        model.CN_ISSUPERUSER = true;
                    }
                    else
                    {
                        model.CN_ISSUPERUSER = false;
                    }
                }
                if (ds.Tables[0].Rows[0]["CN_ISSYSTEM"] != null && ds.Tables[0].Rows[0]["CN_ISSYSTEM"].ToString() != "")
                {
                    if ((ds.Tables[0].Rows[0]["CN_ISSYSTEM"].ToString() == "1") || (ds.Tables[0].Rows[0]["CN_ISSYSTEM"].ToString().ToLower() == "true"))
                    {
                        model.CN_ISSYSTEM = true;
                    }
                    else
                    {
                        model.CN_ISSYSTEM = false;
                    }
                }
                if (ds.Tables[0].Rows[0]["CN_DISABLED"] != null && ds.Tables[0].Rows[0]["CN_DISABLED"].ToString() != "")
                {
                    if ((ds.Tables[0].Rows[0]["CN_DISABLED"].ToString() == "1") || (ds.Tables[0].Rows[0]["CN_DISABLED"].ToString().ToLower() == "true"))
                    {
                        model.CN_DISABLED = true;
                    }
                    else
                    {
                        model.CN_DISABLED = false;
                    }
                }
                if (ds.Tables[0].Rows[0]["CN_ISLOCAL"] != null && ds.Tables[0].Rows[0]["CN_ISLOCAL"].ToString() != "")
                {
                    if ((ds.Tables[0].Rows[0]["CN_ISLOCAL"].ToString() == "1") || (ds.Tables[0].Rows[0]["CN_ISLOCAL"].ToString().ToLower() == "true"))
                    {
                        model.CN_ISLOCAL = true;
                    }
                    else
                    {
                        model.CN_ISLOCAL = false;
                    }
                }
                if (ds.Tables[0].Rows[0]["CN_ISDELETE"] != null && ds.Tables[0].Rows[0]["CN_ISDELETE"].ToString() != "")
                {
                    if ((ds.Tables[0].Rows[0]["CN_ISDELETE"].ToString() == "1") || (ds.Tables[0].Rows[0]["CN_ISDELETE"].ToString().ToLower() == "true"))
                    {
                        model.CN_ISDELETE = true;
                    }
                    else
                    {
                        model.CN_ISDELETE = false;
                    }
                }
                if (ds.Tables[0].Rows[0]["CN_COMPANY_ID"] != null && ds.Tables[0].Rows[0]["CN_COMPANY_ID"].ToString() != "")
                {
                    model.CN_COMPANY_ID = int.Parse(ds.Tables[0].Rows[0]["CN_COMPANY_ID"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_ENTYPE"] != null && ds.Tables[0].Rows[0]["CN_ENTYPE"].ToString() != "")
                {
                    model.CN_ENTYPE = int.Parse(ds.Tables[0].Rows[0]["CN_ENTYPE"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_DOMAIN_ID"] != null && ds.Tables[0].Rows[0]["CN_DOMAIN_ID"].ToString() != "")
                {
                    model.CN_DOMAIN_ID = int.Parse(ds.Tables[0].Rows[0]["CN_DOMAIN_ID"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_LEVEL"] != null && ds.Tables[0].Rows[0]["CN_LEVEL"].ToString() != "")
                {
                    model.CN_LEVEL = int.Parse(ds.Tables[0].Rows[0]["CN_LEVEL"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_EMTYPE"] != null && ds.Tables[0].Rows[0]["CN_EMTYPE"].ToString() != "")
                {
                    model.CN_EMTYPE = int.Parse(ds.Tables[0].Rows[0]["CN_EMTYPE"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_ONLINESTATE"] != null && ds.Tables[0].Rows[0]["CN_ONLINESTATE"].ToString() != "")
                {
                    model.CN_ONLINESTATE = int.Parse(ds.Tables[0].Rows[0]["CN_ONLINESTATE"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_STATE"] != null && ds.Tables[0].Rows[0]["CN_STATE"].ToString() != "")
                {
                    model.CN_STATE = int.Parse(ds.Tables[0].Rows[0]["CN_STATE"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_MSGSERVER"] != null && ds.Tables[0].Rows[0]["CN_MSGSERVER"].ToString() != "")
                {
                    model.CN_MSGSERVER = ds.Tables[0].Rows[0]["CN_MSGSERVER"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CN_SIGNSERVER"] != null && ds.Tables[0].Rows[0]["CN_SIGNSERVER"].ToString() != "")
                {
                    model.CN_SIGNSERVER = ds.Tables[0].Rows[0]["CN_SIGNSERVER"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CN_NOTE"] != null && ds.Tables[0].Rows[0]["CN_NOTE"].ToString() != "")
                {
                    model.CN_NOTE = ds.Tables[0].Rows[0]["CN_NOTE"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CN_CREATE_DATE"] != null && ds.Tables[0].Rows[0]["CN_CREATE_DATE"].ToString() != "")
                {
                    model.CN_CREATE_DATE = DateTime.Parse(ds.Tables[0].Rows[0]["CN_CREATE_DATE"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_N_TACTIC_TYPE"] != null && ds.Tables[0].Rows[0]["CN_N_TACTIC_TYPE"].ToString() != "")
                {
                    model.CN_N_TACTIC_TYPE = int.Parse(ds.Tables[0].Rows[0]["CN_N_TACTIC_TYPE"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_PASSKEY"] != null && ds.Tables[0].Rows[0]["CN_PASSKEY"].ToString() != "")
                {
                    model.CN_PASSKEY = ds.Tables[0].Rows[0]["CN_PASSKEY"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CN_B_OPENNETDISK"] != null && ds.Tables[0].Rows[0]["CN_B_OPENNETDISK"].ToString() != "")
                {
                    model.CN_B_OPENNETDISK = int.Parse(ds.Tables[0].Rows[0]["CN_B_OPENNETDISK"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_DT_LASTLOGIN"] != null && ds.Tables[0].Rows[0]["CN_DT_LASTLOGIN"].ToString() != "")
                {
                    model.CN_DT_LASTLOGIN = DateTime.Parse(ds.Tables[0].Rows[0]["CN_DT_LASTLOGIN"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_N_VER"] != null && ds.Tables[0].Rows[0]["CN_N_VER"].ToString() != "")
                {
                    model.CN_N_VER = int.Parse(ds.Tables[0].Rows[0]["CN_N_VER"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CN_S_JIANPIN"] != null && ds.Tables[0].Rows[0]["CN_S_JIANPIN"].ToString() != "")
                {
                    model.CN_S_JIANPIN = ds.Tables[0].Rows[0]["CN_S_JIANPIN"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CN_S_LANDSCAPE"] != null && ds.Tables[0].Rows[0]["CN_S_LANDSCAPE"].ToString() != "")
                {
                    model.CN_S_LANDSCAPE = ds.Tables[0].Rows[0]["CN_S_LANDSCAPE"].ToString();
                }
                return model;
            }
            else
            {
                return null;
            }
        }

        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select CN_LOGIN ");
            strSql.Append(" FROM TN_SYS_EM_USER ");

            return dbhelp.Query(strSql.ToString());
        }


		#endregion  Method
	}
}

