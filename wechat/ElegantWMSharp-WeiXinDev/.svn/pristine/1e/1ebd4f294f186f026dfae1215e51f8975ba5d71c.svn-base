using System;
using ElegantWM.EntityModel;
using System.Data;

/**
 * 作者：WebMisSharp
 * 时间：2014/11/17 15:07:55
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
    public interface IGameQARstDAL : IEFRepository<Game_QARst> 
    {
        /// <summary>
        /// 获取答题结果，总数，超过占比
        /// </summary>
        /// <param name="sid">帐套</param>
        /// <param name="id">唯一ID</param>
        /// <returns></returns>
        DataTable GetQAResult(Guid sid, Guid id);

        /// <summary>
        /// 已经积分
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        int Process(Guid tid);
    }
}
