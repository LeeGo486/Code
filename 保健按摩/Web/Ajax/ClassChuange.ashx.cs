using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Data;

namespace EPReper.Web.Ajax
{
    /// <summary>
    /// ClassChuange 的摘要说明
    /// </summary>
    public class ClassChuange : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string id = context.Request["id"];            
            EPReper.BLL.ReperClass RC = new BLL.ReperClass();
            DataTable dt = RC.GetLists(id).Tables[0];
            List<classname> list = new List<classname>();
            list.Add(new classname() { text = "", value = "" });
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    list.Add(new classname() { text = dt.Rows[i]["classname"].ToString(), value = dt.Rows[i]["id"].ToString() });
                }
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            context.Response.Write(jss.Serialize(list));
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        public class classname
        {
            public string text
            {
                get;
                set;
            }
            public string value
            { get; set; }

        }
    }
}