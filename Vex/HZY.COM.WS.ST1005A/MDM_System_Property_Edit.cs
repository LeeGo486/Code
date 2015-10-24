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
    ///MDM_System_Property_Edit 编辑系统属性信息
    /// </summary>
    public class MDM_System_Property_Edit : LogicBase, ILogicExecute
    {
        public MDM_System_Property_Edit()
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
                string strProperty_ID = m_request.Tables[0].Rows[0]["Property_ID"].ToString();
                m_request.Tables[0].Columns.Remove("Property_ID");

                ArrayList listTable = new ArrayList();
                listTable.Add("MDM_System_Property");
                conn.BeginTransaction();
                conn.TableLock(listTable);

                if (strProperty_ID == "")
                {
                    conn.Insert("MDM_System_Property", m_request.Tables[0]);
                }
                else
                {
                    string strWhere = " Property_ID=" + strProperty_ID;
                    conn.Update("MDM_System_Property", m_request.Tables[0], strWhere);
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