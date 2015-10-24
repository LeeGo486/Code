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
                string _connectionString = ConfigurationManager.ConnectionStrings["NebulaIDB"].ToString();
                return _connectionString;
            }
        }

    }
}
