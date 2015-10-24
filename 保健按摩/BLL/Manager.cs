using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EPReper.DALFactory;
using EPReper.IDAL;
using EPReper.Model;
using System.Data;

namespace EPReper.BLL
{
    public partial class Manager
    {
        private readonly IManager dal = DataAccess.CreateManager();
        public Manager() { }

        /// <summary>
        /// 添加维修人员
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public int Add(EPReper.Model.Manager model)
        {
            return dal.Add(model);
        }
        /// <summary>
        /// 设置管理员
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public int uPAdmin(int id)
        {
            return dal.uPAdmin(id);
        }
        public int downAdmin(int id)
        {
            return dal.downAdmin(id);
        }
        public int has(string strWhere)
        {
            return dal.has(strWhere);
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }
        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            return dal.GetList(Top, strWhere, filedOrder);
        }
        /// <summary>
        /// 删除数据
        /// </summary>
        public bool Delete(int id)
        {
            return dal.Delete(id);
        }

        public DataTable GetPage(string sqlWhere, int PageIndex, int PageSize, out int RecordCount, out int PageCount)
        {
            return dal.GetPage(sqlWhere, PageIndex, PageSize, out RecordCount, out PageCount);
        }
        /// </summary>
        public EPReper.Model.Manager GetModel(int id)
        {

            return dal.GetModel(id);
        }

        public bool Update(Model.Manager manager)
        {
            return dal.Update(manager);
        }

        public bool changes(string repair)
        {
            return dal.changes(repair);
        }

        public bool upworks(string username)
        {
            return dal.upworks(username);
        }
    }
}
