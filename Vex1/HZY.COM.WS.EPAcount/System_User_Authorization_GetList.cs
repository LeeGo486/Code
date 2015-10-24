using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：System_User_Authorization_GetList
/// 类说明：根据环境编号和用户编号信息取到系统用户权限 
/// 创建人：郭琦琦 
/// 创建日期：2014-02-19  
/// 修改人：郭琦琦
/// 修改日期：2014-02-20
namespace HZY.COM.WS.EPAcount
{
    class System_User_Authorization_GetList : LogicBase, ILogicGetData
    {
        public System_User_Authorization_GetList()
        {
            this.m_SessionCheck = false;
        }

        private Dbconn conn = new Dbconn("VexSSO");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                DataTable dt_LIST = ds.Tables["LIST"];

                for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
                {
                    #region GET
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                    {

                        string strEnv_ID = dt_LIST.Rows[0]["Env_ID"].ToString();
                        string strVexSSONewID = dt_LIST.Rows[0]["VexSSONewID"].ToString();
                        string strApp_UserID = dt_LIST.Rows[0]["app_userid"].ToString();

                        if (string.IsNullOrEmpty(strVexSSONewID))
                        {
                            strVexSSONewID = "00000000-0000-0000-0000-000000000000";
                        }
                        if (strApp_UserID == "0")
                        {
                            strApp_UserID = "-1";
                        }

                        string strSQL = @"
                
                                        SELECT  DISTINCT
                                                t1.Authorization_ID ,
                                                t1.Authorization_Name ,
                                                0 AS Authorization_ID_F,
                                                ISNULL(HavaFlag, 0) HavaFlag 
                                        FROM    dbo.MDM_System_Authorization t1 WITH ( NOLOCK )
                                                LEFT JOIN dbo.MDM_System_User_Authorization t2 WITH ( NOLOCK ) ON t1.Authorization_ID = t2.Authorization_ID
                                                                                                      AND (VexSSONewID =@param0 OR App_UserID = @param1)
                                        WHERE   Env_ID = @param2

                                    ";

                        ds_Return = conn.GetDataSet(strSQL, new string[3] { strVexSSONewID, strApp_UserID, strEnv_ID });
                    }
                    #endregion GET
                    
                    #region UPDATE
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE")
                    {
                        bool bResult = false;
                        conn.BeginTransaction();
                        DataTable dt_list = ds.Tables["List"];

                        string strVexSSONewID = dt_list.Rows[0]["form_AuthorizationSubmit_VexSSONewID"].ToString();
                        string strAuthorizationList = dt_list.Rows[0]["form_AuthorizationSubmit_AUZlist"].ToString();
                        string strApp_UserID = dt_list.Rows[0]["form_AuthorizationSubmit_App_UserID"].ToString();
                        string strEnv_ID = dt_list.Rows[0]["Env_ID"].ToString();
                        string[] strAuthorization_ID = strAuthorizationList.Split(',');

                        if (strApp_UserID == "")
                        {
                            strApp_UserID = "0";
                        }

                        if (strApp_UserID == "0" && string.IsNullOrEmpty(strVexSSONewID))
                        {
                            throw new Exception("传入的信息不足");
                        }

                       
                        DataTable dt_Data = new DataTable();
                        dt_Data.Columns.Add("Authorization_ID");
                        dt_Data.Columns.Add("App_UserID");
                        dt_Data.Columns.Add("VexSSONewID");
                        dt_Data.Columns.Add("HavaFlag");
                        dt_Data.Columns.Add("Createtime");
                        dt_Data.Columns.Add("Updatetime");
                        DateTime timeNow = DateTime.Now;

                        foreach (string str in strAuthorization_ID)
                        {
                            if (str != "")
                            {
                                if (strVexSSONewID == "")
                                {
                                    dt_Data.Rows.Add(new object[] { str, strApp_UserID, DBNull.Value, "1", timeNow, timeNow });
                                }
                                else
                                {
                                    dt_Data.Rows.Add(new object[] { str, strApp_UserID, strVexSSONewID, "1", timeNow, timeNow });
                                }
                            }
                        }

                        if (strApp_UserID == "0")
                        {
                            strApp_UserID = "-1";
                        }
                        if (string.IsNullOrEmpty(strVexSSONewID))
                        {
                            strVexSSONewID = "00000000-0000-0000-0000-000000000000";
                        }


                        string strWhere = " (App_UserID=" + "'" + strApp_UserID + "'" + " OR VexSSONewID='" + strVexSSONewID + @"') AND 
                                                EXISTS (
                                SELECT * FROM dbo.MDM_System_Authorization
                                WHERE Env_ID=" + strEnv_ID + @"
                                AND MDM_System_User_Authorization.Authorization_ID=dbo.MDM_System_Authorization.Authorization_ID
                                )";
                        //删除人员权限
                        bResult = conn.Delete("MDM_System_User_Authorization", strWhere);
                        //增加人员权限
                        bResult = conn.Insert("MDM_System_User_Authorization", dt_Data);
                        conn.CommitTransaction();
                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "提交失败" });
                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                }
#endregion
                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
    }
}

