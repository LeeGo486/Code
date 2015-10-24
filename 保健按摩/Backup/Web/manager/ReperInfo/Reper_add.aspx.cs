using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPReper.Web.manager.ReperInfo
{
    public partial class Reper_add : System.Web.UI.Page
    {
        EPReper.BLL.ReperClass RC = new BLL.ReperClass();
        EPReper.Model.ReperClass rc = new Model.ReperClass();
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        EPReper.BLL.RepairInfo RI = new BLL.RepairInfo();
        EPReper.Model.RepairInfo ri = new Model.RepairInfo();
        EPReper.BLL.Manager Manager = new BLL.Manager();

        string userid = "";
        string classid = "";
        string _bigid = "";
        string bigid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Tools.CookieHelper.GetCookie("CN_ID") != "" && Tools.CookieHelper.GetCookie("CN_ID") != null)
            {
                userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
                string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
                if (Manager.GetList("username like'" + username + "' and isAdmin = 1").Tables[0].Rows.Count > 0)
                {
                    admins.Visible = true;
                }
            }
            else
            {
                Response.Redirect("../../login.aspx");
            }
            _bigid = Request.QueryString["bigid"].ToString();
            bigid = "";
            classid = Request.QueryString["id"].ToString();
            if (_bigid == null)
            {
                bigid = classid;
            }
            else
            {
                bigid = _bigid;
            }
            classid = Request.QueryString["id"].ToString();


            DataTable dt = RC.GetTable(0, "id = " + classid, "orderNum");
            ClassName.Text = dt.Rows[0]["classname"].ToString();
            DataTable dts = RC.GetList("parentID = " + classid + "and isDel=0").Tables[0];
            if (dts != null)
            {
                for (int i = 0; i < dts.Rows.Count; i++)
                {
                    rc.id = int.Parse(dts.Rows[i]["id"].ToString());
                    rc.classname = dts.Rows[i]["classname"].ToString();
                    if (rc.classname != "")
                    {
                        smallclass.Visible = true;
                        smallclass.Items.Add(new ListItem(rc.classname, rc.id.ToString()));
                    }
                }
            }
            //得到申请人ID
            //userid = Tools.CookieHelper.GetCookie("CN_ID");

            //ri.BigID = int.Parse(bigid);
            //ri.ClassID = int.Parse(classid);
            //ri.userID = int.Parse(userid);
            //ri.UpTime = DateTime.Now;
            //ri.DoTime = null;
            //ri.OverTime = null;
            //ri.StartComment = "";
            ////ri.StartComment = startComment.Text;
            //ri.OverComment = null;
            //ri.point = 1;
            //ri.Times = times.Text;
            //ri.Finish = 0;
            //ri.isDel = 0;
            //DataTable dtu = UI.GetInfo("CN_ID = " + ri.userID);
            //string subject = "维修任务";
            //string[] depts = dtu.Rows[0]["CN_DEPTINFO"].ToString().Split('/');
            //string dept = "";
            //for (int i = 0; i < depts.Count(); i++)
            //{
            //    if (i != 0)
            //    {
            //        dept += depts[i]+"/";
            //    }
            //}
            //dept = dept.Remove(dept.Length - 1);
            //string content = "您好,您有一条新报修任务！<br />报修部门: " + dept + "<br />报 修 人: " + dtu.Rows[0]["CN_LOGIN"] + "<br/>报修内容: " + ClassName.Text + "<br/>联络电话: " + dtu.Rows[0]["CN_O_PHONE"] + "<br/>联络手机: " + dtu.Rows[0]["CN_HANDSET"] + "<br/>报修日期: " + DateTime.Now + "<br/>个人备注: " + dtu.Rows[0]["CN_NOTE"] + "<br/>请您登陆<a href=\"http://192.168.0.52:81\" target=\"_blank\">维修管理系统</a>，查看并接受";
            //DataTable dtm = Manager.GetList("").Tables[0];
            //if (dtm != null)
            //{
            //    if (dtm.Rows.Count > 0)
            //    {
            //        for (int i = 0; i < dtm.Rows.Count; i++)
            //        {
            //            if (dtm.Rows[i]["isAdmin"].ToString().Equals("0"))
            //            {
            //                string repair = dtm.Rows[i]["repair"].ToString();
            //                if (repair.Length > 2)
            //                {
            //                    string[] strs = repair.Split(',');
            //                    foreach (string str in strs)
            //                    {
            //                        if (str.Equals(bigid))
            //                        {
            //                            UI.AddAmDetail(dtm.Rows[i]["username"].ToString(), subject, content);
            //                        }
            //                    }
            //                }
            //                else
            //                {
            //                    if (repair.Equals(bigid))
            //                    {
            //                        UI.AddAmDetail(dtm.Rows[i]["username"].ToString(), subject, content);
            //                    }
            //                }
            //            }
            //        }
            //    }
            //}

            //RI.Add(ri);
            //int counts=RI.counts(int.Parse(bigid));
            //Tools.CookieHelper.ClearCookie("bigid");
            //Response.Redirect("ShowRI.aspx?counts="+counts+"&classid="+bigid);
            /*
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            if (Manager.GetList("username like'" + username + "' and isAdmin = 1").Tables[0].Rows.Count > 0)
            {
                mulu.Visible = true;
                renyuan.Visible = true;

            }
             */

            DataTable dtuser = UI.GetInfo("CN_ID = " + userid);
            userName.Text = dtuser.Rows[0]["CN_LOGIN"].ToString();
            dep.Text = dtuser.Rows[0]["CN_DEPTINFO"].ToString();
            if (!IsPostBack)
            {
                phone.Text = dtuser.Rows[0]["CN_O_PHONE"].ToString();
            }
            DateTime time = DateTime.Now;
            time = time.AddHours(4);
            if (!IsPostBack)
            {
                string t = time.ToString("yyyy-MM-dd HH:mm");
                times.Value = t;
            }
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            string basecode = DateTime.Now.ToString("yyyyMMdd");
            DataTable dt = RI.GetList(1, "BaseCode like '%" + basecode + "%'", "BaseCode desc").Tables[0];
            string strbillcode = "";
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                    strbillcode = dt.Rows[0]["BaseCode"].ToString();
            }
            if (strbillcode != "")
            {
                strbillcode = strbillcode.ToUpper();
                strbillcode = strbillcode.Split('R')[1];
                basecode = "R" + (Convert.ToInt64(strbillcode) + 1).ToString();
            }
            else
            {
                basecode = "R" + basecode + "0001";
            }
            ri.BaseCode = basecode;
            ri.BigID = int.Parse(bigid);
            string ClassID = smallclass.SelectedValue;
            if (ClassID != string.Empty && ClassID != null)
            {
                ri.ClassID = int.Parse(ClassID);
            }
            else
            {
                ri.ClassID = int.Parse(classid);
            }
            ri.userID = int.Parse(userid);
            ri.UpTime = DateTime.Now;
            ri.DoTime = null;
            ri.OverTime = null;
            ri.StartComment = startComment.Text;
            //ri.StartComment = startComment.Text;
            ri.OverComment = null;
            ri.point = 1;
            ri.Times = times.Value;
            ri.Finish = 0;
            ri.applyPhone = phone.Text;
            ri.isDel = 0;
            DataTable dtu = UI.GetInfo("CN_ID = " + ri.userID);
            string subject = "维修任务";
            string[] depts = dtu.Rows[0]["CN_DEPTINFO"].ToString().Split('/');
            string dept = "";
            for (int i = 0; i < depts.Count(); i++)
            {
                if (i != 0)
                {
                    dept += depts[i] + "/";
                }
            }
            dept = dept.Remove(dept.Length - 1);
            string smallid = smallclass.SelectedValue;
            string classname = "";
            if (smallid != "")
            {
                classname = "-" + RC.GetModel(Convert.ToInt32(smallid)).classname;
            }
            else
            {
                classname = ClassName.Text;
            }
            //string content = "您好,您有一条新报修任务！<br />维修单号：" + basecode + "<br />报修部门: " + dept + "<br />报 修 人: " + dtu.Rows[0]["CN_LOGIN"] + "<br/>报修内容: " + ClassName.Text + "<br/>联络电话: " + dtu.Rows[0]["CN_O_PHONE"] + "<br/>联络手机: " + dtu.Rows[0]["CN_HANDSET"] + "<br/>报修日期: " + DateTime.Now + "<br/>个人备注: " + dtu.Rows[0]["CN_NOTE"] + "<br/>请您登陆<a href=\"http://192.168.0.52:81\" target=\"_blank\">维修管理系统</a>，查看并接受";
            string content = "您好,您有一条新报修任务！<br />维修单号：" + basecode + "<br />报修部门: " + dept + "<br />报 修 人: " + dtu.Rows[0]["CN_LOGIN"] + "<br/>报修内容: " + classname + "<br/>联络电话: " + dtu.Rows[0]["CN_O_PHONE"] + "<br/>联络手机: " + dtu.Rows[0]["CN_HANDSET"] + "<br/>报修日期: " + DateTime.Now + "<br/>个人备注: " + dtu.Rows[0]["CN_NOTE"] + "<br/>请您登陆<a href=\"http://" + Config.UIConfig.Server + "\" target=\"_blank\">维修管理系统</a>，查看并接受";
            string MessageContent = "您好,您有一条新报修任务！维修单号：" + basecode + "；报修部门: " + dept + "；报 修 人: " + dtu.Rows[0]["CN_LOGIN"] + "；报修内容: " + classname + startComment.Text + "；联络电话: " + dtu.Rows[0]["CN_O_PHONE"] + "；联络手机: " + dtu.Rows[0]["CN_HANDSET"] + "；报修日期: " + DateTime.Now;
            DataTable dtm = Manager.GetList(1, " isadmin = 0 and states = 1 and repair like '%" + bigid + "%'", "worktime").Tables[0];
            if (dtm != null)
            {
                if (dtm.Rows.Count > 0)
                {
                    for (int i = 0; i < dtm.Rows.Count; i++)
                    {
                        string repair = dtm.Rows[i]["repair"].ToString();
                        if (repair.Length > 2)
                        {
                            string[] strs = repair.Split(',');
                            foreach (string str in strs)
                            {
                                if (str.Equals(bigid))
                                {
                                    UI.AddAmDetail(dtm.Rows[i]["username"].ToString(), subject, content);
                                    //DataTable dtt = Manager.GetList("isadmin = 0 and states = 1 and repair like '%" + bigid + "%'").Tables[0];
                                    //if (dtt.Rows.Count > 1)
                                    //{
                                    //    Manager.changes(bigid);
                                    //}
                                    //if (dtt.Rows.Count == 1)
                                    //{
                                    Manager.upworks(dtm.Rows[i]["username"].ToString());
                                    //}
                                    UI.SendMSG(MessageContent, dtm.Rows[i]["phonenum"].ToString());
                                }
                            }
                        }
                        else
                        {
                            if (repair.Equals(bigid))
                            {
                                UI.AddAmDetail(dtm.Rows[i]["username"].ToString(), subject, content);
                                //DataTable dtt = Manager.GetList("isadmin = 0 and states = 1 and repair like '%" + bigid + "%'").Tables[0];
                                //if (dtt.Rows.Count > 1)
                                //{
                                //    Manager.changes(bigid);
                                //}
                                //if (dtt.Rows.Count == 1)
                                //{
                                Manager.upworks(dtm.Rows[i]["username"].ToString());
                                //}
                                UI.SendMSG(MessageContent, dtm.Rows[i]["phonenum"].ToString());
                            }
                        }
                    }
                }
            }

            RI.Add(ri);
            int counts = RI.counts(int.Parse(bigid));
            Tools.CookieHelper.ClearCookie("bigid");
            Response.Redirect("ShowRI.aspx?counts=" + counts + "&bigid=" + bigid);

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
    }
}