using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/11/18 15:53:26
 * 功能：Game_QAVolunteer ORM
 **/

namespace ElegantWM.EntityModel
{
    public class Game_QAVolunteer : Entity
    {
        public Game_QAVolunteer() { }

		/// <summary>
		/// Oid
		/// </summary>
		public string Oid { get; set; }
		
		/// <summary>
		/// 志愿者姓名
		/// </summary>
		public string VTName { get; set; }
		
		/// <summary>
		/// 志愿者手机
		/// </summary>
		public string VtPhone { get; set; }
		
		/// <summary>
		/// 志愿者地址
		/// </summary>
		public string VtAddress { get; set; }
		
		/// <summary>
		/// 申请原因
		/// </summary>
		public string VtReason { get; set; }

        /// <summary>
        /// 组别
        /// </summary>
        public int Type { get; set; }

		/// <summary>
		/// TntId
		/// </summary>
		public Guid TntId { get; set; }
		

         
    }
}
