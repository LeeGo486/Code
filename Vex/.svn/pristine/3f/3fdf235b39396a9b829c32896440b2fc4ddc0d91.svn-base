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
    ///SSO_AM_User_ExceuteGetFromMDM 将MDM数据库的小翅膀账户同步到VEXSSO中去，并更新VEXSSO的单点登录信息
    /// </summary>
    public class SSO_AM_User_ExceuteGetFromMDM : LogicBase, ILogicExecute
    {
        public SSO_AM_User_ExceuteGetFromMDM()
        {
            this.m_SessionCheck = false;

        }

        public bool Execute()
        {
            string strBatchID = Guid.NewGuid().ToString();
            Dbconn conn = new Dbconn("MDM");
            DataSet ds = conn.GetDataSet(
                @"
                SELECT CONVERT(UNIQUEIDENTIFIER,'" + strBatchID + @"') as BatchID
                      ,[AM_User_id]
                      ,[AM_login]
                      ,[AM_User_Name]
                      ,[AM_Password] 
                  FROM [MDM].[dbo].[AM_User]
                  WHERE am_isdelete =0
	            ");



            Dbconn connVexSSO = new Dbconn("VEXSSO");

            try
            {
                connVexSSO.BeginTransaction();

                connVexSSO.InsertBYSQLBC("Tmp_AM_User", ds.Tables[0]);

                string strSQL = @"
                     DECLARE @envid INT
                     SELECT @envid = Env_ID
                     FROM   dbo.MDM_System_Env
                     WHERE  Env_SN = 'AM'

                     SELECT [NewID] ,
                            [BatchID] ,
                            RIGHT('888888888888888' + CONVERT(VARCHAR(100), AM_User_id), 11) [AM_User_id] ,
                            [AM_login] ,
                            [AM_User_Name] ,
                            [AM_Password]
                     INTO   #tmp
                     FROM   [Tmp_AM_User]
                     WHERE  batchID = '" + strBatchID + @"'
                            AND AM_login NOT IN ( SELECT    App_UserName
                                                  FROM      dbo.MDM_System_User
                                                  WHERE     Env_ID = @envid
                                                            AND checked = 1 )
                            AND RIGHT('888888888888888' + CONVERT(VARCHAR(100), AM_User_id), 11) NOT IN ( SELECT    VexSSOLoginUser
                                                  FROM      B01_MDM.VEXSSOUser
                                                )


                     DELETE FROM [dbo].[Tmp_AM_User]
                     WHERE  batchID = '" + strBatchID + @"'
                     INSERT INTO B01_MDM.VEXSSOUser
                            ( VexSSONewID ,
                              VexSSOLoginUser ,
                              VexSSOPassWord ,
                              VexSSOPassWordMd52 ,
                              Disabled  
                            )
                            SELECT  NEWID() ,
                                    AM_User_id ,
                                    AM_Password ,
                                     right(sys.fn_VarBinToHexStr(hashbytes('MD5',Convert(varchar(100), right(sys.fn_VarBinToHexStr(hashbytes('MD5',Convert(varchar(100),AM_Password))),32)))),32)  ,
                                    0
                            FROM    #tmp
 

                    INSERT INTO [VexSSO].[dbo].[MDM_System_User]
                    ( [Env_ID]
                          ,[VexSSONewID]
                          ,[App_UserName]
                          ,[App_PasswordSrc]
                          ,[App_Password]
                          ,[App_UserName_CN]
                          ,[Chang_Password_Time]
                          ,[Checked]
                          ,[Check_User]
                          ,[Check_Time])
 
                     SELECT @envid,VexSSONewID,AM_login,AM_Password,AM_Password,AM_User_Name,GETDATE(),1,'sysytem',GETDATE()
                     FROM   #tmp
                            LEFT JOIN B01_MDM.VEXSSOUser ON AM_User_id = VexSSOLoginUser

 
                     INSERT INTO [B01_MDM].[VexSSOUserInfo]
                     ([VexSSONewId],[Name],[CreateTime],[CreateUser],[UpdateTime],[UpdateUser])
                      SELECT VexSSONewID,AM_login ,GETDATE(),'system',GETDATE(),'system'
                     FROM   #tmp
                            LEFT JOIN B01_MDM.VEXSSOUser ON AM_User_id = VexSSOLoginUser

                     DROP TABLE #tmp
                ";

                connVexSSO.ExcuteQuerryByTran(strSQL);
                connVexSSO.CommitTransaction();
                return true;
            }
            catch
            {
                connVexSSO.RollbackTransaction();
                throw;
            }
        }

    }

}