using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;
using System.Data.SqlTypes;

namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_User_ExceuteGetFromAM_Sync 从小翅膀的服务器取到用户的信息到MDM中去(实时)
    /// </summary>
    public class MDM_User_ExceuteGetFromAM_Sync : LogicBase, ILogicExecute
    {
        public MDM_User_ExceuteGetFromAM_Sync()
        {
            this.m_SessionCheck = false;

        }

        public bool Execute()
        {

            Dbconn conn = new Dbconn("AM");
            Dbconn connMDM = new Dbconn("VexSSO");

            conn.BeginTransaction();
            connMDM.BeginTransaction();


            try
            {
                DataSet ds = conn.GetDataSet(
                @"    
               DECLARE @maxid  AS BINARY(10);
 
                 SELECT t1.[__$start_lsn] AS LogID,
                        t1.[__$seqval] ,
                        t1.[__$operation] OprationType ,
                        t1.CN_ID ,
                        t1.CN_LOGIN ,
                        t1.CN_USER_NAME ,
                        t1.CN_PASSWORD ,
                        Convert(int,t1.CN_ISDELETE) as CN_ISDELETE ,
                        Convert(int,t1.CN_DISABLED) as CN_DISABLED
						INTO #tmp
                FROM   [cdc].[dbo_TN_SYS_EM_USER_CT] t1 ,
                        [M01_CONF].[S01_Sync] t2
                WHERE  1=1
				AND  t1.[__$start_lsn]> ISNULL(t2.MaxStart_lsn,0x00023FE600000FBF0004)
				AND t2.SyncName='MDM数据获取'
				AND t1.[__$update_mask] !=0x00004000
				AND  t1.[__$update_mask] !=0x00800000 
				AND t1.[__$update_mask] !=0x00804000  
                
                
				SELECT @maxid=MAX(LogID)
				FROM #tmp
                
                if(@maxid is not null)
                begin
				UPDATE [M01_CONF].[S01_Sync] SET MaxStart_lsn=@maxid
				WHERE SyncName='MDM数据获取'
                end

                select * from #tmp
                order by  [LogID] ASC,[__$seqval] ASC ,[OprationType] ASC


	            ");
                string strSQL = "";

                Byte[] strMaxID = null;
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    strMaxID = (Byte[])ds.Tables[0].Rows[i]["LogID"];
                    string strCN_LOGIN = ds.Tables[0].Rows[i]["CN_LOGIN"].ToString();
                    string strCN_PASSWORD = ds.Tables[0].Rows[i]["CN_PASSWORD"].ToString();
                    string strCN_ISDELETE = ds.Tables[0].Rows[i]["CN_ISDELETE"].ToString();

                    string strOprationType = ds.Tables[0].Rows[i]["OprationType"].ToString();

                    if (strOprationType == "1" || strOprationType == "4") //添加或者更新
                    {
                        if (connMDM.GetDataTableRowCount("select 1 as a from MDM_Employees where SSO_UserName=@param0", new string[] { strCN_LOGIN }) == 0)
                        {
                            strSQL = @"INSERT INTO MDM_Employees (Name,SSO_UserName,SSO_Password,Leave_Flag,IsActived)
                                    Values(@param0,@param1,@param2,@param3,'1')";
                        }
                        else
                        {
                            strSQL = @"update MDM_Employees 
                                        SET SSO_Password=@param2,Leave_Flag=@param3
                                        WHERE SSO_UserName=@param1
                                    ";
                        }
                        connMDM.ExcuteQuerryByTran(strSQL, new string[] { strCN_LOGIN, strCN_LOGIN, strCN_PASSWORD, strCN_ISDELETE });

                    }
                    else if (strOprationType == "2" || strOprationType == "3") //删除
                    {
                        strSQL = @"update MDM_Employees 
                                        SET Leave_Flag=@param0
                                    WHERE SSO_UserName=@param1";
                        connMDM.ExcuteQuerryByTran(strSQL, new string[] { "1", strCN_LOGIN });

                    }
                }

                if (strMaxID != null)
                {
                    strSQL = "UPDATE M01_CONF.S01_Sync SET MaxStart_lsn=@param0,LastSyncTime=getdate() WHERE SyncName='MDM数据获取'";
                    conn.ExcuteQuerryByTran(strSQL, new object[] { strMaxID });
                }
                conn.CommitTransaction();
                connMDM.CommitTransaction();
                return true;
            }
            catch
            {
                connMDM.RollbackTransaction();
                conn.RollbackTransaction();
                throw;
            }
        }

    }

}