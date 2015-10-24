using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

/// 类名：WSServiceCall_Param_Edit 
/// 类说明：任务列表项目参数编辑
/// 创建人：HWA-沈加华
/// 创建日期：2014-11-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{
    public class WSServiceCall_Param_Edit : LogicBase, ILogicExecute
    {
        /// <summary>
        /// 任务列表项目参数编辑
        /// </summary>
        public WSServiceCall_Param_Edit()
        {
            this.m_SessionCheck = false;
        }

        /// <summary>
        /// 编辑任务参数信息
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM");    //创建连接类

            try
            {
                if (m_request == null
                    || m_request.Tables.Count == 0
                    || m_request.Tables[0].Rows.Count == 0)
                {
                    return true;
                }
                string strTASK_ID = m_request.Tables[0].Rows[0]["task_id"].ToString();  //获取参数Task_ID
                string strParam_Name = m_request.Tables[0].Rows[0]["param_name"].ToString();  //获取参数Param_Name
                string strParam_ID = m_request.Tables[0].Rows[0]["param_id"].ToString();  //获取参数Param_ID

                ArrayList listTable = new ArrayList();
                listTable.Add("WS_SchedulingParam");
                conn.BeginTransaction();    //开启事务
                conn.TableLock(listTable);  //锁表WS_SchedulingParam
                string strWhere = " 1=1 ";

                if (!string.IsNullOrEmpty(strTASK_ID))
                {
                    strWhere += " AND TASK_ID = '" + strTASK_ID + "'";
                }

                if (!string.IsNullOrEmpty(strParam_Name))
                {
                    strWhere += " AND Param_Name = '" + strParam_Name + "'";
                }

                //创建DataTable
                DataTable dt_Add = new DataTable();
                dt_Add.Columns.Add("Param_ID");
                dt_Add.Columns.Add("TASK_ID");
                dt_Add.Columns.Add("Param_Name");
                dt_Add.Columns.Add("Param_Value");

                DataRow dr = dt_Add.NewRow();

                for (int i = 0; i < dt_Add.Columns.Count; i++)
                {
                    dr[i] = m_request.Tables[0].Rows[0][dt_Add.Columns[i].ColumnName].ToString();   //将m_request中的数据逐个赋值
                }
                dt_Add.Rows.Add(dr);



                if (strParam_ID == "") //如果为空，说明是复制数据
                {
                    //判断是否已经存在
                    int nRow = conn.GetDataTableRowCount("SELECT * FROM WS_SchedulingParam WHERE " + strWhere, new string[0]);
                    if (nRow > 0)
                    {
                        throw new Exception(strParam_Name + "已经存在，不能更新");
                    }
                    strParam_ID = Guid.NewGuid().ToString();    //创建GUID

                    dt_Add.Rows[0]["Param_ID"] = strParam_ID;
                    conn.Insert("WS_SchedulingParam", dt_Add);  //插入数据
                }
                else
                {
                    dt_Add.Columns.Remove("Param_ID");  //删除Param_ID，更新不需要
                    dt_Add.Columns.Remove("Task_ID");  //删除Task_ID，更新不需要
                    strWhere = " 1=1 AND Param_ID = '" + strParam_ID + "'"; //重新设置where语句
                    conn.Update("WS_SchedulingParam", dt_Add, strWhere);    //更新数据
                }
                //更新主表
                DataTable dtScheduling = new DataTable();
                dtScheduling.Columns.Add("UpdateTime");
                DataRow drScheduling = dtScheduling.NewRow();
                drScheduling["UpdateTime"] = DateTime.Now;
                dtScheduling.Rows.Add(drScheduling);
                string strSchedulingWhere = " 1=1 AND TASK_ID = '" + strTASK_ID + "'";
                conn.Update("WS_Scheduling", dtScheduling, strSchedulingWhere);    //更新数据

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
