using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/11/17 15:07:04
 * 功能：Game_Question ORM
 **/

namespace ElegantWM.EntityModel
{
    public class Game_Question : Entity
    {
        public Game_Question() { }

		/// <summary>
		/// 问题
		/// </summary>
		public string Question { get; set; }

        /// <summary>
        /// 组别
        /// </summary>
        public int Type { get; set; }

        /// <summary>
        /// 带图片的题目
        /// </summary>
        public string QImage { get; set; }

		/// <summary>
		/// TntId
		/// </summary>
		public Guid TntId { get; set; }

        public virtual ICollection<Game_Answer> Answer { get; set; }
         
    }
}
