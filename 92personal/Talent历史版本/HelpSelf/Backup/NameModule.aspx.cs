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
    public partial class NameModule : System.Web.UI.Page
    {
        protected static BLL.TB_HS_Module moduledb = new BLL.TB_HS_Module();
        private static BLL.TB_HS_NamePermission npdb = new BLL.TB_HS_NamePermission();

        private static JavaScriptSerializer jss = new JavaScriptSerializer();

        protected Pager p = new Pager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var userid = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
                if (!Common.Constants.isAdmin(userid)) Response.Redirect("login.aspx");

                p.total = npdb.GetTotal("");
                p.html = GetModuleList(0, 1, "", p.total);
            }
        }

        public static string GetModuleList(int pagesize, int index, string querystr, int total)
        {
            int itempager = Common.Constants.GetPageItems(ref pagesize, index, total);
            if (itempager <= 0) return "";
            StringBuilder sb = new StringBuilder();
            List<Model.TB_HS_NamePermission> list = npdb.GetModelList(pagesize, index, querystr, itempager);

            foreach (var apply in list)
            {
                sb.Append("<tr>");
                sb.Append("<td><input name='NP_No' value='" + apply.NP_No + "' type='checkbox'  /></td>");
                sb.Append("<td><select name='NP_M_No'>" + moduledb.GetOptions(0, (apply.NP_M_No == null ? 0 : apply.NP_M_No.Value)) + "</select></td>");
                sb.Append("<td><input class=gray  name='NP_Name' value='" + apply.NP_Name + "'  style='width:300px' /></td>");
                sb.Append("<td><select name='NP_Status'><option value='1' " + (apply.NP_Status == 1 ? "selected=selected" : "") + " >有效</option><option value='0' " + (apply.NP_Status == 0 ? "selected=selected" : "") + " >无效</option></select></td>");
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

            var ModuleArr = jss.Deserialize<List<Model.TB_HS_NamePermission>>(list);
            foreach (var module in ModuleArr)
            {
                module.NP_Name = HttpUtility.UrlDecode(module.NP_Name);
                if (module.NP_No == 0)
                {
                    if (npdb.GetModel(module.NP_M_No == null ? "0" : module.NP_M_No.Value + "", module.NP_Name) == null)
                        npdb.Add(module);
                }
                else
                {
                        npdb.Update(module);
                }
            }
            return "{html:'姓名信息保存成功',flag:'true'}";
        }

        [WebMethod]
        public static string GetModuleListWeb(int pagesize, int index, string querystr)
        {
            Pager p = new Pager();
            p.total = npdb.GetTotal(querystr);
            p.html = GetModuleList(pagesize, index, querystr, p.total);
            return jss.Serialize(p);
        }

        [WebMethod]
        public static string deleteModule(string NP_Nolist)
        {
            string userid = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
            if (!Common.Constants.isAdmin(userid))
                return "{html:'登录状态不争气或不是管理员，请重新登录！',flag:'false'}";

            npdb.DeleteList(NP_Nolist);
            return "{html:'姓名删除成功',flag:'true'}";
        }

    }
}