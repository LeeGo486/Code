using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

namespace ElegantWM.Tools
{
    /// <summary>
    /// 新闻内容分页类
    /// </summary>
    public class PagerHelper
    {

        /// <summary>
        ///文章分页函数   //使用的是FCK的分页字符串
        /// </summary>
        /// <param name="content">文章内容</param>
        /// <param name="currentPage">当前页码(第几页)</param>
        /// <param name="pageUrl">当前页面地址</param>
        /// 调用说明 ArticlePage(ds.Tables[0].Rows[0]["content"].ToString(),page, "ThesisShow.aspx?id=" + id);
        ///   this.lblPage.Text表示是分页label,this.lblcontent.Text表示显示的内容
        protected void ArticlePage(string content, int currentPage, string pageUrl, ref string lblPage, ref string lblcontent)
        {
            int pageCount = 0;//页数


            //<div style="page-break-after: always;"><span style="display: none;">&nbsp;</span></div>

            content = content.Replace("<div style=\"page-break-after: always\"><span style=\"display: none\">&#160;</span></div>", "[--page--]");//FCK在IE中生成的默认分页符，替换为自定义分页符
            content = content.Replace("<div style=\"page-break-after: always;\"><span style=\"display: none;\">&nbsp;</span></div>", "[--page--]");//FCK在FF中生成的默认分页符，替换为自定义分页符
            //string[] tempContent = System.Text.RegularExpressions.Regex.Split(content, "\\u005B--page--]"); //取得分页符 "\\u005B"为"["的转义

            string[] tempContent = System.Text.RegularExpressions.Regex.Split(content, "\\[--page--]"); //取得分页符 "\\["为"["的转义

            pageCount = tempContent.Length;
            string outputContent = "";//要输出的内容

            if (pageCount <= 1)
            {
                outputContent = content; //文章内容

            }
            else
            {
                string pageStr = "";//分页字符串
                pageStr += "共 <span class='count'>" + pageCount + "</span> 页&nbsp;&nbsp;";

                if (currentPage != 1)
                {
                    pageStr += "<a class='prev' href =" + pageUrl + "&page=" + (currentPage - 1) + ">上一页</a>";
                }

                for (int i = 1; i <= pageCount; i++)
                {
                    if (i == currentPage)
                        pageStr += ("<span class='active'>" + i + "</span>");
                    else
                        pageStr += ("<a class='num' href =" + pageUrl + "&page=" + i + ">" + i + "</a>");
                }

                if (currentPage != pageCount)
                {
                    pageStr += "<a class='next' href =" + pageUrl + "&page=" + (currentPage + 1) + ">下一页</a>";
                }
                lblPage = pageStr;
                outputContent = tempContent[currentPage - 1].ToString();
            }
            lblcontent = outputContent;
        }

        //最新最完整

        //使用方法如下：

        //非伪静态：

        // 引用内容
        //string content = ContentAutoPage.ContentPagination("内容",分页字符长度, "cid=1&id=10" ,"", 0, "", 当前页码);

        //伪静态：

        // 引用内容
        //string content = ContentAutoPage.ContentPagination("内容",分页字符长度, "Detail-1-10","", 0, ".html", 当前页码);


        //注意：
        //以上为原来的修改，红色部分是错误修复部分，请对照修改。（解决以前使用此分页朋友的问题）

