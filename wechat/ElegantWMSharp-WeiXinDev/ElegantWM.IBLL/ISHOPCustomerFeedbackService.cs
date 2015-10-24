using System;
using ElegantWM.EntityModel;
using System.Data;
using ElegantWM.DTO;
using System.Collections.Generic;

/**
 * 作者：WebMisSharp
 * 时间：2014/7/30 16:16:50
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
    public interface ISHOPCustomerFeedbackService : IBaseService<SHOP_CustomerFeedback>
    {
        /// <summary>
        /// 客户反馈IPAD报表，Hightchart部分
        /// </summary>
        /// <param name="type">报表类型101 客户需求大类，102 客户需求小类，103 skc，104 客户职业分布，201,202,203子类，skc，职业详细报表</param>
        /// <param name="param">参数，102需要，</param>
        /// <param name="date">时间范围1 昨天，2 近七天，3 本周，4 上周， 5 本月，6 上月，7本年度</param>
        /// <returns></returns>
        IList<ITSMEventChartDto> Report(int type, string param, int date);

        /// <summary>
        /// 客户反馈IPAD报表，详细部分
        /// </summary>
        /// <param name="type">报表类型101 客户需求大类，102 客户需求小类，103 skc，104 客户职业分布，201,202,203子类，skc，职业详细报表</param>
        /// <param name="param">参数，102需要，</param>
        /// <param name="date">时间范围1 昨天，2 近七天，3 本周，4 上周， 5 本月，6 上月，7本年度</param>
        /// <returns></returns>
        DataTable ReportDetail(int type, string param, int date);
    }
}
