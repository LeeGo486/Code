using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;
using System.Data;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:02:43
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
    public class HRCourseUserDAL : EFRepository<HR_CourseUser>, IHRCourseUserDAL
    {
        /* 如果是多数据库，请开启
        public HRCourseUserDAL()
            : base("Your web.config DbConnectString")
        {

        }
        */
        /// <summary>
        /// 获取积分
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public decimal TotalScore(Guid uid)
        {
            string sql = @"WITH #TMP AS (SELECT d.id Cid ,c.Integration/NULLIF(COUNT(*),0) AS LsnScore FROM HR_CourseLesson c,HR_Course d  WHERE d.id=c.cid GROUP BY d.id,c.Integration)
                         SELECT cast(ISNULL(SUM(CASE SignRst WHEN '请假' THEN LsnScore/2 ELSE LsnScore END),0) AS DECIMAL(8,2)) TotalScore FROM V_HR_CourseSignRst r,#TMP t
                         WHERE r.Cid=t.Cid
                         AND Uid='{0}' AND SignRst!='缺勤' AND SignRst!='其他'";
            DataTable dt = Query(string.Format(sql, uid), null);
            if (dt != null && dt.Rows.Count > 0)
                return decimal.Parse(dt.Rows[0][0].ToString());
            else
                return 0;
        }

        /// <summary>
        /// 获取考勤情况
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public DataTable AttendResult(Guid uid)
        {
            string sql = @"SELECT SignRst,COUNT(1) AS TotalCount FROM V_HR_CourseSignRst WHERE Uid='{0}' GROUP BY SignRst";
            return Query(string.Format(sql, uid), null);
        }

        /// <summary>
        /// 获取积分明细
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public DataTable ScoreInfo(Guid uid)
        {
            string sql = @"SELECT  t2.LessonName ,
                CAST(ISNULL(SUM(CASE SignRst
                          WHEN '请假' THEN t2.Integration / 2
                          WHEN '缺勤' THEN 0
                          WHEN '其他' THEN 0
                          ELSE t2.Integration
                        END), 0) AS DECIMAL(8, 2)) Integration
            FROM    [dbo].[V_HR_CourseSignRst] t1 ,dbo.HR_CourseLesson t2
            WHERE   Uid = '{0}'  AND t1.Cid= t2.Cid
            GROUP BY t2.Integration ,
                    t2.LessonName
            ";
            return Query(string.Format(sql, uid), null);
        }


        /// <summary>
        /// 获取课时总数
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public DataTable ClassHour(Guid uid)
        {
            string sql = @"SELECT  SUM(ClassHour) ClassHour
                                    FROM    dbo.HR_CourseLesson t1
                                    WHERE   EXISTS ( SELECT 1
                                                     FROM   HR_LK_CourseUser t2
                                                     WHERE  Uid='{0}'
                                                            AND t2.Cid = t1.Cid )   ";
            return Query(string.Format(sql, uid), null);
        }
    }
}
