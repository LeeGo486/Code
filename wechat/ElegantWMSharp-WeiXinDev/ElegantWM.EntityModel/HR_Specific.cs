using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2015-01-13 21:13:31
 * 功能：HR_Specific ORM
 **/

namespace ElegantWM.EntityModel
{
    public class HR_Specific : Entity
    {
        public HR_Specific() { }

		/// <summary>
		/// 课程id
		/// </summary>
		public Guid CourseID { get; set; }
		
		/// <summary>
		/// 可报名的人
		/// </summary>
        public string UserName { get; set; }
		

         
    }
}
