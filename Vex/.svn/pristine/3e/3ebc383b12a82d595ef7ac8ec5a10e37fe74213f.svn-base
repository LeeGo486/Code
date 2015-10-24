using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_User_GetByAuthorization
/// 类说明：根据权限获取用户信息
/// 创建人：马卫清
/// 创建日期：2014-03-07
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_User_GetByAppUserName 根据权限获取用户信息
    /// </summary>
    public class MDM_System_User_GetByAuthorization : LogicBase, ILogicGetData
    {
        public MDM_System_User_GetByAuthorization()
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
                string strEnv_SN = "";
                string strAUZ = "";
                
                if (m_request != null && m_request.Tables[0].Rows.Count > 0)
                {
                    if (m_request.Tables[0].Columns.Contains("Env_SN"))
                    {
                        strEnv_SN = m_request.Tables[0].Rows[0]["Env_SN"].ToString();
                    }

                    if (m_request.Tables[0].Columns.Contains("AUZ"))
                    {
                        strAUZ = m_request.Tables[0].Rows[0]["AUZ"].ToString();
                        if (strAUZ != "")
                        {
                            strAUZ = "'" + strAUZ.Replace("'", "''");
                        }
                    }
                }

                if (strAUZ == "")
                {
                    throw new Exception("请输入权限名");
                }

                if (strEnv_SN == "")
                {
                    throw new Exception("请输入环境简称");
                }

                Dbconn conn = new Dbconn("MDM");

                string strSQL = @"
                        SELECT  App_UserID ,
                                t1.Env_ID ,
                                SSOEmployee_ID ,
                                App_UserName ,
                                App_Password ,
                                App_UserName_CN ,
                                Chang_Password_Time ,
                                Checked ,
                                Check_User ,
                                Check_Time
                        FROM    dbo.MDM_System_User t1
                                JOIN dbo.MDM_System_Env t4 ON t1.Env_ID = t4.Env_ID
                        WHERE   t4.Env_SN = @param0
                                AND t1.Checked=1
 
                ";
                string[] listAUZ = strAUZ.Split(',');
                for (int i = 0; i < listAUZ.Length; i++)
                {
                    if (listAUZ[i] != "")
                    {
                        strSQL += @"
                                AND EXISTS ( SELECT 1
                                                FROM   dbo.MDM_System_Authorization t3
                                                    JOIN dbo.MDM_System_User_Authorization t2 ON t1.App_UserID = t2.App_UserID
                                                WHERE  t2.Authorization_ID = t3.Authorization_ID
                                                    AND Authorization_Name = '"+listAUZ[i]+@"' )
                                ";


                    }
                }

                DataSet ds = conn.GetDataSet(strSQL, new string[1] { strEnv_SN });

                return ds;
            }
            catch
            {
                throw;

            }



        }

    }

}