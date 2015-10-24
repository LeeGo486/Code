using System;
using System.Collections.Generic;
using System.Web;
using System.Diagnostics;
using System.Reflection;
using System.Data;
using System.Security.Cryptography;
using System.Collections;
using System.ComponentModel;
using System.Xml;
using System.Xml.Serialization;
using System.Net;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：WS_Param_Delete 
/// 类说明：删除WS参数信息
/// 创建人：Victor
/// 创建日期：2013-03-21
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{
    /// <summary>
    ///WS_Param_Delete 删除WS参数信息
    /// </summary>
    public class WS_Param_Delete : LogicBase, ILogicExecute
    {
        public WS_Param_Delete()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 编辑WS信息
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("WSRR");

            try
            {
                if (m_request == null
                    || m_request.Tables.Count == 0
                    || m_request.Tables[0].Rows.Count == 0)
                {
                    return true;
                }
                string strParam_ID = m_request.Tables[0].Rows[0]["Param_ID"].ToString();

                ArrayList listTable = new ArrayList();
                listTable.Add("WS_Param");
                conn.BeginTransaction();
                conn.TableLock(listTable);
                string strWhere = " Param_ID = '" + strParam_ID + "'";

                conn.Delete("WS_Param", strWhere);
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