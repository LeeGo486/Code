using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Maticsoft.Common;
using EPReper.Common;
using DAO;
using EPReper.Model;

namespace EPReper.Web.EPSafe
{
    public partial class DuAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Page_Preload(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetDefaultdata();
            }


            this.DropDownListYear.Items.Add(new ListItem(DateTime.Now.Year.ToString()));
            this.DropDownListYear.Items.Add(new ListItem(DateTime.Now.AddYears(1).Year.ToString()));

        }




        private void SetDefaultdata()
        {
            if (Request.QueryString["fid"] != null)
            {

                CommonDao<SafeDuty> newmgr = new CommonDao<SafeDuty>();

                SafeDuty sduty = newmgr.FindById(Request.QueryString["fid"]);
                if (sduty != null)
                {
                    this.TextAreaQuyu.InnerText = sduty.area;
                    this.TextBoxFenlei.Text = sduty.areatype;
                    this.TextBoxDept.Text = sduty.dept;
                    this.TextBoxDeptLeader.Text = sduty.deptleader;
                    this.DropDownListImportant.SelectedValue = sduty.isimportant;
                    this.DropDownListYear.Text = sduty.time.ToString();
                    this.TextBoxPerson.Text = sduty.person;

                }
                else
                {
                    MessageBox.ShowAndRedirect(this, "出错了，资源未找到！", "SafeAdmin.aspx");
                }
            }
        }


        protected void GetValue(object sender, EventArgs e)
        {
            CommonDao<Model.SafeDuty> newmgr = new CommonDao<SafeDuty>();
            SafeDuty sduty = new SafeDuty();

            if (Request.QueryString["fid"] != null)
            {
                sduty = newmgr.FindById(Request.QueryString["fid"].ToString());
            }
            sduty.area = this.TextAreaQuyu.InnerText.Replace("\r\n", "").Trim().ToString();
            sduty.areatype = this.TextBoxFenlei.Text.Trim().ToString();
            sduty.dept = this.TextBoxDept.Text.Trim().ToString();
            sduty.deptleader = this.TextBoxDeptLeader.Text.Trim().ToString();
            sduty.isimportant = this.DropDownListImportant.SelectedValue.ToString();
            sduty.time = this.DropDownListYear.Text.ToString();
            sduty.person = this.TextBoxPerson.Text.Trim().ToString();
            

            if (Request.QueryString["fid"] != null)
            {
                if (newmgr.Update(sduty))
                {
                    MessageBox.ShowAndRedirect(this, "恭喜您，安全责任修改成功！", "SafeDuAdd.aspx");
                }
                MessageBox.Show(this, "Sorry,安全责任修改失败！请您重试！");

            }
            else
            {
                if (newmgr.Add(sduty))
                {
                    MessageBox.ShowAndRedirect(this, "恭喜您，安全责任添加成功！", "SafeDuAdd.aspx");
                }
                MessageBox.Show(this, "Sorry,安全责任添加失败！请您重试！");

            }
        }
    }
}