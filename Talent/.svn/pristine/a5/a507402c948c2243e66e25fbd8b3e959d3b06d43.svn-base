using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.IO;
using Talent.Web.TalentClass;

namespace Talent.Web
{
    /// <summary>
    /// report 的摘要说明
    /// </summary>
    public class report : IHttpHandler,IRequiresSessionState 
    {

        public void ProcessRequest(HttpContext context)
        {
            StringWriter sw = null;

            string userid = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
            string mode = Common.Constants.getReqValue(context.Request,"mode");
            if (userid =="" || mode == "")
            {
                context.Response.AddHeader("Content-Disposition", "attachment; filename=111111.csv");
                context.Response.ContentType = "application/ms-excel";
                context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
                context.Response.Write("");
            }
            else
            {
                context.Response.ContentType = "application/ms-excel";
                switch (mode)
                {
                    case "1": sw = TalentClassCx.ReportTalentClass(context.Request.QueryString["queryStr"]);  /*颜色类别*/
                        context.Response.AddHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode("人才类别") + ".csv");
                        break;
                    case "2": sw = TalentCx.TalentCx.ReportTalent(context.Request.QueryString["queryStr"]);  /*人才列表 大*/
                        context.Response.AddHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode("人才列表") + ".csv");
                        break;
                    case "3": sw = TalentInfo.TalentLlist.ReportTalent(context.Request.QueryString["queryStr"]);  /*人才列表 小*/
                        context.Response.AddHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode("人才列表") + ".csv");
                        break;
                    case "21": sw = TalentInfo.ReportTalent.ReportTalentWord(context.Request.QueryString["CB_No"]);  /*人才文档*/
                        context.Response.ContentType = "application/ms-word";
                        context.Response.AddHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode("人才信息") + ".doc");
                        break;
                    default: sw = new StringWriter(); break; 
                }
                context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
                context.Response.Write(sw);
            }
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}