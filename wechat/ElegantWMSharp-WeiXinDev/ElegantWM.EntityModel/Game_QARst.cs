using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/11/17 15:07:54
 * 功能：Game_QARst ORM
 **/

namespace ElegantWM.EntityModel
{
    public class Game_QARst : Entity
    {
        public Game_QARst() { }

		/// <summary>
		/// 用户
		/// </summary>
		public string Oid { get; set; }

        /// <summary>
        /// 组别
        /// </summary>
        public int Type { get; set; }

        /// <summary>
		/// 得分
		/// </summary>
		public int Total { get; set; }
		
		/// <summary>
		/// TntId
		/// </summary>
		public Guid TntId { get; set; }

    }
}
