using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using ElegantWM.DAL;
using ElegantWM.EntityModel;
using ElegantWM.IBLL;
using ElegantWM.IDAL;
using ElegantWM.Tools;
using ElegantWM.Common;
using ElegantWM.DTO;
/**
 * 作者：陈杰
 * 时间：2012-08-10 00:25
 * 功能：业务层公共实现
 **/
namespace ElegantWM.BLL
{
    public class BaseService<T> : IBaseService<T> where T : class,IEntity
    {
        protected IEFRepository<T> IEF = null;
        public BaseService(IEFRepository<T> _ief = null)
        {
            if (_ief == null)
                IEF = new EFRepository<T>();
            else
                IEF = _ief;
        }
        /// <summary>
        /// 获取所有数据
        /// </summary>
        /// <returns></returns>
        public virtual IEnumerable<T> GetAll()
        {
            return IEF.GetAll();
        }
        /// <summary>
        /// 根据条件查找
        /// </summary>
        /// <param name="order">排序字段</param>
        /// <param name="filters">条件</param>
        /// <returns>返回List</returns>
        public virtual IEnumerable<T> FindByConditions(Func<IQueryable<T>, IOrderedQueryable<T>> order, Expression<Func<T, bool>> filter, ExtGridSearch eSearch = null)
        {
            //将eSearch转换为标准的linq查询
            if (eSearch != null)
            {
                Expression<Func<T, bool>> Conditions = ConvertExtSearch2Linq.Convert<T>(eSearch.fields, eSearch.query);
                filter = Conditions.And(filter);
            }
            return IEF.FindByConditions(order, filter);
        }
        /// <summary>
        /// 分页查找
        /// </summary>
        /// <param name="startIndex">开始记录</param>
        /// <param name="pageSize">页号</param>
        /// <param name="order">排序字段</param>
        /// <param name="filters">条件</param>
        /// <returns>返回当前页List</returns>
        public virtual IEnumerable<T> FindByPage(int startIndex, int pageSize, out int Total, Func<IQueryable<T>, IOrderedQueryable<T>> order, Expression<Func<T, bool>> filters, ExtGridSearch eSearch = null)
        {
            //将eSearch转换为标准的linq查询
            if (eSearch != null && eSearch.fields != null && !string.IsNullOrEmpty(eSearch.query))
            {
                Expression<Func<T, bool>> Conditions = ConvertExtSearch2Linq.Convert<T>(eSearch.fields, eSearch.query);
                filters = (filters == null ? Conditions : Conditions.And(filters));
            }
            return IEF.FindByPage(startIndex, pageSize, out Total, order, filters);
        }
        /// <summary>
        /// 获取记录数量
        /// </summary>
        /// <param name="filters">条件</param>
        /// <returns>返回记录号</returns>
        public virtual int GetCount(Expression<Func<T, bool>> filters)
        {
            return IEF.GetCount(filters);
        }
        /// <summary>
        /// 根据ID查找
        /// </summary>
        /// <param name="Id">ID</param>
        /// <returns>返回唯一实体</returns>
        public virtual T GetById(string Id)
        {
            return IEF.GetById(Id);
        }
        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="_t">实体</param>
        /// <returns>是否成功</returns>
        public virtual bool Insert(T _t)
        {
            //插入记录，自动为公共字段赋值
            if (_t.Id == null || _t.Id == Guid.Parse("00000000-0000-0000-0000-000000000000"))
                _t.Id = Guid.NewGuid();
            _t.CreateTime = DateTime.Now;
            if(string.IsNullOrEmpty(_t.CreateUser))
                _t.CreateUser = AuthToken.CurrentUser.UserName;
            //_t.ModifyUser = null;
            //_t.Version = 0;
            return IEF.Insert(_t);
        }
        /// <summary>
        /// 更新
        /// </summary>
        /// <param name="_t">实体</param>
        /// <returns>是否成功</returns>
        public virtual bool Update(T _t)
        {
            //更新记录，自动为公共字段赋值
            _t.ModifyTime = DateTime.Now;
            if (string.IsNullOrEmpty(_t.ModifyUser))
                _t.ModifyUser = AuthToken.CurrentUser.UserName;
            return IEF.Update(_t);
        }
        /// <summary>
        /// 更新
        /// </summary>
        /// <param name="Command">sql</param>
        /// <returns></returns>
        public virtual bool Update(string Command)
        {
            //更新记录，自动为公共字段赋值
            Command = "ModifyTime='" + DateTime.Now.ToString() + "',ModifyUser='" + AuthToken.CurrentUser.UserName + "'," + Command;
            return IEF.Update(Command);
        }
        /// <summary>
        /// 删除实体
        /// </summary>
        /// <param name="_t">实体</param>
        /// <returns>是否成功</returns>
        public virtual bool Delete(T _t)
        {
            return IEF.Delete(_t);
        }
        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="filters">条件</param>
        /// <returns>是否成功</returns>
        public virtual bool Delete(Expression<Func<T, bool>> filters)
        {
            return IEF.Delete(filters);
        }
        /// <summary>
        /// 用户自定义删除
        /// </summary>
        /// <param name="Conditions">删除条件</param>
        /// <returns></returns>
        public virtual bool Delete(string Conditions)
        {
            return IEF.Delete(Conditions);
        }
        /// <summary>
        /// 执行查询SQL语句
        /// </summary>
        /// <param name="SQL">SQL语句</param>
        /// <returns>返回IEnumerable</returns>
        public virtual IEnumerable<T> Query(string SQL)
        {
            return IEF.Query(SQL);
        }
        /// <summary>
        /// 执行非查询SQL语句
        /// </summary>
        /// <param name="SQL">SQL语句</param>
        /// <returns>返回受影响行</returns>
        public virtual int RunCmd(string SQL)
        {
            return IEF.RunCmd(SQL);
        }
        /// <summary>
        /// 执行事务
        /// </summary>
        /// <param name="SQL">事务SQL集合</param>
        /// <returns>返回受影响行</returns>
        public virtual int RunTransaction(List<string> SQL)
        {
            return IEF.RunTransaction(SQL);
        }
    }
}
