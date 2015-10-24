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

/**
 * 作者：WebMisSharp
 * 时间：2015-07-27 16:31:42
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
    public class WX_QR_CodeScanFansService : BaseService<WX_QR_CodeScanFans>, IWX_QR_CodeScanFansService
    {
        private IWX_QR_CodeScanFansDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public WX_QR_CodeScanFansService()
            : base(new WX_QR_CodeScanFansDAL())
        {
            dal = IEF as WX_QR_CodeScanFansDAL;
        }

    }
}

