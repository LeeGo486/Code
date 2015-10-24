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
 * 时间：2015-03-21 0:04:11
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
    public class Game_QrstService : BaseService<Game_Qrst>, IGame_QrstService
    {
        private IGame_QrstDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public Game_QrstService()
            : base(new Game_QrstDAL())
        {
            dal = IEF as Game_QrstDAL;
        }

    }
}

