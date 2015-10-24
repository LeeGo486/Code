using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/4 16:02:43
 * 功能：HR_CourseUser ORM
 **/

namespace ElegantWM.EntityModel
{
    public class HR_CourseUser : Entity
    {
        public HR_CourseUser() { }

		/// <summary>
		/// 微信ID
		/// </summary>
		public string OpenId { get; set; }
		
		/// <summary>
		/// 员工姓名
		/// </summary>
		public string UserName { get; set; }
		
		/// <summary>
		/// 员工工号
		/// </summary>
		public string EmployeeID { get; set; }

        /// <summary>
        /// 用户课程关联
        /// </summary>
        public virtual ICollection<HR_LK_CourseUser> Courses { get; set; }
         
    }
}
