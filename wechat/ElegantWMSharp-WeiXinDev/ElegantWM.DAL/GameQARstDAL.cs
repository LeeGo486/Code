using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;
using System.Data;

/**
 * 作者：WebMisSharp
 * 时间：2014/11/17 15:07:55
 * 功能：数据访问层
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

 namespace ElegantWM.DAL
{
    public class GameQARstDAL : EFRepository<Game_QARst>, IGameQARstDAL
    {
		/* 如果是多数据库，请开启
        public GameQARstDAL()
            : base("Your web.config DbConnectString")
        {

        }
		*/
        /// <summary>
        /// 获取答题结果，总数，超过占比
        /// </summary>
        /// <param name="sid">帐套</param>
        /// <param name="id">唯一ID</param>
        /// <returns></returns>
        public DataTable GetQAResult(Guid sid, Guid id)
        {
            string sql = @"SELECT 
                            ISNULL((SELECT Total FROM [Game_QARst] WHERE Id='{0}'),0) MyTotal,
                            (SELECT ISNULL(SUM(Total),0) FROM [Game_QARst] WHERE TntId='{1}') Total,
                            ISNULL(((SELECT COUNT(1) FROM Game_QARst WHERE TntId='{1}' AND Total<(SELECT Total FROM Game_QARst WHERE Id='{0}'))*1.0/NULLIF((SELECT COUNT(1) FROM [Game_QARst] WHERE TntId='{1}'),0)),0) MyPercent";
            sql = string.Format(sql, id, sid);
            return Query(sql, null);
        }
        /// <summary>
        /// 已经积分
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public int Process(Guid tid)
        {
            string sql = "SELECT ISNULL(SUM(total),0) Total FROM Game_QARst WHERE TntId='" + tid.ToString() + "'";
            return int.Parse(Query(sql, null).Rows[0][0].ToString());
        }
    }
}
