using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_User_Authorization_GetList 
/// 类说明：根据环境编号和用户编号信息取到系统用户权限对应表
/// 创建人：马卫清
/// 创建日期：2012-12-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_User_Authorization_GetList 根据环境编号和用户编号信息取到系统用户权限对应表
    /// </summary>
    public class MDM_System_User_Authorization_GetList : LogicBase, ILogicGetData
    {
        public MDM_System_User_Authorization_GetList()
        {
            this.m_SessionCheck = false;

        }

        public DataSet GetData()
        {

            string strEnv_ID = m_request.Tables[0].Rows[0]["Env_ID"].ToString();
            string strEmployee_ID = m_request.Tables[0].Rows[0]["Employee_ID"].ToString();
            string strApp_UserID = m_request.Tables[0].Rows[0]["App_UserID"].ToString();

            if (strEmployee_ID == "0")
            {
                strEmployee_ID = "-1";
            }
            if (strApp_UserID == "0")
            {
                strApp_UserID = "-1";
            }

            Dbconn conn = new Dbconn("MDM");
            string strSQL = @"
                
                SELECT  DISTINCT
                        t1.Authorization_ID ,
                        t1.Authorization_Name ,
                        ISNULL(HavaFlag, 0) HavaFlag ,
                        0 AS Authorization_ID_F
                FROM    dbo.MDM_System_Authorization t1 WITH ( NOLOCK )
                        LEFT JOIN dbo.MDM_System_User_Authorization t2 WITH ( NOLOCK ) ON t1.Authorization_ID = t2.Authorization_ID
                                                                              AND (Employee_ID =@param0 OR App_UserID = @param1)
                WHERE   Env_ID = @param2

            ";

            DataSet ds = conn.GetDataSet(strSQL, new string[3] { strEmployee_ID, strApp_UserID, strEnv_ID });

            return ds;

        }

    }

}