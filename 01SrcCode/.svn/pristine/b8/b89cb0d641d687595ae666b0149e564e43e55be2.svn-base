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
        public string CreateAllocationId(string userid)
        {
            return CJDAL.CreateAllocationId(userid);
        }

        public DataTable GetReceiveShops(string depotid)
        {
            return CJDAL.GetReceiveShops(depotid);
        }

        public string GetShopName(string depotid)
        {
            return CJDAL.GetShopName(depotid).Rows[0][0].ToString();
        }

        //调拨入库操作
        //验证款式是否存在
        public DataTable CheckClothingExists(string clothingid)
        {
            string sql = string.Format("SELECT clothingid,styleid FROM j_clothing WHERE clothingid='{0}' OR oldclothingid='{0}'", clothingid);
            return CJDAL.ExecuteSql(sql).Tables[0];
        }
        //验证是否有权限
        public int CheckAccess(string userid,string styleid,string depotid)
        {
            string db = (depotid.Substring(0, 1).ToLower()) == "n" ? "F22NF.dbo.sys_stylepower18ql" : "F22JL.dbo.sys_stylepower18ql";
            string sql = string.Format("SELECT * FROM {2} WHERE userid='{0}' AND styleid='{1}'", userid, styleid, db);
            return CJDAL.ExecuteSql(sql).Tables[0].Rows.Count;
        }
        //获取款式品牌
        public string GetLoadPlanId(string moveid)
        {
            string sql = string.Format("select shjjdepotid from d_move where moveid='{0}'", moveid);
            return CJDAL.ExecuteSql(sql).Tables[0].Rows[0][0].ToString();
        }
        //验证品牌
        public string CheckBrand(string styleid)
        {
            string sql = string.Format("select brandid from j_style where styleid='{0}'", styleid);
            return CJDAL.ExecuteSql(sql).Tables[0].Rows[0][0].ToString();
        }
        //更新主表品牌
        public bool UpdateDMoveBrand(string brand,string moveid)
        {
            return CJDAL.UpdateByConditions("shjjdepotid='" + brand + "'", "moveid='" + moveid + "'");
        }
        //获取款式信息
        public DataTable GetClotingInfo(string depotid, string clothingId)
        {
            return CJDAL.GetClotingInfo(depotid, clothingId);
        }
        //获取子表信息
        public DataTable GetMoveSub(string moveid)
        {
            string sql = string.Format("select d.clothingid,j.s_name,d.colorid,c.c_name,d.sizeid,d.set_nums,d.x_price from d_movesub d,j_style j,j_color c where d.colorid=c.colorid and d.styleid=j.styleid and moveid='{0}'", moveid);
            return CJDAL.ExecuteSql(sql).Tables[0];
        }
        //获取当前登陆人
        public string GetCurUser(string userid)
        {
            DataTable dt = CJDAL.ExecuteSql(string.Format("select username from f18master.dbo.sys_f22user where userid='{0}'", userid)).Tables[0];
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0][0].ToString();
            }
            return userid;
        }
    }
}
