using System;
using ElegantWM.EntityModel;
using System.Data;

/**
 * 作者：WebMisSharp
 * 时间：2014/7/9 13:57:05
 * 功能：业务逻辑接口
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

namespace ElegantWM.IBLL
{
    public interface IITSMEgrScheduleService : IBaseService<ITSM_EgrSchedule>
    {
        /// <summary>
        /// 返回事件排版详细列表
        /// </summary>
        /// <returns></returns>
        DataTable ScheduleDetail();
    }
}
