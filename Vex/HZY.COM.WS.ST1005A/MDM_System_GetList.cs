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
    ///MDM_System_GetData 取到系统
    /// </summary>
    public class MDM_System_GetList : LogicBase, ILogicGetData
    {
        public MDM_System_GetList()
        {
            this.m_SessionCheck = false;

        }

        public DataSet GetData()
        {


            int nPage = 1;
            int nPageRowCount = 1000000;
            string strOrder = " DESC  ";
            string strSort = " System_ID";
            string strWhere = " ";

            if (m_request != null && m_request.Tables.Contains("Page_Info"))
            {
                nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;

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
		                        ROW_NUMBER()OVER(ORDER BY " + strSort + " " + strOrder + @") AS ROW_NUMBER_INDEX,
		                                  [System_ID],
                                        [System_Code],
                                        [System_Name],
                                        [System_SN]
                                FROM    [mdm].[dbo].[MDM_System]
                                WHERE 1=1  " + strWhere + @"
                        ) t1 
                        WHERE ROW_NUMBER_INDEX >= " + (nPage * nPageRowCount - nPageRowCount +1 ).ToString() + " AND ROW_NUMBER_INDEX<=" + (nPage * nPageRowCount).ToString() + @"
            ");

            DataTable dt = conn.GetDataTable(@" SELECT  
		                        Count(1) as AllRowCount
                                 FROM dbo.MDM_System WITH(NOLOCK)
                                WHERE 1=1 " + strWhere + @"", new string[0]);

            dt.TableName = "PageRowCount";

            ds.Tables.Add(dt.Copy());
            return ds;


        }

    }

}