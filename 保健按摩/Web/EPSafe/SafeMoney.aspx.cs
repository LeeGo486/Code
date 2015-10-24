using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAO;
using EPReper.Model;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Maticsoft.Common;

namespace EPReper.Web.EPSafe
{
    public partial class SafeMoney : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    SetDropValue();
                }
                catch
                {

                    MessageBox.ShowAndRedirect(this, "出错了", "SafeAdmin.aspx");
                    return;
                }
                BindGridView();
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

            this.DropDownListYear.Items.Add(new ListItem(DateTime.Now.Year.ToString()));
            this.DropDownListYear.Items.Add(new ListItem(DateTime.Now.AddYears(1).Year.ToString()));
        }

        private void BindGridView()
        {
            CommonDao<SafeDeptMoney> newmgr = new CommonDao<SafeDeptMoney>();

            DataTable dt = new DataTable();
            dt = newmgr.FindDataTableByCondition("");

            if (dt.Rows.Count == 0)
            {
                dt.Rows.Add(dt.NewRow());
                GridViewEmployee.DataSource = dt;
                GridViewEmployee.DataBind();

                int columnCount = dt.Columns.Count;

                GridViewEmployee.Rows[0].Cells.Clear();

                GridViewEmployee.Rows[0].Cells.Add(new TableCell());

                GridViewEmployee.Rows[0].Cells[0].ColumnSpan = columnCount + 1;

                GridViewEmployee.Rows[0].Cells[0].Text = "没有记录";

                GridViewEmployee.Rows[0].Cells[0].Style.Add("text-align", "center");
            }
            else
            {
                GridViewEmployee.DataSource = dt;
                GridViewEmployee.DataBind();
            }
        }

        protected void AddValue(object sender, EventArgs e)
        {

            CommonDao<SafeDeptMoney> newmgr = new CommonDao<SafeDeptMoney>();
            SafeDeptMoney safemoney = new SafeDeptMoney();


            safemoney.deptname = this.DropDownListDept.Text.ToString();
            safemoney.deptmoney = int.Parse(this.TextBoxReward.Text.ToString());
            safemoney.currentmoney = safemoney.deptmoney;
            safemoney.deptyear = this.DropDownListYear.Text.ToString();
            safemoney.createtime = DateTime.Now.ToString();

            if (int.Parse(newmgr.GetTotalCount(" deptname='" + safemoney.deptname.ToString() + "' and deptyear='" + safemoney.deptyear.ToString() + "' ")) == 0)
            {

                if (newmgr.Add(safemoney))
                {
                    Alert("部门金额添加成功！");
                    BindGridView();
                }
                else
                {
                    Alert("部门金额添加失败！请重试。");

                }
            }
            else
            {

                Alert("部门已存在，不能再添加！");
            }

        }


        protected void GridViewEmployee_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewEmployee.EditIndex = e.NewEditIndex; // turn to edit mode
            BindGridView(); // Rebind GridView to show the data in edit mode
        }

        protected void GridViewEmployee_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewEmployee.EditIndex = -1; //swicth back to default mode
            BindGridView(); // Rebind GridView to show the data in default mode
        }

        protected void GridViewEmployee_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

            string money = ((TextBox)GridViewEmployee.Rows[e.RowIndex].Cells[2].Controls[0]).Text.Trim().ToString();
            string year = ((TextBox)GridViewEmployee.Rows[e.RowIndex].Cells[3].Controls[0]).Text.Trim().ToString();

            string fid = GridViewEmployee.DataKeys[e.RowIndex].Value.ToString();

            CommonDao<SafeDeptMoney> newmgr = new CommonDao<SafeDeptMoney>();
            SafeDeptMoney safemoney = newmgr.FindById(fid);

            try
            {
                safemoney.currentmoney = safemoney.currentmoney - safemoney.deptmoney + int.Parse(money);
                safemoney.deptmoney = int.Parse(money);
                safemoney.deptyear = year;
            }
            catch
            {

                Alert("部门金额更新失败，请填写正确的金额！");
                return;
            }



            if (newmgr.Update(safemoney))
            {

                Alert("部门金额更新成功！");
            }
            else
            {
                Alert("热点专题更新失败！");
            }

            GridViewEmployee.EditIndex = -1; //Turn the Grid to read only mode

            BindGridView(); // Rebind GridView to reflect changes made

        }

        protected void GridViewEmployee_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string fid = GridViewEmployee.DataKeys[e.RowIndex].Value.ToString();
            CommonDao<SafeDeptMoney> newmgr = new CommonDao<SafeDeptMoney>();
            SafeDeptMoney safemoney = newmgr.FindById(fid);
            CommonDao<SafeRewards> rewardmgr = new CommonDao<SafeRewards>();
            int countreward = int.Parse(rewardmgr.GetTotalCount("dept='" + safemoney.deptname + "' and datepart(yy,createtime)='" + safemoney.deptyear + "'"));
            if (countreward == 0)
            {
                if (safemoney != null)
                {
                    if (newmgr.Del(safemoney))
                    {
                        Alert("部门金额删除成功！");
                        BindGridView();
                    }
                }
            }
            else {
                Alert("已有部门奖惩记录，无法删除！");
            }

        }

        protected void GridViewEmployee_PageChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewEmployee.PageIndex = e.NewPageIndex;
            BindGridView();
        }
        private void Alert(string msg)
        {
            string strJS = "alert('" + msg + "');";
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(this.UpdatePanel1, UpdatePanel1.GetType(), "提示", strJS, true);
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