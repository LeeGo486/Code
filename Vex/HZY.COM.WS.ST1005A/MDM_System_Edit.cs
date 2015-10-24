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
    ///MDM_System_Edit 编辑系统信息
    /// </summary>
    public class MDM_System_Edit : LogicBase, ILogicExecute
    {
        public MDM_System_Edit()
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
                string strSystem_ID = m_request.Tables[0].Rows[0]["System_ID"].ToString();
                string strSystem_Code = m_request.Tables[0].Rows[0]["System_Code"].ToString();
                string strSystem_SN = m_request.Tables[0].Rows[0]["System_SN"].ToString();
                m_request.Tables[0].Columns.Remove("System_ID");

                ArrayList listTable = new ArrayList();
                listTable.Add("MDM_System");
                conn.BeginTransaction();
                conn.TableLock(listTable);
                string strWhere = " System_ID=" + strSystem_ID;


                //核对系统编号是否存在
                string strSQL = "SELECT 1 AS a FROM MDM_System where System_Code='" + strSystem_Code + "'";
                if(strSystem_ID != "")
                {
                    strSQL += " AND System_ID !=" + strSystem_ID;
                }

                DataTable dtTemp = conn.GetDataTableInTrans(strSQL);
                if (dtTemp.Rows.Count > 0)
                {
                    throw new Exception(strSystem_Code + "已存在！");
                }

                //核对系统简称是否存在
                strSQL = "SELECT 1 AS a FROM MDM_System where System_SN='" + strSystem_SN + "'";
                if (strSystem_ID != "")
                {
                    strSQL += " AND System_ID !=" + strSystem_ID;
                }
                dtTemp = conn.GetDataTableInTrans(strSQL);
                if (dtTemp.Rows.Count > 0)
                {
                    throw new Exception("系统简称" + strSystem_SN + "已存在！");
                }


                if (strSystem_ID == "")
                {
                    //插入
                    conn.Insert("MDM_System", m_request.Tables[0]);
                }
                else
                {
                    //更新
                    conn.Update("MDM_System", m_request.Tables[0], strWhere);
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