using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EPManageWeb.Helper
{
    public static class PagerHelper
    {
        private const int defaultDisplayCount = 11;

        #region HtmlHelper Extensions

        /// <summary>
        /// Pager Helper Extensions
        /// </summary>
        /// <param name="htmlHelper"></param>
        /// <param name="currentPage">当前页码</param>
        /// <param name="pageSize">页面显示的数据条目</param>
        /// <param name="totalCount">总记录数</param>
        /// <param name="toDisplayCount">Helper要显示的页数</param>
        /// <returns></returns>
        public static string Pager(this HtmlHelper htmlHelper, String pageParameterName, int currentPage, int pageSize, int totalCount, int toDisplayCount)
        {
            RenderPager pager = new RenderPager(htmlHelper, pageParameterName, currentPage, pageSize, totalCount, toDisplayCount);
            return pager.RenderHtml();
        }

        /// <summary>
        /// Pager Helper Extensions
        /// </summary>
        /// <param name="htmlHelper"></param>
        /// <param name="currentPage">当前页码</param>
        /// <param name="pageSize">页面显示的数据条目</param>
        /// <param name="totalCount">总记录数</param>
        /// <returns></returns>
        public static string Pager(this HtmlHelper htmlHelper, String pageParameterName, int currentPage, int pageSize, int totalCount)
        {
            RenderPager pager = new RenderPager(htmlHelper, pageParameterName, currentPage, pageSize, totalCount, defaultDisplayCount);

            return pager.RenderHtml();
        }

        /// <summary>
        /// IEnumerable extensions
        /// </summary>
        public static PageList<T> ToPageList<T>(this IEnumerable<T> source, int pageIndex, int pageSize, int totalCount)
        {
            return new PageList<T>(source, pageIndex, pageSize, totalCount);
        }

        #endregion
    }
}