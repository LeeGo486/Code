using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_Auz_Exd_GetListIDBySessionID 
/// 类说明：根据SessionID获取用户权限的扩展信息
/// 创建人：马卫清
/// 创建日期：2013-07-22
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Auz_Exd_GetListIDBySessionID 根据SessionID获取用户权限的扩展信息
    /// </summary>
    public class MDM_System_Auz_Exd_GetListIDBySessionID : LogicBase, ILogicGetData
    {
        public MDM_System_Auz_Exd_GetListIDBySessionID()
        {
            this.m_SessionCheck = true;

        }

        /// <summary>
        /// 根据SessionID获取用户权限的扩展信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {

                string strVexSSONewID = hzyMessage.VexSSONewID;
                string strApp_UserID = hzyMessage.User_ID;
                string strEnv_ID = hzyMessage.Env_ID;

                if (string.IsNullOrEmpty(strVexSSONewID))
                {
                    strVexSSONewID = "";
                }
                if (strApp_UserID == "0" || strApp_UserID == "")
                {
                    strApp_UserID = "-1";
                }

                string strAuthorization_Type = "";
                if (m_request.Tables[0].Columns.Contains("Authorization_Type"))
                {
                    strAuthorization_Type = m_request.Tables[0].Rows[0]["Authorization_Type"].ToString().Trim();
                }

                Dbconn conn = new Dbconn("MDM");

                string strSQL = @"
                        SELECT  t1.Autiorization_Exd_ID ,
                                t1.Authorization_ID ,
                                t1.Authorization_Type ,
                                t1.Authorization_Value ,
                                t1.Authorization_Content ,
                                t1.CreateTime ,
                                t1.UpdateTime ,
                                t1.Timestamps ,
                                t2.Authorization_Name
                        FROM    dbo.MDM_System_Authorization_Exd t1 WITH ( NOLOCK )
                                LEFT JOIN dbo.MDM_System_Authorization t2 WITH ( NOLOCK ) ON t1.Authorization_ID = t2.Authorization_ID
                                LEFT JOIN dbo.MDM_System_User_Authorization t3 WITH ( NOLOCK ) ON t1.Authorization_ID = t3.Authorization_ID
                                LEFT JOIN dbo.MDM_System_User t4 WITH ( NOLOCK ) ON t3.App_UserID = t4.App_UserID
                                
                        WHERE   ( t4.App_UserID = @Param0
                                    OR t3.VexSSONewID = @Param1
                                )
                                AND t2.Env_ID = @Param2
                ";

                DataSet ds = null;
                if (strAuthorization_Type != "")
                {
                    strSQL += " AND Authorization_Name=@Param3 ";
                    ds = conn.GetDataSet(strSQL, new string[4] { strApp_UserID, strVexSSONewID, strEnv_ID, strAuthorization_Type });
                }
                else
                {
                    ds = conn.GetDataSet(strSQL, new string[3] { strApp_UserID, strVexSSONewID, strEnv_ID });
                }
                return ds;

            }
            catch  
            {
                throw;

            }



        }

    }

}