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
    ///MDM_Dept_ExceuteGetFromAm 从小翅膀的服务器取到组织架构的信息到MDM中去
    /// </summary>
    public class MDM_Dept_ExceuteGetFromAm : LogicBase, ILogicExecute
    {
        public MDM_Dept_ExceuteGetFromAm()
        {
            this.m_SessionCheck = false;

        }

        public DataSet GetData()
        {
            return null;
        }

        public bool Execute()
        {

           
            Dbconn conn = new Dbconn("AM");
            DataSet ds = conn.GetDataSet(
                @"WITH    cte ( AM_S_Dept_ID, AM_P_Dept_ID, AM_Dept_NAME, AM_Dept_NAME_ALL, OrderIndex,AM_Company,AM_Dept1_ID, AM_Dept2_ID, AM_Dept3_ID, AM_Dept4_ID)
          AS (--父项 
               SELECT   cn_id AS CN_S_EMITEM_ID ,
                        0 AS CN_P_EMITEM_ID ,
                        CONVERT(VARCHAR(200), CN_VIEW_NAME) AS CN_GROUP_NAME ,
                        CONVERT(VARCHAR(200), CN_VIEW_NAME) AS CN_GROUP_NAME_ALL,
                        CONVERT(VARCHAR(100), RIGHT('0000'
                                                    + CONVERT(VARCHAR(10), ROW_NUMBER() OVER ( ORDER BY CN_LEVEL )),
                                                    4)) OrderIndex ,
                        cn_id AS Company ,
                        NULL AS Dept1 ,
                        NULL AS Dept2 ,
                        NULL AS Dept3 ,
                        NULL AS Dept4
               FROM     dbo.TN_SYS_EM_VIEW WITH ( NOLOCK )
               WHERE    1 = 1
                        AND CN_VIEW_TYPE = 1
                        AND CN_OWNERID = 0
               UNION ALL 
                        --递归结果集中的下级 
               SELECT   t1.CN_S_EMITEM_ID ,
                        t1.CN_P_EMITEM_ID ,
                        CONVERT(VARCHAR(200), t3.CN_GROUP_NAME) ,
                        CONVERT(VARCHAR(200), t2.AM_Dept_NAME_All + '\'
                        + t3.CN_GROUP_NAME) AS CN_GROUP_NAME,
                        CONVERT(VARCHAR(100),OrderIndex + RIGHT('0000'
                                           + CONVERT(VARCHAR(4), ROW_NUMBER() OVER ( ORDER BY CN_LEVEL, t3.CN_GROUP_NAME )),
                                           4)) ,
                        t2.AM_Company ,
                        CASE WHEN LEN(OrderIndex) = 4 THEN t3.CN_ID
                             WHEN LEN(OrderIndex) > 4 THEN t2.AM_Dept1_ID
                             ELSE NULL
                        END AS Dept1 ,
                        CASE WHEN LEN(OrderIndex) = 8 THEN t3.CN_ID
                             WHEN LEN(OrderIndex) > 8 THEN t2.AM_Dept2_ID
                             ELSE NULL
                        END AS Dept2 ,
                        CASE WHEN LEN(OrderIndex) = 12 THEN t3.CN_ID
                             WHEN LEN(OrderIndex) > 12 THEN t2.AM_Dept3_ID
                             ELSE NULL
                        END AS Dept3 ,
                        CASE WHEN LEN(OrderIndex) = 16 THEN t3.CN_ID
                             WHEN LEN(OrderIndex) > 16 THEN t2.AM_Dept4_ID
                             ELSE NULL
                        END AS Dept4
               FROM     dbo.TN_SYS_EM_RELATION t1 WITH ( NOLOCK )
                        INNER JOIN cte AS t2 ON t1.CN_P_EMITEM_ID = t2.AM_S_Dept_ID
                        INNER JOIN dbo.TN_SYS_EM_GROUP t3 WITH ( NOLOCK ) ON t3.cn_id = t1.CN_S_EMITEM_ID
               WHERE    cn_s_emitem_type = 1
                        AND CN_OWNERID = 0  --在陈杰的基础上加了这个条件，经过测试，与小翅膀的组织框架一致
               
             )
    SELECT  *
    FROM    cte		");



            Dbconn connMDM = new Dbconn("MDM");

            try
            {


                ArrayList tableList = new ArrayList();
                connMDM.BeginTransaction();

                tableList.Add("AM_Dept_log");
                tableList.Add("am_dept");
                connMDM.TableLock(tableList);


                //存入日志数据
                connMDM.ExcuteQuerryByTran(@"INSERT  INTO dbo.AM_Dept_log
                ( Log_datetime ,
                  AM_S_Dept_ID ,
                  AM_P_Dept_ID ,
                  AM_Dept_NAME ,
                  AM_Dept_NAME_ALL,
                  AM_Company,
                  AM_Dept1_ID,
                  AM_Dept2_ID,
                  AM_Dept3_ID,
                  AM_Dept4_ID,
                  CreateTime ,
                  UpdateTime ,
                  Timestamps_old
		        
                )
                SELECT  GETDATE() ,
                        AM_S_Dept_ID ,
                        AM_P_Dept_ID ,
                        AM_Dept_NAME ,
                        AM_Dept_NAME_ALL,
                        AM_Company,
                        AM_Dept1_ID,
                        AM_Dept2_ID,
                        AM_Dept3_ID,
                        AM_Dept4_ID,
                        CreateTime ,
                        UpdateTime,
                        Convert(bigint,Timestamps)
                FROM    am_dept;");


                //删除数据
                connMDM.ExcuteQuerryByTran("DELETE  FROM am_dept");
                connMDM.Insert("am_dept", ds.Tables[0]);
                connMDM.CommitTransaction();

                return true;

            }
            catch
            {
                connMDM.RollbackTransaction();
                
                
                throw;
            }
        }

    }

}