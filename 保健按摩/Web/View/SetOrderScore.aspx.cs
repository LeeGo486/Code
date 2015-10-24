using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPReper.Model;
using DAO;
using System.Data;


namespace Web.View
{
    public partial class SetOrderScore : System.Web.UI.Page
    {
        static string OrderID = "";

        EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();

        protected void Page_Load(object sender, EventArgs e)
        {
            OrderID = Request.QueryString["OrderID"];
            if (!IsPostBack)
            {
                if (Tools.CookieHelper.GetCookie("CN_ID") != "" && Tools.CookieHelper.GetCookie("CN_ID") != null && OrderID != null)
                {
                    OrderDataBind();
                }
                else
                {
                    Response.Redirect("~/login.aspx");

                }
            }
        }

        public void OrderDataBind()
        {
            CommonDao<HealthUserOrder> UserOrderMgr = new CommonDao<HealthUserOrder>();
            HealthUserOrder hu = UserOrderMgr.FindById(OrderID);
            this.Labeldoctor.Text = hu.userdoctor;
            this.Labeldatetime.Text = hu.userdate.Substring(0, 3) + "&nbsp&nbsp" + hu.usertime;
            this.Labeldept.Text = hu.userdept;
            this.Labeluser.Text = hu.username;
            this.LabelTel.Text = hu.usertel;
            this.TextAreaDescription.InnerHtml = hu.description == null ? "" : hu.description.Replace("<br>", "\r\n");
            CommonDao<HealthScore> HeacthScoreMgr = new CommonDao<HealthScore>();
            if (int.Parse(HeacthScoreMgr.GetTotalCount(" ORDERID='" + OrderID + "'")) == 1)
            {
                HealthScore hs = HeacthScoreMgr.FindByConditions(" ORDERID='" + OrderID + "'");
                this.Ratingliaoxiao.CurrentRating = hs.liaoxiao/4;
                this.Ratingfuwu.CurrentRating = hs.fuwutaidu/4;
                this.Ratingjifa.CurrentRating = hs.jifa/4;
                this.Ratinglidu.CurrentRating = hs.lidao/4;
                this.Ratingshushidu.CurrentRating = hs.shushidu/4;

                this.TextAreaScore.InnerHtml = hs.description == null ? "" : hs.description.Replace("<br>", "\r\n");
            }
        }

