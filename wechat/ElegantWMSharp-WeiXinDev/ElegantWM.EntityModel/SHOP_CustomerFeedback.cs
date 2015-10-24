using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/7/30 16:16:50
 * 功能：SHOP_CustomerFeedback ORM
 **/

namespace ElegantWM.EntityModel
{
    public class SHOP_CustomerFeedback : Entity
    {
        public SHOP_CustomerFeedback() { }

        /// <summary>
        /// 店铺名称
        /// </summary>
        public string DepotId { get; set; }
		
		/// <summary>
		/// 分公司
		/// </summary>
		public string Branch { get; set; }
		
		/// <summary>
		/// 店铺名称
		/// </summary>
		public string DepotName { get; set; }
		
		/// <summary>
		/// 客户经理
		/// </summary>
		public string CusManager { get; set; }
		
		/// <summary>
		/// 反馈类型
		/// </summary>
		public Guid TypeId { get; set; }
		
		/// <summary>
		/// 反馈子类型
		/// </summary>
		public Guid SubTypeId { get; set; }
		
		/// <summary>
		/// 手机
		/// </summary>
		public string Mobile { get; set; }
		
		/// <summary>
		/// 客户名称
		/// </summary>
		public string CusName { get; set; }
		
		/// <summary>
		/// 年龄
		/// </summary>
		public int Age { get; set; }
		
		/// <summary>
		/// 近12月消费
		/// </summary>
		public decimal Last12MonthAmount { get; set; }
		
		/// <summary>
		/// 职业
		/// </summary>
		public Guid ProfessionId { get; set; }
		
		/// <summary>
		/// 身高
		/// </summary>
		public Guid HeightId { get; set; }
		
		/// <summary>
		/// 体型
		/// </summary>
		public Guid FigureId { get; set; }
		
		/// <summary>
		/// SKC
		/// </summary>
		public string SKC { get; set; }
		
		/// <summary>
		/// 系列
		/// </summary>
		public string Series { get; set; }
		
		/// <summary>
		/// 反馈描述
		/// </summary>
		public string Remark { get; set; }
		
		/// <summary>
		/// 是否删除
		/// </summary>
		public int IsDelete { get; set; }
		
		/// <summary>
		/// 帐套
		/// </summary>
		public Guid TntId { get; set; }
		

         
    }
}
