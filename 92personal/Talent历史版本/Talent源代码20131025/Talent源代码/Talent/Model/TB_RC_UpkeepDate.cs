using System;
namespace Talent.Model
{
	/// <summary>
	/// TB_RC_UpkeepDate:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class TB_RC_UpkeepDate
	{
		public TB_RC_UpkeepDate()
		{}
		#region Model
		private int _ud_no;
		private int? _ud_cb_no;
		private int? _ud_ti_no;
		private DateTime? _ud_date;
		private string _ud_result;
		private string _ud_createper;
		private DateTime? _ud_createdate;
		/// <summary>
		/// 
		/// </summary>
		public int UD_No
		{
			set{ _ud_no=value;}
			get{return _ud_no;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? UD_CB_No
		{
			set{ _ud_cb_no=value;}
			get{return _ud_cb_no;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? UD_TI_No
		{
			set{ _ud_ti_no=value;}
			get{return _ud_ti_no;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UD_Date
		{
			set{ _ud_date=value;}
			get{return _ud_date;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string UD_Result
		{
			set{ _ud_result=value;}
			get{return _ud_result;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string UD_CreatePer
		{
			set{ _ud_createper=value;}
			get{return _ud_createper;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UD_CreateDate
		{
			set{ _ud_createdate=value;}
			get{return _ud_createdate;}
		}
		#endregion Model

	}
}

