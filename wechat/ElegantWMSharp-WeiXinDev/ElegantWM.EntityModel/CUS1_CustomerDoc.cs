using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014-10-24 10:17:40
 * 功能：CUS1_CustomerDoc ORM
 **/

namespace ElegantWM.EntityModel
{
    public class CUS1_CustomerDoc : Entity
    {
        public CUS1_CustomerDoc() { }

		/// <summary>
		/// M01P_ID
		/// </summary>
		public string M01P_ID { get; set; }
		
		/// <summary>
		/// M02C_ID
		/// </summary>
		public string M02C_ID { get; set; }
		
		/// <summary>
		/// Code
		/// </summary>
		public string Code { get; set; }
		
		/// <summary>
		/// Name
		/// </summary>
		public string Name { get; set; }
		
		/// <summary>
		/// VIPCard
		/// </summary>
		public string VIPCard { get; set; }
		
		/// <summary>
		/// MobileNum
		/// </summary>
		public string MobileNum { get; set; }
		
		/// <summary>
		/// BatchNo
		/// </summary>
		public string BatchNo { get; set; }
		
		/// <summary>
		/// DeptID
		/// </summary>
		public string DeptID { get; set; }
		
		/// <summary>
		/// Depotid
		/// </summary>
		public string Depotid { get; set; }
		
		/// <summary>
		/// deptName
		/// </summary>
		public string deptName { get; set; }
		
		/// <summary>
		/// CompanyName
		/// </summary>
		public string CompanyName { get; set; }
		
		/// <summary>
		/// points
		/// </summary>
		public decimal points { get; set; }
		
		/// <summary>
		/// LoyaltyType
		/// </summary>
		public string LoyaltyType { get; set; }
		
		/// <summary>
		/// Age
		/// </summary>
		public decimal Age { get; set; }
		
		/// <summary>
		/// TwelveMonthsConsumptionNum
		/// </summary>
		public decimal TwelveMonthsConsumptionNum { get; set; }
		
		/// <summary>
		/// Birthday
		/// </summary>
		public DateTime Birthday { get; set; }
		
		/// <summary>
		/// Level
		/// </summary>
		public string Level { get; set; }
		
		/// <summary>
		/// CustomerManager
		/// </summary>
		public string CustomerManager { get; set; }
		
		/// <summary>
		/// SeekDate
		/// </summary>
		public DateTime SeekDate { get; set; }
		
		/// <summary>
		/// CustomerManagerID
		/// </summary>
		public string CustomerManagerID { get; set; }
		
		/// <summary>
		/// VIPID
		/// </summary>
		public string VIPID { get; set; }
		
		/// <summary>
		/// RecentConsumptionDate
		/// </summary>
		public DateTime RecentConsumptionDate { get; set; }
		
		/// <summary>
		/// RecentConsumptionAmount
		/// </summary>
		public decimal RecentConsumptionAmount { get; set; }
		
		/// <summary>
		/// ThisYearConsumptionAmount
		/// </summary>
		public decimal ThisYearConsumptionAmount { get; set; }
		
		/// <summary>
		/// LastYearConsumpitonAmount
		/// </summary>
		public decimal LastYearConsumpitonAmount { get; set; }
		
		/// <summary>
		/// TwelveMonthsConsumptionAmount
		/// </summary>
		public decimal TwelveMonthsConsumptionAmount { get; set; }
		
		/// <summary>
		/// TotalNum
		/// </summary>
		public long TotalNum { get; set; }
		
		/// <summary>
		/// TotalAmount
		/// </summary>
		public decimal TotalAmount { get; set; }
		

         
    }
}
