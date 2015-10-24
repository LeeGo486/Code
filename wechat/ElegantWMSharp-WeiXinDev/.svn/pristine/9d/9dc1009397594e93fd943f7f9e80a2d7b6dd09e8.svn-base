using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/11/17 15:07:32
 * 功能：Game_Answer ORM
 **/

namespace ElegantWM.EntityModel
{
    public class Game_Answer : Entity
    {
        public Game_Answer() { }

		/// <summary>
		/// 问题ID
		/// </summary>
        
		public Guid Qid { get; set; }

        [ForeignKey("Qid")]
        public virtual Game_Question Question { get; set; }

		/// <summary>
		/// 选项
		/// </summary>
		public string Answer { get; set; }

		/// <summary>
		/// 答案
		/// </summary>
		public int IsRight { get; set; }

        /// <summary>
        /// 组别
        /// </summary>
        public int Type { get; set; }
    }
}
