using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

/// 类名：WSServiceCall_Param_GetListByTaskID 
/// 类说明：获取任务列表项目参数
/// 创建人：HWA-沈加华
/// 创建日期：2014-11-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{
    /// <summary>
    /// 获取任务列表项目参数
    /// </summary>
    public class WSServiceCall_Param_GetListByTaskID : LogicBase, ILogicGetData
    {
        public WSServiceCall_Param_GetListByTaskID()
        {
            this.m_SessionCheck = false;
        }

        /// <summary>
        /// 获取执行任务参数信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strTaskID = m_request.Tables[0].Rows[0]["task_id"].ToString();   //获取参数TaskID

                Dbconn conn = new Dbconn("MDM");    //创建连接类
                DataSet ds = conn.GetDataSet(@"
                    SELECT 
                        Param_ID
                      ,[Param_Name]
                      ,[Param_Value] 
                  FROM [dbo].[WS_SchedulingParam]
                  WHERE TASK_ID='" + strTaskID + "' ");
                return ds;
            }
            catch
            {
                throw;
            }
        }
    }
}
