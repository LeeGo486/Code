using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014-12-09 18:04:31
 * 功能：Fire_Question ORM
 **/

namespace ElegantWM.EntityModel
{
    public class Fire_Question : Entity
    {
        public Fire_Question() { }

		/// <summary>
		/// Question
		/// </summary>
		public string Question { get; set; }
		
		/// <summary>
		/// QImage
		/// </summary>
		public string QImage { get; set; }
		
		/// <summary>
		/// TntId
		/// </summary>
		public Guid TntId { get; set; }
		

         
    }
}
