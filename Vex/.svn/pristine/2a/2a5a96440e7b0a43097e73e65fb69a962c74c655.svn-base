using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace HZY.COM.WSRR
{
    public class WS_GetAllList : HZYLogicBase, ILogicGetData
    {
        public WS_GetAllList()
        {
            this.m_SessionCheck = false;
        }

        public DataSet GetData()
        {
            try
            {
                string strWhere = string.Empty;
                string strSearchFilter = " ";

                if (m_request != null)
                {
                    //strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;

                    //if (m_request.Tables[0].Columns.Contains("searchFilter"))
                    //{
                    //    strSearchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : strSearchFilter;
                    //}
                    //if (strWhere.Trim() != "")
                    //{
                    //    strWhere = " AND " + strWhere;
                    //}

                    //if (strSearchFilter.Trim() != "")
                    //{
                    //    strWhere = " AND " + strSearchFilter;
                    //}
                }

                Dbconn conn = new Dbconn("WSRR");
                string strSQL = @"   
                    SELECT [WSID]
                          ,[ServicePath]
                          ,[WSName]
                      FROM [WSRR_Manage].[B01_MDM].[WS0_WSMainDoc] WITH ( NOLOCK ) WHERE 1=1   " + strWhere;
                DataSet ds = conn.GetDataSet(strSQL);

                return ds;
            }
            catch
            {
                throw;

            }



        }

    }
}
