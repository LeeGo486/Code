using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_Property_Info_Edit 
/// 类说明：编辑系统属性值信息
/// 创建人：马卫清
/// 创建日期：2012-12-04
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Property_Info_Edit 编辑系统属性值信息
    /// </summary>
    public class MDM_System_Property_Info_Edit : LogicBase, ILogicExecute
    {
        public MDM_System_Property_Info_Edit()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 编辑系统属性值信息
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM");

            try
            {
                string strSystem_ID = m_request.Tables[0].Rows[0]["System_ID"].ToString();
                string strSystem_Code = m_request.Tables[0].Rows[0]["System_Code"].ToString();

                DataTable dt_Add = new DataTable();
                dt_Add.Columns.Add("System_ID");
                dt_Add.Columns.Add("System_Code");
                dt_Add.Columns.Add("Property_ID");
                dt_Add.Columns.Add("Property_Text");
                for (int i = 2; i < m_request.Tables[0].Columns.Count; i++)
                {
                    string strValue = m_request.Tables[0].Rows[0][i].ToString();
                    if (strValue != "")
                    {
                        dt_Add.Rows.Add(new object[] { strSystem_ID, strSystem_Code, m_request.Tables[0].Columns[i].ToString(),strValue});
                    }
                }


                ArrayList listTable = new ArrayList();
                listTable.Add("MDM_System_Property_info");
                conn.BeginTransaction();
                conn.TableLock(listTable);
                string strWhere = " System_ID=" + strSystem_ID;
                conn.Delete("MDM_System_Property_info", strWhere);

                conn.InsertBYSQLBC("MDM_System_Property_info", dt_Add);
                
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