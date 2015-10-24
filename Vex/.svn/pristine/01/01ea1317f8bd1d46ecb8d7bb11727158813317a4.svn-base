using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_User_Authorization_Edit 
/// 类说明：编辑系统用户权限
/// 创建人：马卫清
/// 创建日期：2012-12-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Menu_Edit 编辑系统用户权限
    /// </summary>
    public class MDM_System_User_Authorization_Edit : LogicBase, ILogicExecute
    {
        public MDM_System_User_Authorization_Edit()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 编辑系统菜单权限
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM");

            try
            {
                string strEmployee_ID = m_request.Tables[0].Rows[0]["Employee_ID"].ToString();
                string strApp_UserID = m_request.Tables[0].Rows[0]["App_UserID"].ToString();
                string strEnv_ID = m_request.Tables[0].Rows[0]["Env_ID"].ToString();

                if (strApp_UserID == "0")
                {
                    strApp_UserID = "-1";
                }
                if (strEmployee_ID == "0")
                {
                    strEmployee_ID = "-1";
                }
               // DataTable dt = conn.GetDataTable("SELECT * FROM MDM_Employees_AppUser_Link WHERE ");

                ArrayList listTable = new ArrayList();
                listTable.Add("MDM_System_User_Authorization");
                conn.BeginTransaction();
                conn.TableLock(listTable);
                string strWhere = " (App_UserID=" + strApp_UserID + " OR Employee_ID=" + strEmployee_ID + @") AND 
                                                EXISTS (
                                SELECT * FROM dbo.MDM_System_Authorization
                                WHERE Env_ID=" + strEnv_ID + @"
                                AND MDM_System_User_Authorization.Authorization_ID=dbo.MDM_System_Authorization.Authorization_ID
                                )
                ";

                conn.Delete("MDM_System_User_Authorization", strWhere);


                m_request.Tables[0].Columns.Remove("Env_ID");

                for (int i = 0; i < m_request.Tables[0].Rows.Count; i++)
                {
                    DataTable dt = m_request.Tables[0].Clone();

                    if (m_request.Tables[0].Rows[i]["Authorization_Id"].ToString() != "0")
                    {
                        
                        dt.ImportRow(m_request.Tables[0].Rows[i]);

                        conn.Insert("MDM_System_User_Authorization", dt);
                    }
                }
                conn.CommitTransaction();
                return true;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }



        }

    }

}