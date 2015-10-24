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
    ///MDM_User_Com_GetbyUserName 通过用户名获取小翅膀的公司信息
    /// </summary>
    public class MDM_User_Com_GetbyUserName : LogicBase, ILogicGetData
    {
        public MDM_User_Com_GetbyUserName()
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

                string strAMUserName = m_request.Tables[0].Rows[0]["AMUserName"].ToString();

                Dbconn conn = new Dbconn("MDM");
                DataSet ds = conn.GetDataSet(@"
                SELECT DISTINCT t4.AM_Company,
						t4.AM_Dept_NAME AM_Company_Name,t2.OrderIndex
                FROM    dbo.AM_User_Dept t1 WITH ( NOLOCK )
						LEFT JOIN dbo.AM_User  t3 WITH ( NOLOCK ) ON t3.AM_User_id = t1.AM_USER_ID
                        LEFT JOIN dbo.AM_Dept t2 WITH ( NOLOCK ) ON t1.am_S_dept_ID = t2.am_S_dept_ID
						LEFT JOIN dbo.AM_Dept t4 WITH(NOLOCK) ON t2.AM_Company=t4.AM_S_Dept_ID
                WHERE   t3.AM_login =@param0
                AND (t2.AM_Dept_NAME_all LIKE '01%' 
				OR t2.AM_Dept_NAME_all LIKE '02%'
				OR t2.AM_Dept_NAME_all LIKE '03%')
                AND (t2.am_dept1_id IS NULL OR
                t2.AM_Dept_NAME_all LIKE '%室%'
                OR t2.AM_Dept_NAME_all LIKE '%中心%'
                OR t2.AM_Dept_NAME_all LIKE'%部%')
                ORDER BY t2.OrderIndex

                ", new string[] { strAMUserName });
                return ds;
            }
            catch
            {
                throw;

            }


        }

    }

}