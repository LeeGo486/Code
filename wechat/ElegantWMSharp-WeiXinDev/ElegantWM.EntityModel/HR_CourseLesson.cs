using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:01:35
 * 功能：HR_CourseLesson ORM
 **/

namespace ElegantWM.EntityModel
{
    public class HR_CourseLesson : Entity
    {
        public HR_CourseLesson() { }

        /// <summary>
        /// 课程ID
        /// </summary>
        public Guid Cid { get; set; }

        /// <summary>
        /// 课时名称
        /// </summary>
        public string LessonName { get; set; }

        /// <summary>
        /// 讲师姓名
        /// </summary>
        public string Teacher { get; set; }

        /// <summary>
        /// 对应积分
        /// </summary>
        public decimal Integration { get; set; }


        /// <summary>
        /// 报名人数
        /// </summary>
        public int Num { get; set; }

        /// <summary>
        /// 课时
        /// </summary>
        public int ClassHour { get; set; }

        /// <summary>
        /// 满意度模版类型
        /// </summary>
        public string SatisfactionType { get; set; }

        /// <summary>
        /// 上课时间
        /// </summary>
        public DateTime StartTime { get; set; }

        /// <summary>
        /// 下课时间
        /// </summary>
        public DateTime EndTime { get; set; }



    }
}
