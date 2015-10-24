using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPReper.Web.manager.ReperInfo
{
    public partial class SelectRI : System.Web.UI.Page
    {
        EPReper.BLL.RepairInfo RI = new BLL.RepairInfo();
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        EPReper.BLL.Manager Manager = new BLL.Manager();
        string classid;
        string userid = "";
        string bigid;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Tools.CookieHelper.GetCookie("CN_ID") != "" && Tools.CookieHelper.GetCookie("CN_ID") != null)
            {
                userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
            }
            else
            {
                Response.Redirect("../../login.aspx");
                return;
            }
            //if (Request.QueryString["bigid"] != null)
            //{
            //    bigid = Request.QueryString["bigid"].ToString();
            //}
            //if (Request.QueryString["classid"] != null)
            //{
            //    classid = Request.QueryString["classid"].ToString();
            //}
            if (!IsPostBack)
            {
                //string counts = Request.QueryString["counts"];
                //if (counts != null)
                //{
                //    counts = counts.ToString();
                //    Page.ClientScript.RegisterStartupScript(Page.GetType(), "报修消息", "<script>alert('您排在当前维修的第" + counts + "位!');</script>");
                //}
            };

            //维修员工登录设置为1
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();

            //EPReper.Model.Reper.isReper = 0;

            if (Manager.GetList("username like'" + username + "' and isAdmin = 1").Tables[0].Rows.Count > 0)
            {
                admins.Visible = true;
            }




            string bigname = BigClass.Value;
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

                StartLoad(1, "", "", "", "", "", "", "", "", "");
            }

        }
        protected void PageNavigator1_PageChange(object sender, int PageIndex)
        {
            Session["pageindex"] = PageIndex;
            string BigClassName = bigclassid.Value;
            //if (BigClassName != null && BigClassName != "") { _bigclassname = BigClassName.ToString(); }
            string SecondClassName = secondclassid.Value;
            string ThirdClassName = thirdclassid.Value;
            string ApplyDep = applydep.Value;
            string ApplyName = applyname.Value;
            string RepairName = repairname.Value;
            string StartTime = starttime.Value;
            string EndTime = endtime.Value;
            string Start = start.Value;
            StartLoad(PageIndex, BigClassName, SecondClassName, ThirdClassName, ApplyDep, ApplyName, RepairName, StartTime, EndTime, Start);
        }
        protected void StartLoad(int PageIndex, string bigclassname, string secondclassname, string thirdclassname, string applydep, string applyname, string repairname, string starttime, string endtime, string state)
        {
            int RecordCount = 0, PageCount = 0;
            int PageSize = Convert.ToInt32(Session["pagesize"]);
            DropDownList1.SelectedValue = PageSize.ToString();
            BigClass.Value = bigclassname;
            DataTable dt = new DataTable();
            string sqlWhere = " 1=1";
            if (bigclassname != "")
            {
                sqlWhere += " and bigid = " + bigclassname;
                this.bigclassname.Value = RC.GetList("id = " + bigclassname).Tables[0].Rows[0]["classname"].ToString();
            }
            //未完善
            if (secondclassname != "")
            {
                string classids = "";
                dt = RC.GetList("parentID = " + secondclassname).Tables[0];
                this.secondclassname.Value = RC.GetList("id = " + secondclassname).Tables[0].Rows[0]["classname"].ToString();
                if (dt.Rows.Count > 0)
                {
                    classids += "(";
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        classids += "ClassID = " + dt.Rows[i]["id"].ToString() + " or ";
                    }
                    classids = classids.Substring(0, classids.Length - 3) + ")";
                    sqlWhere += " and " + classids;
                }
                else
                {
                    sqlWhere += " and classid = " + secondclassname;
                }

            }
            if (thirdclassname != "")
            {
                sqlWhere += " and classid = " + thirdclassname;
                this.thirdclassname.Value = RC.GetList("id = " + thirdclassname).Tables[0].Rows[0]["classname"].ToString();
            }
            //未完善
            if (applydep != "")
            {
                string applydeps = "";
                dt = UI.GetInfo("TN_SYS_EM_USER_PROP.CN_DEPTINFO LIKE '%" + applydep + "%'");
                if (dt.Rows.Count > 0)
                {
                    applydeps += "(";
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        applydeps += "UserID = " + dt.Rows[i]["CN_ID"].ToString() + " or ";
                    }
                    applydeps = applydeps.Substring(0, applydeps.Length - 3) + ")";
                    sqlWhere += " and " + applydeps;
                }
                else
                {
                    sqlWhere += " and 1 = 0 ";
                }
            }
            if (applyname != "")
            {
                string applynames = "";
                dt = UI.GetList("CN_LOGIN like '%" + applyname + "%'").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    applynames += "(";
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        applynames += "UserID = " + dt.Rows[i]["CN_ID"].ToString() + " or ";
                    }
                    applynames = applynames.Substring(0, applynames.Length - 3) + ")";
                    sqlWhere += " and " + applynames;
                }
                else
                {
                    sqlWhere += " and 1 = 0 ";
                }
            }
            if (repairname != "")
            {
                string repairnames = "";
                dt = UI.GetList("CN_LOGIN like '%" + repairname + "%'").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    repairnames += "(";
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        repairnames += "ReperID = " + dt.Rows[i]["CN_ID"].ToString() + " or ";
                    }
                    repairnames = repairnames.Substring(0, repairnames.Length - 3) + ")";
                    sqlWhere += " and " + repairnames;
                }
                else
                {
                    sqlWhere += " and 1 = 0 ";
                }
            }
            if (starttime != "")
            {
                starttime += " 0:00:00";
                sqlWhere += " and (UpTime >= '" + starttime + "')";
            }
            if (endtime != "")
            {
                endtime += " 23:59:59";
                sqlWhere += " and (UpTime <= '" + endtime + "')";
            }
            if (state != "")
            {
                sqlWhere += " and " + state;
            }


            dt = RI.GetPage(sqlWhere, PageIndex, PageSize, out RecordCount, out PageCount);//RI.GetList("ClassID = " + classid).Tables[0];
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
                dt.Columns.Add("BaseCodes", typeof(string));
                dt.Columns.Add("BigClassName", typeof(string));
                dt.Columns.Add("SecondClassName", typeof(string));
                dt.Columns.Add("ThirdClassName", typeof(string));
                dt.Columns.Add("ApplyName", typeof(string));
                dt.Columns.Add("ApplyDEP", typeof(string));
                dt.Columns.Add("RepairName", typeof(string));
                dt.Columns.Add("state", typeof(string));
                if (dt.Rows.Count > 0)
                {

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {

                        dt.Rows[i]["BaseCodes"] = "<a href=\"SelectShow.aspx?ClassID=" + dt.Rows[i]["ClassID"].ToString() + "&id=" + dt.Rows[i]["id"].ToString() + "\">" + dt.Rows[i]["BaseCode"].ToString().ToUpper() + "</a>";
                        dt.Rows[i]["BigClassName"] = RC.GetList("id= " + dt.Rows[i]["BigID"]).Tables[0].Rows[0]["classname"].ToString();
                        string parentID = RC.GetList("id= " + dt.Rows[i]["ClassID"]).Tables[0].Rows[0]["parentID"].ToString();

                        dt.Rows[i]["SecondClassName"] = RC.GetList("id= " + parentID).Tables[0].Rows[0]["classname"].ToString();
                        dt.Rows[i]["ThirdClassName"] = RC.GetList("id = " + dt.Rows[i]["ClassID"]).Tables[0].Rows[0]["classname"].ToString();

                        DataTable dtui = UI.GetList("CN_ID = " + dt.Rows[i]["UserID"].ToString()).Tables[0];
                        if (dtui.Rows.Count > 0)
                        {
                            dt.Rows[i]["ApplyName"] = dtui.Rows[0]["CN_LOGIN"].ToString();
                            string appdep = UI.GetInfo("CN_ID = " + dt.Rows[i]["UserID"].ToString()).Rows[0]["CN_DEPTINFO"].ToString();
                            appdep = appdep.Replace("Elegant-prosper/", "");
                            dt.Rows[i]["ApplyDEP"] = appdep;
                        }
                        else
                        {
                            dt.Rows[i]["ApplyName"] = "已离职";
                            dt.Rows[i]["ApplyDEP"] = "";
                        }
                        //dt.Rows[i]["ApplyName"] = UI.GetList("CN_ID = " + dt.Rows[i]["UserID"].ToString()).Tables[0].Rows[0]["CN_LOGIN"].ToString();

                        

                        if (dt.Rows[i]["ReperID"].ToString().Equals(""))
                        {
                            dt.Rows[i]["RepairName"] = "";
                        }
                        else
                        {
                             dtui = UI.GetList("CN_ID = " + dt.Rows[i]["ReperID"].ToString()).Tables[0];
                            if (dtui.Rows.Count > 0)
                            {
                                dt.Rows[i]["RepairName"] = dtui.Rows[0]["CN_LOGIN"].ToString();
                            }
                            else
                            {
                                dt.Rows[i]["RepairName"] = "已离职";
                            }
                            
                        }

                        string finish = dt.Rows[i]["Finish"].ToString();
                        string isdel = dt.Rows[i]["isDel"].ToString();
                        if (isdel == "1")
                        {
                            dt.Rows[i]["state"] = "已取消";
                        }
                        else
                        {
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
            }
            show.DataSource = dt;
            show.DataBind();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["pagesize"] = DropDownList1.Text.ToString();
            string BigClassName = bigclassid.Value;
            //if (BigClassName != null && BigClassName != "") { _bigclassname = BigClassName.ToString(); }
            string SecondClassName = secondclassid.Value;
            string ThirdClassName = thirdclassid.Value;
            string ApplyDep = applydep.Value;
            string ApplyName = applyname.Value;
            string RepairName = repairname.Value;
            string StartTime = starttime.Value;
            string EndTime = endtime.Value;
            string Start = start.Value;
            StartLoad(1, BigClassName, SecondClassName, ThirdClassName, ApplyDep, ApplyName, RepairName, StartTime, EndTime, Start);
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

            Response.Redirect("ShowRI.aspx?Finish=0");
        }

        protected void yesjs(object sender, EventArgs e)
        {
            Response.Redirect("ShowRI.aspx?Finish=1");
        }

        protected void isfinish(object sender, EventArgs e)
        {
            Response.Redirect("ShowRI.aspx?Finish=2");
        }

        protected void rep(object sender, EventArgs e)
        {
            Response.Redirect("Repair.aspx");
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            string BigClassName = bigclassid.Value;
            //if (BigClassName != null && BigClassName != "") { _bigclassname = BigClassName.ToString(); }
            string SecondClassName = secondclassid.Value;
            string ThirdClassName = thirdclassid.Value;
            string ApplyDep = applydep.Value;
            string ApplyName = applyname.Value;
            string RepairName = repairname.Value;
            string StartTime = starttime.Value;
            string EndTime = endtime.Value;
            string Start = start.Value;
            StartLoad(1, BigClassName, SecondClassName, ThirdClassName, ApplyDep, ApplyName, RepairName, StartTime, EndTime, Start);
        }

        protected void Execl_Click(object sender, EventArgs e)
        {
            string BigClassName = bigclassid.Value;
            //if (BigClassName != null && BigClassName != "") { _bigclassname = BigClassName.ToString(); }
            string SecondClassName = secondclassid.Value;
            string ThirdClassName = thirdclassid.Value;
            string ApplyDep = applydep.Value;
            string ApplyName = applyname.Value;
            string RepairName = repairname.Value;
            string StartTime = starttime.Value;
            string EndTime = endtime.Value;
            string Start = start.Value;
            DataTable dt = new DataTable();
            string sqlWhere = " 1=1";
            if (BigClassName != "")
            {
                sqlWhere += " and bigid = " + BigClassName;
            }
            //未完善
            if (SecondClassName != "")
            {
                string classids = "";
                dt = RC.GetList("parentID = " + SecondClassName).Tables[0];
                if (dt.Rows.Count > 0)
                {
                    classids = "(";
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        classids += "ClassID = " + dt.Rows[i]["id"].ToString() + " or ";
                    }
                    classids = classids.Substring(0, classids.Length - 3) + ")";
                    sqlWhere += " and " + classids;
                }
                else
                {
                    sqlWhere += " and classid = " + SecondClassName;
                }
            }
            if (ThirdClassName != "")
            {
                sqlWhere += " and classid = " + ThirdClassName;
            }
            //未完善
            if (ApplyDep != "")
            {
                string applydeps = "";
                dt = UI.GetInfo("TN_SYS_EM_USER_PROP.CN_DEPTINFO LIKE '%" + ApplyDep + "%'");
                if (dt.Rows.Count > 0)
                {
                    applydeps = "(";
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        applydeps += "UserID = " + dt.Rows[i]["CN_ID"].ToString() + " or ";
                    }
                    applydeps = applydeps.Substring(0, applydeps.Length - 3) + ")";
                    sqlWhere += " and " + applydeps;
                }
            }
            if (ApplyName != "")
            {
                string applynames = "";
                dt = UI.GetList("CN_LOGIN like '%" + ApplyName + "%'").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    applynames = "(";
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        applynames += "UserID = " + dt.Rows[i]["CN_ID"].ToString() + " or ";
                    }
                    applynames = applynames.Substring(0, applynames.Length - 3) + ")";
                    sqlWhere += " and " + applynames;
                }
            }
            if (RepairName != "")
            {
                string repairnames = "";
                dt = UI.GetList("CN_LOGIN like '%" + RepairName + "%'").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    repairnames = "(";
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        repairnames += "ReperID = " + dt.Rows[i]["CN_ID"].ToString() + " or ";
                    }
                    repairnames = repairnames.Substring(0, repairnames.Length - 3) + ")";
                    sqlWhere += " and " + repairnames;
                }

            }
            if (StartTime != "")
            {
                StartTime += " 0:00:00";
                sqlWhere += " and (UpTime >= '" + StartTime + "')";
            }
            if (EndTime != "")
            {
                EndTime += " 23:59:59";
                sqlWhere += " and (UpTime <= '" + EndTime + "')";
            }
            if (Start != "")
            {
                sqlWhere += " and " + Start;
            }

            string strsql = "select basecode,bigid,classid,userid,applyphone,reperid,repairphone,uptime,times,overtime,startcomment,overcomment,finish,isdel from repairinfo where " + sqlWhere;
            string filename = "雅莹维修统计信息.xls";
            BLL.Excel excel = new BLL.Excel();
            excel.WriteToExcel(strsql, filename);
        }

        protected void Clear_Click(object sender, EventArgs e)
        {
            bigclassid.Value = "";
            //if (BigClassName != null && BigClassName != "") { _bigclassname = BigClassName.ToString(); }
            secondclassid.Value = "";
            thirdclassid.Value = "";
            applydep.Value = "";
            applyname.Value = "";
            repairname.Value = "";
            starttime.Value = "";
            endtime.Value = "";
            start.Value = "";
            bigclassname.Value = "";
            secondclassname.Value = "";
            thirdclassname.Value = "";
            StartLoad(1, "", "", "", "", "", "", "", "", "");
        }
    }
}