#pragma checksum "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\DBHelper\YY_CommonDAO.cs" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "B5440BBFE10B6A30F4204F07453B8B93F0536AF4"

#line 1 "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\DBHelper\YY_CommonDAO.cs"
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

/**
 * 泛型方法集合
 * 作者：陈杰
 * Q Q： 710782046
 * Email：ovenjackchain@gmail.com
 * Web：http://www.chinacloudtech.com
 */

namespace DBHelper
{
    public class YY_CommonDAO<T> where T : new()
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
        public IList<T> FindAllByPageDesc(int start, int limit, string conditions)
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
        public IList<T> FindAllByPageAsc(int start, int limit, string conditions)
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
        public IList<T> FindByProcPage(int start, int limit, string conditions, int orderby)
        {
            return Common<T>.Dt2List(DbHelperSQL.FindByProcPage(new T(), start, limit, conditions, orderby));
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
        /// 根据id查找相应的一条记录
        /// </summary>
        /// <param name="id">要查找的ID号</param>
        /// <returns>返回值</returns>
        public T FindById(string id)
        {
            T model = new T();
            return Common<T>.Dt2Model(model, DbHelperSQL.FindByConditions(model, " " + Common<object>.GetModelInfo(model)[1] + "=" + id));
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

        public DataTable GetDtByCondition(string conditions)
        {
            string sql = "select BrName as 品牌,BrId as 品牌编码,Production as 产地,ClothingId as 新条形码,StyleId as 新款式编码,ColorId as 新颜色,SizeId as 新尺码,J_Price as 吊牌价,J_Cost as 成本价,S_Name as 品名,Fabric as 成份,PrintState as 打印,St_Year as 年份,St_Month as 季节,St_Xl as 款式种类,St_Dl as 款式大类,St_Xz as 款式小类,OldClothingId as 旧条形码,OldStyleId as 旧款式编码,OldColorId as 旧颜色,OldSizeId as 旧尺码 from Y_StyleFoundation";
            if (conditions != "")
                sql = sql + " where " + conditions;
            return (DbHelperSQL.Query(sql).Tables[0]);
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

        /// <summary>
        /// 执行sql返回受影响行
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <returns>返回行数</returns>
        public int ExecNoReturnSql(string sql)
        {
            return DbHelperSQL.ExecuteSql(sql);
        }
        /// <summary>
        /// 执行存储过程
        /// </summary>
        /// <param name="procName">存储过程名称</param>
        /// <param name="para">参数</param>
        /// <returns>返回受影响行</returns>
        public int RunProc(string procName, IDataParameter[] para)
        {
            return DbHelperSQL.ExecuteProcedure(procName, para);
        }

        public string SynDataByProc(string procname, IDataParameter[] param)
        {
            return DbHelperSQL.SynDataByProc(procname, param);
        }
    }
}


#line default
#line hidden
