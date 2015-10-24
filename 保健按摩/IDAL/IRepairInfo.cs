using System;
using System.Data;
namespace EPReper.IDAL
{
    /// <summary>
    /// 接口层RepairInfo
    /// </summary>
    public interface IRepairInfo
    {
        #region  成员方法
        /// <summary>
        /// 得到最大ID
        /// </summary>
        int GetMaxId();
        /// <summary>
        /// 增加一条数据
        /// </summary>
        int Add(EPReper.Model.RepairInfo model);
        /// <summary>
        /// 更新一条数据
        /// </summary>
        bool UpdateDal(string id, string userid, string repairphone);
        bool UpdateEnd(string id, string endComment);
        bool Update(EPReper.Model.RepairInfo model);
        /// <summary>
        /// 删除一条数据
        /// </summary>
        bool Delete(int id);
        bool DeleteList(string idlist);
        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        EPReper.Model.RepairInfo GetModel(int id);
        /// <summary>
        /// 获得数据列表
        /// </summary>
        DataSet GetList(string strWhere);
        /// <summary>
        /// 获得前几行数据
        /// </summary>
        DataSet GetList(int Top, string strWhere, string filedOrder);
        /// <summary>
        /// 根据分页获得数据列表
        /// </summary>
        //DataSet GetList(int PageSize,int PageIndex,string strWhere);

        DataTable GetPage(string sqlWhere, int PageIndex, int PageSize, out int RecordCount, out int PageCount);

        int counts(int bigid);
        #endregion  成员方法





        bool UpCode(string bigid, string code);

        int GetCount(string id,string sqlwhere);
    }
}
