using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Transactions;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;
using System.Data.SqlClient;
using System.Configuration;
/**
 * 作者：陈杰
 * ＱＱ：710782046
 * 时间：2012-08-10
 * 功能：EF操作数据库基类
 **/
namespace ElegantWM.DAL
{
    public class EFRepository<T> : IEFRepository<T> where T : class,IEntity
    {
        //日志
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        //EF
        protected DbSet<T> DBSET = null;
        protected DB _db = null;
        //构造函数，不同数据库需要在子类里面重新赋值
        public EFRepository(string _DBConStr = "DefaultDB")
        {
            _db = new DB(_DBConStr);
            DBSET = _db.Set<T>();
        }

        /// <summary>
        /// 获取所有的数据
        /// </summary>
        /// <returns></returns>
        public virtual IEnumerable<T> GetAll()
        {
            try
            {
                return DBSET.ToList();
            }
            catch (Exception e)
            {
                log.Error("GetAll:" + e.ToString());
                throw;
            }
        }

        /// <summary>
        /// 根据查询条件和排序方法返回结果集
        /// </summary>
        /// <param name="order">排序方法的委托</param>
        /// <param name="filters">查询条件</param>
        public virtual IEnumerable<T> FindByConditions(Func<IQueryable<T>, IOrderedQueryable<T>> order, Expression<Func<T, bool>> filter)
        {
            try
            {
                IQueryable<T> rs = DBSET.Where(filter);
                if (order != null)
                {
                    rs = order(rs);
                }
                return rs.ToList();
            }
            catch (Exception e)
            {
                log.Error("FindByConditions:" + order.ToString() + " " + filter.ToString() + " " + e.ToString());
                throw;
            }
        }
        /// <summary>
        /// 根据开始索引、每页大小查询条件和排序方法返回分页结果集，适用于前台分页件
        /// </summary>
        /// <param name="startIndex">开始索引</param>
        /// <param name="pageSize">页面大小</param>
        /// <param name="totalCount">数据总数</param>
        /// <param name="order">排序方法的委托</param>
        /// <param name="filters">查询条件</param>
        public virtual IEnumerable<T> FindByPage(int startIndex, int pageSize, out int Total, Func<IQueryable<T>, IOrderedQueryable<T>> order, Expression<Func<T, bool>> filters)
        {
            try
            {
                IQueryable<T> rs = order(filters != null ? DBSET.Where(filters) : DBSET);
                Total = rs.Count();
                if (startIndex < 0 || pageSize < 1)
                {
                    return null;// rs.ToList();
                }
                else
                {
                    return rs.Skip(startIndex).Take(pageSize).ToList();//* pageSize
                }
            }
            catch (Exception e)
            {
                Total = 0;
                log.Error("FindByPage:" + e.ToString());
                throw;
            }
        }
        /// <summary>
        /// 根据条件获取总数据行数
        /// </summary>
        /// <param name="conditions"></param>
        /// <returns></returns>
        public virtual int GetCount(Expression<Func<T, bool>> filters)
        {
            return DBSET.Count(filters);
        }
        /// <summary>
        /// 根据ID获取实体
        /// </summary>
        /// <param name="Id">实体主键ID</param>
        /// <returns>返回实体</returns>
        public virtual T GetById(string Id)
        {
            try
            {
                return DBSET.SingleOrDefault(t => t.Id == new Guid(Id));
            }
            catch (Exception e)
            {
                log.Error("GetById:" + Id + " " + e.ToString());
                throw;
            }
        }

