using System;
using ElegantWM.EntityModel;
using System.Data;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/15 22:28:59
 * 功能：业务逻辑接口
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

namespace ElegantWM.IBLL
{
    public interface IWXMenuService : IBaseService<WX_Menu>
    {
        /// <summary>
        /// 获取需要上传到微信服务器的MenuJson
        /// </summary>
        /// <param name="accountId"></param>
        /// <returns></returns>
        string WxMenuJson(Guid accountId);

        /// <summary>
        /// 获取微信账号的菜单
        /// </summary>
        /// <param name="sysId"></param>
        /// <returns></returns>
        string MenuTree(Guid accountId);


        /// <summary>
        /// 复制行业菜单模板
        /// </summary>
        /// <param name="idtId">行业菜单id</param>
        /// <param name="wxId">微信号id</param>
        /// <param name="user">用户</param>
        /// <returns></returns>
        bool CopyMenu(Guid idtId, Guid wxId);
    }
}
