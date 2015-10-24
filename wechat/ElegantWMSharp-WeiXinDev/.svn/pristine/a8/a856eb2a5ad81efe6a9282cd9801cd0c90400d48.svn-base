using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Hubble.SQLClient;
using Hubble.Core.Analysis.HighLight;
using Hubble.Analyzer;
using System.Data;
using System.Text.RegularExpressions;
using System.Web;

namespace DBUtility
{
    public abstract class DbHelperHubble
    {
        //获取连接串
        public static string connectionString = PubConstant.ConnectionString;
        //构造函数
        public DbHelperHubble()
        {}
        const int CacheTimeout = 0; //缓存
        public static DataTable Optimized(string tablename)
        {
            using (HubbleAsyncConnection conn = new HubbleAsyncConnection(connectionString))
            {
                conn.Open();
                string sql = string.Format("exec SP_Columns '{0}'", tablename.Replace("'", "''"));
                HubbleCommand cmd = new HubbleCommand(sql, conn);
                DataTable dt = cmd.Query().Tables[0];
                cmd.Dispose();
                conn.Close();
                conn.Dispose();
                return dt;
            }
        }
        public static bool InsertHubbleDB(string sql)
        {
            using (HubbleAsyncConnection conn = new HubbleAsyncConnection(connectionString))
            {
                conn.Open();
                HubbleCommand cmd = new HubbleCommand(sql, conn);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                conn.Close();
                conn.Dispose();
                return true;
            }
        }
        public static DataTable ExecuteSqlQuery(string sql)
        {
            DataSet ds = new DataSet();
            using (HubbleAsyncConnection conn = new HubbleAsyncConnection(connectionString))
            {
                conn.Open();
                HubbleDataAdapter adapter = new HubbleDataAdapter();
                adapter.SelectCommand = new HubbleCommand(sql, conn);
                adapter.SelectCommand.CacheTimeout = CacheTimeout;
                HubbleCommand cmd = adapter.SelectCommand;
                ds = cmd.Query(CacheTimeout);
                adapter.Dispose();
                conn.Close();
                conn.Dispose();
                return ds.Tables[0];
            }
        }
        public static string KeyWordsAnalyzer(string keywords,string tablename,string columname)
        {
            using (HubbleAsyncConnection conn = new HubbleAsyncConnection(connectionString))
            {
                HubbleCommand matchCmd = new HubbleCommand(conn);
                string wordssplitbyspace;
                string matchString = matchCmd.GetKeywordAnalyzerStringFromServer(tablename,
                    columname, keywords, int.MaxValue, out wordssplitbyspace);
                matchCmd.Dispose();
                conn.Close();
                conn.Dispose();
                return matchString;
            }
        }


        public static string NoHTML(string Htmlstring)
        {
            //删除脚本 
            Htmlstring = Regex.Replace(Htmlstring, @"<script[^>]*?>.*?</script>", "",
              RegexOptions.IgnoreCase);
            //删除HTML 
            Htmlstring = Regex.Replace(Htmlstring, @"<(.[^>]*)>", "",
              RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"([\r\n])[\s]+", "",
              RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"-->", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"<!--.*", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(quot|#34);", "\"",
              RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(amp|#38);", "&",
              RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(lt|#60);", "<",
              RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(gt|#62);", ">",
              RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(nbsp|#160);", "   ",
              RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(iexcl|#161);", "\xa1",
              RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(cent|#162);", "\xa2",
              RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(pound|#163);", "\xa3",
              RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(copy|#169);", "\xa9",
              RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&#(\d+);", "",
              RegexOptions.IgnoreCase);
            Htmlstring.Replace("<", "");
            Htmlstring.Replace(">", "");
            Htmlstring.Replace("\r\n", "");
            Htmlstring = HttpContext.Current.Server.HtmlEncode(Htmlstring).Trim();

            return Htmlstring;
        }

        public static string ReturnEnCodeKeyWords(string keywords)
        {
            return HttpUtility.UrlEncode(keywords);
        }
    }
}
