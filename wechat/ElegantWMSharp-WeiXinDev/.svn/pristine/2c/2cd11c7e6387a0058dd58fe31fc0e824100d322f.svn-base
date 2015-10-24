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
    public class Game_LittleModelService : BaseService<Game_LittleModelInfo>, IGame_LittleModelService
    {
        private IGame_LittleModelDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public Game_LittleModelService()
            : base(new Game_LittleModelDAL())
        {
            dal = IEF as Game_LittleModelDAL;
        }

        #region 获取小模特信息
        public System.Data.DataTable GetLittleModelInfo(string strWhere,int iPage,int iGroup)
        {
            return dal.GetLittleModelInfo(strWhere,iPage,iGroup);
        }
        #endregion

        #region 获取小模特行数
        public DataTable GetLittleModelCount(int iGroup) {
            return dal.GetLittleModelCount(iGroup);
        }
        #endregion

        #region 验证
        public DataTable CheckVote(string Oid,string LId) {
            return dal.CheckVote(Oid, LId);
        }
        #endregion
    }
}
