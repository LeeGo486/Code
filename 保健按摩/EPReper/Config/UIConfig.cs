using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace EPReper.Config
{
    public class UIConfig
    {
        public static string returnCopyRight = "(c)2011-2011 JuLun Inc. By " + verConfig.Productversion;
        public static string sysName = ConfigurationManager.AppSettings["sysName"];
        public static char sysNamereturnCopyRight;
        public static string PageSize = ConfigurationManager.AppSettings["PageSize"];
        public static string dirDumm = ConfigurationManager.AppSettings["dirDumm"];
        public static string EndTime = DateTime.Now.AddDays(3).ToString("yyyy-MM-dd");
        public static string LoginURL = ConfigurationManager.AppSettings["LoginURL"];
        public static string Dept = ConfigurationManager.AppSettings["Dept"];
        public static string FinishUser = ConfigurationManager.AppSettings["FinishUser"];
        public static string FinishRepair = ConfigurationManager.AppSettings["FinishRepair"];
        public static string Server = ConfigurationManager.AppSettings["Server"];
        public static int GetPageSize()
        {

            int n = Convert.ToInt32(ConfigurationManager.AppSettings["PageSize"]);
            if (n < 1)
                throw new Exception("每页记录条数不能小于1!");
            return n;
        }

    }
}
