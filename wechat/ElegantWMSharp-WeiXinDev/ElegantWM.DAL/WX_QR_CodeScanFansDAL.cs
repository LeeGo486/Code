using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;

/**
 * 作者：WebMisSharp
 * 时间：2015-07-27 16:31:42
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
    public class WX_QR_CodeScanFansDAL : EFRepository<WX_QR_CodeScanFans>, IWX_QR_CodeScanFansDAL
    {
		/* 如果是多数据库，请开启
        public WX_QR_CodeScanFansDAL()
            : base("Your web.config DbConnectString")
        {

        }
		*/
    }
}
