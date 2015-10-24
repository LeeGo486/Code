using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPReper.Model;
using DAO;
using EPReper.BLL;
using System.Data;

namespace Web.View
{
    public partial class SetOrder : System.Web.UI.Page
    {
        static string SchedulId = "";
        static string userid = "";
        static string username = "";
        EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
        protected void Page_Load(object sender, EventArgs e)
        {
            SchedulId = Request.QueryString["SchedulId"];
            if (Tools.CookieHelper.GetCookie("CN_ID") != "" && Tools.CookieHelper.GetCookie("CN_ID") != null && SchedulId != null)
            {
                userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
                username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
                OrderDataBind();
                CheckOther();
            }
            else
            {
                Response.Redirect("~/login.aspx");
            }

        }
        private void CheckOther()
        {

            CommonDao<HealthAdmin> healadminmgr = new CommonDao<HealthAdmin>();
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            if (int.Parse(healadminmgr.GetTotalCount(" username='" + username + "' and works=2 ")) > 0)
           
            {
                this.TextBoxOther.Visible = true;
                healthother1.Visible = true;
           
            }
        }


        public void OrderDataBind()
        {

            CommonDao<HealthSchedule> OrderSchMgr = new CommonDao<HealthSchedule>();
            HealthSchedule healthuserorder = OrderSchMgr.FindById(SchedulId);
            this.LabelDoctor.Text = healthuserorder.orderdoctor.ToString();
            this.LabelDateTime.Text = healthuserorder.orderdate.Substring(0, 3).ToString() + "&nbsp&nbsp" + healthuserorder.ordertime.ToString();
            DataTable dtu = UI.GetInfo("CN_ID = " + userid);

            string[] depts = dtu.Rows[0]["CN_DEPTINFO"].ToString().Split('/');
            string dept = "";
            for (int i = 0; i < depts.Count(); i++)
            {
                if (i != 0)
                {
                    dept += depts[i] + "/";
                }
            }
            //if(dept.Length>0)
            //    dept = dept.Remove(dept.Length - 1);
            if (dept.Length > 0)
                dept = dept.Trim('/');
            this.LabelUser.Text = username;
            this.LabelDept.Text = dept;
            this.TextBoxTel.Text = dtu.Rows[0]["CN_O_PHONE"].ToString();
        }
        protected void Btn_OK(object sender, EventArgs e)
        {
            CommonDao<HealthUserOrder> UserOrderMgr = new CommonDao<HealthUserOrder>();
            int UserOrderCount = int.Parse(UserOrderMgr.GetTotalCount("USERSTATE='已生效' and USERID='" + userid + "'"));

            CommonDao<HealthSchedule> OrderSchMgr = new CommonDao<HealthSchedule>();
            HealthSchedule hs = OrderSchMgr.FindById(SchedulId);
            HealthUserOrder uo = new HealthUserOrder();
            if (uo.userstate == "已生效")
            {
                Response.Write("<script>alert('预约操作时间超过五分钟，该预约已失效，请重新预约！');window.location='UserOrder.aspx'</script>");
                return;
            }

            if (UserOrderCount == 0)
            {
               
                if (this.TextBoxOther.Text.Trim().Length > 0)
                {
                    uo.userid = "other";
                    uo.username = this.TextBoxOther.Text.Trim().ToString();
                    uo.userdept = this.TextBoxOtherDept.Text.Trim().ToString();

                    int UserOrderCount2 = int.Parse(UserOrderMgr.GetTotalCount(" USERSTATE='已生效' and USERNAME='" + uo.username + "'"));
                    if (UserOrderCount2 >0)
                    {
                        MsgShow("" + uo.username + "已经有生效的预约,请进行评价或取消后再进行预约！");
                        return;
                    }
                   
                  
                }
                else
                {
                    uo.userid = userid;
                    uo.username = username;
                    uo.userdept = this.LabelDept.Text.ToString();
                }

                uo.userdoctor = hs.orderdoctor;
                uo.userschid = SchedulId.ToString();
                uo.userstate = "已生效";
                uo.usertel = this.TextBoxTel.Text.ToString();
                uo.usertime = hs.ordertime;
                uo.userdate = hs.orderdate.Substring(0, 3);
                uo.starttime = hs.starttime;//判断预约时间
                uo.createtime = DateTime.Now.ToString();
                uo.description = this.TextAreaXuqiu.InnerHtml.Replace("\r\n", "<br>").ToString();


                HealthUserMsg healmsg = new HealthUserMsg();
                healmsg.username = uo.username;
                healmsg.userdoctor = hs.orderdoctor;
                healmsg.userschid = SchedulId.ToString();
                healmsg.starttime = hs.starttime;
                healmsg.userdate = hs.orderdate.Substring(0, 3);
                healmsg.usertime = hs.starttime;
                healmsg.createtime = DateTime.Now.ToString();
                healmsg.sendstate = 0;
                CommonDao<HealthUserMsg> healthmsgMgr = new CommonDao<HealthUserMsg>();
                //增加记录
                healthmsgMgr.Add(healmsg);

                hs.isorder = 1;
                hs.orderperson = uo.username;

                if (UserOrderMgr.Add(uo) && OrderSchMgr.Update(hs))
                {

                    string subject = "保健预约";
                    string content = "保健预约负责人：<br />您好，" + uo.username + " 已成功预约(" + hs.orderdate.Substring(0, 3) + " " + hs.ordertime + ")时间段 " + hs.orderdoctor + " 医师，特告知您知晓并跟踪详情。";

                    CommonDao<HealthAdmin> healadminmgr = new CommonDao<HealthAdmin>();
                    IList<HealthAdmin> listhealthadmin = healadminmgr.FindByCondition(" works=0 ");

                    if (listhealthadmin != null)
                    {
                        foreach (HealthAdmin healthadmin in listhealthadmin)
                        {
                            UI.AddAmDetail(healthadmin.username, subject, content);
                          // UI.AddAmDetail("盛绍华", subject, content);
                        }
                    }
                    Response.Write("<script>alert('预约成功！');window.location='Default.aspx'</script>");

                }
                else
                {
                    MsgShow("预约失败！");
                    return;
                }
            }

            MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");

        }

        private void MsgShow(string infos)
        {
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, this.GetType(), "", "alert('" + infos + "');", true);

        }
        private void Show(string msg, string close)
        {
            this.ClientScript.RegisterStartupScript(this.GetType(), "message", "<script language='javascript' defer>alert('" + msg + "');" + close + "</script>");
        }
    }
}