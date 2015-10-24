using System;
using ElegantWM.EntityModel;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:00:30
 * 功能：数据访问层接口
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

namespace ElegantWM.IDAL
{
    public interface IHRCourseAttendDAL : IEFRepository<HR_CourseAttend> 
    {
        /// <summary>
        /// 获取课程的签到情况
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        IEnumerable<V_HR_CourseSignRst> CourseSignHistory(Func<IQueryable<V_HR_CourseSignRst>, IOrderedQueryable<V_HR_CourseSignRst>> order, Expression<Func<V_HR_CourseSignRst, bool>> filter);
    }
}
