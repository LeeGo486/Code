using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

/// 类名：WSServiceCall_Param_GetListByTaskID 
/// 类说明：获取任务项目执行日志
/// 创建人：HWA-沈加华
/// 创建日期：2014-11-26
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{
    /// <summary>
    /// 获取任务项目执行日志
    /// </summary>
    public class WSServiceCall_Log_GetListByTaskID : HZYLogicBase, ILogicGetData
    {
        public WSServiceCall_Log_GetListByTaskID()
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
                string strXML = string.Empty;
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString(); //获取参数XML
                DataSet dsRequest  = Common.Common.GetDSByExcelXML(strXML); //转换XML到DataSet

                string strTaskID = dsRequest.Tables[1].Rows[0]["task_id"].ToString();   //获取参数TaskID
                if (string.IsNullOrEmpty(m_hzyPageInfo.Sort))
                {
                    m_hzyPageInfo.Sort = "CreateTime";
                    m_hzyPageInfo.Order = "desc ";
                }

                Dbconn conn = new Dbconn("WSRR");    //创建连接类
                string strSQL = @"SELECT 
                                            [Auto_ID]
                                          ,[TASK_ID]
                                          ,[Execute_StartTime]
                                          ,[Execute_EndTime]
                                          ,[Execute_Result]
                                          ,[Execute_Message]
                                          ,[CreateTime]
                                      FROM [dbo].[WS_Scheduling_Execute_log]
                                      WHERE TASK_ID='" + strTaskID + "' ";
                DataSet ds = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);  //调用方法，获取分页数据
                return ds;
            }
            catch
            {
                throw;
            }
        }
    }
}
