using System;
using System.Collections.Generic;
using System.Web;
using System.Diagnostics;
using System.Reflection;
using System.Data;
using System.Security.Cryptography;
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml;
using System.Xml.Serialization;
using System.Net;
using HZY.COM.Common;
using HZY.COM.DBAccess;
using HZY.COM.WS.DataSets;

/// 类名：WS_Param_Edit 
/// 类说明：编辑WS参数信息
/// 创建人：马卫清
/// 创建日期：2013-09-22
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{
    /// <summary>
    ///WS_Param_Edit 编辑WS参数信息
    /// </summary>
    public class WS_Param_Edit : LogicBase, ILogicExecute
    {
        public WS_Param_Edit()
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
                if(m_request == null
                    || m_request.Tables.Count==0
                    || m_request.Tables[0].Rows.Count == 0)
                {
                    return true;
                }
                string strParam_ID = m_request.Tables[0].Rows[0]["Param_ID"].ToString();
                string strParam_Index = m_request.Tables[0].Rows[0]["Param_Index"].ToString();
                string strWS_ID = m_request.Tables[0].Rows[0]["WS_ID"].ToString();

                ArrayList listTable = new ArrayList();
                listTable.Add("WS_Param");
                conn.BeginTransaction();
                conn.TableLock(listTable);
                string strWhere = " Param_Index='" + strParam_Index + "' AND WS_ID='"+strWS_ID+"'";

                if (strParam_ID != "")
                {
                    strWhere += " AND Param_ID != '" + strParam_ID + "'";
                }

                //判断是否已经存在
                int nRow = conn.GetDataTableRowCount("SELECT 'A' as A FROM WS_Param WHERE " + strWhere, new string[0]);
                if (nRow > 0)
                {
                    throw new Exception("序号"+strParam_Index + "已经存在，不能更新");
                }

                DSWSRR.WS_ParamDataTable dt_Add = new DSWSRR.WS_ParamDataTable();
                dt_Add.PrimaryKey = null;
                dt_Add.Columns.Remove("Param_ID");

                DataRow dr = dt_Add.NewRow();
                
                for (int i = 0; i < dt_Add.Columns.Count-1; i++)
                {
                    dr[i] = m_request.Tables[0].Rows[0][dt_Add.Columns[i].ColumnName].ToString();

                }
                dt_Add.Rows.Add(dr);

                if (strParam_ID == "")
                {
                   
                    conn.Insert("WS_Param", dt_Add);
                }
                else
                {
                    strWhere = "  Param_ID = '" + strParam_ID + "'";

                    conn.Update("WS_Param", dt_Add, strWhere);
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