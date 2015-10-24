using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/21 17:30:41
 * 功能：V_HR_CourseSignRst ORM
 **/

namespace ElegantWM.EntityModel
{
    public class V_HR_CourseSignRst
    {
        public V_HR_CourseSignRst() { }

		/// <summary>
		/// 课程ID
		/// </summary>
		public Guid Cid { get; set; }
		
		/// <summary>
		/// 课时ID
		/// </summary>
        [Key]
        [Column("Lid", Order = 0)]
		public Guid Lid { get; set; }
		
		/// <summary>
		/// 用户ID
		/// </summary>
        [Key]
        [Column("Uid", Order = 1)]
		public Guid Uid { get; set; }

        /// <summary>
        /// 用户名
        /// </summary>
        public string UserName { get; set; }
		/// <summary>
		/// 课时名
		/// </summary>
		public string LessonName { get; set; }
		
		/// <summary>
		/// 上课时间
		/// </summary>
		public DateTime StartTime { get; set; }
		
		/// <summary>
		/// 下课时间
		/// </summary>
		public DateTime EndTime { get; set; }

        /// <summary>
        /// 签到时间
        /// </summary>
        public DateTime? CreateTime { get; set; }

		/// <summary>
		/// 状态
		/// </summary>
		public string SignRst { get; set; }
		

         
    }
}
