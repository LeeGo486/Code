using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_Property_GetList 
/// 类说明：取到系统属性列表
/// 创建人：马卫清
/// 创建日期：2012-12-03
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Property_GetList 取到系统属性列表
    /// </summary>
    public class MDM_System_Property_GetList : LogicBase, ILogicGetData
    {
        public MDM_System_Property_GetList()
        {
            this.m_SessionCheck = false;

        }

        public DataSet GetData()
        {


            int nPage = 1;
            int nPageRowCount = 10000000;
            string strOrder = " asc  ";
            string strSort = " Property_ID";
            string strWhere = " ";

            if (m_request != null && m_request.Tables.Contains("Page_Info"))
            {
                nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() :  strOrder;
                strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;
            }


            Dbconn conn = new Dbconn("MDM");
            DataSet ds = conn.GetDataSet(@"
                 SELECT   * FROM 
                        (

                        SELECT  
		                        ROW_NUMBER()OVER(ORDER BY " + strSort + " " + strOrder + @") AS ROW_NUMBER_INDEX,
		                                  [Property_ID],
                                        [Property_Name]
                                FROM    [mdm].[dbo].[MDM_System_Property]
                                WHERE 1=1  " + strWhere + @"
                        ) t1 
                        WHERE ROW_NUMBER_INDEX >= " + (nPage * nPageRowCount - nPageRowCount +1 ).ToString() + " AND ROW_NUMBER_INDEX<=" + (nPage * nPageRowCount).ToString() + @"
            ");

            DataTable dt = conn.GetDataTable(@" SELECT  
		                        Count(1) as AllRowCount
                                 FROM dbo.MDM_System_Property WITH(NOLOCK)
                                WHERE 1=1 " + strWhere + @"", new string[0]);

            dt.TableName = "PageRowCount";

            ds.Tables.Add(dt.Copy());
            return ds;


        }

    }

}