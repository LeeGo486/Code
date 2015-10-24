using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/26 9:43:53
 * 功能：WX_LK_FansC3AM ORM
 **/

namespace ElegantWM.EntityModel
{
    public class WX_LK_FansC3AM : Entity
    {
        public WX_LK_FansC3AM() { }

		/// <summary>
		/// 公众账号ID
		/// </summary>
		public Guid AccountId { get; set; }
		
		/// <summary>
		/// OpenId
		/// </summary>
		public string OpenId { get; set; }
		
		/// <summary>
		/// AM用户ID
		/// </summary>
		public Guid Uid { get; set; }
		
		/// <summary>
		/// AM用户名
		/// </summary>
		public string UserName { get; set; }
		
		/// <summary>
		/// 令牌ID
		/// </summary>
		public Guid TokenId { get; set; }
		

         
    }
}
