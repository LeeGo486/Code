using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPReper.Web.manager.ReperInfo
{
    public partial class ShowRI : System.Web.UI.Page
    {
        EPReper.BLL.RepairInfo RI = new BLL.RepairInfo();
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        EPReper.BLL.Manager Manager = new BLL.Manager();
        string classid;
        string userid = "";
        string bigid;
        int k = 0;
        //string strbigid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            /*if (Request.QueryString["k"] != null)
            {
                k = 0;
            }
             */
            if (Tools.CookieHelper.GetCookie("CN_ID") != "" && Tools.CookieHelper.GetCookie("CN_ID") != null)
            {
                userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
            }
            else
            {
                Response.Redirect("../../login.aspx");
            }
            if (Request.QueryString["bigid"] != null)
            {
                bigid = Request.QueryString["bigid"].ToString();
            }
            if (Request.QueryString["classid"] != null)
            {
                classid = Request.QueryString["classid"].ToString();
            }
            if (!IsPostBack)
            {
                string counts = Request.QueryString["counts"];
                if (counts != null)
                {
                    counts = counts.ToString();
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "报修消息", "<script>alert('您排在当前维修的第" + counts + "位!');</script>");
                }
            }
            //if (Request.QueryString["ClassID"] != null)
            //{
            //    classid="";
            //    //classid = Request.QueryString["ClassID"].ToString();
            //}
            //得到
            //userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
            //userid = "24"; 

            //维修员工登录设置为1
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            //DataTable mdt=Manager.GetList("username like'" + username + "'").Tables[0];
            //if (mdt.Rows.Count > 0)
            //{
            //    //if (mdt.Rows[0]["isAdmin"].ToString().Equals("0"))
            //    //{
            //        EPReper.Model.Reper.isReper = 1;
            //    //    string[] wheres = mdt.Rows[0]["repair"].ToString().Split(',');
            //    //    string where = "(";
            //    //    if (wheres.ToString() != "")
            //    //    {
            //    //        foreach (string s in wheres)
            //    //        {
            //    //            where += " BigID = " + s + " or";
            //    //        }
            //    //        where = where.Remove(where.Length - 2)+")";
            //    //    }
            //    //    strbigid = where;
            //    //}
            //}
            //else
            //{
            EPReper.Model.Reper.isReper = 0;
            //}

            if (Manager.GetList("username like'" + username + "' and isAdmin = 1").Tables[0].Rows.Count > 0)
            {
                //    mulu.Visible = true;
                //    renyuan.Visible = true;
                admins.Visible = true;
            }
            //if (Manager.GetList("username like'" + username + "' and isAdmin = 0").Tables[0].Rows.Count > 0)
            //{
            //    repair.Visible = true;

            //}





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
                //DropDownList1.SelectedValue = Tools.CookieHelper.GetCookie("pagesize");
                string _finish = "";
                string Finish = Request.QueryString["Finish"];
                if (Finish != null && Finish != "") { _finish = Finish.ToString(); }
                StartLoad(1, _finish);
            }

        }
        protected void PageNavigator1_PageChange(object sender, int PageIndex)
        {
            Session["pageindex"] = PageIndex;
            string _finish = "";
            string Finish = Request.QueryString["Finish"];
            if (Finish != null && Finish != "") { _finish = Finish.ToString(); }
            StartLoad(PageIndex, _finish);
        }
        protected void StartLoad(int PageIndex, string sqlWhere)
        {
            int RecordCount = 0, PageCount = 0;
            int PageSize = Convert.ToInt32(Session["pagesize"]);
            DropDownList1.SelectedValue = PageSize.ToString();

            if (sqlWhere == string.Empty || sqlWhere == null)
            {
                sqlWhere = "Finish >=0 and Finish<2";
            }
            else
            {
                sqlWhere = "Finish = " + sqlWhere;
            }
            if (bigid != null)
            {
                sqlWhere = "Finish>=0 and Finish<2 and BigID = " + bigid;
            }
            if (classid != null)
            {
                DataTable dtr = RC.GetList("parentID = " + classid).Tables[0];
                if (dtr != null)
                {
                    if (dtr.Rows.Count > 0)
                    {
                        string strWhere = "(";
                        for (int i = 0; i < dtr.Rows.Count; i++)
                        {
                            strWhere += " classid = " + dtr.Rows[i]["id"].ToString() + " or";
                        }
                        strWhere = strWhere.Substring(0, strWhere.Length - 2) + ")";
                        sqlWhere += " and " + strWhere;
                    }
                    else
                    {
                        sqlWhere += " and classid = " + classid;
                    }
                }
            }
            sqlWhere += " and isDel = 0";
            //if (EPReper.Model.Reper.isReper == 1&&strbigid!="")
            //{
            //    sqlWhere = sqlWhere + " and " + strbigid;
            //}
            DataTable dt = RI.GetPage(sqlWhere, PageIndex, PageSize, out RecordCount, out PageCount);//RI.GetList("ClassID = " + classid).Tables[0];
            k = (PageIndex - 1) * PageSize;
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
                dt.Columns.Add("ids", typeof(string));
                dt.Columns.Add("ClassName", typeof(string));
                dt.Columns.Add("ApplyName", typeof(string));
                dt.Columns.Add("RepairName", typeof(string));
                dt.Columns.Add("op", typeof(string));
                dt.Columns.Add("state", typeof(string));
                if (dt.Rows.Count > 0)
                {

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string classname = RC.GetList("id = " + dt.Rows[i]["ClassID"]).Tables[0].Rows[0]["classname"].ToString();
                        string bigname = RC.GetList("id= " + dt.Rows[i]["BigID"]).Tables[0].Rows[0]["classname"].ToString();
                        k++;
                        dt.Rows[i]["ids"] = bigname + "：第" + dt.Rows[i]["code"].ToString() + "位";
                        if (dt.Rows[i]["Finish"].ToString().Equals("1") || dt.Rows[i]["Finish"].ToString().Equals("2"))
                        {
                            dt.Rows[i]["ClassName"] = "<a href=\"RI_Show_End.aspx?ClassID=" + dt.Rows[i]["ClassID"].ToString() + "&id=" + dt.Rows[i]["id"].ToString() + "\">" + classname + "</a>";
                        }
                        else
                        {
                            dt.Rows[i]["ClassName"] = "<a href=\"RI_Show_Dal.aspx?ClassID=" + dt.Rows[i]["ClassID"].ToString() + "&id=" + dt.Rows[i]["id"].ToString() + "\">" + classname + "</a>";
                        }

                        dt.Rows[i]["ApplyName"] = UI.GetList("CN_ID = " + dt.Rows[i]["UserID"].ToString()).Tables[0].Rows[0]["CN_LOGIN"].ToString();
                        if (dt.Rows[i]["ReperID"].ToString().Equals(""))
                        {
                            dt.Rows[i]["RepairName"] = "";
                        }
                        else
                        {
                            dt.Rows[i]["RepairName"] = UI.GetList("CN_ID = " + dt.Rows[i]["ReperID"].ToString()).Tables[0].Rows[0]["CN_LOGIN"].ToString();
                        }
                        if (dt.Rows[i]["StartComment"].ToString().Length > 32)
                        {
                            dt.Rows[i]["StartComment"] = dt.Rows[i]["StartComment"].ToString().Substring(0, 31) + "...";
                        }
                        if (dt.Rows[i]["OverComment"].ToString().Length > 32)
                        {
                            dt.Rows[i]["OverComment"] = dt.Rows[i]["OverComment"].ToString().Substring(0, 31) + "...";
                        }
                        string opStr = "";
                        //if (EPReper.Model.Reper.isReper == 1)
                        //{
                        //    if (dt.Rows[i]["Finish"].ToString().Equals("0"))
                        //    {
                        //        opStr += "<a href=\"RI_Show_Dal.aspx?ClassID=" + dt.Rows[i]["ClassID"].ToString() + "&id=" + dt.Rows[i]["id"] + "\">接受请求</a>";
                        //    }
                        //    if (dt.Rows[i]["Finish"].ToString().Equals("1"))
                        //    {
                        //        opStr += "<a href=\"RI_Show_End.aspx?ClassID=" + dt.Rows[i]["ClassID"].ToString() + "&id=" + dt.Rows[i]["id"] + "\">完成任务</a>";
                        //    }
                        //}
                        dt.Rows[i]["op"] = opStr;
                        string finish = dt.Rows[i]["Finish"].ToString();
                        if (finish == "0")
                        {
                            dt.Rows[i]["state"] = "未接受";
                        }
                        else if (finish == "1")
                        {
                            dt.Rows[i]["state"] = "已接受";
                        }
                        else
                        {
                            dt.Rows[i]["state"] = "已完成";
                        }
                    }
                }
            }
            show.DataSource = dt;
            show.DataBind();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["pagesize"] = DropDownList1.Text.ToString();
            string _finish = "";
            string Finish = Request.QueryString["Finish"];
            if (Finish != null && Finish != "") { _finish = Finish.ToString(); }
            StartLoad(1, _finish);
        }

        protected void bx(object sender, EventArgs e)
        {
            Response.Redirect("ReperInfo.aspx");
        }

        protected void ml(object sender, EventArgs e)
        {
            Response.Redirect("../ReperClass/ReperClass_List.aspx");
        }

        protected void ry(object sender, EventArgs e)
        {
            Response.Redirect("../manager/user_list.aspx");
        }

        protected void work(object sender, EventArgs e)
        {
            Response.Redirect("../../index.aspx");
        }

        protected void nojs(object sender, EventArgs e)
        {
            k = 0;
            Response.Redirect("ShowRI.aspx?Finish=0");
        }

        protected void yesjs(object sender, EventArgs e)
        {
            k = 0;
            Response.Redirect("ShowRI.aspx?Finish=1");
        }

        protected void isfinish(object sender, EventArgs e)
        {
            k = 0;
            Response.Redirect("ShowRI.aspx?Finish=2");
        }

        protected void rep(object sender, EventArgs e)
        {
            Response.Redirect("Repair.aspx");
        }
    }
}