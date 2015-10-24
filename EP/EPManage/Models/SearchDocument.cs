using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Text.RegularExpressions;

namespace EPManageWeb.Models
{
    public class SearchDocument
    {
        public const int PAGE_SIZE = 20;
        private const String PREFIX = "^";
        public SearchDocument() { PageIndex = 1; }

        public String NO { get; set; }
        public String Tags { get; set; }
        public int ClothesTypeId { get; set; }

        public Field OrderByField { get; set; }

        public int PageIndex { get; set; }

        public enum Field
        {
            Id,
            Year,
            SaledCount,
            ViewedCount
        }

        public String ToSearchDocument()
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendFormat("(ClothesTypeId:{0})", ClothesTypeId);
            if (!String.IsNullOrEmpty(NO))
            {
                if (sb.Length > 0)
                    sb.Append(" AND ");

                sb.AppendFormat("(SampleNoIndex:\\" + PREFIX + "*{0}* OR ProductNOIndex:\\" + PREFIX + "*{0}*)", NO.ToLower());
            }

            var tags = Tags.Split(new char[] { ',' });
            Dictionary<string, string> dics = new Dictionary<string, string>();
            Array.ForEach(tags, t =>
                {
                    if (!String.IsNullOrEmpty(t))
                    {
                        var key = t.Substring(0, t.IndexOf('-'));
                        var value = t.Substring(t.IndexOf('-') + 1);
                        if (dics.ContainsKey(key))
                        {
                            dics[key] = dics[key] + "," + value;
                        }
                        else
                        {
                            dics.Add(key, value);
                        }
                    }
                });
            dics.Keys.ToList().ForEach(k =>
                {
                    if (!String.IsNullOrEmpty(dics[k]))
                    {
                        //3-H,X,A,B
                        //((3:H) OR (3:X))
                        sb.Append(" AND (");
                        //sb.AppendFormat(" ({0}:{1}) ", k, Regex.Replace(dics[k].Trim().Replace(',', ' '), @"[\(\)|+\-\!\{\}\[\}\^\""\~\*\?\:\\]", @"\$0"));
                        StringBuilder sb1 = new StringBuilder();
                        Array.ForEach(dics[k].Trim().Split(new char[] { ',' }), t =>
                            {
                                // sb1.AppendFormat("({0}:{1}) OR ", k, t);
                                sb1.AppendFormat("({0}:\\" + PREFIX + "*{1}*) OR ", k, Regex.Replace(t, @"[\(\)|+\-\!\{\}\[\}\^\""\~\*\?\:\\]", @"\$0"));
                            });
                        if (sb1.Length > 0) sb1.Remove(sb1.Length - 3, 3);
                        sb.Append(sb1);
                        sb.Append(")");
                    }
                });
            return sb.ToString();
        }
    }
}