using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Web;

namespace EPReper.Config
{
    public class DBConfig
    {
        //public static readonly string EPReperconString = ConfigurationManager.ConnectionStrings["EPReperconString"].ConnectionString;
        //public static readonly string UserInfoString =ConfigurationManager.ConnectionStrings["UserInfoString"].ConnectionString; 
        //public static readonly string NotesString =  ConfigurationManager.ConnectionStrings["NotesString"].ConnectionString;
        public static string EPErperString
        {
            get
            {
                string tstr = ConfigurationManager.ConnectionStrings["EPErperString"].ConnectionString;
                    return tstr;
            }
        }
        public static string UserInfoString
        {
            get
            {
                string tstr = ConfigurationManager.ConnectionStrings["UserInfoString"].ConnectionString;
                    return tstr;
            }
        }
        public static string AMString
        {
            get
            {
                string tstr = ConfigurationManager.ConnectionStrings["AMString"].ConnectionString;
                    return tstr;
            }
        }
        public static string SendMSGString
        {
            get
            {
                string tstr = ConfigurationManager.ConnectionStrings["SendMSGString"].ConnectionString;
                return tstr;
            }
        }

        /// <summary>
        /// 取得连接字符串
        /// </summary>
        /// <param name="tstr"></param>
        /// <returns></returns>
        private static string getConnectionString(string tstr)
        {
            string conns = string.Empty;
            tstr = tstr.Replace('/', '\\');
            string[] str = tstr.Split('\\');
            int j = 0;
            for (int i = 0; i < str.Length; i++)
            {
                if (!string.IsNullOrEmpty(str[i]))
                {
                    if (j == 0)
                        conns = str[i];
                    else
                        conns += "\\" + str[i];
                    j++;
                }
            }

            if (HttpContext.Current == null)
            {
                conns = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + HttpRuntime.AppDomainAppPath + conns + ";Persist Security Info=True;";
            }
            else
                conns = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + HttpContext.Current.Server.MapPath(tstr) + ";Persist Security Info=True;";
            return conns;
        }
    }
}
