using System;
using System.Configuration;

namespace DBUtility
{

    public class PubConstant
    {
        /// <summary>
        /// 获取连接字符串
        /// </summary>
        public static string ConnectionString
        {
            get
            {
                string _connectionString = ConfigurationManager.AppSettings["ConnectionString"];
                return _connectionString;
            }
        }

        //112服务器 小翅膀发送数据
        public static string AMConnectionString112
        {
            get
            {
                string _connectionString = ConfigurationManager.AppSettings["AMConnectionString112"];
                return _connectionString;
            }
        }


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


    }
}
