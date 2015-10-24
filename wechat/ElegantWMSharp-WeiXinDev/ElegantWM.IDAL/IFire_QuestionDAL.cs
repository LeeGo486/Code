using System;
using ElegantWM.EntityModel;
using System.Data;

/**
 * 作者：WebMisSharp
 * 时间：2014-12-09 18:04:31
 * 功能：数据访问层接口
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

namespace ElegantWM.IDAL
{
    public interface IFire_QuestionDAL : IEFRepository<Fire_Question> 
    {
        #region 获取消防知识题目数据
        DataTable FireKnowLedgeInfo(string TntId);
        #endregion

        #region 获取消防题目表头
        DataTable FireKnowLedgeHead(string TntId);
        #endregion
    }
}
