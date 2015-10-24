﻿using System;
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
    ///MDM_System_Env_GetList 获取系统环境信息
    /// </summary>
    public class MDM_SysEnv_GetList : LogicBase, ILogicGetData
    {
        public MDM_SysEnv_GetList()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 获取系统环境信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                int nPage = 1;
                int nPageRowCount = 20;
                string strOrder = " desc  ";
                string strSort = " Env_ID";
                string strWhere = " ";

                if (m_request != null && m_request.Tables.Contains("Page_Info"))
                {
                    nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                    nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                    strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                    strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                    strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() :  strWhere;

                    if (strWhere.Trim() != "")
                    {
                        strWhere = " AND " + strWhere;
                    }
                }

                Dbconn conn = new Dbconn("MDM");
                DataSet ds = conn.GetDataSet(@"
                 SELECT * FROM 
                        (

                        SELECT  
		                        ROW_NUMBER()OVER(ORDER BY " + strSort +" " + strOrder + @") AS ROW_NUMBER_INDEX,
		                        t1.[Env_ID]
                                ,t1.[Company_ID]
                                ,t2.Company_Name
                                ,t1.[System_ID]
                                ,t3.[System_Name]
                                ,t3.[System_SN]
                                ,t1.[Env_SN]
                                ,t1.[Env_Name]
                                ,t1.[SSO_Login_URL]
                                ,t1.[Login_URL]
                                ,t1.[Createtime]
                                ,t1.[Updatetime]
                                ,Convert(bigint,t1.[Timestamps]) Timestamps
                                FROM [MDM].[dbo].[MDM_System_Env] t1 WITH(NOLOCK)
                                LEFT JOIN mdm.dbo.MDM_Company t2 WITH(NOLOCK) ON t1.company_id=t2.Company_ID
                                LEFT JOIN mdm.dbo.MDM_System t3 WITH(NOLOCK) ON t1.System_ID=t3.System_ID

                                WHERE 1=1 " + strWhere + @"
                        ) t1 
                        WHERE ROW_NUMBER_INDEX >= " + (nPage * nPageRowCount - nPageRowCount +1 ).ToString() + " AND ROW_NUMBER_INDEX<=" + (nPage * nPageRowCount).ToString() + @"
            ");

                DataTable dt = conn.GetDataTable(@" SELECT  
		                        Count(1) as AllRowCount
                                  FROM [MDM].[dbo].[MDM_System_Env] t1 WITH(NOLOCK)
                                LEFT JOIN mdm.dbo.MDM_Company t2 WITH(NOLOCK) ON t1.company_id=t2.Company_ID
                                LEFT JOIN mdm.dbo.MDM_System t3 WITH(NOLOCK) ON t1.System_ID=t3.System_ID
                                WHERE 1=1 " + strWhere + @"", new string[0]);

                dt.TableName = "PageRowCount";

                ds.Tables.Add(dt.Copy());

                return ds;
            }
            catch  
            {
                throw;

            }



        }

    }

}