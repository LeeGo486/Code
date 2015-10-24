using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/8/27 10:26:30
 * 功能：Shop_Event ORM
 **/

namespace ElegantWM.EntityModel
{
    public class Shop_Event : Entity
    {
        public Shop_Event() { }

		/// <summary>
		/// 活动ID
		/// </summary>
		public Guid EventId { get; set; }
		
		/// <summary>
		/// 活动名称
		/// </summary>
		public string EventName { get; set; }
		
		/// <summary>
		/// 是否结束
		/// </summary>
		public int isOver { get; set; }
		

         
    }
}
