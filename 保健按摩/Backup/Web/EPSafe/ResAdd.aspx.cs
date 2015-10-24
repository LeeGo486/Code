using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Maticsoft.Common;
using DAO;
using EPReper.Model;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using EPReper.Common;

namespace EPReper.Web.EPSafe
{
    public partial class ResAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Page_Preload(object sender, EventArgs e)
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

                CommonDao<SafePitFalls> newmgr = new CommonDao<SafePitFalls>();

                SafePitFalls spf = newmgr.FindById(Request.QueryString["fid"]);
                if (spf != null)
                {

                    this.TextBoxDate.Text = DateTime.Parse(spf.time).ToShortDateString();

                    SetDropValueDefault(spf.dept, spf.person);

                    //ListItem itmSelected = DropDownListQuyu.Items.FindByValue(spf.area);
                    //if (itmSelected != null) { itmSelected.Selected = true; }
                    

                    ListItem itmSelected1 = DropDownListDept.Items.FindByValue(spf.dept);
                    if (itmSelected1 != null) { itmSelected1.Selected = true; }

                    ListItem itmSelected2 = DropDownListPerson.Items.FindByValue(spf.person);
                    if (itmSelected2 != null) { itmSelected2.Selected = true; }

                    this.TextBoxfk.Text = spf.Fine == null ? "" : spf.Fine.ToString();
                    this.TextAreaQuYu.InnerText = spf.area == null ? "" : spf.area.ToString();
                    this.TextAreaJieguo.InnerHtml = spf.pitresult == null ? "" : spf.pitresult.ToString();
                    this.TextAreaYijian.InnerHtml = spf.pitsuggestion == null ? "" : spf.pitsuggestion.ToString();
                    this.TextAreaYinhuan.InnerHtml = spf.pitcontents.ToString();

                }
                else
                {
                    MessageBox.ShowAndRedirect(this, "出错了，资源未找到！", "SafeAdmin.aspx");
                }
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


            string Sql2 = "SELECT   distinct Area  FROM [EPHealth].[dbo].[SafeDuty]  where Person='" + dt1.Rows[0][0].ToString() + "'";
            DataTable dt2 = Query(Sql2).Tables[0];
            this.TextAreaQuYu.InnerText = dt2.Rows[0][0].ToString();
            
            //this.DropDownListQuyu.Items.Clear();
            //this.DropDownListQuyu.DataSource = dt2;
            //DropDownListQuyu.DataTextField = "Area";
            //DropDownListQuyu.DataValueField = "Area";
            //DropDownListQuyu.DataBind();

        }

        private void SetDropValueDefault(string Dept, string Person)
        {

            string Sql = "SELECT  distinct Dept  FROM [EPHealth].[dbo].[SafeDuty] ";
            //if (Request.QueryString["fid"] != null)
            //{

            //    CommonDao<Model.SafeRewards> newmgr = new CommonDao<SafeRewards>();

            //    SafeRewards sres = newmgr.FindById(Request.QueryString["fid"]);
            //    if (sres != null)
            //    {
            //        Sql = Sql + " where Dept='"+ sres.dept.ToString()+"'";
            //    }
            //}

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
            this.TextAreaQuYu.InnerText = dt2.Rows[0][0].ToString();
            //this.DropDownListQuyu.Items.Clear();
            //this.DropDownListQuyu.DataSource = dt2;
            //DropDownListQuyu.DataTextField = "Area";
            //DropDownListQuyu.DataValueField = "Area";
            //DropDownListQuyu.DataBind();

        }

        protected void GetValue(object sender, EventArgs e)
        {
            CommonDao<Model.SafePitFalls> newmgr = new CommonDao<SafePitFalls>();
            SafePitFalls spf = new SafePitFalls();
           
            
            if (Request.QueryString["fid"] != null)
            {
                spf = newmgr.FindById(Request.QueryString["fid"].ToString());
            }
            spf.area = this.TextAreaQuYu.InnerText.Trim().ToString();

            spf.time = this.TextBoxDate.Text.ToString();
            spf.person = this.DropDownListPerson.Text.Trim().ToString();
            spf.pitresult = this.TextAreaJieguo.InnerHtml.Trim().ToString();
            if (this.TextBoxfk.Text.ToString()!="")
            {
                spf.Fine = Int32.Parse(this.TextBoxfk.Text.ToString());
            }
            
            spf.pitsuggestion = this.TextAreaYijian.InnerHtml.Trim().ToString();
            spf.pitcontents = this.TextAreaYinhuan.InnerText.Trim().ToString().Replace("\"", "'");//.Replace("\"", "\"\'\"")
            spf.dept = this.DropDownListDept.Text.ToString();
            spf.createperson = "测试";
            spf.createtime = DateTime.Now.ToString();
            GetImg getimg = new GetImg();
            spf.picurl = getimg.MyGetImgUrl(this.TextAreaYinhuan.InnerText.ToString());
            if (Request.QueryString["fid"] != null)
            {
                if (newmgr.Update(spf))
                {
                    MessageBox.ShowAndRedirect(this, "恭喜您，安全隐患修改成功！", "SafeResAdd.aspx");
                }
                MessageBox.Show(this, "Sorry,安全隐患修改失败！请您重试！");

            }
            else
            {
                if (newmgr.Add(spf))
                {
                    MessageBox.ShowAndRedirect(this, "恭喜您，安全隐患添加成功！", "SafeResAdd.aspx");
                }
                MessageBox.Show(this, "Sorry,安全隐患添加失败！请您重试！");

            }
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
            this.TextAreaQuYu.InnerText = dt1.Rows[0][0].ToString();
            //this.DropDownListQuyu.Items.Clear();
            //this.DropDownListQuyu.DataSource = dt1;
            //DropDownListQuyu.DataTextField = "Area";
            //DropDownListQuyu.DataValueField = "Area";
            //DropDownListQuyu.DataBind();
        }

       
        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string Sql = "SELECT  distinct Area  FROM [EPHealth].[dbo].[SafeDuty]  where Person='" + this.DropDownListPerson.SelectedValue.ToString() + "'";
            DataTable dt = Query(Sql).Tables[0];
            this.TextAreaQuYu.InnerText = dt.Rows[0][0].ToString();
            //this.DropDownListQuyu.Items.Clear();
            //DropDownListQuyu.DataSource = dt;
            //DropDownListQuyu.DataTextField = "Area";
            //DropDownListQuyu.DataValueField = "Area";
            //DropDownListQuyu.DataBind();

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