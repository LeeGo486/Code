using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Text;
using System.Web.Services;

namespace HelpSelf.Web
{
    public partial class Module : System.Web.UI.Page
    {
        private static BLL.TB_HS_Module moduledb = new BLL.TB_HS_Module();
        private static JavaScriptSerializer jss = new JavaScriptSerializer();

        protected Pager p = new Pager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var userid = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
                if (!Common.Constants.isAdmin(userid)) Response.Redirect("login.aspx");

                p.total = moduledb.GetTotal("");
                p.html = GetModuleList(0, 1, "",p.total);
            }
        }

        public static string GetModuleList(int pagesize, int index, string querystr, int total)
        {
            int itempager = Common.Constants.GetPageItems(ref pagesize, index, total);
            if (itempager <= 0) return "";
            StringBuilder sb = new StringBuilder();
            List<Model.TB_HS_Module> list = moduledb.GetModelList(pagesize, index, querystr, itempager);

            foreach (var apply in list)
            {
                sb.Append("<tr>");
                sb.Append("<td><input name='M_No' value='" + apply.M_No + "' type='hidden'  /><input class='gray' name='M_Name' value='" + apply.M_Name + "'  style='width:115px' /></td>");
                sb.Append("<td><input class='gray' name='M_Desc' value='"+ apply.M_Desc + "'  style='width:205px' /></td>");
                sb.Append("<td><select name='M_Type'><option value='0' " + (apply.M_Type == 0 ? "selected=selected" : "") + " >名字</option><option value='1' " + (apply.M_Type == 1 ? "selected=selected" : "") + " >IP</option><option value='2' " + (apply.M_Type == 2 ? "selected=selected" : "") + " >所有</option></select></td>");
                sb.Append("<td><select name='M_Status'><option value='1' "+( apply.M_Status == 1 ? "selected=selected" : "" )+" >有效</option><option value='0' "+( apply.M_Status == 0 ? "selected=selected" : "" ) + " >无效</option></select></td>");
                sb.Append("<td><input class='gray'  name='M_Url' value='" + apply.M_Url + "'  style='width:240px' /></td>");
                sb.Append("<td><input class='gray'  name='M_Pic' value='" + apply.M_Pic + "'  style='width:115px' /></td>");
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

            var ModuleArr = jss.Deserialize<List<Model.TB_HS_Module>>(list);
            foreach (var module in ModuleArr)
            {
                module.M_Name = HttpUtility.UrlDecode(module.M_Name);
                module.M_Desc = HttpUtility.UrlDecode(module.M_Desc);
                module.M_Url = HttpUtility.UrlDecode(module.M_Url);
                module.M_Pic = HttpUtility.UrlDecode(module.M_Pic);
                if (module.M_No == 0)
                {
                    moduledb.Add(module);
                }
                else
                {
                    moduledb.Update(module);
                }
            }
            return "{html:'模块信息保存成功',flag:'true'}";
        }

        [WebMethod]
        public static string GetModuleListWeb(int pagesize, int index, string querystr)
        {
            Pager p = new Pager();
            p.total = moduledb.GetTotal(querystr);
            p.html = GetModuleList(pagesize, index, querystr, p.total);
            return jss.Serialize(p);
        }

        [WebMethod]
        public static string deleteModule(int M_No)
        {
            string userid = Common.Constants.getNullToString(Tools.SessionHelper.Get("userid"));
            if (!Common.Constants.isAdmin(userid))
                return "{html:'登录状态不争气或不是管理员，请重新登录！',flag:'false'}";

            moduledb.Delete(M_No);
            return "{html:'模块信息删除成功',flag:'true'}";
        }
    }

    

    public class Pager
    {
        public string html { set; get; }
        public int total { set; get; }
    }
}