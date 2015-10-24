using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_SSO_UserByAuthorization 
/// 类说明：根据角色名称来获取所有用户
/// 创建人：马卫清
/// 创建日期：2012-12-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_SSO_UserByAuthorization 根据角色名称来获取所有用户
    /// </summary>
    public class MDM_SSO_UserByAuthorization : LogicBase, ILogicGetData
    {
        public MDM_SSO_UserByAuthorization()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据角色名称来获取所有用户,还具备其他的哪些权限
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {

                //这个类为了销售预算管理多加了一些功能,如果有通用的需求,需要重新修改:马卫清,2013-07-24
                string strEnvSN = m_request.Tables[0].Rows[0]["EnvSN"].ToString().Trim();
                string strAuthorizationName = m_request.Tables[0].Rows[0]["AuthorizationName"].ToString().Trim();

                if (strEnvSN == "" || strAuthorizationName == "")
                {
                    throw new Exception("参数不能为空");
                }


                Dbconn conn = new Dbconn("VexSSO");
                DataSet ds = conn.GetDataSet(@"
                        
                        SELECT  t4.VexSSONewID,t4.VexSSOLoginUser
                        INTO #tmp
                        FROM    dbo.MDM_System_User_Authorization t1
                                JOIN dbo.MDM_System_Authorization t2 ON t1.Authorization_ID = t2.Authorization_ID
                                JOIN dbo.MDM_System_Env t3 ON t2.Env_ID = t3.Env_ID
                                JOIN B01_MDM.VEXSSOUser t4 ON t1.VexSSONewID = t4.VexSSONewID 
                        WHERE   Env_SN = @param0
                                AND Authorization_Name = @param1
 
 

                         SELECT DISTINCT #tmp.*,t2.Authorization_Name FROM #tmp
                         LEFT JOIN dbo.MDM_System_User_Authorization t1 ON t1.VexSSONewID=#tmp.VexSSONewID
                         LEFT  JOIN dbo.MDM_System_Authorization t2 ON t1.Authorization_ID = t2.Authorization_ID
                         LEFT JOIN dbo.MDM_System_Env t3 ON t2.Env_ID = t3.Env_ID
                        WHERE   Env_SN =@param0
                                AND Authorization_Name <> @param1
								ORDER BY 2 

                          DROP TABLE #tmp
  
  

                ", new string[2] { strEnvSN, strAuthorizationName });
                return ds;
            }
            catch  
            {
                throw;

            }



        }

    }

}