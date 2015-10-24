using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;
using HZY.COM.Common.Base;

namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_User_GetList 获取小翅膀的用户信息
    /// </summary>
    public class MDM_User_GetList : LogicBase, ILogicGetData
    {
        public MDM_User_GetList()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 返回有效的小翅膀用户
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                int nPage = 1;
                int nPageRowCount = 20;
                string strOrder = " asc  ";
                string strSort = " AM_User_ID";
                string strWhere = " ";

                if (m_request != null && m_request.Tables.Contains("Page_Info"))
                {
                    nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                    nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                    strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : " cn_ID asc ";
                    strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : " cn_ID asc ";
                    strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : "";

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
		                        AM_User_id ,
                                AM_LOGIN ,
                                AM_USER_NAME ,
                                AM_PASSWORD ,
                                AM_EMAIL ,
                                AM_TITLE ,
                                AM_HANDSET ,
                                AM_ISDELETE ,
                                CreateTime ,
                                UpdateTime ,
                                Timestamps FROM dbo.AM_User WITH(NOLOCK)
                                WHERE 1=1 AND AM_ISDELETE=0 " + strWhere + @"
                        ) t1 
                        WHERE ROW_NUMBER_INDEX >= " + (nPage * nPageRowCount - nPageRowCount +1 ).ToString() + " AND ROW_NUMBER_INDEX<=" + (nPage * nPageRowCount).ToString() + @"
            ");

                DataTable dt = conn.GetDataTable(@" SELECT  
		                        Count(1) as AllRowCount
                                 FROM dbo.AM_User WITH(NOLOCK)
                                WHERE 1=1 AND AM_ISDELETE=0 " + strWhere + @"", new string[0]);

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