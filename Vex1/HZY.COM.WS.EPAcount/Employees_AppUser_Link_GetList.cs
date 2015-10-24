using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：Employees_AppUser_Link_GetList
/// 类说明：Employees_AppUser_Link_GetList 获取MDM人员信息
/// 创建人：郭琦琦 
/// 创建日期：2014-02-19  
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.EPAcount
{
    public class Employees_AppUser_Link_GetList : HZYLogicBase, ILogicGetData
    {
        public Employees_AppUser_Link_GetList()
        {
            this.m_SessionCheck = false;

        }
        Dbconn conn = new Dbconn("VexSSO");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        /// <summary>
        /// 获取MDM人员信息
        /// </summary>
        /// <returns></returns>

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                DataTable dt_LIST = ds.Tables["LIST"];
                 
                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET")
                    {
       
                        string strEnv_ID = "0";

                        strEnv_ID = dt_LIST.Rows[0]["Env_ID"].ToString();
                         

                        conn.BeginTransaction();
                        conn.ExcuteQuerryByTran(@"SELECT  App_UserID ,
                                                             Env_ID ,
                                                             VexSSONewID ,
                                                             App_UserName,
                                                            App_UserName_CN  
                                                     INTO   #tmp1
                                                     FROM   MDM_System_User
                                                     WHERE  ENV_ID =" + strEnv_ID + @" AND Checked=1");

                        string strSQL = @"SELECT  
		                                                          
		                                                           VEXSSOUser.VexSSONewID
                                                                  ,[Name]
                                                                  ,VEXSSOUser.[VexSSOLoginUser]
                                                                  ,#tmp1.App_UserID
                                                                  ,#tmp1.App_UserName
                                                                  ,#tmp1.App_UserName_CN
                                                              FROM B01_MDM.VEXSSOUser
                                                              left join B01_MDM.VexSSOUserInfo on VexSSOUserInfo.VexSSONewID = VEXSSOUser.VexSSONewID
                                                              FULL JOIN #tmp1 ON #tmp1.VexSSONewID=VEXSSOUser.VexSSONewID
                                                              WHERE ISNULL(Disabled,0)=0  " + m_hzyPageInfo.Where + @"    ";


                        ds_Return = conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);
                        conn.CommitTransaction();
            }
                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
    }
}