        protected void Btn_OK(object sender, EventArgs e)
        {

            CommonDao<HealthScore> HeacthScoreMgr = new CommonDao<HealthScore>();
            CommonDao<HealthUserOrder> UserOrderMgr = new CommonDao<HealthUserOrder>();
            HealthUserOrder hu = UserOrderMgr.FindById(OrderID);

            CommonDao<HealthSchedule> OrderSchMgr = new CommonDao<HealthSchedule>();
            HealthSchedule hsc = OrderSchMgr.FindById(hu.userschid);

            if (DateTime.Parse(hu.starttime).AddMinutes(45) > DateTime.Now) 
            //if (DateTime.Parse(hsc.endtime) > DateTime.Now) 
            {
                Show("您的保健服务未完成,请您在保健结束后进行评价。结束时间："+hsc.endtime+"", " ");
                return;
            }

            if (int.Parse(HeacthScoreMgr.GetTotalCount(" ORDERID='" + OrderID + "' ")) == 0)
            {
                HealthScore hs = new HealthScore();
                hs.orderid = OrderID;
                hs.doctor = hu.userdoctor;
                hs.liaoxiao = this.Ratingliaoxiao.CurrentRating*4;
                hs.fuwutaidu = this.Ratingfuwu.CurrentRating * 4;
                hs.jifa = this.Ratingjifa.CurrentRating * 4;
                hs.lidao = this.Ratinglidu.CurrentRating * 4;
                hs.shushidu = this.Ratingshushidu.CurrentRating * 4; 
                hs.totalsum = hs.liaoxiao + hs.fuwutaidu + hs.jifa + hs.lidao + hs.shushidu;

                hs.description = this.TextAreaScore.InnerHtml.Replace("\r\n", "<br>").ToString();


                string userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
                hs.createperson = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();

                hs.createtime = DateTime.Now.ToString();
                hu.userstate = "已评价";

                if (UserOrderMgr.Update(hu) && HeacthScoreMgr.Add(hs))
                {
                    //MsgShow("评价成功！");
                    string subject = "保健预约";
                    string content = "保健预约负责人：<br />您好，" + hs.createperson + " 预约的(" + hu.userdate + " " + hu.usertime + ")时间段" + hs.doctor + "医生，预约人已于" + DateTime.Now + "对保健服务进行评价，特告知您知晓并跟踪详情。";
                   

                    CommonDao<HealthAdmin> healadminmgr = new CommonDao<HealthAdmin>();
                    IList<HealthAdmin> listhealthadmin = healadminmgr.FindByCondition(" works=0 ");

                    if (listhealthadmin != null)
                    {
                        foreach (HealthAdmin healthadmin in listhealthadmin)
                        {
                            UI.AddAmDetail(healthadmin.username, subject, content);
                        }
                    }

                    Response.Write("<script>alert('评价成功！');window.location='Default.aspx'</script>");
                    return;
                }
                else
                {
                    Show("评价失败", " ");
                    return;
                }

                // Response.Write("<script>alert('评论成功！');window.location='Default.aspx'</script>");
                //MsgShow("预约成功！");
                // Show("恭喜您，您的文章发布成功！", "window.opener=null;window.open('','_self');window.close();");
            }
            else
            {
                HealthScore hs = HeacthScoreMgr.FindByConditions(" ORDERID='" + OrderID + "'");
                hs.liaoxiao = this.Ratingliaoxiao.CurrentRating * 4;
                hs.fuwutaidu = this.Ratingfuwu.CurrentRating * 4;
                hs.jifa = this.Ratingjifa.CurrentRating * 4;
                hs.lidao = this.Ratinglidu.CurrentRating * 4;
                hs.shushidu = this.Ratingshushidu.CurrentRating * 4;
                hs.totalsum = hs.liaoxiao + hs.fuwutaidu + hs.jifa + hs.lidao + hs.shushidu;


                hs.description = this.TextAreaScore.InnerHtml.Replace("\r\n", "<br>").ToString();

                string userid = Tools.CookieHelper.GetCookie("CN_ID").ToString();
                hs.createperson = UI.GetList("CN_ID = " + userid).Tables[0].Rows[0]["CN_LOGIN"].ToString();
                hs.createtime = DateTime.Now.ToString();

                if (HeacthScoreMgr.Update(hs))
                {
                    string subject = "保健预约";
                    string content = "您好,评价成功！ " + DateTime.Now;
                    EPReper.BLL.Manager Manager = new EPReper.BLL.Manager();
                    DataTable dtm = Manager.GetList(0, " isadmin = 9 and states =9 ", "id").Tables[0];
                    if (dtm != null)
                    {
                        if (dtm.Rows.Count > 0)
                        {
                            for (int i = 0; i < dtm.Rows.Count; i++)
                            {
                                UI.AddAmDetail(dtm.Rows[i]["username"].ToString(), subject, content);
                            }
                        }
                    }

                    //Show("评价成功！", "window.opener=null;window.open('','_self');window.close();");
                    Response.Write("<script>alert('评价成功！');window.location='Default.aspx'</script>");
                    return;
                }
                else
                {
                    Show("评价失败", " ");
                    return;
                }
            }


        }



        //private void MsgShow(string infos)
        //{
        //    ScriptManager.RegisterClientScriptBlock(UpdatePanel1, this.GetType(), "", "alert('" + infos + "');", true);


        //}
        private void Show(string msg, string close)
        {
            this.ClientScript.RegisterStartupScript(this.GetType(), "message", "<script language='javascript' defer>alert('" + msg + "');" + close + "</script>");
        }
    }
}