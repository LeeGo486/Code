using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DAO;
using EPReper.Model;
using System.Configuration;
using System.Data.SqlClient;

namespace Web.View
{
    public partial class SetSchedule : System.Web.UI.Page
    {
        EPReper.BLL.Userinfo UI = new EPReper.BLL.Userinfo();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SchDataBind();
                SetSchDate();

            }


        }

        public void SchDataBind()
        {

            Repeater1.DataSource = GetUserOrder();
            Repeater1.DataBind();
        }


        protected void DoneClick(object sender, EventArgs e)
        {
            if (DoProc("PROC_UPDATE_ORDERTIME"))
            {
                MsgShow("执行成功！");


                CommonDao<HealthAdmin> healadminmgr = new CommonDao<HealthAdmin>();
                IList<HealthAdmin> listhealthadmin = healadminmgr.FindByCondition(" works=1 ");

                if (listhealthadmin != null)
                {
                    foreach (HealthAdmin healthadmin in listhealthadmin)
                    {
                        UI.AddAmDetail(healthadmin.username, "保健预约", "排班完成");
                    }
                }
                
            }
            else
            {

                MsgShow("执行失败！");
            }

        }

        protected void btnOr_Clik1(object sender, CommandEventArgs e)
        {

            string fid1 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb1 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox1");
            string name = tb1.Text.ToString();
            if (UpdateSchedule(fid1, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }

        protected void btnOr_Clik2(object sender, CommandEventArgs e)
        {
            string fid2 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb2 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox2");
            string name = tb2.Text.ToString();
            if (UpdateSchedule(fid2, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik3(object sender, CommandEventArgs e)
        {
            string fid3 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb3 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox3");
            string name = tb3.Text.ToString();
            if (UpdateSchedule(fid3, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik4(object sender, CommandEventArgs e)
        {
            string fid4 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb4 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox4");
            string name = tb4.Text.ToString();
            if (UpdateSchedule(fid4, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik5(object sender, CommandEventArgs e)
        {
            string fid5 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb5 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox5");
            string name = tb5.Text.ToString();
            if (UpdateSchedule(fid5, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik6(object sender, CommandEventArgs e)
        {
            string fid6 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb6 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox6");
            string name = tb6.Text.ToString();
            if (UpdateSchedule(fid6, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik7(object sender, CommandEventArgs e)
        {
            string fid7 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb7 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox7");
            string name = tb7.Text.ToString();
            if (UpdateSchedule(fid7, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik8(object sender, CommandEventArgs e)
        {
            string fid8 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb8 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox8");
            string name = tb8.Text.ToString();
            if (UpdateSchedule(fid8, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik9(object sender, CommandEventArgs e)
        {
            string fid9 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb9 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox9");
            string name = tb9.Text.ToString();
            if (UpdateSchedule(fid9, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik10(object sender, CommandEventArgs e)
        {
            string fid10 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb10 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox10");
            string name = tb10.Text.ToString();
            if (UpdateSchedule(fid10, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik11(object sender, CommandEventArgs e)
        {
            string fid11 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb11 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox11");
            string name = tb11.Text.ToString();
            if (UpdateSchedule(fid11, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik12(object sender, CommandEventArgs e)
        {
            string fid12 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb12 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox12");
            string name = tb12.Text.ToString();
            if (UpdateSchedule(fid12, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik13(object sender, CommandEventArgs e)
        {
            string fid13 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb13 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox13");
            string name = tb13.Text.ToString();
            if (UpdateSchedule(fid13, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik14(object sender, CommandEventArgs e)
        {
            string fid14 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb14 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox14");
            string name = tb14.Text.ToString();
            if (UpdateSchedule(fid14, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        protected void btnOr_Clik15(object sender, CommandEventArgs e)
        {
            string fid15 = e.CommandName.ToString().Split(',')[0];
            int itemIndex = Convert.ToInt32(e.CommandName.ToString().Split(',')[1]);
            TextBox tb15 = (TextBox)this.Repeater1.Items[itemIndex].FindControl("TextBox15");
            string name = tb15.Text.ToString();
            if (UpdateSchedule(fid15, name))
            {
                MsgShow("保存成功！");
                SchDataBind();
            }
            else
            {
                MsgShow("保存失败！");
            }
        }
        public DataSet GetUserOrder()
        {
            CommonDao<HealthUserOrder> UserOrdermgr = new CommonDao<HealthUserOrder>();
            string Sql = "SELECT *  FROM  V_HealthSchedule ";
            return UserOrdermgr.ExecuteSql(Sql);
        }


        public bool UpdateSchedule(string fid, string doctor)
        {
            CommonDao<HealthSchedule> healthSchmgr = new CommonDao<HealthSchedule>();
            HealthSchedule hs = healthSchmgr.FindById(fid);

            CommonDao<HealthUserOrder> healthOrdmgr = new CommonDao<HealthUserOrder>();

            HealthUserOrder horder = healthOrdmgr.FindByConditions(" userschid='" + fid + "' and starttime='" + hs.starttime.ToString() + "' and userstate='已生效' ");

            hs.orderdoctor = doctor;
            bool updatehorder=true;

            if (horder == null)//判断是否已经有预约的
            {
                if (doctor.Trim() == "")
                {
                    hs.islock = 0;
                    hs.isorder = 2;//不能预约 没有医生
                    hs.orderperson = "";
                }
                else
                {
                    hs.isorder = 0;
                }
            }
            else {
                //有预约但医生为空
                if (doctor.Trim() == "")
                {
                    //取消小翅膀信息发送
                    CommonDao<HealthUserMsg> healthmsgMgr = new CommonDao<HealthUserMsg>();
                    HealthUserMsg hwalmsg = healthmsgMgr.FindByConditions(" userschid='" + fid + "' and starttime='" + hs.starttime.ToString() + "'");
                    if (hwalmsg != null)
                    {
                        hwalmsg.sendstate = 2;
                        healthmsgMgr.Update(hwalmsg);
                    }

                    hs.islock = 0;
                    hs.isorder = 2;//不能预约 没有医生
                    hs.orderperson = "";
                    horder.userstate = "已取消";
                    horder.userdoctor = "";
                    updatehorder = healthOrdmgr.Update(horder);
                    string subject = "保健预约";
                    string content = "" + horder.username.ToString() + ",您好!您预约的(" + horder.userdate.Substring(0, 3) + " " + horder.usertime + ") 时间段保健,因没有医师已自动取消，特告知您知晓。";
                    UI.AddAmDetail(horder.username.ToString(), subject, content);
                }
                else
                {
                   // hs.isorder = 0;
                  horder.userdoctor = doctor;
                  updatehorder=healthOrdmgr.Update(horder);
                }
             
            }


            if (healthSchmgr.Update(hs) && updatehorder)
            {
                return true;
            }
            return false;
        }

        public void SetSchDate()
        {
            this.Label1.Text = getWeekUpOfDate(DateTime.Now, DayOfWeek.Monday, 0).ToShortDateString();
            this.Label2.Text = getWeekUpOfDate(DateTime.Now, DayOfWeek.Tuesday, 0).ToShortDateString();
            this.Label3.Text = getWeekUpOfDate(DateTime.Now, DayOfWeek.Wednesday, 0).ToShortDateString();
            this.Label4.Text = getWeekUpOfDate(DateTime.Now, DayOfWeek.Thursday, 0).ToShortDateString();
            this.Label5.Text = getWeekUpOfDate(DateTime.Now, DayOfWeek.Friday, 0).ToShortDateString();
           // this.Label6.Text = getWeekUpOfDate(DateTime.Now, DayOfWeek.Saturday, 0).ToShortDateString();

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

        public bool DoProc(string storeProcName)
        {
            string connstr = ConfigurationManager.AppSettings["ConnectionString"];
            try
            {
                using (SqlConnection connection = new SqlConnection(connstr))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = storeProcName;
                    cmd.CommandType = CommandType.StoredProcedure;//存储过程
                    cmd.Connection = connection;//数据库连接
                    connection.Open();
                    cmd.ExecuteNonQuery();
                    connection.Close();
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}