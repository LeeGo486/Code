using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

/// 类名：WSServiceCall_Delete 
/// 类说明：任务列表项目删除
/// 创建人：HWA-沈加华
/// 创建日期：2014-11-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{
    /// <summary>
    /// 任务列表项目删除
    /// </summary>
    public class WSServiceCall_Delete : LogicBase, ILogicExecute
    {
        public WSServiceCall_Delete()
        {
            this.m_SessionCheck = false;
        }

        /// <summary>
        /// 删除任务信息
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM");

            try
            {
                if (m_request == null
                    || m_request.Tables.Count == 0
                    || m_request.Tables[0].Rows.Count == 0)
                {
                    return true;
                }
                string strTASK_ID = m_request.Tables[0].Rows[0]["task_id"].ToString();  //获取参数TASK_ID

                ArrayList listTable = new ArrayList();
                listTable.Add("WS_Scheduling");
                conn.BeginTransaction();    //事物事务
                conn.TableLock(listTable);  //锁表WS_Scheduling

                DataTable dt_Add = new DataTable() ;
                dt_Add.Columns.Add("IsDeleted");
                dt_Add.Columns.Add("Enabled");
                dt_Add.Columns.Add("UpdateUser");
                dt_Add.Columns.Add("UpdateTime");

                DataRow dr = dt_Add.NewRow();
                dr["IsDeleted"] = "True";   //将删除标志设为“True”
                dr["Enabled"] = "False";    //将可用标志设为“False”
                dr["UpdateTime"]=DateTime.Now;  //更新时间设为当前时间
                dr["UpdateUser"] = hzyMessage.User_Name;    //设置更新者
                dt_Add.Rows.Add(dr);

                string strWhere = " TASK_ID = '" + strTASK_ID + "'";
                conn.Update("WS_Scheduling", dt_Add, strWhere); //更新操作

                conn.CommitTransaction();   //提交事务
                return true;
            }
            catch
            {
                conn.RollbackTransaction(); //回滚
                throw;
            }
        }

    }
}
