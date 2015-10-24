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

namespace ElegantWM.BLL
{
    public class ITSMEventService : BaseService<ITSM_Event>, IITSMEventService
    {
        private IITSMEventDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public ITSMEventService()
            : base(new ITSMEventDAL())
        {
            dal = IEF as ITSMEventDAL;
        }

        /// <summary>
        /// 返回ITSM报表
        /// </summary>
        /// <param name="type">类型1</param>
        /// <returns></returns>
        public IEnumerable<ITSMEventChartDto> Report(int type)
        {
            DataTable dtRst = dal.Report(type);
            return ModelConvertHelper<ITSMEventChartDto>.ConvertToModel(dtRst);
        }

        /// <summary>
        /// 执行存储过程，返回结果
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        public DataTable GetProcData(int type)
        {
            return dal.Report(type);
        }

        /// <summary>
        /// 消息通知
        /// </summary>
        /// <param name="type">0 请派工，1 已派工，4 已完成，5 已评价</param>
        /// <param name="evt">事件</param>
        public void Notice(int type, ITSM_Event evt)
        {
            dal.Notice(type, evt);
        }
    }
}

