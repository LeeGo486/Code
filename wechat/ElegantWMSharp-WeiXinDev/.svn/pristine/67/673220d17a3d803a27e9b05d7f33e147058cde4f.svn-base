using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using ElegantWM.EntityModel;
using System.Diagnostics;
using Hubble.Core.Analysis.HighLight;
using Hubble.Analyzer;

namespace DBUtility
{
    public class NebulaDAL
    {
        /*
         * 搜索引擎代码
         */
        private static string _fnameAnalyzerName = null;
        private static string _ffcontentAnalyzerName = null;
        private static string _fauthor = null;
        private static void GetAnalyzerName()
        {
            if (_fnameAnalyzerName != null && _ffcontentAnalyzerName != null && _fauthor != null)
            { return; }
            foreach (DataRow row in DbHelperHubble.Optimized("N_KnowledgeBase").Rows)
            {
                if (row["FieldName"].ToString().Equals("kTitle", StringComparison.CurrentCultureIgnoreCase))
                    _fnameAnalyzerName = row["Analyzer"].ToString();
                if (row["FieldName"].ToString().Equals("kContent", StringComparison.CurrentCultureIgnoreCase))
                    _ffcontentAnalyzerName = row["Analyzer"].ToString();
                if (row["FieldName"].ToString().Equals("CreateUser", StringComparison.CurrentCultureIgnoreCase))
                    _ffcontentAnalyzerName = row["Analyzer"].ToString();
            }
        }
        /*
        public IList<N_Knowledge> Search(string searchType, string keywords, int limit, int start,
                            out int recCount, out long elapsedMilliseconds, string author=null,string category=null)
        {
            Stopwatch sw = new Stopwatch();
            sw.Start();
            GetAnalyzerName();
            string condition = "";
            if (!string.IsNullOrEmpty(author))
            {
                condition = "and CreateUser='" + author.Replace("'","").Replace("--","") + "'";
            }
            if (!string.IsNullOrEmpty(category))
            {
                condition = "and kCategory='" + category.Replace("'", "").Replace("--","") + "'";
            }
            string sql = "select between {0} to {1} * from N_KnowledgeBase where (kContent {2} '{3}' or kTitle^2 {2} '{3}') " + condition + " order by score desc";
            string pangu=DbHelperHubble.KeyWordsAnalyzer(keywords, "N_KnowledgeBase", "kContent");
            sql = string.Format(sql, (start - 1) * limit, start * limit - 1, searchType, pangu);
            DataTable dt = DbHelperHubble.ExecuteSqlQuery(sql);
            recCount = dt.MinimumCapacity;
            sw.Stop();
            elapsedMilliseconds = sw.ElapsedMilliseconds;
            return SearchDt2List(dt, keywords);
        }
        public IList<N_Knowledge> SearchDt2List(DataTable dt, string keywords)
        {
            IList<N_Knowledge> list = new List<N_Knowledge>();
            SimpleHTMLFormatter simpleHTMLFormatter = new SimpleHTMLFormatter("<font color='Red'>", "</font>");
            foreach (DataRow row in dt.Rows)
            {
                N_Knowledge _knowledge = new N_Knowledge();
                _knowledge.id = row["id"].ToString();
                _knowledge.kTitle = row["kTitle"].ToString();
                string _content = DbHelperHubble.NoHTML(row["kContent"].ToString()).Trim().Replace(" ", "").Replace("\r\n", "");
                _knowledge.kContent = "";
                
                _knowledge.ModifyTime = row["CreateTime"].ToString();
                _knowledge.Creater = row["CreateUser"].ToString();
                Highlighter fnameHighlighter = new Highlighter(simpleHTMLFormatter, new PanGuAnalyzer());
                fnameHighlighter.FragmentSize = 50;
                _knowledge.kTitle = fnameHighlighter.GetBestFragment(keywords, _knowledge.kTitle);
                if (string.IsNullOrEmpty(_knowledge.kTitle))
                    _knowledge.kTitle = row["kTitle"].ToString();
                Highlighter fcontentHighlighter = new Highlighter(simpleHTMLFormatter, new PanGuAnalyzer());
                //news.fcontent = news.fcontent.Length > 500 ? news.fcontent.Substring(0, 500) : news.fcontent;
                fcontentHighlighter.FragmentSize = 90;
                _knowledge.kContent = fcontentHighlighter.GetBestFragment(keywords, _content);
                if (string.IsNullOrEmpty(_knowledge.kContent))
                    _knowledge.kContent = _content.Length > 90 ? _content.Substring(0, 90) + "..." : _content;
                list.Add(_knowledge);
            }
            return list;
        }
         */
    }
}
