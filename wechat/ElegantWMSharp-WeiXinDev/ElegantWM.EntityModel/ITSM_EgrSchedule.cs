using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/7/9 13:58:31
 * 功能：ITSM_EgrSchedule ORM
 **/

namespace ElegantWM.EntityModel
{
    public class ITSM_EgrSchedule : Entity
    {
        public ITSM_EgrSchedule() { }

		/// <summary>
		/// 类型
		/// </summary>
		public string CategoryId { get; set; }
		
		/// <summary>
		/// 事件标题
		/// </summary>
		public string EventTitle { get; set; }
		
		/// <summary>
		/// 开始时间
		/// </summary>
		public DateTime StartDate { get; set; }
		
		/// <summary>
		/// 结束时间
		/// </summary>
		public DateTime EndDate { get; set; }
		
		/// <summary>
		/// 地点
		/// </summary>
		public string Location { get; set; }
		
		/// <summary>
		/// 备注
		/// </summary>
		public string Notes { get; set; }
		
		/// <summary>
		/// 链接
		/// </summary>
		public string LinkUrl { get; set; }
		
		/// <summary>
		/// 是否全天
		/// </summary>
		public bool IsAllDay { get; set; }
		
		/// <summary>
		/// 提醒时间
		/// </summary>
		public string Reminder { get; set; }
		

         
    }
}
