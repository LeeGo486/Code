using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/11 17:25:23
 * 功能：WX_Fans ORM
 **/

namespace ElegantWM.EntityModel
{
    public class WX_Fans : Entity
    {
        public WX_Fans() { }

		/// <summary>
		/// 公众账号ID
		/// </summary>
		public Guid AccountId { get; set; }
		
		/// <summary>
		/// OpenId
		/// </summary>
		public string OpenId { get; set; }
		
		/// <summary>
		/// 昵称
		/// </summary>
		public string NickName { get; set; }
		
		/// <summary>
		/// 性别
		/// </summary>
		public int? Sex { get; set; }
		
		/// <summary>
		/// 城市
		/// </summary>
		public string City { get; set; }
		
		/// <summary>
		/// 省份
		/// </summary>
		public string Province { get; set; }
		
		/// <summary>
		/// 国家
		/// </summary>
		public string Country { get; set; }
		
		/// <summary>
		/// 头像
		/// </summary>
		public string Avatar { get; set; }

        /// <summary>
        /// 使用中
        /// </summary>
        public int IsUsed { get; set; }
         
    }
}
