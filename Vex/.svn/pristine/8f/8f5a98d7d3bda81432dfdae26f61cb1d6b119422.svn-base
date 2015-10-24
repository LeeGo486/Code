using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_Employees_AppUser_Link_GetList 
/// 类说明：获取MDM人员与各系统的关联信息
/// 创建人：马卫清
/// 创建日期：2013-03-13
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_Employees_GetList 获取MDM人员信息
    /// </summary>
    public class MDM_Employees_AppUser_Link_GetList : LogicBase, ILogicGetData
    {
        public MDM_Employees_AppUser_Link_GetList()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 获取MDM人员信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                int nPage = 1;
                int nPageRowCount = 20;
                string strOrder = " desc  ";
                string strSort = " [Employee_ID]";
                string strWhere = " ";
                string strEnv_ID = "0";

                if (m_request != null && m_request.Tables.Contains("Page_Info"))
                {
                    nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                    nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                    strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                    strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                    strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;
                    strEnv_ID = m_request.Tables[0].Rows[0]["Env_ID"].ToString();

                    if (strWhere.Trim() != "")
                    {
                        strWhere = " AND " + strWhere;
                    }
                }



                Dbconn conn = new Dbconn("MDM");
                DataSet ds = conn.GetDataSet(@"

                 SELECT  App_UserID ,
                         Env_ID ,
                         SSOEmployee_ID ,
                         App_UserName,App_UserName_CN  
       
                 INTO   #tmp1
                 FROM   MDM_System_User
                 WHERE  ENV_ID =" + strEnv_ID + @" AND Checked=1

                 SELECT * FROM 
                        (

                        SELECT  
		                        ROW_NUMBER()OVER(ORDER BY " + strSort +" " + strOrder + @") AS ROW_NUMBER_INDEX,
		                       [MDM_Employees].[Employee_ID]
                              ,[Name]
                              ,[SSO_UserName]
                              ,App_UserID
                              ,App_UserName
                              ,App_UserName_CN
                          FROM [MDM].[dbo].[MDM_Employees]  
                          FULL JOIN #tmp1 ON SSOEmployee_ID=MDM_Employees.Employee_ID
                          WHERE ISNULL(Leave_Flag,0)=0  " + strWhere + @"
                        ) t1 
                        WHERE ROW_NUMBER_INDEX >= " + (nPage * nPageRowCount - nPageRowCount +1 ).ToString() + " AND ROW_NUMBER_INDEX<=" + (nPage * nPageRowCount).ToString() + @"
            ");

                DataTable dt = conn.GetDataTable(@" 
                        SELECT  App_UserID ,
                         Env_ID ,
                         SSOEmployee_ID ,
                         App_UserName,App_UserName_CN  
       
                 INTO   #tmp1
                 FROM   MDM_System_User
                 WHERE  ENV_ID =" + strEnv_ID + @" AND Checked=1
                           

                          SELECT  
		                       Count(1) as AllRowCount
                          FROM [MDM].[dbo].[MDM_Employees]   
                          FULL JOIN #tmp1 ON SSOEmployee_ID=MDM_Employees.Employee_ID
                          WHERE ISNULL(Leave_Flag,0)=0  " + strWhere + @"", new string[0]);

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