using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014-10-21 17:53:47
 * 功能：TK2_TaskDetail ORM
 **/

namespace ElegantWM.EntityModel
{
    public class TK2_TaskDetail : Entity
    {
        public TK2_TaskDetail() { }

		/// <summary>
		/// 任务ID
		/// </summary>
		public string TK1_ID { get; set; }
		
		/// <summary>
		/// 任务明细排列序号
		/// </summary>
		public string Seq { get; set; }
		
		/// <summary>
		/// 任务明细名称
		/// </summary>
		public string Name { get; set; }
		
		/// <summary>
		/// 任务明细描述
		/// </summary>
		public string Desp { get; set; }
		
		/// <summary>
		/// 预约状态
		/// </summary>
		public string Status { get; set; }
		
		/// <summary>
		/// 任务明细有效状态Code
		/// </summary>
		public string ValidateState { get; set; }
		
		/// <summary>
		/// 任务明细有效期开始
		/// </summary>
		public DateTime ValidateFrom { get; set; }
		
		/// <summary>
		/// 任务明细有效期结束
		/// </summary>
		public DateTime ValidateTo { get; set; }
		
		/// <summary>
		/// CUS1_ID
		/// </summary>
		public string CUS1_ID { get; set; }
		
		/// <summary>
		/// 店铺编号
		/// </summary>
		public string Depotid { get; set; }
		
		/// <summary>
		/// 预约时间
		/// </summary>
		public DateTime ReservationDate { get; set; }
		
		/// <summary>
		/// 预约结果ID
		/// </summary>
		public string DICP_ID_Result { get; set; }
		
		/// <summary>
		/// 原因ID
		/// </summary>
		public string DICP_ID_Reason { get; set; }
		
		/// <summary>
		/// 是否有价值信息
		/// </summary>
		public string ValueInformation { get; set; }
		
		/// <summary>
		/// 预约反馈
		/// </summary>
		public string Feedback { get; set; }
		
		/// <summary>
		/// 应邀日期
		/// </summary>
		public DateTime InvitationDate { get; set; }
		
		/// <summary>
		/// 再次预约时间
		/// </summary>
		public DateTime ReservationDateAgain { get; set; }
		
		/// <summary>
		/// 提交时间
		/// </summary>
		public DateTime SubmitTime { get; set; }
		

         
    }
}
