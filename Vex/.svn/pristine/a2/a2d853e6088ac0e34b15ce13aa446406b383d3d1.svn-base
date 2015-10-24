using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：MDM_System_Menu_Delete 
/// 类说明：删除菜单信息
/// 创建人：马卫清
/// 创建日期：2012-12-10
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Menu_Delete 删除菜单信息
    /// </summary>
    public class MDM_System_Menu_Delete : LogicBase, ILogicExecute
    {
        public MDM_System_Menu_Delete()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 删除菜单信息
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM");

            try
            {
                string strMenu_ID = m_request.Tables[0].Rows[0]["Menu_ID"].ToString();
                //m_request.Tables[0].Columns.Remove("Property_ID");

                ArrayList listTable = new ArrayList();
                listTable.Add("MDM_System_Menu");
                listTable.Add("MDM_System_Menu_AUZ");
                string strWhere = " Menu_ID=" + strMenu_ID;

                conn.BeginTransaction();
                conn.TableLock(listTable);

                DataTable dt = conn.GetDataTable("select top 100 1 as  c from MDM_System_Menu_AUZ WHERE " + strWhere, new string[0]);

                if (dt.Rows.Count > 0)
                {
                    throw new Exception("该菜单已分配过权限，请先删除相关权限信息！");
                }

                if (strMenu_ID != "")
                {

                    conn.Delete("MDM_System_Menu", strWhere);
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