        //下面是新修改的完整代码：
        /// <summary>
        /// 显示分页的主体部分
        /// </summary>
        /// <param name="content">要分页的内容。</param>
        /// <param name="ContentpageSize">自动分页时的字数限制。</param>
        /// <param name="preFix">地址的前缀。</param>
        /// <param name="sufFix">地址的后缀。</param>
        /// <param name="IsURLRewrite">是否启用伪静态(1是 0不是)。</param>
        /// <param name="fileExt">文件的后缀名,只对启用伪静态有效。</param>
        /// <param name="CurrentPage">当前是第几页</param>
        /// <returns>字符串+分页下标</returns>
        public static string ContentPagination(string content, int ContentpageSize, string preFix, string sufFix, int IsURLRewrite, string fileExt, int CurrentPage)
        {

            string ArticleContent = "";
            string[] arrContent;
            int Paginate = 0;
            string m_strFileUrl, m_strFileExt;
            string strContent = InsertPageBreak(content, ContentpageSize);
            int ContentLen = content.Length;
            if (strContent.IndexOf("[hiweb_break]") <= 0)
            {
                //ArticleContent = "<div id=\"NewsContentLabel\" class=\"NewsContent\">" + strContent + "</div><div id=\"Message\" class=\"Message\"></div>";
                ArticleContent = "<div id=\"NewsContentLabel\" class=\"NewsContent\">" + strContent + "</div>";
            }
            else
            {
                arrContent = strContent.Split(new string[1] { "[hiweb_break]" }, StringSplitOptions.None);
                Paginate = arrContent.Length;
                if (CurrentPage < 1) { CurrentPage = 1; }
                if (CurrentPage > Paginate) { CurrentPage = Paginate; }
                strContent = "<div id=\"NewsContentLabel\" class=\"NewsContent\">" + arrContent[CurrentPage - 1];
                //ArticleContent += strContent + "</p></div><p align=\"center\"><b>";
                ArticleContent += strContent + "</div><div align=\"center\"><b>";
                if (IsURLRewrite == 1)
                {
                    string tmpA, tmpB;
                    tmpA = preFix.Replace('&', '-');//在此可以修改静态页面URL样式
                    tmpB = sufFix.Replace('&', '-');//在此可以修改静态页面URL样式
                    m_strFileUrl = tmpA + "-" + tmpB;//在此可以修改静态页面URL样式
                    m_strFileExt = fileExt;
                }
                else
                {
                    m_strFileExt = "";
                    if (preFix != "")
                    {
                        m_strFileUrl = "?" + preFix + "&Page=";
                    }
                    else
                    {
                        m_strFileUrl = "?Page=";
                    }
                }
                if (CurrentPage > 1)
                {
                    if (IsURLRewrite == 1 && (CurrentPage - 1) == 1)
                    {
                        ArticleContent += "<a href=\"" + m_strFileUrl + (CurrentPage - 1).ToString() + sufFix + m_strFileExt + "\">上一页</a>  ";
                    }
                    else
                    {
                        ArticleContent += "<a href=\"" + m_strFileUrl + (CurrentPage - 1).ToString() + sufFix + m_strFileExt + "\">上一页</a>  ";
                    }
                }
                for (int i = 1; i <= Paginate; i++)
                {
                    if (i == CurrentPage)
                    {
                        ArticleContent += "<span style=\"color:red;\">[" + i.ToString() + "]</span> ";
                    }
                    else
                    {
                        if (IsURLRewrite == 1 && i == 1)
                        {
                            ArticleContent += "<a href=\"" + m_strFileUrl + i.ToString() + sufFix + m_strFileExt + "\">[" + i.ToString() + "]</a> ";
                        }
                        else if (IsURLRewrite == 1 && i != 1)
                        {
                            ArticleContent += "<a href=\"" + m_strFileUrl + i.ToString() + sufFix + m_strFileExt + "\">[" + i.ToString() + "]</a> ";
                        }
                        else
                        {
                            ArticleContent += "<a href=\"" + m_strFileUrl + i.ToString() + sufFix + m_strFileExt + "\">[" + i.ToString() + "]</a> ";
                        }
                    }
                }
                if (CurrentPage < Paginate)
                {
                    if (IsURLRewrite == 1)
                    {
                        ArticleContent += " <a href=\"" + m_strFileUrl + (CurrentPage + 1).ToString() + sufFix + m_strFileExt + "\">下一页</a>";
                    }
                    else
                    {
                        ArticleContent += " <a href=\"" + m_strFileUrl + (CurrentPage + 1).ToString() + sufFix + m_strFileExt + "\">下一页</a>";
                    }
                }
                ArticleContent += "</b></div>";
            }
            return ArticleContent;
        }
        /// <summary>
        /// 插入分割标签
        /// </summary>
        /// <param name="strText">打算插入标签的内容</param>
        /// <param name="maxPagesize">自动插入标签的最大字符长度</param>
        /// <returns></returns>
        private static string InsertPageBreak(string strText, int maxPagesize)
        {
            string s = strText;
            int sl = s.Length;
            string strPagebreak = "[hiweb_break]";
            bool IsCount = true;
            string Temp_String = "";
            string strTemp = "";
            string c = "";
            int iCount = 0;
            string[] Temp_Array;
            string ss = "";
            if (s.Length < Int32.Parse((maxPagesize + maxPagesize / 3).ToString()))
            {
                return s;
            }
            s = s.Replace(" ", "< >");
            s = s.Replace(">", "<>>");
            s = s.Replace("<", "<<>");
            s = s.Replace("\"", "<\">");
            s = s.Replace("'", "<'>");
            if (s != "" && maxPagesize != 0 && s.IndexOf(strPagebreak, 1) <= 0)
            {
                IsCount = true;
                Temp_String = "";

                for (int i = 0; i < sl; i++)
                {
                    c = s.Substring(i, 1);
                    if (c == "<")
                    {
                        IsCount = false;
                    }
                    else if (c == ">")
                    {
                        IsCount = true;
                    }
                    else
                    {
                        if (IsCount)
                        {
                            if (Regex.Replace(c, "\u4e00-\u9fa5", "", RegexOptions.IgnoreCase) == "")
                            {
                                iCount += 2;
                            }
                            else
                            {
                                iCount += 1;
                            }
                            if (iCount > maxPagesize && i < sl)
                            {
                                strTemp = s.Substring(0, i);
                                if (CheckPagination(strTemp, "table|a|b>|i>|strong|div|span"))
                                {
                                    Temp_String += i.ToString() + ",";
                                    iCount = 0;
                                }
                            }
                        }
                    }
                }
                if (Temp_String.Length > 1)
                {
                    Temp_String = Temp_String.Substring(0, Temp_String.Length - 1);
                }
                Temp_Array = Temp_String.Split(',');
                int l = Temp_Array.Length;
                if (Temp_Array.Length > 0)
                {
                    for (int j = l - 1; j > -1; j--)
                    {
                        ss = s.Substring(Int32.Parse(Temp_Array[j].ToString()) + 1);
                        if (ss.Length > 380)
                        {
                            s = s.Substring(0, Int32.Parse(Temp_Array[j].ToString())) + strPagebreak + ss;
                        }
                        else
                        {
                            s = s.Substring(0, Int32.Parse(Temp_Array[j].ToString())) + ss;
                        }
                    }
                }
            }
            s = s.Replace("< >", " ");
            s = s.Replace("<>>", ">");
            s = s.Replace("<<>", "<");
            s = s.Replace("<\">", "\"");
            s = s.Replace("<'>", "'");
            return s;
        }
        /// <summary>
        /// 检测内容标签闭合情况
        /// </summary>
        /// <param name="strTemp">打算检测的字符</param>
        /// <param name="strFind">打算检查闭合情况的标签集合</param>
        /// <returns></returns>
        private static bool CheckPagination(string strTemp, string strFind)
        {
            strTemp = strTemp.ToLower();
            strFind = strFind.ToLower();
            string[] FindArray;
            string m_strBegin, m_strEnd;
            int n = 0, m_intEndNum = 0, m_ingBeginNum = 0;
            if (strTemp != "" && strFind != "")
            {
                FindArray = strFind.Split('|');
                for (int i = 0, cl = FindArray.Length; i < cl; i++)
                {
                    m_strBegin = "<" + FindArray[i];
                    m_strEnd = "</" + FindArray[i];
                    n = 0;
                    while (strTemp.IndexOf(m_strBegin, n + 1) > 0)//不知道对不对
                    {
                        n = strTemp.IndexOf(m_strBegin, n + 1);
                        m_ingBeginNum += 1;
                    }
                    n = 0;
                    while (strTemp.IndexOf(m_strEnd, n + 1) > 0)//不知道对不对
                    {
                        n = strTemp.IndexOf(m_strEnd, n + 1);
                        m_intEndNum += 1;
                    }
                    if (m_intEndNum == m_ingBeginNum)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            else
            {
                return false;
            }
            return false;
        }
    }
}
