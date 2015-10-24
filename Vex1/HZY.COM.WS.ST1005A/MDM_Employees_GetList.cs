using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_Employees_GetList 
/// 类说明：获取MDM人员信息
/// 创建人：马卫清
/// 创建日期：2012-12-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_Employees_GetList 获取MDM人员信息
    /// </summary>
    public class MDM_Employees_GetList : LogicBase, ILogicGetData
    {
        public MDM_Employees_GetList()
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
                string strSort = " Employee_ID";
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
		                       [Employee_ID]
                              ,[Name]
                              ,[Sex]
                              ,[Phone]
                              ,[Moblie]
                              ,[SSO_UserName]
                             -- ,[SSO_Password]
                              ,[In_Time]
                              ,[Leave_Time]
                              ,[Leave_Flag]
                              ,[Createtime]
                              ,[Updatetime]
                              ,[Timestamps]
                          FROM [MDM].[dbo].[MDM_Employees]

                                WHERE Leave_Flag=0 " + strWhere + @"
                        ) t1 
                        WHERE ROW_NUMBER_INDEX >= " + (nPage * nPageRowCount - nPageRowCount +1 ).ToString() + " AND ROW_NUMBER_INDEX<=" + (nPage * nPageRowCount).ToString() + @"
            ");

                DataTable dt = conn.GetDataTable(@" SELECT  
		                        Count(1) as AllRowCount
                                 FROM [MDM].[dbo].[MDM_Employees] WITH(NOLOCK)
                                WHERE Leave_Flag=0 " + strWhere + @"", new string[0]);

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