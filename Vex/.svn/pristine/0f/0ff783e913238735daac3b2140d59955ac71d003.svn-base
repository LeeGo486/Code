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
    ///MDM_UserDept_ExceuteGetFromAM 从AM服务器抽取人员部门信息到MDM数据库中
    /// </summary>
    public class MDM_User_Dept_ExceuteGetFromAM : LogicBase, ILogicExecute
    {
        public MDM_User_Dept_ExceuteGetFromAM()
        {

            this.m_SessionCheck = false;
        }

        public bool Execute()
        {

            Dbconn conn = new Dbconn("AM");
            DataSet ds = conn.GetDataSet(
                @"SELECT  DISTINCT t1.CN_S_EMITEM_ID AS AM_USER_ID ,
                            t1.CN_P_EMITEM_ID AS AM_S_Dept_ID  	
                    FROM     TN_SYS_EM_USER t2 WITH ( NOLOCK )
                            LEFT   JOIN  TN_SYS_EM_RELATION t1 WITH ( NOLOCK ) ON t1.CN_S_EMITEM_ID = t2.CN_ID
                    WHERE   1 = 1
                            AND t2.CN_ISDELETE = 0
                            AND t2.CN_DISABLED = 0
                            AND t1.CN_REL_TYPE = 1
                            AND CN_S_EMITEM_TYPE=0
                            AND ( 
                            ( CN_P_EMITEM_TYPE = 1
                                    AND EXISTS ( SELECT 1
                                                 FROM    TN_SYS_EM_GROUP t3 WITH ( NOLOCK )
                                                 WHERE  T1.CN_P_EMITEM_ID = T3.cn_id
                                                        AND T3.CN_OWNERID = 0 )
                                  )
                                  OR 
                                  ( CN_P_EMITEM_TYPE = 3
                                       AND EXISTS ( SELECT  1
                                                    FROM     TN_SYS_EM_VIEW T4 WITH ( NOLOCK )
                                                    WHERE   1 = 1
                                                            AND CN_VIEW_TYPE = 1
                                                            AND CN_OWNERID = 0
                                                            AND CN_P_EMITEM_ID = T4.cn_id )
                                     )
                                )
                     ");



            Dbconn connMDM = new Dbconn("MDM");

            try
            {


                ArrayList tableList = new ArrayList();
                connMDM.BeginTransaction();

                tableList.Add("Am_User_Dept_log");
                tableList.Add("Am_User_Dept");
                connMDM.TableLock(tableList);


//                //存入日志数据
//                connMDM.ExcuteQuerryByTran(@"INSERT  INTO dbo.Am_User_Dept_log
//                ( Log_datetime ,
//				  AM_USER_ID,
//                  AM_S_Dept_ID ,
//                  CreateTime ,
//                  UpdateTime,
//                  Timestamps_old
//		        
//                )
//                SELECT  GETDATE() ,
//						AM_USER_ID,
//                        AM_S_Dept_ID ,
//                        CreateTime ,
//                        UpdateTime,
//                        convert(bigint,Timestamps)
//                FROM    Am_User_Dept");


                //删除数据
                connMDM.ExcuteQuerryByTran("DELETE  FROM Am_User_Dept");
                connMDM.InsertBYSQLBC("Am_User_Dept", ds.Tables[0]);
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