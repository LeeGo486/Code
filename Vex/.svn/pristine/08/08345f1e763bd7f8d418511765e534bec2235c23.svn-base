using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_User_Authorization_GetListBySession_ID 
/// 类说明：根据用户登录信息取到权限信息
/// 创建人：马卫清
/// 创建日期：2012-12-25
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_User_Authorization_GetListBySession_ID 根据用户登录信息取到权限信息
    /// </summary>
    public class MDM_System_User_Authorization_GetListBySession_ID : LogicBase, ILogicGetData
    {

        public MDM_System_User_Authorization_GetListBySession_ID()
        {
            this.m_SessionCheck = true;

        }

        public DataSet GetData()
        {

            string strVexSSONewID = m_hzyMessage.VexSSONewID;
            string strApp_UserID = m_hzyMessage.User_ID;
            string strEnv_ID = m_hzyMessage.Env_ID;

            if (string.IsNullOrEmpty(strVexSSONewID))
            {
                strVexSSONewID = "00000000-0000-0000-0000-000000000000";
            }
            if (strApp_UserID == "0")
            {
                strApp_UserID = "-1";
            }

            Dbconn conn = new Dbconn("VexSSO");
            string strSQL = @"
                SELECT  t1.Authorization_ID ,
                        t1.Authorization_Name  
                FROM    dbo.MDM_System_Authorization t1 WITH ( NOLOCK )
                        JOIN dbo.MDM_System_User_Authorization t2 WITH ( NOLOCK ) ON t1.Authorization_ID = t2.Authorization_ID
                                                              
                WHERE   Env_ID = @param1
		                AND (VexSSONewID = @param0 OR App_UserID=@param2)
		                AND ISNULL(HavaFlag, 0)=1
            ";

            DataSet ds = conn.GetDataSet(strSQL, new string[3] { strVexSSONewID, strEnv_ID ,strApp_UserID});
            return ds;

        }
        
    }

}