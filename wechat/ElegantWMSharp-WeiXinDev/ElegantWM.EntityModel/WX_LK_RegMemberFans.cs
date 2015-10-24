using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/8/7 10:29:39
 * 功能：WX_LK_RegMemberFans ORM
 **/

namespace ElegantWM.EntityModel
{
    public class WX_LK_RegMemberFans : Entity
    {
        public WX_LK_RegMemberFans() { }

		/// <summary>
		/// 微信号ID
		/// </summary>
		public Guid AccountId { get; set; }
		
		/// <summary>
		/// 手机号
		/// </summary>
		public string Telphone { get; set; }
		
		/// <summary>
		/// OpenId
		/// </summary>
		public string OpenId { get; set; }
		
		/// <summary>
		/// 是否绑定
		/// </summary>
		public int IsUsing { get; set; }
		

         
    }
}
