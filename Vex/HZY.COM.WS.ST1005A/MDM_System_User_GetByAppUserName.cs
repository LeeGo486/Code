using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_User_GetByAppUserName
/// 类说明：通过用户ID获取用户信息
/// 创建人：马卫清
/// 创建日期：2014-02-25
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_User_GetByAppUserName 通过用户ID获取用户信息
    /// </summary>
    public class MDM_System_User_GetByAppUserName : LogicBase, ILogicGetData
    {
        public MDM_System_User_GetByAppUserName()
        {
            this.m_SessionCheck = false; 
        }

        /// <summary>
        /// 获取系统用户信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strEnv_SN = "";
                string strApp_UserName = "";
                if (m_request != null && m_request.Tables[0].Rows.Count > 0)
                {
                    if (m_request.Tables[0].Columns.Contains("Env_SN"))
                    {
                        strEnv_SN = m_request.Tables[0].Rows[0]["Env_SN"].ToString();
                    }

                    if (m_request.Tables[0].Columns.Contains("App_UserName"))
                    {
                        strApp_UserName = m_request.Tables[0].Rows[0]["App_UserName"].ToString();
                        if (strApp_UserName != "")
                        {
                            strApp_UserName = "'" + strApp_UserName.Replace("'", "''").Replace(",", "','") + "'";
                        }
                    }
                }

                if (strApp_UserName == "")
                {
                    throw new Exception("请输入用户名");
                }

                if (strEnv_SN == "")
                {
                    throw new Exception("请输入环境简称");
                }

                Dbconn conn = new Dbconn("VexSSO");
                DataSet ds = conn.GetDataSet(@"
                 SELECT 
	                  [App_UserID]
                      ,[App_UserName]
                      ,[App_UserName_CN]
                      ,[Chang_Password_Time]
                  FROM [dbo].[MDM_System_User]  with(nolock)
                  WHERE App_UserName in (" + strApp_UserName + @")
                  AND EXISTS(SELECT 1 FROM dbo.MDM_System_Env with(nolock)
                      WHERE Env_SN=@Param0
                      AND MDM_System_User.Env_ID=MDM_System_Env.Env_ID
                      )
                    ", new string[1] { strEnv_SN });

                return ds;
            }
            catch
            {
                throw;

            }



        }

    }

}