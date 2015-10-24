using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2015-07-27 16:28:03
 * 功能：WX_QR_Code ORM
 **/

namespace ElegantWM.EntityModel
{
    public class WX_QR_Code : Entity
    {
        public WX_QR_Code() { }

		/// <summary>
		/// 微信号
		/// </summary>
		public Guid AccountId { get; set; }
		
		/// <summary>
		/// 二维码URL
		/// </summary>
		public string Url { get; set; }
		
		/// <summary>
		/// 二维码类型
		/// </summary>
		public string Action_Name { get; set; }
		
		/// <summary>
		/// 场景号
		/// </summary>
		public int Scene_ID { get; set; }
		
		/// <summary>
		/// 场景介绍
		/// </summary>
		public string Scene_Name { get; set; }
		
		/// <summary>
		/// 场景事件
		/// </summary>
		public string Scene_Key { get; set; }
		
		/// <summary>
		/// 场景参数1
		/// </summary>
		public string Scene_Param1 { get; set; }
		
		/// <summary>
		/// 场景参数2
		/// </summary>
		public string Scene_Param2 { get; set; }
		
		/// <summary>
		/// 是否使用
		/// </summary>
		public int IsUsed { get; set; }
		

         
    }
}
