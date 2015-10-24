using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Caching;
using System.Web;

namespace Tools
{

   // [StrongNameIdentityPermissionAttribute(SecurityAction.LinkDemand, PublicKey =""]

    /// <summary>
    /// CacheHelper 数据缓存操作类
    /// </summary>
    public class CacheHelper
    {
        //public static Cache cache = new Cache();
        //如果不能运行请修改成
        public static Cache cache = HttpRuntime.Cache;
        public CacheHelper()
        {

        }

        //当缓存建立后过minute分钟就过期
        /// <summary>
        ///以key键值，把value赋给Cache[key].固定过期时间。当缓存建立后过minute分钟就过期.
        /// </summary>
        ///<param name="key">Cache键值</param>
        ///<param name="value">给Cache[key]赋的值</param>
        ///<param name="minute">固定过期分钟</param>
        public static void CacheInsertFromMinutes(string key, object value, int minute)
        {
            cache.Insert(key, value, null, System.Web.Caching.Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(minute));
        }


        //缓存建立后，过期时间为可调，比如1：20秒建立的缓存过期时间应该是6：20但如果在3：20有人访问了缓存，则过期时间将调整为8：20，以此类推……
        /// <summary>
        ///以key键值，把value赋给Cache[key].可调过期时间. 缓存被调用minute分钟后，再过期
        /// </summary>
        ///<param name="key">Cache键值</param>
        ///<param name="value">给Cache[key]赋的值</param>
        ///<param name="minute">可调过期分钟</param>
        public static void CacheInsertAddMinutes(string key, object value, int minute)
        {
            cache.Insert(key, value, null, DateTime.Now.AddMinutes(minute), System.Web.Caching.Cache.NoSlidingExpiration);
        }


        /// <summary>
        ///以key键值，把value赋给Cache[key].如果不主动清空，会一直保存在内存中.
        /// </summary>
        ///<param name="key">Cache键值</param>
        ///<param name="value">给Cache[key]赋的值</param>
        public static void CacheInsert(string key, object value)
        {
            cache.Insert(key, value);
        }

        /// <summary>
        ///清除Cache[key]的值
        /// </summary>
        ///<param name="key"></param>
        public static void CacheNull(string key)
        {
            cache.Remove(key);
        }

        /// <summary>
        ///根据key值，返回Cache[key]的值
        /// </summary>
        ///<param name="key"></param>
        public static object CacheValue(string key)
        {
            return cache.Get(key);
        }
    }

}
