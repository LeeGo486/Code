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
    ///MDM_User_Dept_GetbyUser 通过用户ID获取用户现有的组织架构的信息
    /// </summary>
    public class MDM_User_Dept_GetbyUser : LogicBase, ILogicGetData
    {
        public MDM_User_Dept_GetbyUser()
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

                string strUser_id = m_request.Tables[0].Rows[0]["user_id"].ToString();

                Dbconn conn = new Dbconn("MDM");
                DataSet ds = conn.GetDataSet(@"
                SELECT  
                        t1.AM_S_dept_ID ,
                        t2.AM_Dept_NAME ,
                        t2.AM_Dept_NAME_all
                FROM    dbo.AM_User_Dept t1 WITH ( NOLOCK )
                        LEFT JOIN dbo.AM_Dept t2 WITH ( NOLOCK ) ON t1.am_S_dept_ID = t2.am_S_dept_ID
                WHERE   t1.AM_User_ID = "+strUser_id+@"
");
                return ds;
            }
            catch 
            {
                throw ;

            }
           

        }

    }

}