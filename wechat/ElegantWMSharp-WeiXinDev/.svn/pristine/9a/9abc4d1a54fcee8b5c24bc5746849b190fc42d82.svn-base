using System;
using ElegantWM.EntityModel;
using System.Collections.Generic;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:04:13
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
    public interface IHRLKCourseUserDAL : IEFRepository<HR_LK_CourseUser> 
    {
        /// <summary>
        /// 获取已报名课程
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        IEnumerable<HR_Course> GetCourseByUserId(Guid uid);
    }
}
