using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace HelpSelf.Web
{
    public partial class userModules : System.Web.UI.Page
    {
        private static BLL.TB_HS_IPPermission ipdb = new BLL.TB_HS_IPPermission();
        private static BLL.TB_HS_NamePermission npdb = new BLL.TB_HS_NamePermission();
        private static BLL.TB_HS_Module mdb = new BLL.TB_HS_Module();

        protected string listr = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var userid = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
                if (userid == "" ) Response.Redirect("login.aspx");
                var list = new List<String>();
                GetIPMoudles(list);
                GetNameMoudles(list);
                GetALLMoudles(list);
                StringBuilder sb = new StringBuilder();
                var str = String.Join(",", list.ToArray());
                var tmplist = mdb.GetModelList(" M_No in (" + str + ")  order by M_Desc asc");
                foreach(var obj in tmplist )
                {
                    var tmpstr = obj.M_Url == null ? "" : obj.M_Url;
                    sb.Append("<li>");
                    sb.Append("<a target='zzptviewwin' href='" + tmpstr.Replace("{name}", HttpUtility.UrlEncode(Tools.SessionHelper.Get("userid"),Encoding.UTF8)) + "'>");
                    sb.Append("<img src='Images/");
                    sb.Append(obj.M_Pic);
                    sb.Append("' alt='' />");
                    sb.Append("</a>");
                    sb.Append("</li>");
                }
                listr = sb.ToString();
            }
        }


        protected void GetALLMoudles(List<String> list)
        {
            var alllist = mdb.GetModelList(" M_Type='2' and M_Status='1' ");
            foreach (var obj in alllist)
            {
                list.Add(obj.M_No.ToString());
            }
        }

        protected void GetIPMoudles(List<String> list)
        {
            string clientIP = HttpContext.Current.Request.UserHostAddress.ToString();
            var substr = clientIP.Substring(0, clientIP.LastIndexOf('.')) + ".0";
            var iplist = ipdb.GetModelList(" and M_Status='1' and IP_Status='1' and IP_Address='" + substr + "' ");
            foreach (var ip in iplist)
            {
                list.Add(ip.IP_M_No == null ? "0": ip.IP_M_No.Value.ToString());
            }
        }

        protected void GetNameMoudles(List<String> list)
        {
            var uplist = npdb.GetModelList(" and M_Status='1' and NP_Status='1' and NP_Name='" + Tools.SessionHelper.Get("userid") + "' ");
            StringBuilder sb = new StringBuilder();
            foreach (var up in uplist)
            {
                list.Add(up.NP_M_No == null ? "0" : up.NP_M_No.Value.ToString());
            }
        }
    }
}