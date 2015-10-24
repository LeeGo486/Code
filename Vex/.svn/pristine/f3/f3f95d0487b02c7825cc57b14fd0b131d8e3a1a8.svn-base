using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_User_GetBySessionID
/// 类说明：通过Session_ID获取系统用户信息--使用系统登录
/// 创建人：马卫清
/// 创建日期：2013-04-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_User_GetBySessionID 通过Session_ID获取系统用户信息--使用系统登录
    /// </summary>
    public class MDM_System_User_GetBySessionID : LogicBase, ILogicGetData
    {
        public MDM_System_User_GetBySessionID()
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
                string strUser_ID = m_hzyMessage.User_ID;

                Dbconn conn = new Dbconn("VexSSO");
                DataSet ds = conn.GetDataSet(@"
                 SELECT 
	                  [App_UserID]
                      ,[App_UserName]
                      ,[App_UserName_CN]
                      ,[Chang_Password_Time]
                  FROM [dbo].[MDM_System_User]  
                  WHERE App_UserID=@param0
                    ", new string[1]{strUser_ID});

                return ds;
            }
            catch  
            {
                throw;

            }



        }

    }

}