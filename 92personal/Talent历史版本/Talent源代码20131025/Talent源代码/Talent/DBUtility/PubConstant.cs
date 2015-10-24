using System;
using System.Configuration;
namespace Maticsoft.DBUtility
{
    
    public class PubConstant
    {        
        /// <summary>
        /// 获取连接字符串
        /// </summary>
        public static string LoginConnectionString = ConfigurationManager.ConnectionStrings["LoginConnectionString"].ConnectionString;

        public static string TalentConnectionString = ConfigurationManager.ConnectionStrings["TalentConnectionString"].ConnectionString;

        public static string CGConnectionString = ConfigurationManager.ConnectionStrings["CGConnectionString"].ConnectionString;

        /// <summary>
        /// 得到web.config里配置项的数据库连接字符串。
        /// </summary>
        /// <param name="configName"></param>
        /// <returns></returns>
        public static string GetConnectionString(string configName)
        {
            string connectionString = ConfigurationManager.AppSettings[configName];
            return connectionString;
        }


        public static string PlaceStr = GetConnectionString("PlaceStr");


    }
}
