using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;

/**
 * 作者：WebMisSharp
 * 时间：2014/7/11 10:06:23
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
    public class ITSMBasicInfoDAL : EFRepository<ITSM_BasicInfo>, IITSMBasicInfoDAL
    {
		/* 如果是多数据库，请开启
        public ITSMBasicInfoDAL()
            : base("Your web.config DbConnectString")
        {

        }
		*/
    }
}
