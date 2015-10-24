using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：VexSSOUserInfo
/// 类说明：SSO获取用户信息
/// 创建人：马卫清
/// 创建日期：2014-07-30
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.SSO
{

    public class VexSSOUserInfo : LogicBase, ILogicExecute
    {
        #region 构造函数
        public VexSSOUserInfo()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量
        private Dbconn m_conn = new Dbconn("VEXSSO");
        
      
        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            return true;
        }
        #endregion

        #region  内部函数


        #endregion
    }

}