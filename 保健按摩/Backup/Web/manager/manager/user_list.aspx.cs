using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPReper.Web.manager.manager
{
    public partial class user_list : System.Web.UI.Page
    {
        EPReper.BLL.Manager Manager = new BLL.Manager();
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Tools.CookieHelper.GetCookie("CN_ID") == "" || Tools.CookieHelper.GetCookie("CN_ID") == null)
            {
                Response.Redirect("../../login.aspx");
            }

            if (Request.QueryString["type"] != null)
            {
                string types = Request.QueryString["type"].ToString();
                string id=Request.QueryString["id"].ToString();
                if (types.Equals("del"))
                {
                    del(id);
                }
                if (types.Equals("up"))
                {
                    up(id);
                }
                if (types.Equals("down"))
                {
                    down(id);
                }
            }

            this.PageNavigator1.OnPageChange += new PageChangeHandler(PageNavigator1_PageChange);
            if (!IsPostBack)
            {
                if (Session["pagesize"] == null)
                {
                    Session["pagesize"] = EPReper.Config.UIConfig.PageSize;
                }
                if (Session["pageindex"] == null)
                {
                    Session["pageindex"] = 1;
                }
                DropDownList1.SelectedValue = Tools.CookieHelper.GetCookie("pagesize");
                //初始化完成时间，当前时间+3天

                //初始化列表信息
                StartLoad(1, "");

            }
        }

        protected void PageNavigator1_PageChange(object sender, int PageIndex)
        {
            Session["pageindex"] = PageIndex;
            StartLoad(PageIndex, "");
        }
        protected void StartLoad(int PageIndex, string sqlWhere)
        {
            int RecordCount = 0, PageCount = 0;
            int PageSize = Convert.ToInt32(Session["pagesize"]);
            DropDownList1.SelectedValue = PageSize.ToString();
            if (sqlWhere == string.Empty || sqlWhere == null)
            {
                sqlWhere = "1=1";
            }
            DataTable dt = Manager.GetPage(sqlWhere, PageIndex, PageSize, out RecordCount, out PageCount);
            if (RecordCount % PageSize == 0)
            {
                PageCount = RecordCount / PageSize;
            }
            else
            {
                PageCount = RecordCount / PageSize + 1;
            }
            if (dt != null)
            {
                this.PageNavigator1.PageCount = PageCount;//共多少页
                this.PageNavigator1.PageIndex = PageIndex; //当前页数
                this.PageNavigator1.RecordCount = RecordCount;//共多少条记录

                dt.Columns.Add("level",typeof(string));
                dt.Columns.Add("op", typeof(string));
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string admin="";
                        string op = "";
                        if (dt.Rows[i]["isAdmin"].ToString().Trim().Equals("1"))
                        {
                            admin = "<font color=\"Red\">管理员</font>";
                            op += "<a href=\"user_list.aspx?type=down&id=" + dt.Rows[i]["id"] + "\">取消管理员权限</a>";
                        }
                        else
                        {
                            string[] adminids = dt.Rows[i]["repair"].ToString().Split(',');
                            string ad = "";
                            foreach (string s in adminids)
                            {
                                if (!s.Equals(""))
                                {
                                    ad += RC.GetList(" id = " + s).Tables[0].Rows[0]["classname"].ToString() + ",";
                                }
                            }
                            if (ad.Length > 0)
                            {
                                ad = ad.Remove(ad.Length - 1);
                            }
                            admin = ad+"维修员";
                            op+="<a href=\"user_list.aspx?type=up&id="+dt.Rows[i]["id"]+"\">设置为管理员权限</a>&nbsp;&nbsp;";
                            op += "<a href=\"user_list.aspx?type=del&id=" + dt.Rows[i]["id"] + "\" onClick=\"{if(confirm('确定要删除吗？')){return true;}return false;}\">删除人员</a>";
                        }
                        dt.Rows[i]["level"] = admin;
                        dt.Rows[i]["op"] = op;
                    }
                }
            }
            show.DataSource = dt;
            show.DataBind();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["pagesize"] = DropDownList1.Text.ToString();
            StartLoad(1, "");
        }

        protected void del(string id)
        {
            Manager.Delete(int.Parse(id));
            Response.Redirect("user_list.aspx");
        }
        protected void up(string id)
        {
            Manager.uPAdmin(int.Parse(id));
            Response.Redirect("user_list.aspx");
        }
        protected void down(string id)
        {
            Manager.downAdmin(int.Parse(id));
            Response.Redirect("user_list.aspx");
        }

        protected void bx(object sender, EventArgs e)
        {
            Response.Redirect("../ReperInfo/ReperInfo.aspx");
        }

        protected void ml(object sender, EventArgs e)
        {
            Response.Redirect("../ReperClass/ReperClass_List.aspx");
        }

        protected void ry(object sender, EventArgs e)
        {
            Response.Redirect("user_list.aspx");
        }

        protected void ry_add(object sender, EventArgs e)
        {
            Response.Redirect("user_add.aspx");
        }

        protected void work(object sender, EventArgs e)
        {
            Response.Redirect("../../index.aspx");
        }
    }
}