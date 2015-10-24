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
 * 时间：2014/5/28 14:07:02
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
    public class WXAccountService : BaseService<WX_Account>, IWXAccountService
    {
        private IWXAccountDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public WXAccountService()
            : base(new WXAccountDAL())
        {
            dal = IEF as WXAccountDAL;
        }

        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="_t">实体</param>
        /// <returns>是否成功</returns>
        public override bool Insert(WX_Account _t)
        {
            //插入记录，自动为公共字段赋值
            if (_t.Id == null || _t.Id == Guid.Parse("00000000-0000-0000-0000-000000000000"))
                _t.Id = Guid.NewGuid();
            _t.CreateTime = DateTime.Now;
            if (string.IsNullOrEmpty(_t.CreateUser))
                _t.CreateUser = AuthToken.CurrentUser.UserName;
            _t.TntId = Guid.Parse(AuthToken.CurrentUser.GroupId);
            //_t.ModifyUser = null;
            //_t.Version = 0;
            return IEF.Insert(_t);
        }
        /// <summary>
        /// 更新
        /// </summary>
        /// <param name="Command">sql</param>
        /// <returns></returns>
        public override bool Update(string Command)
        {
            //更新记录，自动为公共字段赋值
            Command = "ModifyTime='" + DateTime.Now.ToString() + "',ModifyUser='WeiXin'," + Command;
            return IEF.Update(Command);
        }
    }
}

