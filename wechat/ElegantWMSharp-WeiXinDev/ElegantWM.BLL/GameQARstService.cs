using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ElegantWM.DAL;
using ElegantWM.EntityModel;
using ElegantWM.IBLL;
using ElegantWM.IDAL;
using System.Data;
using System.Data.SqlClient;
using ElegantWM.Common;

/**
 * 作者：WebMisSharp
 * 时间：2014/11/17 15:07:55
 * 功能：业务逻辑接口
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

namespace ElegantWM.BLL
{
    public class GameQARstService : BaseService<Game_QARst>, IGameQARstService
    {
        private IGameQARstDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public GameQARstService()
            : base(new GameQARstDAL())
        {
            dal = IEF as GameQARstDAL;
        }

        public DataTable GetQAResult(Guid sid, Guid id)
        {
            return dal.GetQAResult(sid, id);
        }

        /// <summary>
        /// 已经积分
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public int Process(Guid tid)
        {
            return dal.Process(tid);
        }
    }
}

