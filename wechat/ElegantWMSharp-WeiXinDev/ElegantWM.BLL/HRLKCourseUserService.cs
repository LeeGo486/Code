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

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:04:13
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
    public class HRLKCourseUserService : BaseService<HR_LK_CourseUser>, IHRLKCourseUserService
    {
        private IHRLKCourseUserDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public HRLKCourseUserService()
            : base(new HRLKCourseUserDAL())
        {
            dal = IEF as HRLKCourseUserDAL;
        }

        /// <summary>
        /// 获取已报名课程
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public IEnumerable<HR_Course> GetCourseByUserId(Guid uid)
        {
            return dal.GetCourseByUserId(uid);
        }

    }
}

