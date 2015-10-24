using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;

/**
 * 作者：WebMisSharp
 * 时间：2015-03-12 22:26:22
 * 功能：数据访问层
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

 namespace ElegantWM.DAL
{
    public class WX_Account_USER_AUZDAL : EFRepository<WX_Account_USER_AUZ>, IWX_Account_USER_AUZDAL
    {
		/* 如果是多数据库，请开启
        public WX_Account_USER_AUZDAL()
            : base("Your web.config DbConnectString")
        {

        }
		*/
    }
}