        /// <summary>
        /// 插入
        /// </summary>
        /// <param name="_t">实体</param>
        /// <returns>是否成功</returns>
        public virtual bool Insert(T _t)
        {
            try
            {
                DBSET.Add(_t);
                _db.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                log.Error("Insert:" + e.ToString());
                throw;
            }
        }
        /// <summary>
        /// 更新
        /// </summary>
        /// <param name="_t">实体</param>
        /// <returns>是否成功</returns>
        public virtual bool Update(T _t)
        {
            try
            {
                var entry = _db.Entry(_t);
                //if (entry.State == EntityState.Detached)
                //{
                //    DBSET.Attach(_t);
                //}
                entry.State = EntityState.Modified;
                _db.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                //_db.Dispose();
                //_db.Entry(_t).Reload();//回滚
                log.Error("Update:" + e.ToString());
                throw;
            }
        }
        /// <summary>
        /// 自定义sql更新
        /// </summary>
        /// <param name="Command">sql：set ,,, Where ;</param>
        /// <returns></returns>
        public virtual bool Update(string Command)
        {
            string sql = "UPDATE " + typeof(T).Name + " SET " + Command;
            return RunCmd(sql) > 0;
        }
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="_t">实体</param>
        /// <returns>是否成功</returns>
        public virtual bool Delete(T _t)
        {
            try
            {
                _db.Entry(_t).State = EntityState.Deleted;
                _db.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                //_db.Entry(_t).Reload();//回滚
                log.Error("Delete:" + e.ToString());
                throw;
            }
        }
        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="filters">条件</param>
        /// <returns>是否成功</returns>
        public virtual bool Delete(Expression<Func<T, bool>> filters)
        {
            try
            {
                foreach (var item in DBSET.Where(filters))
                {
                    DBSET.Remove(item);
                }
                _db.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                log.Error("Delete:" + e.ToString());
                throw;
            }
        }
        /// <summary>
        /// 用户自定义删除
        /// </summary>
        /// <param name="Conditions">删除条件</param>
        /// <returns></returns>
        public virtual bool Delete(string Conditions)
        {
            string sql = "DELETE FROM " + typeof(T).Name + " WHERE " + Conditions;
            return RunCmd(sql) >= 0;
        }

        /// <summary>         
        /// 操作提交         
        /// </summary>         
        //public override void SaveChanges()
        //{
        //    //base.SaveChanges();
        //}

        /// <summary>
        /// 执行事务
        /// </summary>
        /// <param name="SQL">执行事务的SQL语句列表</param>
        /// <returns>返回受影行</returns>
        public virtual int RunTransaction(List<string> SQL)
        {
            using (TransactionScope transaction = new TransactionScope())
            {
                int i = 0;
                foreach (string cmd in SQL)
                    i += _db.Database.ExecuteSqlCommand(cmd);
                transaction.Complete();
                return i;
            }
        }

        /// <summary>
        /// 执行非查询的SQL
        /// </summary>
        /// <param name="SQL">SQL语句</param>
        /// <param name="Params">参数</param>
        /// <returns>受影响行</returns>
        public virtual int RunCmd(string SQL)
        {
            try
            {
                return _db.Database.ExecuteSqlCommand(SQL);
            }
            catch (Exception e)
            {
                log.Error("RunCmd:" + SQL + " " + e.Message);
                throw;
            }
        }

        /// <summary>
        /// 执行SQL查询
        /// </summary>
        /// <param name="SQL">sql语句</param>
        /// <param name="Params">参数</param>
        /// <returns>返回列表</returns>
        public virtual IEnumerable<T> Query(string SQL)
        {
            try
            {
                return _db.Database.SqlQuery<T>(SQL);
            }
            catch (Exception e)
            {
                log.Error("Query:" + SQL + " " + e.Message);
                throw;
            }
        }

        /// <summary>
        /// 返回Datatable
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public virtual DataTable Query(string sql, object[] parameters)
        {
            using (SqlConnection conn = new SqlConnection(_db.Database.Connection.ConnectionString))//ConfigurationManager.ConnectionStrings[].ToString()
            {
                if (conn.State != ConnectionState.Open)
                {
                    conn.Open();
                }
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = sql;
                if (parameters != null && parameters.Length > 0)
                {
                    foreach (var item in parameters)
                    {
                        cmd.Parameters.Add(item);
                    }
                }
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                conn.Close();
                return dt;
            }
        }
    }
}
