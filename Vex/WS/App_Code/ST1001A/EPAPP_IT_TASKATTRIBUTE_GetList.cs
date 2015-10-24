using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.ST1001A
{
    /// <summary>
    ///EPAPP_IT_TASKATTRIBUTE_GetList 获取任务列表
    /// </summary>
    public class EPAPP_IT_TASKATTRIBUTE_GetList : LogicBase, ILogicGetData
    {
        public EPAPP_IT_TASKATTRIBUTE_GetList()
        {
            this.m_SessionCheck = false;
        }

        public DataSet GetData()
        {
            int nPage = 1;
            int nPageRowCount = 20;
            string strOrder = " DESC  ";
            string strSort = " fNeedDeliverDay "; //交付日期
            string strWhere = " AND 1=1 ";

            if (m_request != null && m_request.Tables.Contains("Page_Info"))
            {
                nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() :  strOrder;
                strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;
            }


            try
            {
                Dbconn conn = new Dbconn("X6_EPApp");
                DataSet ds = conn.GetDataSet(@"
                 SELECT * FROM 
                        (
                        SELECT  
                                ROW_NUMBER()OVER(ORDER BY " + strSort + " " + strOrder + @") AS ROW_NUMBER_INDEX,
                                fid,
                                fTaskType ,
                                ftaskid ,
                                ftaskname ,
                                fDept ,
                                fneeds ,
                                fImportanceDegree ,
                                fNeedDeliverDay ,
                                fConfirmDeliverDay ,
                                fTaskPrincipal ,
                                fTaskAllocatee ,
                                fTaskState ,
                                fTaskDepiction
                        FROM    IT_TASKATTRIBUTE WITH(NOLOCK)
                        
                        WHERE 1=1 AND AM_ISDELETE=0 " + strWhere + @"
                        
                        ) t1 
                        WHERE ROW_NUMBER_INDEX >= " + (nPage * nPageRowCount - nPageRowCount +1 ).ToString() + " AND ROW_NUMBER_INDEX<=" + (nPage * nPageRowCount).ToString() + @"
            ");

                DataTable dt = conn.GetDataTable(@" SELECT  
		                         Count(1) as AllRowCount
                                 FROM dbo.IT_TASKATTRIBUTE WITH(NOLOCK)
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