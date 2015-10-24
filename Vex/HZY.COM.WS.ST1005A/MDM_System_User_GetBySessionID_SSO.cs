using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_User_GetBySessionID_SSO
/// 类说明：通过Session_ID获取系统用户信息--使用SSO单点登录
/// 创建人：马卫清
/// 创建日期：2013-06-28
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_User_GetBySessionID_SSO 通过Session_ID获取系统用户信息--使用SSO单点登录
    /// </summary>
    public class MDM_System_User_GetBySessionID_SSO : LogicBase, ILogicGetData
    {
        public MDM_System_User_GetBySessionID_SSO()
        {
            this.m_SessionCheck = true;

        }

        /// <summary>
        /// 获取系统用户信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strVexSSONewID = m_hzyMessage.VexSSONewID;
                string strEnv_ID = m_hzyMessage.Env_ID;

                if (m_request != null
                    && m_request.Tables.Count > 0
                    && m_request.Tables[0].Rows.Count > 0
                    && m_request.Tables[0].Columns.Contains("EnvID"))
                {
                    strEnv_ID = m_request.Tables[0].Rows[0]["EnvID"].ToString();
                }

                Dbconn conn = new Dbconn("VexSSO");
                DataSet ds = conn.GetDataSet(@"
                 SELECT 
	                  [App_UserID]
                      ,[App_UserName]
                      ,[App_UserName_CN]
                      ,[Chang_Password_Time]
                  FROM [MDM_System_User]  
                  WHERE VexSSONewID=@param0
                  AND Env_ID=@param1
                    ", new string[2] { strVexSSONewID, strEnv_ID });

                return ds;
            }
            catch  
            {
                throw;

            }



        }

    }

}