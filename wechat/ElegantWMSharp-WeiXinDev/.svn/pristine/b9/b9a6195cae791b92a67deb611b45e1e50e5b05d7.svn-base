using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;
using System.Collections.Generic;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:04:13
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
    public class HRLKCourseUserDAL : EFRepository<HR_LK_CourseUser>, IHRLKCourseUserDAL
    {
        /* 如果是多数据库，请开启
        public HRLKCourseUserDAL()
            : base("Your web.config DbConnectString")
        {

        }
        */
        /// <summary>
        /// 获取已报名课程
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public IEnumerable<HR_Course> GetCourseByUserId(Guid uid)
        {
            string sql = @"WITH #CTE AS(
                            SELECT Cid,COUNT(1) SelectedNum FROM HR_LK_CourseUser WHERE Uid='" + uid.ToString() + @"' GROUP BY Cid)
                            SELECT  c.SignUpType,c.Id,c.CourseName,c.TeacherType,c.OrgName,c.Fee,c.TrainingNum,c.Venue,c.StartDate,c.EndDate,
                            c.CourseDesc,t.SelectedNum AS IsShow,'' CreateUser,c.CreateTime,NULL ModifyUser,NULL ModifyTime,c.RowVersion
                            FROM HR_Course c,#CTE t 
                            WHERE t.Cid=c.Id ORDER BY c.CreateTime DESC";
            return _db.Database.SqlQuery<HR_Course>(sql).ToList();
        }
    }
}
