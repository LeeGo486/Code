using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 15:59:51
 * 功能：HR_Course ORM
 **/

namespace ElegantWM.EntityModel
{
    public class HR_Course : Entity
    {
        public HR_Course() { }

        /// <summary>
        /// 课程名称
        /// </summary>
        public string CourseName { get; set; }

        /// <summary>
        /// 讲师类型
        /// </summary>
        public int TeacherType { get; set; }


        /// <summary>
        /// 报名类型
        /// </summary>
        public int SignUpType { get; set; }

        /// <summary>
        /// 组织机构
        /// </summary>
        public string OrgName { get; set; }

        /// <summary>
        /// 费用预算
        /// </summary>
        public decimal Fee { get; set; }

        /// <summary>
        /// 参训人数
        /// </summary>
        public int TrainingNum { get; set; }

        /// <summary>
        /// 上课地点
        /// </summary>
        public string Venue { get; set; }


        /// <summary>
        /// 开始时间
        /// </summary>
        public DateTime StartDate { get; set; }

        /// <summary>
        /// 结束时间
        /// </summary>
        public DateTime EndDate { get; set; }

        /// <summary>
        /// 课程简介
        /// </summary>
        public string CourseDesc { get; set; }

        /// <summary>
        /// 是否显示
        /// </summary>
        public int IsShow { get; set; }


        /// <summary>
        /// 报名的人
        /// </summary>
        public virtual ICollection<HR_LK_CourseUser> Users { get; set; }

    }
}
