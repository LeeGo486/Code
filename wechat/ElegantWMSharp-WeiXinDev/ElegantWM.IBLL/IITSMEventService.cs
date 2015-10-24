using System;
using ElegantWM.EntityModel;
using System.Data;
using System.Collections.Generic;
using ElegantWM.DTO;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/30 22:37:06
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
    public interface IITSMEventService : IBaseService<ITSM_Event>
    {
        /// <summary>
        /// 返回ITSM报表
        /// </summary>
        /// <param name="type">类型1</param>
        /// <returns></returns>
        IEnumerable<ITSMEventChartDto> Report(int type);
        /// <summary>
        /// 执行存储过程，返回结果
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        DataTable GetProcData(int type);

        /// <summary>
        /// 消息通知
        /// </summary>
        /// <param name="type">0 请派工，1 已派工，4 已完成，5 已评价</param>
        /// <param name="evt">事件</param>
        void Notice(int type, ITSM_Event evt);
    }
}
