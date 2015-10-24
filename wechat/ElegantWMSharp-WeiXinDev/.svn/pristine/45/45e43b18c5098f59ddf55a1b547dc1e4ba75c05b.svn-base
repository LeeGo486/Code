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
using ElegantWM.Tools;

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

namespace ElegantWM.BLL
{
    public class WXLKFansC3AMService : BaseService<WX_LK_FansC3AM>, IWXLKFansC3AMService
    {
        private IWXLKFansC3AMDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public WXLKFansC3AMService()
            : base(new WXLKFansC3AMDAL())
        {
            dal = IEF as WXLKFansC3AMDAL;
        }

        /// <summary>
        /// 根据微信ID和OpenId获取令牌
        /// </summary>
        /// <param name="sid"></param>
        /// <param name="oid"></param>
        /// <returns></returns>
        public WX_LK_FansC3AM GetCurrentAMUser(Guid sid, string oid)
        {
            if (sid == Guid.Empty || string.IsNullOrEmpty(oid))
                return null;
            //缓存
            if (CacheHelper.CacheValue("AMU_"+sid.ToString() + "_" + oid) == null)
            {
                IEnumerable<WX_LK_FansC3AM> userList = dal.FindByConditions(null, f => f.AccountId == sid && f.OpenId == oid);
                WX_LK_FansC3AM fan = userList.FirstOrDefault();
                if (fan != null)
                    CacheHelper.CacheInsertFromMinutes("AMU_" + sid.ToString() + "_" + oid, fan, 23);
            }
            return CacheHelper.CacheValue("AMU_" + sid.ToString() + "_" + oid) as WX_LK_FansC3AM;
        }
    }
}

