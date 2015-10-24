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
    ///MDM_Env_Edit 编辑系统环境信息
    /// </summary>
    public class MDM_Env_Edit : LogicBase, ILogicExecute
    {
        public MDM_Env_Edit()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 获取系统环境信息
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM");

            try
            {
                string strEnv_ID = m_request.Tables[0].Rows[0]["Env_ID"].ToString();
                string strEnv_SN = m_request.Tables[0].Rows[0]["Env_SN"].ToString();
                m_request.Tables[0].Columns.Remove("Env_ID");

                ArrayList listTable = new ArrayList();
                listTable.Add("MDM_System_Env");
                conn.BeginTransaction();
                conn.TableLock(listTable);

                 //核对环境简称是否存在
                string strSQL = "SELECT 1 AS a FROM MDM_System_Env where Env_SN='" + strEnv_SN + "'";
                if(strEnv_ID != "")
                {
                    strSQL += " AND Env_ID !=" + strEnv_ID;
                }

                DataTable dtTemp = conn.GetDataTableInTrans(strSQL);
                if (dtTemp.Rows.Count > 0)
                {
                    throw new Exception(strEnv_SN + "已存在！");
                }

                if (strEnv_ID == "")
                {
                    conn.Insert("MDM_System_Env", m_request.Tables[0]);
                }
                else
                {
                    string strWhere = " Env_ID=" + strEnv_ID;
                    conn.Update("MDM_System_Env", m_request.Tables[0], strWhere);
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