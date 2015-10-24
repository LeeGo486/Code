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
    ///MDM_Company_GetList 获取公司信息
    /// </summary>
    public class MDM_Company_GetList : LogicBase, ILogicGetData
    {
        public MDM_Company_GetList()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 获取公司信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
   
                Dbconn conn = new Dbconn("MDM");
                DataSet ds = conn.GetDataSet(@"
                        SELECT  
		                        
		                          [Company_ID]
                                  ,[Company_Name]
                                  ,[Company_sn]
                                  ,[Company_Address]
                                  ,[Fax]
                                  ,[Tax_ID]
                                  ,[Bank_Name]
                                  ,[Bank_ID]
                                  ,[Createtime]
                                  ,[Updatetime]
                                ,Convert(bigint,t1.[Timestamps]) Timestamps
                                FROM [MDM].[dbo].[MDM_Company] t1 WITH(NOLOCK)
                        
                       ");
                return ds;
            }
            catch  
            {
                throw;

            }



        }

    }

}