using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_User_ChangPassword 
/// 类说明：修改App用户密码
/// 创建人：马卫清
/// 创建日期：2013-03-14
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_User_ChangPassword 修改App用户密码
    /// </summary>
    public class MDM_System_User_ChangPassword : LogicBase, ILogicExecute
    {
        public MDM_System_User_ChangPassword()
        {
            this.m_SessionCheck = false;
        }

        /// <summary>
        /// 修改App用户密码
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM");

            try
            {
                string strEvn_SN = m_request.Tables[0].Rows[0]["Evn_SN"].ToString();
                string strUserName = m_request.Tables[0].Rows[0]["UserName"].ToString();
                string strPassWord = m_request.Tables[0].Rows[0]["PassWord"].ToString();
                string strNewPassWord = m_request.Tables[0].Rows[0]["PassWord"].ToString();

                strPassWord = COM.Common.Common.GetMD5(strPassWord);
                strNewPassWord = COM.Common.Common.GetMD5(strNewPassWord);

                string[] strParam = new string[3];
                strParam[0] = strUserName.Trim();
                strParam[1] = strPassWord;
                strParam[2] = strEvn_SN;

                DataTable dt = conn.GetDataTable(@"
                       SELECT t1.[App_UserID]
                          ,t1.[SSOEmployee_ID] Employee_ID
                          ,t1.[App_UserName]
                          ,t2.Env_ID
                          ,t2.Env_SN
				          ,t3.Company_ID
				          ,t3.Company_sn
                      FROM [MDM].[dbo].[MDM_System_User] T1 WITH(NOLOCK)
                      LEFT JOIN MDM.DBO.MDM_System_Env T2 WITH(NOLOCK) ON T1.Env_ID=t2.Env_ID
                      JOIN mdm.dbo.MDM_Company t3 WITH ( NOLOCK ) ON t3.Company_ID = t2.Company_ID
                      WHERE T2.Env_SN=@param2
                      AND t1.[App_UserName]=@param0
                      AND t1.[App_Password]=@param1
                        ", strParam);

                if (dt.Rows.Count == 0)
                {
                    throw new Exception("旧密码有误");
                }

                string strApp_UserID = dt.Rows[0]["App_UserID"].ToString();
                conn.Excute("UPDATA MDM_System_User SET App_Password='"+strNewPassWord+"' ,Chang_Password_Time=getdate() WHERE App_UserID='" + strApp_UserID + "'");
                
                return true;
            }
            catch
            {
                
                throw;
            }



        }

    }

}