using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/12/19 9:15:41
 * 功能：Game_Award ORM
 **/

namespace ElegantWM.EntityModel
{
    public class Game_Award : Entity
    {
        public Game_Award() { }

		/// <summary>
		/// 名称
		/// </summary>
		public string Name { get; set; }
		
		/// <summary>
		/// 组别
		/// </summary>
		public int Group { get; set; }
		
		/// <summary>
		/// 奖品等级
		/// </summary>
		public int Level { get; set; }
		
		/// <summary>
		/// 数量
		/// </summary>
		public int TotalNum { get; set; }
		
		/// <summary>
		/// 剩余数量
		/// </summary>
		public int PNum { get; set; }
		

         
    }
}
