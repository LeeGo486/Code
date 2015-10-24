using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ElegantWM.DAL;
using ElegantWM.EntityModel;
using ElegantWM.IBLL;
using ElegantWM.IDAL;
using System.Data;
using System.Data.SqlClient;
using ElegantWM.Common;
using ElegantWM.DTO;
using ElegantWM.Tools;

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

namespace ElegantWM.BLL
{
    public class SHOPCustomerFeedbackService : BaseService<SHOP_CustomerFeedback>, ISHOPCustomerFeedbackService
    {
        private ISHOPCustomerFeedbackDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public SHOPCustomerFeedbackService()
            : base(new SHOPCustomerFeedbackDAL())
        {
            dal = IEF as SHOPCustomerFeedbackDAL;
        }

        /// <summary>
        /// 客户反馈IPAD报表,hightchart 部分
        /// </summary>
        /// <param name="type">报表类型101 客户需求大类，102 客户需求小类，103 skc，104 客户职业分布，201,202,203子类，skc，职业详细报表</param>
        /// <param name="param">参数，102需要，</param>
        /// <param name="date">时间范围1 昨天，2 近七天，3 本周，4 上周， 5 本月，6 上月，7本年度</param>
        /// <returns></returns>
        public IList<ITSMEventChartDto> Report(int type, string param, int date)
        {
            DataTable dtRst = dal.Report(type,param,date);
            return ModelConvertHelper<ITSMEventChartDto>.ConvertToModel(dtRst);
        }

        /// <summary>
        /// 客户反馈IPAD报表，详细数据部分
        /// </summary>
        /// <param name="type">报表类型101 客户需求大类，102 客户需求小类，103 skc，104 客户职业分布，201,202,203子类，skc，职业详细报表</param>
        /// <param name="param">参数，102需要，</param>
        /// <param name="date">时间范围1 昨天，2 近七天，3 本周，4 上周， 5 本月，6 上月，7本年度</param>
        /// <returns></returns>
        public DataTable ReportDetail(int type, string param, int date)
        {
            return dal.Report(type, param, date);
        }
    }
}

