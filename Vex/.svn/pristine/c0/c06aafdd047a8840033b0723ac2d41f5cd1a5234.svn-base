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
    ///MDM_System_User_ExceuteGetFromGPF22 从GP的F22系统中，抽取用户数据到MDM中:HZY_Sale_Daily
    /// </summary>
    public class MDM_System_User_ExceuteGetFromGPF22 : LogicBase, ILogicExecute
    {
        public MDM_System_User_ExceuteGetFromGPF22()
        {

            this.m_SessionCheck = false;
        }

        /// <summary>
        /// 供销售日报使用
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {

            Dbconn conn_PLM_AS = new Dbconn("F22GP_ForSalesPlan");
            DataSet ds = conn_PLM_AS.GetDataSet(
                @"  SELECT  94 AS Env_ID , --HZY_Sale_Report
                            null AS VexSSONewID ,
                            b.userid AS App_UserName ,
                            RIGHT(sys.fn_VarBinToHexStr(hashbytes('MD5', CONVERT(VARCHAR(100), b.password))), 32) AS App_Password ,
                            b.password AS App_PasswordSrc ,
                            b.username AS App_UserName_CN ,
                            GETDATE() Chang_Password_Time ,
                            1 Checked ,
                            'system' Check_User ,
                            GETDATE() Check_Time ,
                            GETDATE() Createtime ,
                            GETDATE() Updatetime
                    FROM    j_depot a ,
                            j_user b
                    WHERE   a.depotid = b.depotid
                            AND a.m_type = 11
                     ");

            Dbconn connMDM = new Dbconn("VexSSO");

            try
            {


                ArrayList tableList = new ArrayList();
                connMDM.BeginTransaction();

                tableList.Add("MDM_System_User");
                connMDM.TableLock(tableList);

                //删除数据
                connMDM.ExcuteQuerryByTran(@"DELETE FROM MDM_System_User WHERE ENV_ID=94");

                connMDM.InsertBYSQLBC("MDM_System_User", ds.Tables[0]);
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