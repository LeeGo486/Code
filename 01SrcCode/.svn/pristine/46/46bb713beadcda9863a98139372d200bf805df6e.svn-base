#pragma checksum "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\DBHelper\PubConstant.cs" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "27A1FB96D01277EC9629645EABB828393116255B"

#line 1 "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\DBHelper\PubConstant.cs"
using System;
using System.Configuration;

namespace DBHelper
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
                //string _connectionString = ConfigurationManager.AppSettings["YL"];
                string _connectionString = ConfigurationManager.AppSettings["F22AS"];
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


#line default
#line hidden
