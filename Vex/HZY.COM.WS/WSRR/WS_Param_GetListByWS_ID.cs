using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;

namespace HZY.COM.WSRR
{
    /// <summary>
    ///WS_Param_GetListByWS_ID 通过WS_ID获取WSParam的信息
    /// </summary>
    public class WS_Param_GetListByWS_ID : LogicBase, ILogicGetData
    {
        public WS_Param_GetListByWS_ID()
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
                string strWS_ID = m_request.Tables[0].Rows[0]["ws_id"].ToString();

                Dbconn conn = new Dbconn("WSRR");
                DataSet ds = conn.GetDataSet(@"
                    SELECT 
                        Param_ID,
                      [Param_Index]
                      ,[Param_Content]
                      ,[Param_Name]
                      ,[Param_Type]
                      ,CASE ISNULL(Param_Must_Flag,0) WHEN 1 THEN '必须' WHEN '0' THEN '否' WHEN '2' THEN '系统默认' END AS Param_Must_Flag
                      ,ISNULL(Param_Must_Flag,0) as Param_Must_Flagint
                      ,[Default_Value] 
                  FROM [WSRR].[dbo].[WS_Param]
                  WHERE WS_ID='" + strWS_ID + "' ");
                return ds;
            }
            catch
            {
                throw;

            }



        }

    }

}