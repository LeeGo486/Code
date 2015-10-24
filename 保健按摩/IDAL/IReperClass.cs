using System;
using System.Data;
namespace EPReper.IDAL
{
	/// <summary>
	/// 接口层Class
	/// </summary>
	public interface IReperClass
	{
		#region  成员方法
		/// <summary>
		/// 得到最大ID
		/// </summary>
		int GetMaxId();
		/// <summary>
		/// 增加一条数据
		/// </summary>
		int Add(EPReper.Model.ReperClass model);
		/// <summary>
		/// 更新一条数据
		/// </summary>
		bool Update(EPReper.Model.ReperClass model);
        bool Update(int id);
		/// <summary>
		/// 删除一条数据
		/// </summary>
		bool Delete(int id);
		bool DeleteList(string idlist );
		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		EPReper.Model.ReperClass GetModel(int id);
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


        /// <summary>
        /// 获得数据列表
        /// </summary>
        DataTable GetTable(int Top, string strWhere, string filedOrder);
        DataTable GetPage(string sqlWhere, int PageIndex, int PageSize, out int RecordCount, out int PageCount);
		#endregion  成员方法





        bool UpdateDel(int id);

        DataSet GetLists(string id);
    } 
}
