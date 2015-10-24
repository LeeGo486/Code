using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAO;
using EPReper.Model;
using Maticsoft.Common;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace EPReper.Web.EPSafe
{
    public partial class RewAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetDropValue();
                SetDefaultdata();
            }

        }

        private void SetDefaultdata()
        {
            if (Request.QueryString["fid"] != null)
            {

                CommonDao<Model.SafeRewards> newmgr = new CommonDao<SafeRewards>();
                SafeRewards sres = newmgr.FindById(Request.QueryString["fid"]);

                if (sres != null)
                {

                    SetDropValueDefault(sres.dept, sres.person);

                    //ListItem itmSelected = DropDownListQuyu.Items.FindByValue(sres.area);
                    //if (itmSelected != null) { itmSelected.Selected = true; }
                    this.TextAreaQuyu.InnerText = sres.area;
                    ListItem itmSelected1 = DropDownListDept.Items.FindByValue(sres.dept);
                    if (itmSelected1 != null) { itmSelected1.Selected = true; }
                    ListItem itmSelected2 = DropDownListPerson.Items.FindByValue(sres.person);
                    if (itmSelected2 != null) { itmSelected2.Selected = true; }
                    this.TextBoxReward.Text = sres.rewards.ToString();
                }
                else
                {
                    MessageBox.ShowAndRedirect(this, "出错了，资源未找到！", "SafeAdmin.aspx");
                }
            }
            else
            {


            }
        }


        protected void GetValue(object sender, EventArgs e)
        {
            CommonDao<Model.SafeRewards> newmgr = new CommonDao<SafeRewards>();
            SafeRewards srew = new SafeRewards();

            if (Request.QueryString["fid"] != null)
            {
                srew = newmgr.FindById(Request.QueryString["fid"].ToString());
            }
            srew.area = this.TextAreaQuyu.InnerText.ToString();// this.DropDownListQuyu.Text.Trim().ToString();
            srew.dept = this.DropDownListDept.Text.Trim().ToString();
            srew.person = this.DropDownListPerson.Text.Trim().ToString();
            srew.rewards = int.Parse(this.TextBoxReward.Text.Trim().ToString());
            srew.createtime = DateTime.Now.ToString();

            CommonDao<SafeDeptMoney> moneymgr = new CommonDao<SafeDeptMoney>();
            SafeDeptMoney sm = moneymgr.FindByConditions(" deptname='" + srew.dept + "' and deptyear=datepart(yy,'" + srew.createtime.ToString() + "') ");
            if (sm == null)
            {
                MessageBox.ShowAndRedirect(this, "未对该部门设置初始金额无法进行奖惩,请设置！", "SafeMoney.aspx");
                return;
            }
            
            sm.currentmoney = sm.currentmoney+srew.rewards;
            srew.totals = sm.currentmoney;

            if (Request.QueryString["fid"] != null)
            {
                if( moneymgr.Update(sm)&&newmgr.Update(srew))
                {
                    MessageBox.ShowAndRedirect(this, "恭喜您，安全奖惩修改成功！", "SafeRewAdd.aspx");
                }
                MessageBox.Show(this, "Sorry,安全奖惩修改失败！请您重试！");

            }
            else
            {
                if (moneymgr.Update(sm) && newmgr.Add(srew))
                {
                    MessageBox.ShowAndRedirect(this, "恭喜您，安全奖惩添加成功！", "SafeRewAdd.aspx");
                }
                MessageBox.Show(this, "Sorry,安全奖惩添加失败！请您重试！");

            }
        }

        private void SetDropValue()
        {

            string Sql = "SELECT  distinct Dept  FROM [EPHealth].[dbo].[SafeDuty] ";
            DataTable dt = Query(Sql).Tables[0];

            DropDownListDept.Items.Clear();
            DropDownListDept.DataSource = dt;
            DropDownListDept.DataTextField = "Dept";
            DropDownListDept.DataValueField = "Dept";
            DropDownListDept.DataBind();

            string Sql1 = "SELECT  distinct Person  FROM [EPHealth].[dbo].[SafeDuty]  where Dept='" + dt.Rows[0][0].ToString() + "'";
            DataTable dt1 = Query(Sql1).Tables[0];
            this.DropDownListPerson.Items.Clear();
            DropDownListPerson.DataSource = dt1;
            DropDownListPerson.DataTextField = "Person";
            DropDownListPerson.DataValueField = "Person";
            DropDownListPerson.DataBind();


            string Sql2 = "SELECT  distinct Area  FROM [EPHealth].[dbo].[SafeDuty]  where Person='" + dt1.Rows[0][0].ToString() + "'";
            DataTable dt2 = Query(Sql2).Tables[0];
            //this.DropDownListQuyu.Items.Clear();
            //this.DropDownListQuyu.DataSource = dt2;
            //DropDownListQuyu.DataTextField = "Area";
            //DropDownListQuyu.DataValueField = "Area";
            //DropDownListQuyu.DataBind();
            this.TextAreaQuyu.InnerText = dt2.Rows[0][0].ToString();

        }


        private void SetDropValueDefault(string Dept, string Person)
        {

            string Sql = "SELECT  distinct Dept  FROM [EPHealth].[dbo].[SafeDuty] ";
            DataTable dt = Query(Sql).Tables[0];

            DropDownListDept.Items.Clear();
            DropDownListDept.DataSource = dt;
            DropDownListDept.DataTextField = "Dept";
            DropDownListDept.DataValueField = "Dept";
            DropDownListDept.DataBind();

            string Sql1 = "SELECT  distinct Person  FROM [EPHealth].[dbo].[SafeDuty]  where Dept='" + Dept + "'";
            DataTable dt1 = Query(Sql1).Tables[0];
            this.DropDownListPerson.Items.Clear();
            DropDownListPerson.DataSource = dt1;
            DropDownListPerson.DataTextField = "Person";
            DropDownListPerson.DataValueField = "Person";
            DropDownListPerson.DataBind();


            string Sql2 = "SELECT  distinct Area  FROM [EPHealth].[dbo].[SafeDuty]  where Person='" + Person + "'";
            DataTable dt2 = Query(Sql2).Tables[0];
            //this.DropDownListQuyu.Items.Clear();
            //this.DropDownListQuyu.DataSource = dt2;
            //DropDownListQuyu.DataTextField = "Area";
            //DropDownListQuyu.DataValueField = "Area";
            //DropDownListQuyu.DataBind();
            this.TextAreaQuyu.InnerText = dt2.Rows[0][0].ToString();

        }






        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string Sql = "SELECT  distinct Person  FROM [EPHealth].[dbo].[SafeDuty]  where Dept='" + this.DropDownListDept.SelectedValue.ToString() + "'";
            DataTable dt = Query(Sql).Tables[0];
            this.DropDownListPerson.Items.Clear();
            DropDownListPerson.DataSource = dt;
            DropDownListPerson.DataTextField = "Person";
            DropDownListPerson.DataValueField = "Person";
            DropDownListPerson.DataBind();


            string Sql2 = "SELECT  distinct Area  FROM [EPHealth].[dbo].[SafeDuty]  where Person='" + dt.Rows[0][0].ToString() + "'";
            DataTable dt1 = Query(Sql2).Tables[0];
            //this.DropDownListQuyu.Items.Clear();
            //this.DropDownListQuyu.DataSource = dt1;
            //DropDownListQuyu.DataTextField = "Area";
            //DropDownListQuyu.DataValueField = "Area";
            //DropDownListQuyu.DataBind();
            this.TextAreaQuyu.InnerText = dt1.Rows[0][0].ToString();
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string Sql = "SELECT  distinct Area  FROM [EPHealth].[dbo].[SafeDuty]  where Person='" + this.DropDownListPerson.SelectedValue.ToString() + "'";
            DataTable dt = Query(Sql).Tables[0];
            //this.DropDownListQuyu.Items.Clear();
            //DropDownListQuyu.DataSource = dt;
            //DropDownListQuyu.DataTextField = "Area";
            //DropDownListQuyu.DataValueField = "Area";
            //DropDownListQuyu.DataBind();
            this.TextAreaQuyu.InnerText = dt.Rows[0][0].ToString();

        }

        public static DataSet Query(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                    command.Fill(ds, "ds");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {

                }
                return ds;
            }
        }

    }
}