using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:00:30
 * 功能：HR_CourseAttend ORM
 **/

namespace ElegantWM.EntityModel
{
    public class HR_CourseAttend : Entity
    {
        public HR_CourseAttend() { }

		/// <summary>
		/// 课时ID
		/// </summary>
		public Guid Lid { get; set; }
		
		/// <summary>
		/// 员工ID
		/// </summary>
		public Guid Uid { get; set; }
		

         
    }
}
