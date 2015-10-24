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


namespace ElegantWM.BLL
{
    public class Game_LittleModelResultService : BaseService<Game_LittleModelResult>, IGame_LittleModelResultService
    {
        private IGame_LittleModelResultDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public Game_LittleModelResultService()
            : base(new Game_LittleModelResultDAL())
        {
            dal = IEF as Game_LittleModelResultDAL;
        }
    }
}
