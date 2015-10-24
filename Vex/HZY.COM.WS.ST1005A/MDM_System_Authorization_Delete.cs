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
    ///MDM_System_Authorization_Delete 删除系统权限信息
    /// </summary>
    public class MDM_System_Authorization_Delete : LogicBase, ILogicExecute
    {
        public MDM_System_Authorization_Delete()
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
                string strAuthorization_ID = m_request.Tables[0].Rows[0]["Authorization_ID"].ToString();
                m_request.Tables[0].Columns.Remove("Authorization_ID");

                ArrayList listTable = new ArrayList();
                listTable.Add("MDM_System_Authorization");
                listTable.Add("MDM_System_Menu_AUZ");
                conn.BeginTransaction();
                conn.TableLock(listTable);

                if (strAuthorization_ID != "")
                {
                    string strWhere = " Authorization_ID=" + strAuthorization_ID;
                    conn.Delete("MDM_System_Authorization", strWhere);
                    conn.Delete("MDM_System_Menu_AUZ", strWhere);
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