using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using System.Data;

namespace HZY.COM.WS.WSRR2 
{
    public class User : HZYLogicBase, ILogicGetData
    {
        public User()
        {
            this.m_SessionCheck = true;
        }

        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("WSRR");

            string strSQL = @"
                        SELECT 
                               [UserID]
                              ,[UserName]
                          FROM [WSRR_Manage].[F01_CERT].[User]";
            DataSet dsUser = conn.GetDataSet(strSQL);

            return dsUser;
        }
    }
}
