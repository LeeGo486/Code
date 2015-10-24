using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/8/2 13:48:47
 * 功能：WX_KeyWord ORM
 **/

namespace ElegantWM.EntityModel
{
    public class WX_KeyWord : Entity
    {
        public WX_KeyWord() { }

		/// <summary>
		/// 微信ID
		/// </summary>
		public Guid AccountId { get; set; }
		
		/// <summary>
		/// 关键词
		/// </summary>
		public string KwList { get; set; }

        /// <summary>
        /// 响应类型
        /// </summary>
        public string RespType { get; set; }

		/// <summary>
		/// 是否使用
		/// </summary>
		public int IsUsing { get; set; }
		

    }
}
