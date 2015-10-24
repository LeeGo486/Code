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
    ///MDM_User_ExceuteGetFromAM 从小翅膀的服务器取到用户的信息到MDM中去
    /// </summary>
    public class MDM_User_ExceuteGetFromAM : LogicBase, ILogicExecute
    {
        public MDM_User_ExceuteGetFromAM()
        {
            this.m_SessionCheck = false;

        }

        public bool Execute()
        {

            Dbconn conn = new Dbconn("AM");
            DataSet ds = conn.GetDataSet(
                @"SELECT  cn_id as AM_User_id,
                        CN_LOGIN as AM_login,
                        CN_USER_NAME as AM_User_Name,
                        CN_PASSWORD AM_Password,
                        CN_EMAIL AM_Email,
                        CN_TITLE AM_Title,
                        CN_HANDSET AM_Handset,
                        CN_ISDELETE AM_IsDelete

                FROM    dbo.TN_SYS_EM_USER t1 ,
                         dbo.TN_SYS_EM_USER_PROP t2
                WHERE   t1.cn_id = t2.CN_USERID
	");



            Dbconn connMDM = new Dbconn("MDM");

            try
            {


                ArrayList tableList = new ArrayList();
                connMDM.BeginTransaction();

                tableList.Add("AM_User_log");
                tableList.Add("AM_User");
                connMDM.TableLock(tableList);


//                //存入日志数据
//                connMDM.ExcuteQuerryByTran(@"INSERT  INTO dbo.AM_User_log
//                (   Log_datetime ,
//                    AM_User_id ,
//                    AM_LOGIN ,
//                    AM_USER_NAME,
//                    AM_PASSWORD,
//                    AM_EMAIL,
//                    AM_TITLE,
//                    AM_HANDSET,
//                    AM_ISDELETE,
//                    CreateTime ,
//                    UpdateTime ,
//                    Timestamps_old
//		        
//                )
//                SELECT  GETDATE() ,
//                        AM_User_id ,
//                        AM_LOGIN ,
//                        AM_USER_NAME,
//                        AM_PASSWORD,
//                        AM_EMAIL,
//                        AM_TITLE,
//                        AM_HANDSET,
//                        AM_ISDELETE,
//                        CreateTime ,
//                        UpdateTime,
//                        CONVERT(BIGINT,Timestamps)
//                FROM    AM_User;");
                //删除数据
                connMDM.ExcuteQuerryByTran("DELETE  FROM AM_User");
                connMDM.InsertBYSQLBC("AM_User", ds.Tables[0]);

                //更新MDM_Employees的用户信息
                connMDM.ExcuteQuerryByTran(@"UPDATE MDM_Employees 
                                    SET SSO_Password=t2.AM_Password,
                                    Leave_Flag=AM_ISDELETE
                                    FROM dbo.AM_User t2 WHERE MDM_Employees.SSO_UserName = t2.AM_login
                                    "
                    );


                //并添加新入职的数据
                connMDM.ExcuteQuerryByTran(@" 
                    INSERT INTO dbo.MDM_Employees
                            ( 
                              Name ,
                              Sex ,
                              Phone ,
                              Moblie ,
                              SSO_UserName ,
                              SSO_Password ,
                              In_Time ,
                              Leave_Time ,
                              Leave_Flag ,
                              IsActived 
                            )
                    SELECT  
                            AM_login ,
                            NULL,
                            NULL,
                            NULL,
                            AM_login ,
                            AM_Password ,
                            GETDATE(),
                            
                            NULL,
                            AM_ISDELETE,
                            1 FROM dbo.AM_User
                    WHERE AM_login NOT IN (SELECT SSO_UserName FROM MDM_Employees)
"
                    );
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