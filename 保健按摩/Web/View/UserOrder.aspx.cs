using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DAO;
using EPReper.Model;
namespace Web.View
{
    public partial class UserOrder : System.Web.UI.Page
    {
        static string userid = "";
        EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                if (Tools.CookieHelper.GetCookie("CN_ID") != "" && Tools.CookieHelper.GetCookie("CN_ID") != null)
                {
                    userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
                    UoDataBind();
                    SetSchDate();
                    GetAdmin();
                }
                else
                {
                    Response.Redirect("~/login.aspx");
                }


        }
        public void UoDataBind()
        {

            Repeater1.DataSource = GetUserOrder();
            Repeater1.DataBind();
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

        public DataSet GetUserOrder()
        {
            CommonDao<HealthUserOrder> UserOrdermgr = new CommonDao<HealthUserOrder>();
            string Sql = "SELECT *  FROM  V_HealthSchedule ";
            return UserOrdermgr.ExecuteSql(Sql);
        }

        protected void btnOr_Clik1(object sender, CommandEventArgs e)
        {
            string fid1 = e.CommandName;
            int checkd = checkdept(fid1);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid1))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid1 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik2(object sender, CommandEventArgs e)
        {
            string fid2 = e.CommandName;
            int checkd = checkdept(fid2);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid2))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid2 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik3(object sender, CommandEventArgs e)
        {
            string fid3 = e.CommandName;
            int checkd = checkdept(fid3);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid3))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid3 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik4(object sender, CommandEventArgs e)
        {
            string fid4 = e.CommandName;
            int checkd = checkdept(fid4);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid4))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid4 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik5(object sender, CommandEventArgs e)
        {
            string fid5 = e.CommandName;
            int checkd = checkdept(fid5);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }

            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid5))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid5 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik6(object sender, CommandEventArgs e)
        {
            string fid6 = e.CommandName;

            int checkd = checkdept(fid6);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }


            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid6))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid6 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik7(object sender, CommandEventArgs e)
        {
            string fid7 = e.CommandName;
            int checkd = checkdept(fid7);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid7))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid7 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik8(object sender, CommandEventArgs e)
        {
            string fid8 = e.CommandName;
            int checkd = checkdept(fid8);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid8))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid8 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik9(object sender, CommandEventArgs e)
        {
            string fid9 = e.CommandName;
            int checkd = checkdept(fid9);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid9))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid9 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik10(object sender, CommandEventArgs e)
        {
            string fid10 = e.CommandName;
            int checkd = checkdept(fid10);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid10))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid10 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik11(object sender, CommandEventArgs e)
        {
            string fid11 = e.CommandName;
            int checkd = checkdept(fid11);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid11))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid11 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik12(object sender, CommandEventArgs e)
        {
            string fid12 = e.CommandName;
            int checkd = checkdept(fid12);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid12))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid12 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik13(object sender, CommandEventArgs e)
        {
            string fid13 = e.CommandName;
            int checkd = checkdept(fid13);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid13))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid13 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik14(object sender, CommandEventArgs e)
        {
            string fid14 = e.CommandName;
            int checkd = checkdept(fid14);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid14))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid14 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        protected void btnOr_Clik15(object sender, CommandEventArgs e)
        {
            string fid15 = e.CommandName;
            int checkd = checkdept(fid15);
            if (checkd == 1)
            {
                MsgShow("您在当前时间不能进行该预约！");
                return;
            }
            if (checkd == 2)
            {
                MsgShow("该预约已过期，无法预约！");
                return;
            }
            if (CheckHasOrder(userid))
            {
                if (!OrderLock(fid15))
                {
                    MsgShow("该预约已锁定，等待他人完成操作...");
                    return;
                }
                Response.Redirect("SetOrder.aspx?SchedulId=" + fid15 + "");
            }
            else
            {
                MsgShow("您已经有生效的预约,请进行评价或取消后再进行预约！");
            }
        }

        public bool CheckHasOrder(string userid)
        {
            CommonDao<HealthUserOrder> UserOrderMgr = new CommonDao<HealthUserOrder>();
            int UserOrderCount = int.Parse(UserOrderMgr.GetTotalCount("USERSTATE='已生效' and USERID='" + userid + "'"));
            if (UserOrderCount == 0)
            {
                return true;
            }
            return false;
        }

        //判断预约是有锁定，如果为锁定者进行锁定 ，待定用户完成预约
        public bool OrderLock(string fid)
        {
            CommonDao<HealthSchedule> HScheduleMgr = new CommonDao<HealthSchedule>();
            HealthSchedule Hschedule = HScheduleMgr.FindById(fid);
            if (Hschedule.islock == 1)
            {
                return false;
            }
            else
            {
                Hschedule.islock = 1;
                Hschedule.locktime = DateTime.Now.ToString();
                if (HScheduleMgr.Update(Hschedule))
                {
                    return true;
                }
                return false;
            }
        }


        //判断三级部门长以及预约时间段
        // 0 可以执行，为1没有权限，为2 已过期
        public int checkdept(string fid)
        {

            CommonDao<HealthSchedule> HScheduleMgr = new CommonDao<HealthSchedule>();
            HealthSchedule Hschedule = HScheduleMgr.FindById(fid);

            CommonDao<HealthThree> healthreemgr = new CommonDao<HealthThree>();



            TimeSpan timespan = DateTime.Parse(Hschedule.endtime).Date - DateTime.Now.Date;
            string username = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();


            if (DateTime.Parse(Hschedule.endtime) <= DateTime.Now)
            {
                return 2;
            }
            else
            {
                if (int.Parse(healthreemgr.GetTotalCount(" username ='" + username + "'")) > 0)
                {
                    return 0;
                }
                else
                {
                    if (timespan.Days > 1)
                    {
                        return 1;
                    }
                    else
                    {
                        return 0;
                    }
                }
            }


        }


        public void SetSchDate()
        {
            this.Label1.Text = getWeekUpOfDate(DateTime.Now, DayOfWeek.Monday, 0).ToShortDateString();
            this.Label2.Text = getWeekUpOfDate(DateTime.Now, DayOfWeek.Tuesday, 0).ToShortDateString();
            this.Label3.Text = getWeekUpOfDate(DateTime.Now, DayOfWeek.Wednesday, 0).ToShortDateString();
            this.Label4.Text = getWeekUpOfDate(DateTime.Now, DayOfWeek.Thursday, 0).ToShortDateString();
            this.Label5.Text = getWeekUpOfDate(DateTime.Now, DayOfWeek.Friday, 0).ToShortDateString();
            //this.Label6.Text = getWeekUpOfDate(DateTime.Now, DayOfWeek.Saturday, 0).ToShortDateString();

        }

        public DateTime getWeekUpOfDate(DateTime dt, DayOfWeek weekday, int Number)
        {
            int wd1 = (int)weekday;
            int wd2 = (int)dt.DayOfWeek;
            return wd2 == wd1 ? dt.AddDays(7 * Number) : dt.AddDays(7 * Number - wd2 + wd1);
        }




        private void MsgShow(string infos)
        {
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, this.GetType(), "", "alert('" + infos + "');", true);

        }
    }
}