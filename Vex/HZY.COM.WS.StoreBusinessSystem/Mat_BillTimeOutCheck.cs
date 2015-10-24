using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：Mat_BillTimeOutCheck
/// 类说明：店铺维修超期数据检查
/// 创建人：刘洪
/// 创建日期：2014-03-11 
/// 修改人：2014-03-17
/// 修改日期：
namespace HZY.COM.WS.StoreBusinessSystem
{

    public class Mat_BillTimeOutCheck : HZYLogicBase, ILogicExecute
    {
        public Mat_BillTimeOutCheck()
        {
            this.m_SessionCheck = false;
        }

        private Dbconn conn = new Dbconn("HZY_Mat");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;

        public bool  Execute()
        {

             conn.Excute(@"
	                        UPDATE [mat].[mat_bill]
	                        SET state=7 --处理超期
	                        WHERE state = 1
                                    AND CONVERT(VARCHAR(10), DATEADD(DAY, 2, [chk_date]), 21) < CONVERT(VARCHAR(10), GETDATE(), 21)

	                        UPDATE [mat].[mat_bill]
	                        SET state=4 --施工超期
	                        WHERE state IN ( 2, 6 )
                                AND CONVERT(VARCHAR(10), [schemaenddate], 21) < CONVERT(VARCHAR(10), GETDATE(), 21)
                        ");

             return true;
        }
    }
}
