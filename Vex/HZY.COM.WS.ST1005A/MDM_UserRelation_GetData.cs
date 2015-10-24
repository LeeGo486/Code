using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_UserRelation_GetData 取到系统账户信息
    /// </summary>
    public class MDM_UserRelation_GetData : LogicBase, ILogicGetData
    {
        public MDM_UserRelation_GetData()
        {
            this.m_SessionCheck = false;

        }


        public DataSet GetData()
        {
            try
            {
                if (m_request == null || m_request.Tables.Count == 0 || m_request.Tables[0].Rows.Count == 0)
                {
                    return null;
                }

                string str_User_id = m_request.Tables[0].Rows[0][0].ToString();
                string[] strParam = new string[1];
                strParam[0] = str_User_id;
                Dbconn conn = new Dbconn("MDM");
                DataSet ds = conn.GetDataSet(
                    @"   SELECT System_id ,
                            System_name ,
                            t1.AM_User_ID ,
                            t3.AM_Dept_Name Company ,
                            SYSTEM_USER_id ,
                            SYSTEM_USER_name ,
                            CASE t1.Create_AM_USER_ID
                              WHEN 0 THEN '系统自动'
                              ELSE t2.am_login
                            END AS Createdor
                     FROM   [dbo].[SSO_System_Relation] t1 WITH ( NOLOCK )
                            LEFT JOIN dbo.AM_User t2 WITH ( NOLOCK ) ON t1.Create_AM_USER_ID = t2.AM_User_ID
                            LEFT JOIN dbo.AM_Dept t3 WITH ( NOLOCK ) ON t1.company_id = t3.AM_S_Dept_ID
                    WHERE t1.am_User_id = @param0
 	                    ", strParam);



                return ds;

            }
            catch
            {
                throw;
            }
        }

    }

}