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
 * 时间：2014-12-09 18:04:31
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
    public class Fire_QuestionService : BaseService<Fire_Question>, IFire_QuestionService
    {
        private IFire_QuestionDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public Fire_QuestionService()
            : base(new Fire_QuestionDAL())
        {
            dal = IEF as Fire_QuestionDAL;
        }

        #region 获取消防知识题目
            public System.Data.DataTable FireKnowLedgeInfo(string TntId)
            {
                return dal.FireKnowLedgeInfo(TntId);
            }
        #endregion

        #region 获取消防题目表头
            public System.Data.DataTable FireKnowLedgeHead(string TntId)
            {
                return dal.FireKnowLedgeHead(TntId);
            }
        #endregion
    }
}

