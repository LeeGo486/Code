using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/7/1 13:37:11
 * 功能：ITSM_EventLog ORM
 **/

namespace ElegantWM.EntityModel
{
    public class ITSM_EventLog : Entity
    {
        public ITSM_EventLog() { }

		/// <summary>
		/// 事件ID
		/// </summary>
		public Guid Eid { get; set; }
		
		/// <summary>
		/// 原由
		/// </summary>
		public string Reason { get; set; }
		
		/// <summary>
		/// 备注
		/// </summary>
		public string Remark { get; set; }
		
		/// <summary>
		/// 租户ID
		/// </summary>
		public Guid TntId { get; set; }
		

         
    }
}
