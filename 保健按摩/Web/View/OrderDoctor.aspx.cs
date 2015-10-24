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

namespace EPReper.Web.View
{
    public partial class OrderDoctor : System.Web.UI.Page
    {
        EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
        static string userid = "";
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


            ScoreDateBind();
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
        public void ScoreDateBind()
        {
            int countall = 0;
            CommonDao<V_HealthScore> V_healthscoremgr = new CommonDao<V_HealthScore>();

            V_HealthScore V_heathTotal = V_healthscoremgr.FindById("999");
            if (V_heathTotal != null)
            {
                this.LabelTotal1.Text = V_heathTotal.totalsum.ToString()+"分";
                this.Ratinglidaoall.CurrentRating = V_heathTotal.lidao;
                this.Ratingliaoxiaoall.CurrentRating = V_heathTotal.liaoxiao;
                this.Ratingjifaall.CurrentRating = V_heathTotal.jifa;
                this.Ratingshushiall.CurrentRating = V_heathTotal.shushidu;
                this.Ratingtaiduall.CurrentRating = V_heathTotal.fuwutaidu;

            }

            //医生A
            V_HealthScore V_heathdoctorA = V_healthscoremgr.FindById("1");
            if (V_heathdoctorA != null)
            {

                this.LabelA.Text = V_heathdoctorA.totalsum.ToString() + "分";
                this.RatinglidaoA.CurrentRating = V_heathdoctorA.lidao;
                this.RatingliaoxiaoA.CurrentRating = V_heathdoctorA.liaoxiao;
                this.RatingjifaA.CurrentRating = V_heathdoctorA.jifa;
                this.RatingshushiA.CurrentRating = V_heathdoctorA.shushidu;
                this.RatingtaiduA.CurrentRating = V_heathdoctorA.fuwutaidu;
                this.LabelcountA.Text = V_heathdoctorA.countdoctor.ToString();
                this.LabelD1.Text = V_heathdoctorA.doctor.ToString();
                countall = countall + V_heathdoctorA.countdoctor;
            }

            //医生B

            V_HealthScore V_heathdoctorB = V_healthscoremgr.FindById("2");

            if (V_heathdoctorB != null)
            {
                this.LabelB.Text = V_heathdoctorB.totalsum.ToString() + "分";
                this.RatinglidaoB.CurrentRating = V_heathdoctorB.lidao;
                this.RatingliaoxiaoB.CurrentRating = V_heathdoctorB.liaoxiao;
                this.RatingjifaB.CurrentRating = V_heathdoctorB.jifa;
                this.RatingshushiB.CurrentRating = V_heathdoctorB.shushidu;
                this.RatingtaiduB.CurrentRating = V_heathdoctorB.fuwutaidu;
                this.LabelcountB.Text = V_heathdoctorB.countdoctor.ToString();
                this.LabelD2.Text = V_heathdoctorB.doctor.ToString();
                countall = countall + V_heathdoctorB.countdoctor;
            }

            this.Labelcountall.Text = countall.ToString();
            image1.Visible = true;
            image2.Visible = true;
            if (V_heathdoctorA!=null)
            {
                image1.ImageUrl = "\\Images\\" + V_heathdoctorA.doctor.ToString().Trim() + ".png";
            }
            else
            {
                image1.ImageUrl = "\\Images\\计文军.png";
                this.LabelD1.Text = "计文军";
            }
            if (V_heathdoctorB!=null )
            {
                image2.ImageUrl = "\\Images\\" + V_heathdoctorB.doctor.ToString().Trim() + ".png";
            }
            else
            {
                image2.ImageUrl = "\\Images\\董振香.png";
                this.LabelD2.Text = "董振香";
            }
        }
    }
}