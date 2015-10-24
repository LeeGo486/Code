using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_Menu_Edit 
/// 类说明：编辑系统菜单信息
/// 创建人：马卫清
/// 创建日期：2012-12-10
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Menu_Edit 编辑系统菜单信息
    /// </summary>
    public class MDM_System_Menu_Edit : LogicBase, ILogicExecute
    {
        public MDM_System_Menu_Edit()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 编辑系统属性信息
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM");

            try
            {
                string strMenu_ID = m_request.Tables[0].Rows[0]["Menu_ID"].ToString();
                m_request.Tables[0].Columns.Remove("Menu_ID");

                ArrayList listTable = new ArrayList();
                listTable.Add("MDM_System_Menu");
                conn.BeginTransaction();
                conn.TableLock(listTable);

                if (strMenu_ID == "")
                {
                    conn.Insert("MDM_System_Menu", m_request.Tables[0]);
                }
                else
                {
                    string strWhere = " Menu_ID=" + strMenu_ID;
                    conn.Update("MDM_System_Menu", m_request.Tables[0], strWhere);
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