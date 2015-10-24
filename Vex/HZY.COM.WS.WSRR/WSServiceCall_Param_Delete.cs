using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

/// 类名：WSServiceCall_Delete 
/// 类说明：任务列表项目参数删除
/// 创建人：HWA-沈加华
/// 创建日期：2014-11-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{
    public  class WSServiceCall_Param_Delete : LogicBase, ILogicExecute
    {
        public WSServiceCall_Param_Delete()
        {
            this.m_SessionCheck = false;
        }

        /// <summary>
        /// 删除任务参数信息
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
                string strParam_ID = m_request.Tables[0].Rows[0]["param_id"].ToString();    //获取参数Param_ID
                string strTASK_ID = m_request.Tables[0].Rows[0]["task_id"].ToString();  //获取参数Task_ID

                ArrayList listTable = new ArrayList();
                listTable.Add("WS_SchedulingParam");
                conn.BeginTransaction();    //开启事务
                conn.TableLock(listTable);  //锁表WS_SchedulingParam

                string strWhere = " Param_ID = '" + strParam_ID + "'";  //创建where语句
                conn.Delete("WS_SchedulingParam", strWhere);    //删除参数

                //更新主表
                DataTable dtScheduling = new DataTable();
                dtScheduling.Columns.Add("UpdateTime");
                DataRow drScheduling = dtScheduling.NewRow();
                drScheduling["UpdateTime"] = DateTime.Now;
                dtScheduling.Rows.Add(drScheduling);
                string strSchedulingWhere = " 1=1 AND TASK_ID = '" + strTASK_ID + "'";
                conn.Update("WS_Scheduling", dtScheduling, strSchedulingWhere);    //更新数据

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
