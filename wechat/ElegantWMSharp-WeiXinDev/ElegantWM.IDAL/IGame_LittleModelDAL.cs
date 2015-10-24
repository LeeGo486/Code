﻿using System;
using ElegantWM.EntityModel;
using System.Data;

namespace ElegantWM.IDAL
{
    public interface IGame_LittleModelDAL : IEFRepository<Game_LittleModelInfo>
    {
        #region 获取小模特信息
        DataTable GetLittleModelInfo(string strWhere, int iPage, int iGroup);
        #endregion

        #region 获取小模特行数
        DataTable GetLittleModelCount(int iGroup);
        #endregion

        #region MyRegion
        DataTable CheckVote(string Oid,string LId);
        #endregion
    }
}
