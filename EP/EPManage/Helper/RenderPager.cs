using System.Web.Mvc;
using System.Text.RegularExpressions;
using System;
using System.Text;
using System.Web.Routing;
using System.Web.Mvc.Html;

namespace EPManageWeb.Helper
{
    public class RenderPager
    {
        #region 字段

        /// <summary>
        /// 当前页面的ViewContext
        /// </summary>
        private ViewContext viewContext;
        /// <summary>
        /// 当前页码
        /// </summary>
        private readonly int currentPage;
        /// <summary>
        /// 页面要显示的数据条数
        /// </summary>
        private readonly int pageSize;
        /// <summary>
        /// 总的记录数
        /// </summary>
        private readonly int totalCount;
        /// <summary>
        /// Pager Helper 要显示的页数
        /// </summary>
        private readonly int toDisplayCount;

        private readonly string pagelink;

        private readonly String pageParameterName;
        private HtmlHelper html;
        private RouteValueDictionary dict;
        #endregion

        #region 构造函数

        public RenderPager(HtmlHelper html, String pageParameterName, int currentPage, int pageSize, int totalCount, int toDisplayCount)
        {
            this.html = html;
            this.currentPage = currentPage;
            this.pageSize = pageSize;
            this.totalCount = totalCount;
            this.toDisplayCount = toDisplayCount;
            this.pageParameterName = pageParameterName;

            var queryString = html.ViewContext.HttpContext.Request.QueryString;
            dict = new System.Web.Routing.RouteValueDictionary(html.ViewContext.RouteData.Values);
            if (!string.IsNullOrEmpty(queryString[pageParameterName]))
            {
                foreach (string key in queryString.Keys)
                    if (queryString[key] != null && !string.IsNullOrEmpty(key))
                        dict[key] = queryString[key];
                int.TryParse(queryString[pageParameterName], out currentPage);
            }
            else
            {
                if (dict.ContainsKey(pageParameterName))
                    int.TryParse(dict[pageParameterName].ToString(), out currentPage);
            }
            foreach (string key in queryString.Keys)
                dict[key] = queryString[key];
        }

        #endregion

        public string RenderHtml()
        {
            if (totalCount <= pageSize)
                return string.Empty;

            int pageCount = (int)Math.Ceiling(this.totalCount / (double)this.pageSize);

            int start = 1;

            int end = toDisplayCount;
            if (pageCount < toDisplayCount) end = pageCount;

            int centerNumber = toDisplayCount / 2;

            if (pageCount > toDisplayCount)
            {

                int topNumber = currentPage - centerNumber;

                if (topNumber > 1)
                {
                    start = topNumber;
                }

                if (topNumber > pageCount - toDisplayCount)
                {
                    start = pageCount - toDisplayCount + 1;
                }

                int endNumber = currentPage + centerNumber;

                if (currentPage >= pageCount - centerNumber)
                {
                    end = pageCount;
                }
                else
                {
                    if (endNumber > toDisplayCount)
                    {
                        end = endNumber;
                    }
                }

            }

            StringBuilder sb = new StringBuilder();

            if (this.currentPage > 1)
            {
                dict[pageParameterName] = currentPage - 1;
                sb.Append(html.RouteLink("<< 上一页", dict));
            }

            if (start > 1)
            {
                dict[pageParameterName] = 1;
                sb.Append(html.RouteLink("1", dict));
                sb.Append("...");
            }

            for (int i = start; i <= end; i++)
            {
                if (i == this.currentPage)
                {
                    sb.AppendFormat("<span class=\"current\">{0}</span>", i);
                }
                else
                {
                    dict[pageParameterName] = i;
                    sb.Append(html.RouteLink(i.ToString(), dict));
                }
            }

            if (end < pageCount)
            {
                sb.Append("...");
                dict[pageParameterName] = pageCount.ToString();
                sb.Append(html.RouteLink(pageCount.ToString(), dict));
            }

            if (this.currentPage < pageCount)
            {
                dict[pageParameterName] = this.currentPage + 1;
                sb.Append(html.RouteLink("下一页 >>", dict));
            }
            return sb.ToString();
        }
    }
}