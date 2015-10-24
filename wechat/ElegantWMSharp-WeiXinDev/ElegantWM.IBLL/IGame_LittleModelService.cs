using System;
using ElegantWM.EntityModel;
using System.Data;

namespace ElegantWM.IBLL
{
    public interface IGame_LittleModelService : IBaseService<Game_LittleModelInfo>
    {
        #region 获取小模特信息
        DataTable GetLittleModelInfo(string strWhere,int iPage,int iGroup);
        #endregion

        #region 获取小模特行数
        DataTable GetLittleModelCount(int iGroup);
        #endregion

        #region 投票与验证
        DataTable CheckVote(string Oid, string LId);
        #endregion
    }
}
