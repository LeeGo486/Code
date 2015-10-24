using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EPReper.IDAL;
using EPReper.DBUtility;
using System.Data;

namespace EPReper.SQLServerDAL
{
    public partial class SysInfo : ISysInfo
    {
        public SysInfo()
        { }



        public System.Data.DataSet GetList()
        {
            string strSql="select sysname,sysaddr FROM SysInfo";
            return DbHelper.ExecuteDataSet(CommandType.Text, strSql);
        }
    }
}
