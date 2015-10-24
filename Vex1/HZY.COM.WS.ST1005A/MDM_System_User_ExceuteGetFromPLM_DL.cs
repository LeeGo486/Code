using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_User_ExceuteGetFromPLM_DL 从DLPLM辅助系统中，抽取数据到MDM中
    /// </summary>
    public class MDM_System_User_ExceuteGetFromPLM_DL : LogicBase, ILogicExecute
    {
        public MDM_System_User_ExceuteGetFromPLM_DL()
        {

            this.m_SessionCheck = false;
        }

        public bool Execute()
        {
            string strEnv_ID = "";
            string strEnv_SN = "DL_PLMFZ";

            Dbconn conn_PLM_AS = new Dbconn("PLM_AS_DL");
            DataSet ds = conn_PLM_AS.GetDataSet(
                @"  SELECT 
                        --44 as Env_ID,
                        null as VexSSONewID,
                        username as App_UserName,
                        RIGHT(sys.fn_VarBinToHexStr(hashbytes('MD5', convert(vARCHAR(100),PASSWORD))), 32) as App_Password,
                        PASSWORD as App_PasswordSrc,
                        userNameC as App_UserName_CN,
                        getdate() Chang_Password_Time ,
			            1 Checked ,
			            'system' Check_User ,
			            getdate() Check_Time ,
			            getdate() Createtime ,
			            getdate() Updatetime,
                        0 as oprationFlag

                   FROM dbo.USERINFO u 
                     ");



            Dbconn connMDM = new Dbconn("VexSSO");

            try
            {


                ArrayList tableList = new ArrayList();
                connMDM.BeginTransaction();
                tableList.Add("MDM_System_User");
                connMDM.TableLock(tableList);

                strEnv_ID = connMDM.GetDataTableFirstValue("SELECT [Env_ID]  FROM [MDM_System_Env]  WHERE Env_SN='" + strEnv_SN + "'").ToString();
                DataTable dtMDM = connMDM.GetDataTable(@"
                                                        SELECT [App_UserID]
                                                              ,[Env_ID]
                                                              ,[VexSSONewID]
                                                              ,[App_UserName]
                                                              ,[App_Password]
                                                              ,[App_PasswordSrc]
                                                              ,[App_UserName_CN]
                                                              ,[Chang_Password_Time]
                                                              ,[Checked]
                                                              ,[Check_User]
                                                              ,[Check_Time]
                                                              ,[Createtime]
                                                              ,[Updatetime]
                                                          FROM [dbo].[MDM_System_User]
                                                          WHERE Env_ID='" + strEnv_ID + @"'
                                                        ");


                DataTable dtMDMUpdate = dtMDM.Clone();
                DataTable dtMDMInsert = dtMDM.Clone();
                DataTable dtMDMDelete = dtMDM.Clone();

                for (int i = 0; i < dtMDM.Rows.Count; i++)
                {
                    string strApp_UserName = dtMDM.Rows[i]["App_UserName"].ToString();

                    DataRow[] dr = ds.Tables[0].Select("App_UserName='" + strApp_UserName + "'");
                    if (dr.Length > 0)
                    {
                        dtMDM.Rows[i]["App_Password"] = dr[0]["App_Password"];
                        dtMDM.Rows[i]["App_PasswordSrc"] = dr[0]["App_PasswordSrc"];
                        dtMDM.Rows[i]["App_UserName_CN"] = dr[0]["App_UserName_CN"];

                        dtMDMUpdate.ImportRow(dtMDM.Rows[i]);
                        dr[0]["oprationFlag"] = "1";
                    }
                    else
                    {
                        dtMDMDelete.ImportRow(dtMDM.Rows[i]);
                    }
                }

                DataRow[] drInsert = ds.Tables[0].Select("oprationFlag=0");
                for (int i = 0; i < drInsert.Length; i++)
                {
                    DataRow dr = dtMDMInsert.NewRow();
                    dr["Env_ID"] = strEnv_ID;
                    dr["VexSSONewID"] = drInsert[i]["VexSSONewID"];
                    dr["App_UserName"] = drInsert[i]["App_UserName"];
                    dr["App_Password"] = drInsert[i]["App_Password"];
                    dr["App_PasswordSrc"] = drInsert[i]["App_PasswordSrc"];
                    dr["App_UserName_CN"] = drInsert[i]["App_UserName_CN"];
                    dr["Chang_Password_Time"] = drInsert[i]["Chang_Password_Time"];
                    dr["Checked"] = drInsert[i]["Checked"];
                    dr["Check_User"] = drInsert[i]["Check_User"];
                    dr["Check_Time"] = drInsert[i]["Check_Time"];
                    dr["Createtime"] = drInsert[i]["Createtime"];
                    dr["Updatetime"] = drInsert[i]["Updatetime"];
                    dtMDMInsert.Rows.Add(dr);
                }

                if (dtMDMDelete.Rows.Count > 0)
                {
                    for (int i = 0; i < dtMDMDelete.Rows.Count; i++)
                    {
                        string strWhere = "App_UserID='" + dtMDMDelete.Rows[i]["App_UserID"] + "'";
                        connMDM.Delete("MDM_System_User", strWhere);
                    }
                }


                if (dtMDMUpdate.Rows.Count > 0)
                {
                    ArrayList listKey = new ArrayList();
                    listKey.Add("App_UserID");
                    connMDM.Update("MDM_System_User", dtMDMUpdate, listKey);
                }

                if (dtMDMInsert.Rows.Count > 0)
                {
                    dtMDMUpdate.Columns.Remove("App_UserID");
                    connMDM.InsertBYSQLBC("MDM_System_User", dtMDMInsert);
                }
                connMDM.CommitTransaction();
                return true;
            }
            catch
            {
                connMDM.RollbackTransaction();
                throw;
            }
        }

    }

}