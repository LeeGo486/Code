using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;
using System.Collections.Generic;
using System.Linq.Expressions;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:00:30
 * 功能：数据访问层
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

 namespace ElegantWM.DAL
{
    public class HRCourseAttendDAL : EFRepository<HR_CourseAttend>, IHRCourseAttendDAL
    {
		/* 如果是多数据库，请开启
        public HRCourseAttendDAL()
            : base("Your web.config DbConnectString")
        {

        }
		*/

        /// <summary>
        /// 获取课程的签到情况
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IEnumerable<V_HR_CourseSignRst> CourseSignHistory(Func<IQueryable<V_HR_CourseSignRst>, IOrderedQueryable<V_HR_CourseSignRst>> order, Expression<Func<V_HR_CourseSignRst, bool>> filter)
        {
            try
            {
                IQueryable<V_HR_CourseSignRst> rs = _db.Set<V_HR_CourseSignRst>().Where(filter);
                if (order != null)
                {
                    rs = order(rs);
                }
                return rs.ToList();
            }
            catch (Exception e)
            {
                log.Error("CourseSignHistory:" + order.ToString() + " " + filter.ToString() + " " + e.ToString());
                throw;
            }
        }
    }
}
