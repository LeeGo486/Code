using System;
using ElegantWM.EntityModel;
using System.Data;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/26 9:43:53
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
    public interface IWXLKFansC3AMService : IBaseService<WX_LK_FansC3AM>
    {
        /// <summary>
        /// 根据微信ID和OpenId获取令牌
        /// </summary>
        /// <param name="sid"></param>
        /// <param name="oid"></param>
        /// <returns></returns>
        WX_LK_FansC3AM GetCurrentAMUser(Guid sid, string oid);
    }
}
