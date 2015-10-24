using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace LYMessageService
{
    public class SqlHelper
    {
         //连接字符串
        public static string strConn = ConfigurationManager.AppSettings["LYSMS"];


        /// <summary>
        /// 输入不带参数sql语句，返回DataTable
        /// </summary>
        /// <param name="strSql">sql语句</param>
        /// <returns>DataTable结果集</returns>
        public static DataTable GetDataTable(string strSql)
        {
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = strSql;
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    return dt;
                }
            }
        }

        /// <summary>
        /// 输入带参数sql语句，返回DataTable
        /// </summary>
        /// <param name="strSql">sql语句</param>
        /// <param name="pams">参数</param>
        /// <returns>DataTable结果集</returns>
        public static DataTable GetDataTable(string strSql, params SqlParameter[] pams)
        {
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = strSql;

                    cmd.Parameters.AddRange(pams);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    return dt;
                }
            }
        }


        /// <summary>
        /// 输入带参数sql语句，返回影响行数
        /// </summary>
        /// <param name="strSql">sql语句</param>
        /// <param name="pams">参数</param>
        /// <returns>影响行数</returns>
        public static int ExcuteNoQuery(string strSql, params SqlParameter[] pams)
        {
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(strSql, conn))
                {
                    cmd.Parameters.AddRange(pams);
                    return cmd.ExecuteNonQuery();
                }
            }
        }

    }
}
