using System;
using System.Data;
namespace EPReper.IDAL
{
	/// <summary>
	/// 接口层Userinfo
	/// </summary>
	public interface IUserinfo
	{
		#region  成员方法
		/// <summary>
		/// 得到最大ID
		/// </summary>
		int GetMaxId();
		/// <summary>
		/// 增加一条数据
		/// </summary>
		bool Add(EPReper.Model.Userinfo model);
		/// <summary>
		/// 更新一条数据
		/// </summary>
		bool Update(EPReper.Model.Userinfo model);
		/// <summary>
		/// 删除一条数据
		/// </summary>
		bool Delete(int id);
		bool DeleteList(string idlist );
		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		EPReper.Model.Userinfo GetModel(int id);
		/// <summary>
		/// 获得数据列表
		/// </summary>
		DataSet GetList(string strWhere);
		/// <summary>
		/// 获得前几行数据
		/// </summary>
		DataSet GetList(int Top,string strWhere,string filedOrder);
		/// <summary>
		/// 根据分页获得数据列表
		/// </summary>
		//DataSet GetList(int PageSize,int PageIndex,string strWhere);

        DataTable GetTable(string strWhere, string filedOrder);

        DataTable GetInfo(string strWhere);

        bool AddAmDetail(string username, string subject, string content);
		#endregion  成员方法









        bool Login(string loginname, string password);

        bool SendMSG(string MessageContent, string DestinationAddress);
    } 
}
