using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAO;
using EPReper.Model;
using EPReper.BLL;
using System.Data;

namespace Web.View
{
    public partial class Default : System.Web.UI.Page
    {
        EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
        static string userid = "";
        string username = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Tools.CookieHelper.GetCookie("CN_ID") != "" && Tools.CookieHelper.GetCookie("CN_ID") != null)
                {
                    userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();

                }
                else
                {
                    Response.Redirect("~/login.aspx");
                }

            }


            UserDateBind();
            GetAdmin();

        }

        public void GetAdmin()
        {
            EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
            CommonDao<HealthAdmin> healadminmgr = new CommonDao<HealthAdmin>();
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            if (int.Parse(healadminmgr.GetTotalCount(" username='" + username + "' ")) > 0)
            {
                admins.Visible = true;
                admins1.Visible = true;
                admins2.Visible = true;
            }

        }


        public void UserDateBind()
        {
            CommonDao<HealthUserOrder> HealthUserOrdermgr = new CommonDao<HealthUserOrder>();
            CommonDao<HealthAdmin> healadminmgr = new CommonDao<HealthAdmin>();
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
            if (int.Parse(healadminmgr.GetTotalCount(" username='" + username + "' and works=2 ")) > 0)
            {
                string condition = " userid in('other','" + userid + "') ";
                if (this.DropDownList1.Text.Trim() != "")
                {
                    condition = condition + " and  userstate='" + this.DropDownList1.Text.ToString() + "'";
                }
                AspNetPager1.RecordCount = int.Parse(HealthUserOrdermgr.GetTotalCount(condition));
                Repeater1.DataSource = HealthUserOrdermgr.FindAllByPageDesc(((AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize).ToString(), AspNetPager1.PageSize.ToString(), condition);
                Repeater1.DataBind();

            }
            else
            {

                string condition = " username='" + username + "'";
                if (this.DropDownList1.Text.Trim() != "")
                {
                    condition = condition + " and  userstate='" + this.DropDownList1.Text.ToString() + "'";
                }
                AspNetPager1.RecordCount = int.Parse(HealthUserOrdermgr.GetTotalCount(condition));
                Repeater1.DataSource = HealthUserOrdermgr.FindAllByPageDesc(((AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize).ToString(), AspNetPager1.PageSize.ToString(), condition);
                Repeater1.DataBind();
            }




        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            UserDateBind();
        }

        protected void BtnSearch_Clik(object sender, EventArgs e)
        {
            UserDateBind();
        }


        protected void Btn_Yuyue(object sender, EventArgs e)
        {
            CommonDao<HealthUserOrder> UserOrderMgr = new CommonDao<HealthUserOrder>();
            int UserOrderCount = int.Parse(UserOrderMgr.GetTotalCount("USERSTATE='已生效' and USERID='" + userid + "'"));
            if (UserOrderCount == 0)
            {
                Response.Redirect("UserOrder.aspx");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnSetScore_Clik(object sender, CommandEventArgs e)
        {
            string fid = e.CommandName;
            CommonDao<HealthUserOrder> HealthUserOrdermgr = new CommonDao<HealthUserOrder>();
            HealthUserOrder healthorder = HealthUserOrdermgr.FindById(fid);

            CommonDao<HealthSchedule> OrderSchMgr = new CommonDao<HealthSchedule>();
            HealthSchedule hsc = OrderSchMgr.FindById(healthorder.userschid);

            if (DateTime.Parse(healthorder.starttime).AddMinutes(45) > DateTime.Now)
            //if (DateTime.Parse(hsc.endtime) > DateTime.Now)
            {
                MsgShow("您的保健服务未完成,请您在保健结束后进行评价。结束时间：" + hsc.endtime + "");
                return;
            }

            if (healthorder.userstate == "已评价")
            {
                MsgShow("预约已评价！");
                return;
            }
            Response.Redirect("/View/SetOrderScore.aspx?OrderID=" + fid + "");

        }



        //取消预约
        protected void btnCancel_Clik(object sender, CommandEventArgs e)
        {
            string fid = e.CommandName;
            CommonDao<HealthUserOrder> HealthUserOrdermgr = new CommonDao<HealthUserOrder>();
            HealthUserOrder healthorder = HealthUserOrdermgr.FindById(fid);
            if (healthorder.userstate == "已评价")
            {
                MsgShow("预约已评价,无法取消！");
                UserDateBind();
                return;
            }

            healthorder.userstate = "已取消";

        

            //更新排班表
            // HealthSchedule hs = HealthSchedulmgr.FindById(healthorder.userschid);
            //判断 情况  第二周去评价第一周预约的 不能影响第二周的排班
            CommonDao<HealthSchedule> HealthSchedulmgr = new CommonDao<HealthSchedule>();
            HealthSchedule hs = HealthSchedulmgr.FindByConditions(" fid='" + healthorder.userschid + "' and  starttime='" + healthorder.starttime.ToString() + "'");
            //在排班表里面没有了预约
            if (hs == null)
            {
                HealthUserOrdermgr.Update(healthorder);
                MsgShow("成功取消预约");
                UserDateBind();
                return;
            }


            //当前时间大于预约开始时间
            if (DateTime.Now > DateTime.Parse(healthorder.starttime))
            {
                MsgShow("您的保健服务已超过时间，不能取消，请评价。");
                return;
            }


            //更新排班表 和 预约单的状态
            hs.orderperson = "";
            hs.isorder = 0;
            hs.islock = 0;


            //正常取消预约的情况
            if (HealthUserOrdermgr.Update(healthorder) && HealthSchedulmgr.Update(hs))
            {
                //取消小翅膀信息发送
                CommonDao<HealthUserMsg> healthmsgMgr = new CommonDao<HealthUserMsg>();
                HealthUserMsg hwalmsg = healthmsgMgr.FindByConditions(" USERSCHID='" + healthorder.userschid + " ' and starttime='" + healthorder.starttime.ToString() + "'");
                if (hwalmsg != null)
                {
                    hwalmsg.sendstate = 1;
                    healthmsgMgr.Update(hwalmsg);
                }

                //判断是否失效并发送给袁瑛
                if (DateTime.Parse(hs.starttime) > DateTime.Now)
                {
                    string subject = "保健预约取消";
                    string content = "保健预约负责人：<br /> 您好，" + healthorder.username + "预约的(" + hs.orderdate.Substring(0, 3) + " " + hs.ordertime + ")时间段 " + hs.orderdoctor + " 医师，预约人已于 " + DateTime.Now + " 取消保健服务预约，特告知您知晓并跟踪详情。 ";
                    // EPReper.BLL.Manager Manager = new EPReper.BLL.Manager();
                    // DataTable dtm = Manager.GetList(0, " isadmin = 9 and states =9 ", "id").Tables[0];

                    CommonDao<HealthAdmin> healadminmgr = new CommonDao<HealthAdmin>();
                    IList<HealthAdmin> listhealthadmin = healadminmgr.FindByCondition(" works=0 ");

                    if (listhealthadmin != null)
                    {

                        foreach (HealthAdmin healthadmin in listhealthadmin)
                        {
                            UI.AddAmDetail(healthadmin.username, subject, content);
                            //UI.AddAmDetail("盛绍华", subject, content);
                        }

                    }

                }

                MsgShow("成功取消预约");
                UserDateBind();
            }
            else
            {
                MsgShow("取消预约失败！");
            }
        }

        //评价预约
        protected void btnAppraise_Clik(object sender, CommandEventArgs e)
        {

            string fid = e.CommandName;

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