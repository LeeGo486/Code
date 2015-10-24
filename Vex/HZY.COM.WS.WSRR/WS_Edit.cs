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
using System.Xml;
using System.Xml.Serialization;
using System.Net;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using System.Configuration;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：WS_Edit 
/// 类说明：编辑WS信息
/// 创建人：Victor
/// 创建日期：2013-03-21
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{
    /// <summary>
    ///WS_Edit 编辑WS信息
    /// </summary>
    public class WS_Edit : LogicBase, ILogicExecute
    {
        public WS_Edit()
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
                string strWS_ID = m_request.Tables[0].Rows[0]["WS_ID"].ToString();
                string strWS_Name = m_request.Tables[0].Rows[0]["WS_Name"].ToString();

                ArrayList listTable = new ArrayList();
                listTable.Add("WS");
                conn.BeginTransaction();
                conn.TableLock(listTable);
                string strWhere = " WS_Name='" + strWS_Name + "'";

                if (strWS_ID != "")
                {
                    strWhere += " AND WS_ID != '"+strWS_ID+"'";
                }

                //判断是否已经存在
                int nRow = conn.GetDataTableRowCount("SELECT 'A' as A FROM WS WHERE " + strWhere, new string[0]);
                if (nRow > 0)
                {
                    throw new Exception(strWS_Name + "已经存在，不能更新");
                }

                DSWSRR.WSDataTable dt_Add = new DSWSRR.WSDataTable();
                dt_Add.PrimaryKey = null;
                dt_Add.Columns["WS_ID"].DataType = typeof(string);

                string strWS_IDSrc = "";
                if (m_request.Tables[0].Columns.Contains("WS_IDSrc"))
                {
                    strWS_IDSrc = m_request.Tables[0].Rows[0]["WS_IDSrc"].ToString();
                }

                DataRow dr = dt_Add.NewRow();
                
                for (int i = 0; i < dt_Add.Columns.Count-4; i++)
                {
                    if (dt_Add.Columns[i].ColumnName == "WS_Host")
                    {
                        string strENV = ConfigurationManager.AppSettings["WSRR_ENV"];
                        if (strENV.ToLower() == "prod")
                        {
                            dr[i] = m_request.Tables[0].Rows[0]["WS_Host_Prod"].ToString();
                        }
                        else
                        {
                            dr[i] = m_request.Tables[0].Rows[0]["WS_Host_Test"].ToString();

                        }
                    }
                    else
                    {
                        dr[i] = m_request.Tables[0].Rows[0][dt_Add.Columns[i].ColumnName].ToString();
                    }
                }
                dt_Add.Rows.Add(dr);



                if (strWS_ID == "") //如果为空，说明是复制数据
                {
                    dt_Add.Columns.Remove("Update_User");
                    dt_Add.Columns.Remove("Update_Time");

                    strWS_ID = conn.GetDataTableFirstValue("SELECT NEWID() as ID").ToString();

                    dt_Add.Rows[0]["WS_ID"] = strWS_ID;
                    conn.Insert("WS", dt_Add);


                    //添加参数表的信息
                    DataTable dtParam = conn.GetDataTable("SELECT * FROM WS_Param WHERE WS_ID='" + strWS_IDSrc + "'");
                    
                    
                    //更新WSID
                    for (int i = 0; i < dtParam.Rows.Count; i++)
                    {
                        dtParam.Rows[i]["WS_ID"] = strWS_ID;
                    }

                    dtParam.Columns.Remove("Param_ID");
                    conn.Insert("WS_Param", dtParam);

                }
                else
                {
                    dt_Add.Columns.Remove("Create_User");
                    dt_Add.Columns.Remove("Create_Time");
                    dt_Add.Rows[0]["Update_Time"] = DateTime.Now;

                    strWhere = " WS_ID = '" + strWS_ID + "'";
                    conn.Update("WS", dt_Add, strWhere);
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