using System;
using ElegantWM.EntityModel;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/15 22:28:59
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
    public interface IWXMenuDAL : IEFRepository<WX_Menu>
    {
        /// <summary>
        /// 复制行业菜单模板
        /// </summary>
        /// <param name="idtId">行业菜单id</param>
        /// <param name="wxId">微信号id</param>
        /// <param name="user">用户</param>
        /// <returns></returns>
        bool CopyMenu(Guid idtId, Guid wxId, string user);

    }
}
