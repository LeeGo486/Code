using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPReper.Web
{
    public partial class index : System.Web.UI.Page
    {
        EPReper.BLL.RepairInfo RI = new BLL.RepairInfo();
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        EPReper.BLL.Manager Manager = new BLL.Manager();
        string classid;
        string userid = "";
        string bigid = "";
        int k = 0;
        int j = 0;
        string username = "";
        string temp = "";
        string strbigid = "";
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
                Response.Redirect("login.aspx");
            }
            string types = Request.QueryString["type"];
            if (types != null)
            {
                if (types.ToString().Equals("del"))
                {
                    del(Request.QueryString["id"].ToString());
                }
            }
            if (Request.QueryString["bigid"] != null)
            {
                bigid = Request.QueryString["bigid"].ToString();
            }
            if (Request.QueryString["classid"] != null)
            {
                classid = Request.QueryString["classid"].ToString();
            }
            //if (!IsPostBack)
            //{
            //    string counts = Request.QueryString["counts"];
            //    if (counts != null)
            //    {
            //        counts = counts.ToString();
            //        Page.ClientScript.RegisterStartupScript(Page.GetType(), "报修消息", "<script>alert('您排在当前维修的第" + counts + "位!');</script>");
            //    }
            //}
            //if (Request.QueryString["ClassID"] != null)
            //{
            //    classid="";
            //    //classid = Request.QueryString["ClassID"].ToString();
            //}
            //得到

            //userid = "24"; 

            //维修员工登录设置为1
            username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            DataTable mdt = Manager.GetList("username like'" + username + "'").Tables[0];
            if (mdt.Rows.Count > 0)
            {
                if (mdt.Rows[0]["isAdmin"].ToString().Equals("0"))
                {
                    EPReper.Model.Reper.isReper = 1;
                    string[] wheres = mdt.Rows[0]["repair"].ToString().Split(',');
                    string where = "(";
                    if (wheres.ToString() != "")
                    {
                        foreach (string s in wheres)
                        {
                            where += " BigID = " + s + " or";
                        }
                        where = where.Remove(where.Length - 2) + ")";
                    }
                    strbigid = where;
                }
            }
            //else
            //{
            EPReper.Model.Reper.isReper = 0;
            //}

            if (Manager.GetList("username like'" + username + "' and isAdmin = 1").Tables[0].Rows.Count > 0)
            {
                admins.Visible = true;
            }






            this.PageNavigator1.OnPageChange += new PageChangeHandler(PageNavigator1_PageChange);
            this.PageNavigator2.OnPageChange += new PageChangeHandler(PageNavigator2_PageChange);
            if (!IsPostBack)
            {
                if (Session["pagesize1"] == null)
                {
                    Session["pagesize1"] = EPReper.Config.UIConfig.PageSize;
                }
                if (Session["pagesize2"] == null)
                {
                    Session["pagesize2"] = EPReper.Config.UIConfig.PageSize;
                }
                if (Session["pageindex"] == null)
                {
                    Session["pageindex"] = 1;
                }
                //DropDownList1.SelectedValue = Tools.CookieHelper.GetCookie("pagesize");
                string _finishuser = EPReper.Config.UIConfig.FinishUser;
                string _finishrepair = EPReper.Config.UIConfig.FinishRepair;
                string _isdeluser = "";
                string _isdelrepair = "";
                string Finishuser = Request.QueryString["Finish"];
                string Finishrepair = Request.QueryString["FinishRepair"];
                string isDeluser = Request.QueryString["isDeluser"];
                string isDelrepair = Request.QueryString["isDelrepair"];
                if (Finishuser != null && Finishuser != "") { _finishuser = Finishuser.ToString(); }
                if (Finishrepair != null && Finishrepair != "") { _finishrepair = Finishrepair.ToString(); }
                if (isDeluser != null && isDeluser != "") { _isdeluser = isDeluser.ToString(); }
                if (isDelrepair != null && isDelrepair != "") { _isdelrepair = isDelrepair.ToString(); }

                StartLoad(1, 1, _finishuser, _finishrepair, _isdeluser, _isdelrepair);
            }

        }
        protected void PageNavigator1_PageChange(object sender, int PageIndex1)
        {
            Session["pageindex1"] = PageIndex1;
            //Session["pageindex2"] = PageIndex2;
            string _finishuser = EPReper.Config.UIConfig.FinishUser;
            string _finishrepair = EPReper.Config.UIConfig.FinishRepair;
            string _isdeluser = "";
            string _isdelrepair = "";
            string Finishuser = Request.QueryString["Finish"];
            string Finishrepair = Request.QueryString["FinishRepair"];
            string isDeluser = Request.QueryString["isDeluser"];
            string isDelrepair = Request.QueryString["isDelrepair"];
            if (Finishuser != null && Finishuser != "") { _finishuser = Finishuser.ToString(); }
            if (Finishrepair != null && Finishrepair != "") { _finishrepair = Finishrepair.ToString(); }
            if (isDelrepair != null && isDelrepair != "") { _isdelrepair = isDelrepair.ToString(); }
            if (isDeluser != null && isDeluser != "") { _isdeluser = _isdeluser.ToString(); }

            StartLoad(PageIndex1, 1, _finishuser, _finishrepair, _isdeluser, _isdelrepair);
        }
        protected void PageNavigator2_PageChange(object sender, int PageIndex2)
        {
            //Session["pageindex1"] = PageIndex1;
            Session["pageindex2"] = PageIndex2;
            string _finishuser = EPReper.Config.UIConfig.FinishUser;
            string _finishrepair = EPReper.Config.UIConfig.FinishRepair;
            string _isdeluser = "";
            string _isdelrepair = "";
            string Finishuser = Request.QueryString["Finish"];
            string Finishrepair = Request.QueryString["FinishRepair"];
            string isDeluser = Request.QueryString["isDeluser"];
            string isDelrepair = Request.QueryString["isDelrepair"];
            if (Finishuser != null && Finishuser != "") { _finishuser = Finishuser.ToString(); }
            if (Finishrepair != null && Finishrepair != "") { _finishrepair = Finishrepair.ToString(); }
            if (isDelrepair != null && isDelrepair != "") { _isdelrepair = isDelrepair.ToString(); }
            if (isDeluser != null && isDeluser != "") { _isdeluser = _isdeluser.ToString(); }

            StartLoad(1, PageIndex2, _finishuser, _finishrepair, _isdeluser, _isdelrepair);
        }
        protected void StartLoad(int PageIndex1, int PageIndex2, string sqlWhere, string sqlWhere1, string isdeluser, string isdelrepair)
        {
            temp = sqlWhere;
            int RecordCount = 0, PageCount = 0;
            int PageSize1 = Convert.ToInt32(Session["pagesize1"]);
            DropDownList1.SelectedValue = PageSize1.ToString();

            if (sqlWhere == string.Empty || sqlWhere == null || sqlWhere == "1")
            {
                sqlWhere = "Finish !=2";
                userdl.SelectedValue = "未完成";
            }
            else
            {
                sqlWhere = "Finish = " + sqlWhere;
                userdl.SelectedValue = "已完成";
            }
            //if (classid != null)
            //{
            //    sqlWhere = "Finish!=2 and BigID = " + classid;
            //}
            if (isdeluser == string.Empty)
            {
                sqlWhere += " and isDel = 0";
            }
            else
            {
                sqlWhere += " and isDel = 1";
                userdl.SelectedValue = "已取消";
            }
            sqlWhere += "and userid = " + userid;
            //if (EPReper.Model.Reper.isReper == 1&&strbigid!="")
            //{
            //    sqlWhere = sqlWhere + " and " + strbigid;
            //}
            DataTable dt = RI.GetPage(sqlWhere, PageIndex1, PageSize1, out RecordCount, out PageCount);//RI.GetList("ClassID = " + classid).Tables[0];
            k = (PageIndex1 - 1) * PageSize1;
            if (RecordCount % PageSize1 == 0)
            {
                PageCount = RecordCount / PageSize1;
            }
            else
            {
                PageCount = RecordCount / PageSize1 + 1;
            }


            if (dt != null)
            {
                this.PageNavigator1.PageCount = PageCount;//共多少页
                this.PageNavigator1.PageIndex = PageIndex1; //当前页数
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
                        if (Convert.ToInt32(dt.Rows[i]["code"].ToString()) > 0)
                        {
                            dt.Rows[i]["ids"] = bigname + "：第" + dt.Rows[i]["code"].ToString() + "位";
                        }
                        else
                        {
                            dt.Rows[i]["ids"] = "";
                        }
                        if (dt.Rows[i]["Finish"].ToString().Equals("1") || dt.Rows[i]["Finish"].ToString().Equals("2"))
                        {
                            dt.Rows[i]["ClassName"] = "<a href=\"manager/ReperInfo/RI_Show_End.aspx?ClassID=" + dt.Rows[i]["ClassID"].ToString() + "&id=" + dt.Rows[i]["id"].ToString() + "\">" + classname + "</a>";
                        }
                        else
                        {
                            dt.Rows[i]["ClassName"] = "<a href=\"manager/ReperInfo/RI_Show_Dal.aspx?ClassID=" + dt.Rows[i]["ClassID"].ToString() + "&id=" + dt.Rows[i]["id"].ToString() + "\">" + classname + "</a>";
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
                        if (dt.Rows[i]["isDel"].ToString().Equals("0"))
                        {
                            if (dt.Rows[i]["Finish"].ToString().Equals("0"))
                            {
                                //opStr += "<a href=\"index.aspx?type=del&ClassID=" + dt.Rows[i]["ClassID"].ToString() + "&id=" + dt.Rows[i]["id"] + "\">取消请求</a>";
                                opStr += "<a href=\"index.aspx?type=del&id=" + dt.Rows[i]["id"] + "\" onClick=\"{if(confirm('确定要取消吗？')){return true;}return false;}\">取消请求</a>";
                                dt.Rows[i]["state"] = "未接受";
                            }
                            else if (dt.Rows[i]["Finish"].ToString().Equals("1"))
                            {
                                dt.Rows[i]["state"] = "已接受";
                            }
                            else
                            {
                                dt.Rows[i]["state"] = "已完成";
                            }
                        }
                        else
                        {
                            dt.Rows[i]["state"] = "已取消";
                        }

                        dt.Rows[i]["op"] = opStr;

                    }
                }
            }
            show.DataSource = dt;
            show.DataBind();

            //维修人
            if (Manager.GetList("username like'" + username + "' and isAdmin = 0").Tables[0].Rows.Count > 0)
            {
                EPReper.Model.Reper.isReper = 1;
                int PageSize2 = Convert.ToInt32(Session["pagesize2"]);
                DropDownList2.SelectedValue = PageSize2.ToString();
                repairInfo.Visible = true;
                //sqlWhere = temp;
                if (sqlWhere1 == "0")
                {
                    repairdl.SelectedValue = "未接受";
                }
                if (sqlWhere1 == "1")
                {
                    repairdl.SelectedValue = "已接受";
                }
                if (sqlWhere1 == "2")
                {
                    repairdl.SelectedValue = "已完成";
                }
                if (isdelrepair == "1")
                {
                    repairdl.SelectedValue = "已取消";
                }
                if (sqlWhere1 == string.Empty || sqlWhere1 == null)
                {
                    sqlWhere1 = "Finish != 2 ";
                }
                else
                {
                    sqlWhere1 = "Finish = " + sqlWhere1;
                }

                if (classid != null)
                {
                    sqlWhere1 = "Finish!=2 and BigID = " + classid;
                }
                if (isdelrepair == string.Empty)
                {
                    sqlWhere1 += " and isDel = 0";
                }
                else
                {
                    sqlWhere1 += " and isDel = 1";
                }
                sqlWhere1 += " and " + strbigid;
                DataTable dtreper = RI.GetPage(sqlWhere1, PageIndex2, PageSize2, out RecordCount, out PageCount);//RI.GetList("ClassID = " + classid).Tables[0];
                j = (PageIndex2 - 1) * PageSize2;
                if (RecordCount % PageSize2 == 0)
                {
                    PageCount = RecordCount / PageSize2;
                }
                else
                {
                    PageCount = RecordCount / PageSize2 + 1;
                }


                if (dtreper != null)
                {
                    this.PageNavigator2.PageCount = PageCount;//共多少页
                    this.PageNavigator2.PageIndex = PageIndex2; //当前页数
                    this.PageNavigator2.RecordCount = RecordCount;//共多少条记录
                    dtreper.Columns.Add("ids", typeof(string));
                    dtreper.Columns.Add("ClassName", typeof(string));
                    dtreper.Columns.Add("ApplyName", typeof(string));
                    dtreper.Columns.Add("RepairName", typeof(string));
                    dtreper.Columns.Add("op", typeof(string));
                    dtreper.Columns.Add("state", typeof(string));
                    if (dtreper.Rows.Count > 0)
                    {

                        for (int i = 0; i < dtreper.Rows.Count; i++)
                        {
                            string classname = RC.GetList("id = " + dtreper.Rows[i]["ClassID"]).Tables[0].Rows[0]["classname"].ToString();
                            string bigname = RC.GetList("id= " + dtreper.Rows[i]["BigID"]).Tables[0].Rows[0]["classname"].ToString();
                            j++;
                            if (Convert.ToInt32(dtreper.Rows[i]["code"].ToString()) > 0)
                            {
                                dtreper.Rows[i]["ids"] = bigname + "：第" + dtreper.Rows[i]["code"].ToString() + "位";
                            }
                            else
                            {
                                dtreper.Rows[i]["ids"] = "";
                            }
                            if (dtreper.Rows[i]["Finish"].ToString().Equals("1") || dtreper.Rows[i]["Finish"].ToString().Equals("2"))
                            {
                                dtreper.Rows[i]["ClassName"] = "<a href=\"manager/ReperInfo/RI_Show_End.aspx?isrepair=1&ClassID=" + dtreper.Rows[i]["ClassID"].ToString() + "&id=" + dtreper.Rows[i]["id"].ToString() + "\">" + classname + "</a>";
                            }
                            else
                            {
                                dtreper.Rows[i]["ClassName"] = "<a href=\"manager/ReperInfo/RI_Show_Dal.aspx?isrepair=1&ClassID=" + dtreper.Rows[i]["ClassID"].ToString() + "&id=" + dtreper.Rows[i]["id"].ToString() + "\">" + classname + "</a>";
                            }

                            dtreper.Rows[i]["ApplyName"] = UI.GetList("CN_ID = " + dtreper.Rows[i]["UserID"].ToString()).Tables[0].Rows[0]["CN_LOGIN"].ToString();
                            if (dtreper.Rows[i]["ReperID"].ToString().Equals(""))
                            {
                                dtreper.Rows[i]["RepairName"] = "";
                            }
                            else
                            {
                                dtreper.Rows[i]["RepairName"] = UI.GetList("CN_ID = " + dtreper.Rows[i]["ReperID"].ToString()).Tables[0].Rows[0]["CN_LOGIN"].ToString();
                            }
                            if (dtreper.Rows[i]["StartComment"].ToString().Length > 32)
                            {
                                dtreper.Rows[i]["StartComment"] = dtreper.Rows[i]["StartComment"].ToString().Substring(0, 31) + "...";
                            }
                            if (dtreper.Rows[i]["OverComment"].ToString().Length > 32)
                            {
                                dtreper.Rows[i]["OverComment"] = dtreper.Rows[i]["OverComment"].ToString().Substring(0, 31) + "...";
                            }
                            string opStr = "";
                            if (dtreper.Rows[i]["isDel"].ToString().Equals("0"))
                            {
                                if (dtreper.Rows[i]["Finish"].ToString().Equals("0"))
                                {
                                    opStr += "<a href=\"manager/ReperInfo/RI_Show_Dal.aspx?isrepair=1&ClassID=" + dtreper.Rows[i]["ClassID"].ToString() + "&id=" + dtreper.Rows[i]["id"] + "&FinishRepair=" + Request.QueryString["FinishRepair"] + "&Finish=" + Request.QueryString["Finish"] + "\">接受请求</a>";
                                    dtreper.Rows[i]["state"] = "未接受";
                                }
                                else if (dtreper.Rows[i]["Finish"].ToString().Equals("1"))
                                {
                                    if (dtreper.Rows[i]["ReperID"].ToString().Equals(userid))
                                    {
                                        opStr += "<a href=\"manager/ReperInfo/RI_Show_End.aspx?isrepair=1&ClassID=" + dtreper.Rows[i]["ClassID"].ToString() + "&id=" + dtreper.Rows[i]["id"] + "&FinishRepair=" + Request.QueryString["FinishRepair"] + "&Finish=" + Request.QueryString["Finish"] + "\">完成任务</a>";
                                    }
                                    dtreper.Rows[i]["state"] = "已接受";
                                }
                                else
                                {
                                    dtreper.Rows[i]["state"] = "已完成";
                                }
                            }
                            else
                            {
                                dtreper.Rows[i]["state"] = "已取消";
                            }

                            dtreper.Rows[i]["op"] = opStr;

                        }
                    }
                }

                ReperList.DataSource = dtreper;
                ReperList.DataBind();



            }
            //任务统计

            DataTable dtcount = RC.GetList("parentID = 0").Tables[0];
            if (dtcount != null)
            {
                dtcount.Columns.Add("ALL", typeof(string));
                dtcount.Columns.Add("Done", typeof(string));
                dtcount.Columns.Add("NoDone", typeof(string));
                dtcount.Columns.Add("Check", typeof(string));
                dtcount.Columns.Add("NoCheck", typeof(string));
                dtcount.Columns.Add("ESC", typeof(string));
                if (dtcount.Rows.Count > 0)
                {
                    for (int i = 0; i < dtcount.Rows.Count; i++)
                    {
                        dtcount.Rows[i]["ALL"] = appsum(dtcount.Rows[i]["id"].ToString(), "");
                        dtcount.Rows[i]["Done"] = appsum(dtcount.Rows[i]["id"].ToString(), "Finish = 2");
                        dtcount.Rows[i]["NoDone"] = appsum(dtcount.Rows[i]["id"].ToString(), "Finish != 2 and isdel = 0 ");
                        dtcount.Rows[i]["Check"] = appsum(dtcount.Rows[i]["id"].ToString(), "Finish = 1");
                        dtcount.Rows[i]["NoCheck"] = appsum(dtcount.Rows[i]["id"].ToString(), "Finish = 0 and isdel = 0");
                        dtcount.Rows[i]["ESC"] = appsum(dtcount.Rows[i]["id"].ToString(), "isdel = 1");
                    }
                }
            }
            CountList.DataSource = dtcount;
            CountList.DataBind();
        }

        public int appsum(string id, string sqlwhere)
        {
            int count = 0;
            count = RI.GetCount(id, sqlwhere);
            return count;
        }

        protected void del(string id)
        {
            DataTable dtup = RI.GetList("id = " + id).Tables[0];
            string bigid = dtup.Rows[0]["BigID"].ToString();
            string code = dtup.Rows[0]["code"].ToString();
            if (RI.Delete(int.Parse(id)))
            {
                RI.UpCode(bigid, code);
            }
            Response.Redirect("index.aspx");
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["pagesize1"] = DropDownList1.Text.ToString();
            string _finishuser = EPReper.Config.UIConfig.FinishUser;
            string _finishrepair = EPReper.Config.UIConfig.FinishRepair;
            string _isdeluser = "";
            string _isdelrepair = "";
            string Finishuser = Request.QueryString["Finish"];
            string Finishrepair = Request.QueryString["FinishRepair"];
            string isDeluser = Request.QueryString["isDeluser"];
            string isDelrepair = Request.QueryString["isDelrepair"];
            if (Finishuser != null && Finishuser != "") { _finishuser = Finishuser.ToString(); }
            if (Finishrepair != null && Finishrepair != "") { _finishrepair = Finishrepair.ToString(); }
            if (isDeluser != null && isDeluser != "") { _isdeluser = isDeluser.ToString(); }
            if (isDelrepair != null && isDelrepair != "") { _isdelrepair = isDelrepair.ToString(); }

            StartLoad(1, 1, _finishuser, _finishrepair, _isdeluser, _isdelrepair);
        }
        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["pagesize2"] = DropDownList2.Text.ToString();
            string _finishuser = EPReper.Config.UIConfig.FinishUser;
            string _finishrepair = EPReper.Config.UIConfig.FinishRepair;
            string _isdeluser = "";
            string _isdelrepair = "";
            string Finishuser = Request.QueryString["Finish"];
            string Finishrepair = Request.QueryString["FinishRepair"];
            string isDeluser = Request.QueryString["isDeluser"];
            string isDelrepair = Request.QueryString["isDelrepair"];
            if (Finishuser != null && Finishuser != "") { _finishuser = Finishuser.ToString(); }
            if (Finishrepair != null && Finishrepair != "") { _finishrepair = Finishrepair.ToString(); }
            if (isDeluser != null && isDeluser != "") { _isdeluser = isDeluser.ToString(); }
            if (isDelrepair != null && isDelrepair != "") { _isdelrepair = isDelrepair.ToString(); }

            StartLoad(1, 1, _finishuser, _finishrepair, _isdeluser, _isdelrepair);
        }

        protected void userdl_SelectedIndexChanged(object sender, EventArgs e)
        {
            string user = userdl.Text.ToString();
            userdl.SelectedValue = user;
            switch (user)
            {
                case "未完成":
                    nofinishuser();
                    break;
                case "已完成":
                    isfinishuser();
                    break;
                case "已取消":
                    escuser();
                    break;
            }
        }

        protected void repairdl_SelectedIndexChanged(object sender, EventArgs e)
        {
            string repair = repairdl.Text.ToString();
            repairdl.SelectedValue = repair;
            switch (repair)
            {
                case "未接受":
                    nojs();
                    break;
                case "已接受":
                    yesjs();
                    break;
                case "已完成":
                    isfinish();
                    break;
                case "已取消":
                    esc();
                    break;
            }
        }

        protected void bx(object sender, EventArgs e)
        {
            Response.Redirect("manager/ReperInfo/ReperInfo.aspx");
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
            Response.Redirect("ReperInfo.aspx?type=select");
        }

        protected void nofinishuser()
        {
            k = 0;
            string finishrepair = Request.QueryString["FinishRepair"];
            if (finishrepair != null && finishrepair != "")
            {
                finishrepair = finishrepair.ToString();
            }
            string isdelrepair = Request.QueryString["isDelrepair"];
            if (isdelrepair != null && isdelrepair != "")
            {
                isdelrepair = isdelrepair.ToString();
            }
            Response.Redirect("index.aspx?Finish=1&FinishRepair=" + finishrepair + "&isDelrepair=" + isdelrepair + "");
        }

        protected void isfinishuser()
        {
            k = 0;
            string finishrepair = Request.QueryString["FinishRepair"];
            if (finishrepair != null && finishrepair != "")
            {
                finishrepair = finishrepair.ToString();
            }
            string isdelrepair = Request.QueryString["isDelrepair"];
            if (isdelrepair != null && isdelrepair != "")
            {
                isdelrepair = isdelrepair.ToString();
            }
            Response.Redirect("index.aspx?Finish=2&FinishRepair=" + finishrepair + "&isDelrepair=" + isdelrepair + "");
        }
        protected void escuser()
        {
            k = 0;
            string finishrepair = Request.QueryString["FinishRepair"];
            if (finishrepair != null && finishrepair != "")
            {
                finishrepair = finishrepair.ToString();
            }
            string isdelrepair = Request.QueryString["isDelrepair"];
            if (isdelrepair != null && isdelrepair != "")
            {
                isdelrepair = isdelrepair.ToString();
            }
            Response.Redirect("index.aspx?isDeluser=1&FinishRepair=" + finishrepair + "&isDelrepair=" + isdelrepair + "");
        }

        protected void nojs()
        {
            k = 0;
            string finish = Request.QueryString["Finish"];
            if (finish != null && finish != "")
            {
                finish = finish.ToString();
            }
            string isdeluser = Request.QueryString["isDeluser"];
            if (isdeluser != null && isdeluser != "")
            {
                isdeluser = isdeluser.ToString();
            }
            Response.Redirect("index.aspx?Finish=" + finish + "&FinishRepair=0&isDeluser=" + isdeluser + "");
        }

        protected void yesjs()
        {
            k = 0;
            string finish = Request.QueryString["Finish"];
            if (finish != null && finish != "")
            {
                finish = finish.ToString();
            }
            string isdeluser = Request.QueryString["isDeluser"];
            if (isdeluser != null && isdeluser != "")
            {
                isdeluser = isdeluser.ToString();
            }
            Response.Redirect("index.aspx?Finish=" + finish + "&FinishRepair=1&isDeluser=" + isdeluser + "");
        }

        protected void isfinish()
        {
            k = 0;
            string finish = Request.QueryString["Finish"];
            if (finish != null && finish != "")
            {
                finish = finish.ToString();
            }
            string isdeluser = Request.QueryString["isDeluser"];
            if (isdeluser != null && isdeluser != "")
            {
                isdeluser = isdeluser.ToString();
            }
            Response.Redirect("index.aspx?Finish=" + finish + "&FinishRepair=2&isDeluser=" + isdeluser + "");
        }
        protected void esc()
        {
            k = 0;
            string finish = Request.QueryString["Finish"];
            if (finish != null && finish != "")
            {
                finish = finish.ToString();
            }
            string isdeluser = Request.QueryString["isDeluser"];
            if (isdeluser != null && isdeluser != "")
            {
                isdeluser = isdeluser.ToString();
            }
            Response.Redirect("index.aspx?isDelrepair=1&Finish=" + finish + "&isDeluser=" + isdeluser + "");
        }

        protected void rep(object sender, EventArgs e)
        {
            Response.Redirect("Repair.aspx");
        }
        protected void sc(object sender, EventArgs e)
        {
            Response.Redirect("manager/ReperInfo/ReperInfo.aspx?type=select");
        }

        protected void admin(object sender, EventArgs e)
        {
            Response.Redirect("manager/ReperClass/ReperClass_List.aspx");
        }
    }
}