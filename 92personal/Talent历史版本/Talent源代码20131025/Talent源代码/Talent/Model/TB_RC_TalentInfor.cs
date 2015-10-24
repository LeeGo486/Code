using System;
namespace Talent.Model
{
	/// <summary>
	/// TB_RC_TalentInfor:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class TB_RC_TalentInfor
	{
		public TB_RC_TalentInfor()
		{}
		#region Model
		private int _ti_no;
		private int? _ti_cb_no;
		private string _ti_brandname;
		private string _ti_talentclass;
		private string _ti_name;
		private string _ti_sex;
		private string _ti_phone;
		private string _ti_src;
		private string _ti_recommendpost;
		private string _ti_audition;
		private string _ti_auditionresult;
		private string _ti_followuppeople;
		private DateTime? _ti_maintaindate;
		private string _ti_maintainresult;
		private string _ti_createper;
		private DateTime? _ti_createdate;
        private  string _cb_name;
        private string _cb_position;
        private string _ti_mark;
        private string _ti_work;
        private string _ti_industry;
        private string _ti_recommend;
        private DateTime? _ti_recommenddate;
		/// <summary>
		/// 
		/// </summary>
		public int TI_No
		{
			set{ _ti_no=value;}
			get{return _ti_no;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? TI_CB_No
		{
			set{ _ti_cb_no=value;}
			get{return _ti_cb_no;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TI_BrandName
		{
			set{ _ti_brandname=value;}
			get{return _ti_brandname;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TI_TalentClass
		{
			set{ _ti_talentclass=value;}
			get{return _ti_talentclass;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TI_Name
		{
			set{ _ti_name=value;}
			get{return _ti_name;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TI_Sex
		{
			set{ _ti_sex=value;}
			get{return _ti_sex;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TI_Phone
		{
			set{ _ti_phone=value;}
			get{return _ti_phone;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TI_Src
		{
			set{ _ti_src=value;}
			get{return _ti_src;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TI_RecommendPost
		{
			set{ _ti_recommendpost=value;}
			get{return _ti_recommendpost;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TI_Audition
		{
			set{ _ti_audition=value;}
			get{return _ti_audition;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TI_AuditionResult
		{
			set{ _ti_auditionresult=value;}
			get{return _ti_auditionresult;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TI_FollowUpPeople
		{
			set{ _ti_followuppeople=value;}
			get{return _ti_followuppeople;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? TI_MaintainDate
		{
			set{ _ti_maintaindate=value;}
			get{return _ti_maintaindate;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TI_MaintainResult
		{
			set{ _ti_maintainresult=value;}
			get{return _ti_maintainresult;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TI_CreatePer
		{
			set{ _ti_createper=value;}
			get{return _ti_createper;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? TI_CreateDate
		{
			set{ _ti_createdate=value;}
			get{return _ti_createdate;}
		}

        public string CB_Name
        {
            set { _cb_name = value; }
            get { return _cb_name; }
        }

        public string CB_Position
        {
            set { _cb_position = value; }
            get { return _cb_position; }
        }

        public string TI_Mark
        {
            set { _ti_mark = value; }
            get { return _ti_mark; }
        }

        public string TI_Work
        {
            set { _ti_work = value; }
            get { return _ti_work; }
        }

        public string TI_Industry
        {
            set { _ti_industry = value; }
            get { return _ti_industry; }
        }

        public string TI_Recommend
        {
            set { _ti_recommend = value; }
            get { return _ti_recommend; }
        }

        public DateTime? TI_RecommendDate
        {
            set { _ti_recommenddate = value; }
            get { return _ti_recommenddate; }
        }

		#endregion Model

	}
}

