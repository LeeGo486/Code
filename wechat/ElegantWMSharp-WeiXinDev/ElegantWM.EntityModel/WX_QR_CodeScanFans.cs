using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2015-07-27 16:31:42
 * 功能：WX_QR_CodeScanFans ORM
 **/

namespace ElegantWM.EntityModel
{
    public class WX_QR_CodeScanFans : Entity
    {
        public WX_QR_CodeScanFans() { }

		/// <summary>
		/// 微信号
		/// </summary>
		public Guid AccountId { get; set; }
		
		/// <summary>
		/// 用户微信号
		/// </summary>
		public string Oid { get; set; }
		
		/// <summary>
		/// 场景号
		/// </summary>
		public int Scene_ID { get; set; }
		
		/// <summary>
		/// 场景类型
		/// </summary>
		public string Scene_Key { get; set; }
		
		/// <summary>
		/// 场景名称
		/// </summary>
		public string Scene_Name { get; set; }
		
		/// <summary>
		/// 场景参数1
		/// </summary>
		public string Scene_Param1 { get; set; }
		
		/// <summary>
		/// 场景参数2
		/// </summary>
		public string Scene_Param2 { get; set; }
		

         
    }
}
