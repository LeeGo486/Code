using System;
namespace EPReper.Model
{
	/// <summary>
	/// Userinfo:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Userinfo
	{
		public Userinfo()
		{}
		#region Model
		private int _id;
		private string _username;
		private string _department;
		private string _phone;
		private string _amnum;
		private string _qq;
		private string _email;
		private int? _urole;
		/// <summary>
		/// 
		/// </summary>
		public int id
		{
			set{ _id=value;}
			get{return _id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string username
		{
			set{ _username=value;}
			get{return _username;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string department
		{
			set{ _department=value;}
			get{return _department;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string phone
		{
			set{ _phone=value;}
			get{return _phone;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string AMNum
		{
			set{ _amnum=value;}
			get{return _amnum;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string QQ
		{
			set{ _qq=value;}
			get{return _qq;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Email
		{
			set{ _email=value;}
			get{return _email;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? URole
		{
			set{ _urole=value;}
			get{return _urole;}
		}
		#endregion Model

	}
}

