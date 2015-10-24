using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Transactions;
using HZY.COM.Common.Base;


namespace HZY.COM.WS.SPWX
{
    internal class DBConn
    {
        private string appName;
        private string soure;
        internal SqlConnection sqlCon;

        internal DBConn(string appName)
        {
            this.appName = appName;

            this.soure
                = Security.Decode(ConfigurationManager.AppSettings[this.appName]);

            this.sqlCon = new SqlConnection(this.soure);
        }


    }
}
