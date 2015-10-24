using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DBUtility;

namespace DAO
{
    public class CommonDao<T> where T : new()
    {
        /// <summary>
        /// 获得所有记录
        /// </summary>
        /// <returns>返回所有记录IList</returns>
        public IList<T> FindAll()
        {
            return Common<T>.Dt2List(DbHelperSQL.FindByConditions(new T(), ""));
        }
        /// <summary>
        /// 分页获取数据,降序分页
        /// </summary>
        /// <param name="start">起始记录号</param>
        /// <param name="limit">每页记录数</param>
        /// <param name="conditions">查询条件</param>
        /// <returns>返回符合记录的当前页数据</returns>
        public IList<T> FindAllByPageDesc(string start, string limit, string conditions)
        {
            return Common<T>.Dt2List(DbHelperSQL.FindByPageDesc(new T(), start, limit, conditions));
        }
        /// <summary>
        /// 分页获取数据,升序分页
        /// </summary>
        /// <param name="start">起始记录</param>
        /// <param name="limit">分页大小</param>
        /// <param name="conditions">条件</param>
        /// <returns>数据集</returns>
        public IList<T> FindAllByPageAsc(string start, string limit, string conditions)
        {
            return Common<T>.Dt2List(DbHelperSQL.FindByPageAsc(new T(), start, limit, conditions));
        }
        /// <summary>
        /// 存储过程分页
        /// </summary>
        /// <param name="start">起始记录</param>
        /// <param name="limit">分页大小</param>
        /// <param name="conditions">条件</param>
        /// <param name="orderby">升降序</param>
        /// <returns>List</returns>
        public IList<T> FindByProcPage(string start, string limit, string conditions, int orderby)
        {
            return Common<T>.Dt2List(DbHelperSQL.FindByProcPage(new T(), start, limit, conditions, orderby));
        }



        /// <summary>
        /// 倒序取前几条记录
        /// </summary>
        /// <param name="limit">记录</param>
        /// <param name="conditions">条件</param>
        /// <param name="orderby">升降序</param>
        /// <returns>List</returns>
        public IList<T> FindByIDdesc(string limit, string conditions)
        {
            return Common<T>.Dt2List(DbHelperSQL.FindIDdesc(new T(),  limit, conditions));
        }

        /// <summary>
        /// 倒序取前几条记录
        /// </summary>
        /// <param name="limit">记录</param>
        /// <param name="conditions">条件</param>
        /// <param name="orderby">升降序</param>
        /// <returns>List</returns>
        public IList<T> FindBydesc(string limit, string conditions ,string byname)
        {
            return Common<T>.Dt2List(DbHelperSQL.FindBydesc(new T(), limit, conditions,byname));
        }

        /// <summary>
        /// 查找符合条件记录的总条数
        /// </summary>
        /// <param name="conditions">查询条件</param>
        /// <returns>返回符合的记录条数</returns>
        public string GetTotalCount(string conditions)
        {
            return DbHelperSQL.GetCountByConditions(new T(), conditions);
        }

        /// <summary>
        /// 根据id查找相应的一条记录，如果没有返回null值
        /// </summary>
        /// <param name="id">要查找的ID号</param>
        /// <returns>返回值</returns>
        public T FindById(string id)
        {
            T model = new T();
            DataTable dt = DbHelperSQL.FindByConditions(model, " " + Common<object>.GetModelInfo(model)[1] + "=" + id);
            if (dt.Rows.Count <= 0)
            {
                return default(T);
            }
            else
            {
                return Common<T>.Dt2Model(model, DbHelperSQL.FindByConditions(model, " " + Common<object>.GetModelInfo(model)[1] + "=" + id));
            }
        }


        /// <summary>
        /// 根据条件查询记录
        /// </summary>
        /// <param name="conditions">条件</param>
        /// <returns>返回符合条件的IList</returns>
        public DataTable FindDataTableByCondition(string conditions)
        {
            return DbHelperSQL.FindByConditions(new T(), conditions);
        }
        /// <summary>         
        /// /// dataTable转换成Json格式       
        /// /// </summary>          
        /// <param name="dt"></param>      
        /// /// <returns></returns>        
        public string GetSingalJson(string fid)
        {

            T model = new T();
            DataTable dt = DbHelperSQL.FindByConditions(model, " " + Common<object>.GetModelInfo(model)[1] + "=" + fid);
            StringBuilder jsonBuilder = new StringBuilder();
            //jsonBuilder.Append("{\"");
            //jsonBuilder.Append(dt.TableName);
            //jsonBuilder.Append("\":[");
            //jsonBuilder.Append("[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString());
                    jsonBuilder.Append("\",");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            //jsonBuilder.Append("]");
            //jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }

        /// <summary>
        /// 根据条件查找相应的一条记录,如果大于一条记录则返回null
        /// </summary>
        /// <param name="conditions">要查找的条件</param>
        /// <returns>返回值</returns>

        public T FindByConditions(string conditions)
        {
            //userinfo model = new userinfo();
           // return Common<T>.Dt2List(DbHelperSQL.FindByConditions(new T(), conditions));

            DataTable dt = DbHelperSQL.FindByConditions(new T(), conditions);
            if (dt.Rows.Count <= 0 || dt.Rows.Count>=2)
               
                return default(T);
            else
            {
                return Common<T>.Dt2Model(new T(), dt);
            }
        }


        /// <summary>
        /// 添加新纪录
        /// </summary>
        /// <param name="T">实体</param>
        /// <returns>返回是否成功</returns>
        public bool Add(T _T)
        {
            return DbHelperSQL.Insert(_T);
        }

       
        /// <summary>
        /// 更新对象
        /// </summary>
        /// <param name="T">实体</param>
        /// <returns>返回是否成功</returns>
        public bool Update(T _T)
        {
            return DbHelperSQL.Update(_T);
        }
        /// <summary>
        /// 批量更新
        /// </summary>
        /// <param name="sets">值列表c1=xx,c2=yy,c3=zz</param>
        /// <param name="conditions">条件</param>
        /// <returns>成功</returns>
        public bool UpdateByConditions(string sets, string conditions)
        {
            return DbHelperSQL.Update(new T(), sets, conditions);
        }
        /// <summary>
        /// 删除记录
        /// </summary>
        /// <param name="T">实体</param>
        /// <returns>返回是否成功</returns>
        public bool Del(T _T)
        {
            return DbHelperSQL.Delete(_T);
        }
        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="conditions">删除的依赖条件</param>
        /// <returns>成功</returns>
        public bool DelByConditions(string conditions)
        {
            return DbHelperSQL.Delete(new T(), conditions);
        }
        /// <summary>
        /// 根据条件查询记录
        /// </summary>
        /// <param name="conditions">条件</param>
        /// <returns>返回符合条件的IList</returns>
        public IList<T> FindByCondition(string conditions)
        {
            return Common<T>.Dt2List(DbHelperSQL.FindByConditions(new T(), conditions));
        }
        /// <summary>
        /// 执行事务
        /// </summary>
        /// <param name="sqlist">事务sql</param>
        /// <returns>是否成功</returns>
        public int RunTransaction(List<string> sqlist)
        {
            return DbHelperSQL.ExecuteSqlTran(sqlist);
        }

        /// <summary>
        /// 执行sql返回Dataset
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <returns>返回数据集</returns>
        public DataSet ExecuteSql(string sql)
        {
            return DbHelperSQL.Query(sql);
        }
    }
}
