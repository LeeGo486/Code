#pragma checksum "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\DBHelper\YY_CommonMgr.cs" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "8963905C9F3519EA82D7F366170C996A1AC66B59"

#line 1 "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\DBHelper\YY_CommonMgr.cs"
using System.Collections.Generic;
using System.Data;
using System;
using System.Text;
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
    public class YY_CommonMgr<T> where T : new()
    {
        YY_CommonDAO<T> CJDAL = new YY_CommonDAO<T>();
        /// <summary>
        /// 获得所有记录
        /// </summary>
        /// <returns>返回所有记录IList</returns>
        public IList<T> FindAll()
        {
            return CJDAL.FindAll();
        }
        /// <summary>
        /// 分页获取数据
        /// </summary>
        /// <param name="start">起始记录号</param>
        /// <param name="limit">每页记录数</param>
        /// <param name="type">方式：0sql升序分页，1sql降序分页；10存储过程升序，11存储过程降序</param>
        /// <param name="Extconditions">EXT查询条件</param>
        /// <param name="conditions">普通查询条件</param>
        /// <returns>返回符合记录的当前页数据</returns>
        public IList<T> FindAllByPage(int start, int limit, int type, string Extconditions, string where)
        {
            CJSearchSql CJSearchSql = new CJSearchSql();
            string con = CJSearchSql.GetConditonSQL(Extconditions);
            con = con.Length <= 0 ? where : con + (where.Length > 0 ? " and " + where : "");
            if (type == 0)
                return CJDAL.FindAllByPageAsc(start, limit, con);
            else if (type == 1)
                return CJDAL.FindAllByPageDesc(start, limit, con);
            else if (type == 10)
                return CJDAL.FindByProcPage(start, limit, con, 0);
            else if (type == 11)
                return CJDAL.FindByProcPage(start, limit, con, 1);
            else
                return null;
        }

        /// <summary>
        /// 查找符合条件记录的总条数
        /// </summary>
        /// <param name="Extconditions">Ext查询条件</param>
        /// <param name="conditions">普通查询条件</param>
        /// <returns>返回符合的记录条数</returns>
        public string GetTotalCount(string Extconditions, string where)
        {
            CJSearchSql CJSearchSql = new CJSearchSql();
            string con = CJSearchSql.GetConditonSQL(Extconditions);
            con = con.Length <= 0 ? where : con + (where.Length > 0 ? " and " + where : "");
            return CJDAL.GetTotalCount(con);
        }

        /// <summary>
        /// 根据id查找相应的一条记录
        /// </summary>
        /// <param name="id">要查找的ID号</param>
        /// <returns>返回值</returns>
        public T FindById(string id)
        {
            return CJDAL.FindById(id.Replace("'", ""));
        }

        /// <summary>
        /// 添加新纪录
        /// </summary>
        /// <param name="T">实体</param>
        /// <returns>返回是否成功</returns>
        public bool Add(T _T)
        {
            return CJDAL.Add(_T);
        }

        /// <summary>
        /// 更新对象
        /// </summary>
        /// <param name="T">实体</param>
        /// <returns>返回是否成功</returns>
        public bool Update(T _T)
        {
            return CJDAL.Update(_T);
        }
        /// <summary>
        /// 批量更新
        /// </summary>
        /// <param name="sets">值列表c1=xx,c2=yy,c3=zz</param>
        /// <param name="conditions">条件</param>
        /// <returns>成功</returns>
        public bool UpdateByConditions(string sets, string conditions)
        {
            return CJDAL.UpdateByConditions(sets, conditions);
        }
        /// <summary>
        /// 删除记录
        /// </summary>
        /// <param name="T">实体</param>
        /// <returns>返回是否成功</returns>
        public bool Del(T _T)
        {
            return CJDAL.Del(_T);
        }
        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="conditions">删除的依赖条件</param>
        /// <returns>成功</returns>
        public bool DelByConditions(string conditions)
        {
            return CJDAL.DelByConditions(conditions);
        }
        /// <summary>
        /// 根据条件查询记录
        /// </summary>
        /// <param name="conditions">条件</param>
        /// <returns>返回符合条件的IList</returns>
        public IList<T> FindByCondition(string conditions)
        {
            return CJDAL.FindByCondition(conditions);
        }

        public DataTable GetDtByCondition(string Extconditions)
        {
            CJSearchSql CJSearchSql = new CJSearchSql();
            string con = CJSearchSql.GetConditonSQL(Extconditions);
            return CJDAL.GetDtByCondition(con);
        }
        /// <summary>
        /// 执行事务
        /// </summary>
        /// <param name="sqlist">事务sql</param>
        /// <returns>是否成功</returns>
        public int RunTransaction(List<string> sqlist)
        {
            return CJDAL.RunTransaction(sqlist);
        }
        public string SynDataByProc(string procname, IDataParameter[] param)
        {
            return CJDAL.SynDataByProc(procname, param);
        }
        public DataTable Query(string sql)
        {
            return CJDAL.ExecuteSql(sql).Tables[0];
        }
    }
}


#line default
#line hidden
