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
    ///MDM_User_Dept_GetbyUser 通过用户名获取小翅膀的组织机构信息,只取二级部门
    /// </summary>
    public class MDM_User_Dept_GetbyUserName : LogicBase, ILogicGetData
    {
        public MDM_User_Dept_GetbyUserName()
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
						t5.AM_Dept_NAME AM_Company_Name, 
						t4.AM_Dept_NAME ,
                        t4.AM_Dept_NAME AM_Dept_NAME_AllNoCom
						 
                FROM    dbo.AM_User_Dept t1 WITH ( NOLOCK )
						LEFT JOIN dbo.AM_User  t3 WITH ( NOLOCK ) ON t3.AM_User_id = t1.AM_USER_ID
                        LEFT JOIN dbo.AM_Dept t2 WITH ( NOLOCK ) ON t1.am_S_dept_ID = t2.am_S_dept_ID
						LEFT JOIN dbo.AM_Dept t4 WITH(NOLOCK) ON LEFT(t2.OrderIndex,8)=t4.OrderIndex
						LEFT JOIN dbo.AM_Dept t5 WITH(NOLOCK) ON t2.AM_Company=t5.AM_S_Dept_ID
                WHERE   t3.AM_login =@Param0
                AND (t2.AM_Dept_NAME_all LIKE '01%' 
				OR t2.AM_Dept_NAME_all LIKE '02%'
				OR t2.AM_Dept_NAME_all LIKE '03%')
                AND (t2.am_dept1_id IS NULL OR
                t2.AM_Dept_NAME_all LIKE '%室%'
                OR t2.AM_Dept_NAME_all LIKE '%中心%'
                OR t2.AM_Dept_NAME_all LIKE'%部%')
                --AND LEN(t2.OrderIndex)<=8
                
                ", new string[] { strAMUserName });

                ////编辑不包含公司的部门全称
                //for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                //{
                //    string strCom = ds.Tables[0].Rows[i]["AM_Company_Name"].ToString();
                //    string strAM_Dept_NAME_All = ds.Tables[0].Rows[i]["AM_Dept_NAME_All"].ToString();

                //    string strAM_Dept_NAME_AllNoCom = strCom;

                //    if (strAM_Dept_NAME_All.Length > strCom.Length)
                //    {
                //        strAM_Dept_NAME_AllNoCom = strAM_Dept_NAME_All.Remove(0, strCom.Length + 1);
                //    }

                //    if (strAM_Dept_NAME_AllNoCom.IndexOf("\\") > -1)
                //    {
                //        strAM_Dept_NAME_AllNoCom = strAM_Dept_NAME_AllNoCom.Substring(0, strAM_Dept_NAME_AllNoCom.IndexOf("\\"));
                //    }

                //    ds.Tables[0].Rows[i]["AM_Dept_NAME_AllNoCom"] = strAM_Dept_NAME_AllNoCom;
                //}

                return ds;
            }
            catch
            {
                throw;

            }


        }

    }

}