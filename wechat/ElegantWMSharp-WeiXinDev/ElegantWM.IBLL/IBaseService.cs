using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using ElegantWM.EntityModel;
/**
 * 作者：陈杰
 * 时间：2012-08-10 00:25
 * 功能：业务层公共接口
 **/
namespace ElegantWM.IBLL
{
    public interface IBaseService<T> where T : class,IEntity
    {
        /// <summary>
        /// 查找所有
        /// </summary>
        /// <returns>返回所有List</returns>
        IEnumerable<T> GetAll();
        /// <summary>
        /// 根据条件查找
        /// </summary>
        /// <param name="order">排序字段</param>
        /// <param name="filters">条件</param>
        /// <returns>返回List</returns>
        IEnumerable<T> FindByConditions(Func<IQueryable<T>, IOrderedQueryable<T>> order, Expression<Func<T, bool>> filter, ExtGridSearch eSearch = null);
        /// <summary>
        /// 分页查找
        /// </summary>
        /// <param name="startIndex">开始记录</param>
        /// <param name="pageSize">页号</param>
        /// <param name="order">排序字段</param>
        /// <param name="filters">条件</param>
        /// <returns>返回当前页List</returns>
        IEnumerable<T> FindByPage(int startIndex, int pageSize, out int Total, Func<IQueryable<T>, IOrderedQueryable<T>> order, Expression<Func<T, bool>> filters, ExtGridSearch eSearch = null);
        /// <summary>
        /// 获取记录数量
        /// </summary>
        /// <param name="filters">条件</param>
        /// <returns>返回记录号</returns>
        int GetCount(Expression<Func<T, bool>> filters);
        /// <summary>
        /// 根据ID查找
        /// </summary>
        /// <param name="Id">ID</param>
        /// <returns>返回唯一实体</returns>
        T GetById(string Id);

        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="_t">实体</param>
        /// <returns>是否成功</returns>
        bool Insert(T _t);
        /// <summary>
        /// 更新
        /// </summary>
        /// <param name="_t">实体</param>
        /// <returns>是否成功</returns>
        bool Update(T _t);
        /// <summary>
        /// 更新
        /// </summary>
        /// <param name="Command">sql</param>
        /// <returns></returns>
        bool Update(string Command);
        /// <summary>
        /// 删除实体
        /// </summary>
        /// <param name="_t">实体</param>
        /// <returns>是否成功</returns>
        bool Delete(T _t);
        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="filters">条件</param>
        /// <returns>是否成功</returns>
        bool Delete(Expression<Func<T, bool>> filters);
        /// <summary>
        /// 用户自定义删除
        /// </summary>
        /// <param name="Conditions">删除条件</param>
        /// <returns></returns>
        bool Delete(string Conditions);
        /// <summary>
        /// 执行查询SQL语句
        /// </summary>
        /// <param name="SQL">SQL语句</param>
        /// <returns>返回IEnumerable</returns>
        IEnumerable<T> Query(string SQL);
        /// <summary>
        /// 执行非查询SQL语句
        /// </summary>
        /// <param name="SQL">SQL语句</param>
        /// <returns>返回受影响行</returns>
        int RunCmd(string SQL);
        /// <summary>
        /// 执行事务
        /// </summary>
        /// <param name="SQL">事务SQL集合</param>
        /// <returns>返回受影响行</returns>
        int RunTransaction(List<string> SQL);
    }
}
