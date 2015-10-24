using System;
using ElegantWM.EntityModel;
using System.Data;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:02:43
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
    public interface IHRCourseUserDAL : IEFRepository<HR_CourseUser> 
    {
        /// <summary>
        /// 获取积分
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        decimal TotalScore(Guid uid);

        /// <summary>
        /// 获取考勤情况
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        DataTable AttendResult(Guid uid);

        /// <summary>
        /// 获取积分明细
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        DataTable ScoreInfo(Guid uid);

           /// <summary>
        /// 获取课时总数
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        DataTable ClassHour(Guid uid);
    }
}
