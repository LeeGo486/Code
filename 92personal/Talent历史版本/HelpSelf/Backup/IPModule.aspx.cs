using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Text;

namespace HelpSelf.Web
{
    public partial class IPModule : System.Web.UI.Page
    {
        protected static BLL.TB_HS_Module moduledb = new BLL.TB_HS_Module();
        private static BLL.TB_HS_IPPermission ipdb = new BLL.TB_HS_IPPermission();

        private static JavaScriptSerializer jss = new JavaScriptSerializer();

        protected Pager p = new Pager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var userid = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
                if (!Common.Constants.isAdmin(userid)) Response.Redirect("login.aspx");

                p.total = ipdb.GetTotal("");
                p.html = GetModuleList(0, 1, "", p.total);
            }
        }



        public static string GetModuleList(int pagesize, int index, string querystr, int total)
        {
            int itempager = Common.Constants.GetPageItems(ref pagesize, index, total);
            if (itempager <= 0) return "";
            StringBuilder sb = new StringBuilder();
            List<Model.TB_HS_IPPermission> list = ipdb.GetModelList(pagesize, index, querystr, itempager);

            foreach (var apply in list)
            {
                sb.Append("<tr>");
                sb.Append("<td><input name='IP_No' value='" + apply.IP_No + "' type='checkbox'  /></td>");
                sb.Append("<td><select name='IP_M_No'>" + moduledb.GetOptions(1,(apply.IP_M_No == null ? 0 : apply.IP_M_No.Value)) + "</select></td>");
                sb.Append("<td><input class=gray  name='IP_Name' value='" + apply.IP_Name + "'  style='width:300px' /></td>");
                sb.Append("<td><input class=gray  name='IP_Address' value='" + apply.IP_Address + "'  style='width:140px' /></td>");
                sb.Append("<td><select name='IP_Status'><option value='1' " + (apply.IP_Status == 1 ? "selected=selected" : "") + " >有效</option><option value='0' " + (apply.IP_Status == 0 ? "selected=selected" : "") + " >无效</option></select></td>");
                sb.Append("</tr>");
            }

            return sb.ToString();
        }

        [WebMethod]
        public static string SaveOrUpdateList(string list)
        {
            string userid = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
            if (!Common.Constants.isAdmin(userid))
                return "{html:'登录状态不争气或不是管理员，请重新登录！',flag:'false'}";

            var ModuleArr = jss.Deserialize<List<Model.TB_HS_IPPermission>>(list);
            foreach (var module in ModuleArr)
            {
                module.IP_Name = HttpUtility.UrlDecode(module.IP_Name);
                module.IP_Address = HttpUtility.UrlDecode(module.IP_Address);
                
                if (module.IP_No == 0)
                {
                    if (ipdb.GetModel(module.IP_M_No == null ? "0" : module.IP_M_No.Value + "", module.IP_Address) == null)
                    {
                        ipdb.Add(module);
                    }
                }
                else
                {
                        ipdb.Update(module);
                }
            }
            return "{html:'IP信息保存成功',flag:'true'}";
        }

        [WebMethod]
        public static string GetModuleListWeb(int pagesize, int index, string querystr)
        {
            Pager p = new Pager();
            p.total = ipdb.GetTotal(querystr);
            p.html = GetModuleList(pagesize, index, querystr, p.total);
            return jss.Serialize(p);
        }

        [WebMethod]
        public static string deleteModule(string IP_Nolist)
        {
            string userid = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
            if (!Common.Constants.isAdmin(userid))
                return "{html:'登录状态不争气或不是管理员，请重新登录！',flag:'false'}";

            ipdb.DeleteList(IP_Nolist);
            return "{html:'IP删除成功',flag:'true'}";
        }


    }
}