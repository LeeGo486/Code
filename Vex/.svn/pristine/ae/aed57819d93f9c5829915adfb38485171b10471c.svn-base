using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_Market_User_For_HZY_F22_GetList 
/// 类说明：获取Market的用户信息
/// 创建人：马卫清
/// 创建日期：2012-12-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 获取Market的用户信息
    /// </summary>
    public class MDM_Market_User_For_HZY_F22_GetList : LogicBase, ILogicGetData
    {
        public MDM_Market_User_For_HZY_F22_GetList()
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
                string strSort = " User_Login_Name";
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

                Dbconn conn = new Dbconn("MDM_Market");
                DataSet ds = conn.GetDataSet(@"
                 SELECT * FROM 
                        (
                            SELECT 
                        
		                        ROW_NUMBER()OVER(ORDER BY " + strSort +" " + strOrder + @") AS ROW_NUMBER_INDEX,

                          *
                               
                          FROM (
                                SELECT DISTINCT
                               [User_Login_Name]
                              ,[User_Name]
                              ,[User_Notuse]
                              ,[User_Notuser_Time]
                              ,[User_Create_Time]
     
                          FROM [MDM_Market].[dbo].[MKT_User_CN_For_HZY_F22]
                             WHERE 1=1 " + strWhere + @"
                        ) T2
                               
                        ) t1 
                        WHERE ROW_NUMBER_INDEX >= " + (nPage * nPageRowCount - nPageRowCount +1 ).ToString() + " AND ROW_NUMBER_INDEX<=" + (nPage * nPageRowCount).ToString() + @"
            ");

                DataTable dt = conn.GetDataTable(@" SELECT  
		                        Count(1) as AllRowCount
                                 FROM (                            
                                SELECT DISTINCT
                                [User_Login_Name]
                              ,[User_Name]
                              ,[User_Notuse]
                              ,[User_Notuser_Time]
                              ,[User_Create_Time]
     
                             FROM [MDM_Market].[dbo].[MKT_User_CN_For_HZY_F22]
                             )t1
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