using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：获取MDM实体的列表树
/// 类说明：对获取MDM实体的列表树
/// 创建人：郭琦琦
/// 创建日期：2014-08-22 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.MDM2
{
    public class MDM2_Organization : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public MDM2_Organization()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        #endregion

        #region GetData获取MDM实体的列表树

        /// <summary>
        /// 获取MDM实体的列表树
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                Dbconn conn = new Dbconn("MDM_Market2");
                DataSet returnDs = conn.GetDataSet(@"
                        SELECT 组织单元系统编号,REPLACE(名称,'&','&amp;') 名称 ,上级组织单元系统编号,t1.Body_ID,t2.成本中心ID,t2.Body_ID ORGBody_ID
                          FROM [dbo].[MKT_0020] t1
                          LEFT JOIN  [dbo].[MKT_0019]  t2 ON t2.系统编号 = t1.组织单元系统编号
                          WHERE t1.是否有效 = '1' 
                ");
                return returnDs;
            }
            catch
            {
                throw;
            }
        }
        #endregion
    }
}



