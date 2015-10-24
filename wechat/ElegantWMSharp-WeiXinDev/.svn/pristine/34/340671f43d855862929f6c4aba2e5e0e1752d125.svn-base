using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;
using System.Collections.Generic;

/**
 * 作者：WebMisSharp
 * 时间：2014/11/17 15:06:10
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
    public class GameQuestionDAL : EFRepository<Game_Question>, IGameQuestionDAL
    {
        //如果是多数据库，请开启
        public GameQuestionDAL()
            : base("Activities")
        {

        }

        public IEnumerable<Game_Question> GetQuestions(Guid TntId, string Type)
        {
            string sql = "SELECT TOP 100 * FROM Game_Question where Tntid='" + TntId.ToString() + "' ORDER BY NEWID()";
            return Query(sql).ToList();
        }
    }
}
