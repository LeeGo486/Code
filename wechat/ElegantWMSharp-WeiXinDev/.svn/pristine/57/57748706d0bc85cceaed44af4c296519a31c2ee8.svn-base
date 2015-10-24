using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:04:13
 * 功能：HR_LK_CourseUser ORM
 **/

namespace ElegantWM.EntityModel
{
    public class HR_LK_CourseUser : Entity
    {
        public HR_LK_CourseUser() { }

		/// <summary>
		/// 课程ID
		/// </summary>
		public Guid Cid { get; set; }

        /// <summary>
        /// 职位
        /// </summary>
        [ForeignKey("Cid")]
        public virtual HR_Course Course { get; set; }

		/// <summary>
		/// 员工ID
		/// </summary>
		public Guid Uid { get; set; }

        [ForeignKey("Uid")]
        public virtual HR_CourseUser User { get; set; }

         
    }
}
