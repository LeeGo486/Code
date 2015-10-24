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
 * 时间：2014/6/4 16:02:43
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
    public class HRCourseUserService : BaseService<HR_CourseUser>, IHRCourseUserService
    {
        private IHRCourseUserDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public HRCourseUserService()
            : base(new HRCourseUserDAL())
        {
            dal = IEF as HRCourseUserDAL;
        }

        /// <summary>
        /// 获取积分
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public decimal TotalScore(Guid uid)
        {
            return dal.TotalScore(uid);
        }

        /// <summary>
        /// 获取考勤情况
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public DataTable AttendResult(Guid uid)
        {
            return dal.AttendResult(uid);
        }

        /// <summary>
        /// 获取考勤情况
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public DataTable ScoreInfo(Guid uid)
        {
            return dal.ScoreInfo(uid);
        }

        /// <summary>
        /// 获取课时总数
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public DataTable ClassHour(Guid uid)
        {
            return dal.ClassHour(uid);
        }
    }
}

