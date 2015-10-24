using System;
namespace EPReper.Model
{
	/// <summary>
	/// RepairInfo:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class RepairInfo
	{
		public RepairInfo()
		{}
		#region Model
		private int _id;
        private string _basecode;
        private int? _bigid;
		private int? _classid;
		private int? _userid;
        private int? _reperid;
		private int? _point;
		private DateTime? _uptime;
		private DateTime? _dotime;
		private DateTime? _overtime;
		private string _times;
		private string _startcomment;
		private string _overcomment;
		private int? _finish;
		private int? _isdel;
        private string _applyphone;
        private string _repairphone;
        private int? _code;
		/// <summary>
		/// 
		/// </summary>
		public int id
		{
			set{ _id=value;}
			get{return _id;}
		}
        public string BaseCode
        {
            set { _basecode = value; }
            get { return _basecode; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? BigID
        {
            set { _bigid = value; }
            get { return _bigid; }
        }
		/// <summary>
		/// 
		/// </summary>
		public int? ClassID
		{
			set{ _classid=value;}
			get{return _classid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? userID
		{
			set{ _userid=value;}
			get{return _userid;}
		}
        /// <summary>
        /// 
        /// </summary>
        public int? ReperID
        {
            set { _reperid = value; }
            get { return _reperid; }
        }
		/// <summary>
		/// 
		/// </summary>
		public int? point
		{
			set{ _point=value;}
			get{return _point;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UpTime
		{
			set{ _uptime=value;}
			get{return _uptime;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DoTime
		{
			set{ _dotime=value;}
			get{return _dotime;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? OverTime
		{
			set{ _overtime=value;}
			get{return _overtime;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Times
		{
			set{ _times=value;}
			get{return _times;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string StartComment
		{
			set{ _startcomment=value;}
			get{return _startcomment;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string OverComment
		{
			set{ _overcomment=value;}
			get{return _overcomment;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? Finish
		{
			set{ _finish=value;}
			get{return _finish;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? isDel
		{
			set{ _isdel=value;}
			get{return _isdel;}
		}

        public string applyPhone
        {
            set { _applyphone = value; }
            get { return _applyphone; }
        }

        public string repairPhone
        {
            set { _repairphone = value; }
            get { return _repairphone; }
        }

        public int? code
        {
            set { _code = value; }
            get { return _code; }
        }
		#endregion Model

	}
}

