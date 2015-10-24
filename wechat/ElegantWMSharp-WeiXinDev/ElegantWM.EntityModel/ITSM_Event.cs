using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/30 22:37:06
 * 功能：ITSM_Event ORM
 **/

namespace ElegantWM.EntityModel
{
    public class ITSM_Event : Entity
    {
        public ITSM_Event() { }

		/// <summary>
		/// 提报人
		/// </summary>
		public string ReqMan { get; set; }
		
		/// <summary>
		/// 提报公司
		/// </summary>
		public string ReqCom { get; set; }
		
		/// <summary>
		/// 提报部门
		/// </summary>
		public string ReqDept { get; set; }
		
		/// <summary>
		/// 提报人手机
		/// </summary>
		public string ReqManPhone { get; set; }
		
		/// <summary>
		/// 提报地点
		/// </summary>
		public string ReqIncident { get; set; }
		
		/// <summary>
		/// 事件描述
		/// </summary>
		public string EventDesc { get; set; }

        /// <summary>
        /// 事件设备
        /// </summary>
        public string EventEquipment { get; set; }

        /// <summary>
        /// 事件应用
        /// </summary>
        public string EventApp { get; set; }

        /// <summary>
        /// 事件解决方案
        /// </summary>
        public string EventSolution { get; set; }

		/// <summary>
		/// 工程师
		/// </summary>
		public string Engineer { get; set; }
		
		/// <summary>
		/// 状态
		/// </summary>
		public int ProcessStatus { get; set; }
		
		/// <summary>
		/// 及时率
		/// </summary>
		public int ElvTime { get; set; }
		
		/// <summary>
		/// 服务态度
		/// </summary>
		public int ElvAtude { get; set; }
		
		/// <summary>
		/// 服务结果
		/// </summary>
		public int ElvRst { get; set; }
		
		/// <summary>
		/// 评价
		/// </summary>
		public string ElvDesc { get; set; }

        /// <summary>
        /// 租户ID
        /// </summary>
        public Guid TntId { get; set; }

        /// <summary>
        /// 事件编号
        /// </summary>
        public string Code { get; set; }

        /// <summary>
        /// 工程师电话
        /// </summary>
        public string EngineerPhone { get; set; }

        /// <summary>
        /// 附件
        /// </summary>
        public string FileUrl { get; set; }
         
    }
}
