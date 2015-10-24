using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2015/3/4 11:14:24
 * 功能：Game_Link ORM
 **/

namespace ElegantWM.EntityModel
{
    public class Game_Link : Entity
    {
        public Game_Link() { }

		/// <summary>
		/// 组别
		/// </summary>
		public int Group { get; set; }
		
		/// <summary>
		/// 微信ID
		/// </summary>
		public string Oid { get; set; }

        /// <summary>
        /// 微信昵称
        /// </summary>
        public string NickName { get; set; }

        /// <summary>
        /// 微信头像
        /// </summary>
        public string Avatar { get; set; }

        /// <summary>
        /// 操作
        /// </summary>
        public string Oper { get; set; }

		/// <summary>
		/// 链接者ID
		/// </summary>
		public string Lid { get; set; }
		

         
    }
}
