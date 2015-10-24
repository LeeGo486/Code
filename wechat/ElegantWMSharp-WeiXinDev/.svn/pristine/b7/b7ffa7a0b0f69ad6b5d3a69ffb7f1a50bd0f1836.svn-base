using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014-03-21 16:10:48
 * 功能：HR_JobSeeker ORM
 **/

namespace ElegantWM.EntityModel
{
    public class HR_JobSeeker : Entity
    {
        public HR_JobSeeker() { }

		/// <summary>
		/// 职位ID
		/// </summary>
		public Guid JobId { get; set; }

        /// <summary>
        /// 职位
        /// </summary>
        [ForeignKey("JobId")]
        public virtual HR_Jobs Job { get; set; }

		/// <summary>
		/// 姓名
		/// </summary>
		public string SkrName { get; set; }
		
		/// <summary>
		/// 性别
		/// </summary>
		public string SkrSex { get; set; }
		
		/// <summary>
		/// 联系电话
		/// </summary>
		public string Telphone { get; set; }

        /// <summary>
        /// 内部员工工号
        /// </summary>
        public string EmployeeId { get; set; }

		/// <summary>
		/// 申请理由
		/// </summary>
		public string Remark { get; set; }

         
    }
}
