using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014-03-21 16:10:13
 * 功能：HR_Jobs ORM
 **/

namespace ElegantWM.EntityModel
{
    public class HR_Jobs : Entity
    {
        public HR_Jobs() { }

		/// <summary>
		/// 职位名称
		/// </summary>
		public string JobName { get; set; }
		
		/// <summary>
		/// 招聘人数
		/// </summary>
		public int NeedNum { get; set; }
		
		/// <summary>
		/// 岗位职责
		/// </summary>
		public string Responsibilities { get; set; }
		
		/// <summary>
		/// 任职要求
		/// </summary>
		public string Skills { get; set; }
		
		/// <summary>
		/// 应聘邮箱
		/// </summary>
		public string Email { get; set; }
		
		/// <summary>
		/// 显示隐藏
		/// </summary>
		public int IsShow { get; set; }
		
		/// <summary>
		/// 置顶
		/// </summary>
		public int IsTop { get; set; }

        /// <summary>
        /// 求职人员列表
        /// </summary>
        public virtual ICollection<HR_JobSeeker> Seekers { get; set; }
         
    }
}
