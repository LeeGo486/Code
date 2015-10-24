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
    ///MDM_System_Property_Delete 删除系统属性信息
    /// </summary>
    public class MDM_System_Property_Delete : LogicBase, ILogicExecute
    {
        public MDM_System_Property_Delete()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 删除系统权限信息
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM");

            try
            {
                string strProperty_ID = m_request.Tables[0].Rows[0]["Property_ID"].ToString();
                //m_request.Tables[0].Columns.Remove("Property_ID");

                ArrayList listTable = new ArrayList();
                listTable.Add("MDM_System_Property");
                listTable.Add("MDM_System_Property_Info");
                string strWhere = " Property_ID=" + strProperty_ID;

                conn.BeginTransaction();
                conn.TableLock(listTable);

                DataTable dt = conn.GetDataTable("select top 100 1 as  c from MDM_System_Property_Info WHERE " + strWhere, new string[0]);

                if (dt.Rows.Count > 0)
                {
                    throw new Exception("该属性已在系统列表中使用，请先删除系统属性值！");
                }

                if (strProperty_ID != "")
                {
                    
                    conn.Delete("MDM_System_Property", strWhere);
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