using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAO;
using System.Data;
using EPReper.Model;

namespace EPReper.Web.EPSafe
{
    public partial class SafeZhuan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        private void BindGridView()
        {
            CommonDao<Safezhuan> newmgr = new CommonDao<Safezhuan>();

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

            CommonDao<Safezhuan> newmgr = new CommonDao<Safezhuan>();
            Safezhuan safezhuan = new Safezhuan();
            safezhuan.ZhuanName = this.TextBoxName.Text.Trim().ToString();


            int count =int.Parse(newmgr.GetTotalCount("zhuanname='"+safezhuan.ZhuanName.ToString()+"'"));
            if (count == 0)
            {

                if (newmgr.Add(safezhuan))
                {


                    Alert("热点专题添加成功！");
                    BindGridView();
                }
                else
                {
                    Alert("热点专题添加失败！请重试。");

                }
            }
            else {

                Alert("热点专题名称不能重复。");
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

            string zhuanname = ((TextBox)GridViewEmployee.Rows[e.RowIndex].Cells[1].Controls[0]).Text.Trim().ToString();
            string fid = GridViewEmployee.DataKeys[e.RowIndex].Value.ToString();

            CommonDao<Safezhuan> newmgr = new CommonDao<Safezhuan>();
            Safezhuan safezhuan = newmgr.FindById(fid);

            safezhuan.ZhuanName = zhuanname;


            if (newmgr.Update(safezhuan))
            {

                Alert("热点专题更新成功！");
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


            CommonDao<Safezhuan> newmgr = new CommonDao<Safezhuan>();
            Safezhuan safezhuan = newmgr.FindById(fid);

            CommonDao<SafeNews> safenewmgr = new CommonDao<SafeNews>();

            int count = int.Parse(safenewmgr.GetTotalCount("NewsZhuan='" + fid + "'"));
            if (count == 0)
            {

                if (safezhuan != null)
                {

                    if (newmgr.Del(safezhuan))
                    {
                        Alert("热点专题删除成功！");
                        BindGridView();
                    }
                }
            }
            else {

                Alert("有属于该专题的文章，专题不能删除！");
            
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

    }
}