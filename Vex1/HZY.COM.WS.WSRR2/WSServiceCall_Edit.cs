using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

/// 类名：WSServiceCall_Edit 
/// 类说明：任务列表项目编辑操作
/// 创建人：HWA-沈加华
/// 创建日期：2014-11-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{
    /// <summary>
    /// 任务列表项目编辑操作
    /// </summary>
    public class WSServiceCall_Edit : LogicBase, ILogicExecute
    {
        public WSServiceCall_Edit()
        {
            this.m_SessionCheck = false;
        }

        /// <summary>
        /// 编辑任务信息
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
                string strTASK_ID = m_request.Tables[0].Rows[0]["task_id"].ToString();  //获取参数TaskID
                string strWS_Name = m_request.Tables[0].Rows[0]["ws_name"].ToString();  //获取参数WS名称

                ArrayList listTable = new ArrayList();
                listTable.Add("WS_Scheduling");
                conn.BeginTransaction();    //开启事务
                conn.TableLock(listTable);  //锁表WS_Scheduling
                string strWhere = string.Empty;

                //创建DataTable，用于传参
                DataTable dt_Add = new DataTable();
                dt_Add.Columns.Add("TASK_ID");
                dt_Add.Columns.Add("WS_ID");
                dt_Add.Columns.Add("URL");
                dt_Add.Columns.Add("WS_Name");
                dt_Add.Columns.Add("WS_LogicName");
                dt_Add.Columns.Add("Execute_Type");
                dt_Add.Columns.Add("Execute_StartTime");
                dt_Add.Columns.Add("Execute_EndTime");
                dt_Add.Columns.Add("Execute_Cycle");
                dt_Add.Columns.Add("Execute_DayStartTime");
                dt_Add.Columns.Add("Execute_DayEndTime");
                dt_Add.Columns.Add("Execute_WeekTime");
                dt_Add.Columns.Add("Execute_MonthTime");
                dt_Add.Columns.Add("Enabled");
                dt_Add.Columns.Add("Error_Count");
                dt_Add.Columns.Add("Remind_ErrorCount");
                dt_Add.Columns.Add("Remind_UserName");
                dt_Add.Columns.Add("CreateUser");
                dt_Add.Columns.Add("CreateTime");
                dt_Add.Columns.Add("UpdateUser");
                dt_Add.Columns.Add("UpdateTime");

                DataRow dr = dt_Add.NewRow();

                //循环DataTabel的列
                for (int i = 0; i < dt_Add.Columns.Count-4 ; i++)
                {
                    if (dt_Add.Columns[i].ColumnName == "TASK_ID")
                    {
                        continue;
                    }
                    else
                    {
                        dr[i] = m_request.Tables[0].Rows[0][dt_Add.Columns[i].ColumnName].ToString();   //对DataTabel中的每列设置值
                    }
                }
                dt_Add.Rows.Add(dr);



                if (strTASK_ID == "") //如果为空，说明是复制数据
                {
                    strTASK_ID = Guid.NewGuid().ToString(); //生成GUID

                    dt_Add.Rows[0]["TASK_ID"] = strTASK_ID;
                    dt_Add.Rows[0]["CreateTime"] = DateTime.Now;    //设置创建时间
                    dt_Add.Rows[0]["CreateUser"] = hzyMessage.User_Name;    //设置创建者
                    dt_Add.Rows[0]["UpdateTime"] = DateTime.Now;    //设置更新时间
                    dt_Add.Rows[0]["UpdateUser"] = hzyMessage.User_Name;    //设置更新者
                    dt_Add.Columns.Add("IsDeleted");
                    dt_Add.Rows[0]["IsDeleted"] = false;    //将删除标志设为“False”
                    conn.Insert("WS_Scheduling", dt_Add);   //插入数据
                }
                else
                {
                    //更新
                    dt_Add.Columns.Remove("CreateUser");    //删除CreateUser列，更新不需要
                    dt_Add.Columns.Remove("CreateTime");    //删除CreateTime列，更新不需要
                    dt_Add.Columns.Remove("TASK_ID");
                    dt_Add.Rows[0]["UpdateTime"] = DateTime.Now;    //将更新时间设为当前时间
                    dt_Add.Rows[0]["UpdateUser"] = hzyMessage.User_Name;    //设置更新者

                    strWhere = " TASK_ID = '" + strTASK_ID + "'";   //设置更新条件
                    conn.Update("WS_Scheduling", dt_Add, strWhere); //更新数据
                }

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
