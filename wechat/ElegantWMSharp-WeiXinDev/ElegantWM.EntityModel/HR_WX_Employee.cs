using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/17 19:01:20
 * 功能：HR_WX_Employee ORM
 **/

namespace ElegantWM.EntityModel
{
    public class HR_WX_Employee : Entity
    {
        public HR_WX_Employee() { }

		/// <summary>
		/// 工号
		/// </summary>
		public string c_code { get; set; }
		
		/// <summary>
		/// 姓名
		/// </summary>
		public string c_name { get; set; }
		
		/// <summary>
		/// 部门
		/// </summary>
		public string c_unitname { get; set; }
		
		/// <summary>
		/// 职位
		/// </summary>
		public string c_jobname { get; set; }
		

         
    }
}
