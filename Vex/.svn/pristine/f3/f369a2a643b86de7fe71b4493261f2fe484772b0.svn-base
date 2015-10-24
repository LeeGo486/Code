using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Collections;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：GetDemoData
/// 类说明：测试数据获取
/// 创建人：马卫清
/// 创建日期：2014-04-15
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MwqTest
{

    public class GetDemoData : HZYLogicBase, ILogicGetData
    {
        public GetDemoData()
        {
            this.m_SessionCheck = false;
        }

        private Dbconn conn = new Dbconn("MDM");
        DateTime timeNow = DateTime.Now;

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();

                string strSessionID = hzyMessage.Session_ID;

                string strSQL = @"
                                SELECT  top 2 *
                                FROM [mwq_test].[dbo].[DataGrid]
                ";
                ds = conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);
                return ds;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
    }
}
