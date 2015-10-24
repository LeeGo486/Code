using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.WSRR
{
    /// <summary>
    ///WS_GetList 获取WSRR的基本信息
    /// </summary>
    public class WS_GetList : LogicBase, ILogicGetData
    {
        public WS_GetList()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 获取WSRR的基本信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                int nPage = 1;
                int nPageRowCount = 20;
                string strOrder = " desc  ";
                string strSort = " WS_Name ";
                string strWhere = " 1=1 ";
                string strSearchFilter=" ";

                if (m_request != null && m_request.Tables.Contains("Page_Info"))
                {
                    nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                    nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                    strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                    strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                    strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;

                    if (m_request.Tables[0].Columns.Contains("searchFilter"))
                    {
                        strSearchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : strSearchFilter;
                      }
                    if (strWhere.Trim() != "")
                    {
                        strWhere = " AND " + strWhere;
                    }

                    if (strSearchFilter.Trim() != "")
                    {
                        strWhere = " AND " + strSearchFilter;
                    }
                }

                Dbconn conn = new Dbconn("WSRR");
                DataSet ds = conn.GetDataSet(@"
                
                   WITH    cte ( Class_ID, P_Class_ID, Class_Name, Class_Name_all ,ClassIndex)
                              AS ( SELECT   Class_ID ,
                                            P_Class_ID ,
                        
                                            CONVERT(VARCHAR(200), Class_Name) ,
                                            CONVERT(VARCHAR(200), Class_Name),
                                            CONVERT(VARCHAR(200),Rowindex)
                                   FROM     ws_Class
                                   WHERE    1 = 1
                                            AND P_Class_ID = 0
                                   UNION ALL
                                   SELECT   t1.Class_ID ,
                                            t1.P_Class_ID ,
                                            CONVERT(VARCHAR(200), t1.Class_Name) ,
                                            CONVERT(VARCHAR(200), t2.Class_Name_all + '\'
                                            + t1.Class_Name) AS CN_GROUP_NAME,
                        
                                            CONVERT(VARCHAR(200), t2.ClassIndex + '\'
                                            + t1.Rowindex) AS ClassIndex
                                   FROM     ws_Class t1 WITH ( NOLOCK )
                                            INNER JOIN cte AS t2 ON t1.P_Class_ID = t2.Class_ID
                                 )
                        SELECT  *
                        INTO    #Tmp2
                        FROM    cte ;
    
    
                    SELECT 
                            ws_id,
                            WS_Name ,
                            WS_Type ,
                            WS_Help ,
                            WS_State ,
                            WS_Host_PROD ,
                            WS_Host_Test ,
                            WS_URL ,
                            WS_Vision ,
                            WS_Method ,
                            CASE ISNULL(Need_Login, 0)
                              WHEN 1 THEN '必须'
                              ELSE ''
                            END AS need_login ,
                            Class_ID ,
                            WS_Unicode ,
                            isnull(need_login,0) as need_loginint,
                            Create_User ,
                            Create_Time ,
                            Update_User ,
                            Update_Time
                    INTO    #tmp1
                    FROM    WS WITH ( NOLOCK ) ;
                    

                    select * from (SELECT  Class_Name_all ,ClassIndex,ROW_NUMBER() OVER (ORDER BY  ClassIndex,ws_name ) AS RowIndex,
                            #tmp1.*
                    FROM    #Tmp2
                            right JOIN #tmp1 ON #Tmp2.Class_ID = #tmp1.Class_ID
                    WHERE 1=1 " + strWhere + @") t where rowindex > " + (nPage-1)*nPageRowCount + @"
                    AND rowindex <= " + (nPage) * nPageRowCount + @"
                            ORDER BY RowIndex ASC
                    

                SELECT Count(1) as AllRowCount
                    FROM    #Tmp2
                            right JOIN #tmp1 ON #Tmp2.Class_ID = #tmp1.Class_ID
                    WHERE 1=1 " + strWhere + @";


                    DROP TABLE #tmp1
                    DROP TABLE #Tmp2	;
                    ");

                ds.Tables[1].TableName = "PageRowCount";
                return ds;
            }
            catch  
            {
                throw;

            }



        }

    }

}