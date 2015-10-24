﻿using System;
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
using System.Linq.Expressions;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:00:30
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
    public class HRCourseAttendService : BaseService<HR_CourseAttend>, IHRCourseAttendService
    {
        private IHRCourseAttendDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public HRCourseAttendService()
            : base(new HRCourseAttendDAL())
        {
            dal = IEF as HRCourseAttendDAL;
        }

        /// <summary>
        /// 获取课程的签到情况
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IEnumerable<V_HR_CourseSignRst> CourseSignHistory(Func<IQueryable<V_HR_CourseSignRst>, IOrderedQueryable<V_HR_CourseSignRst>> order, Expression<Func<V_HR_CourseSignRst, bool>> filter)
        {
            return dal.CourseSignHistory(order, filter);
        }
    }
}

