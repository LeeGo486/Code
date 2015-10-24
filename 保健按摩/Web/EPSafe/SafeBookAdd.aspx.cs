using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAO;
using EPReper.Model;

namespace EPReper.Web.EPSafe
{
    public partial class SafeBookAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Page_Preload(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InfoBind();

            }

        }





        private void InfoBind()
        {
            CommonDao<SafeBook> newmgr = new CommonDao<SafeBook>();
            string condition = " ";

            if (TextBoxSearch.Text.Trim().Length > 0)
            {
                condition = condition + " bookTitle like '%" + this.TextBoxSearch.Text.Trim().ToString() + "%'";
            }

            Pager.RecordCount = int.Parse(newmgr.GetTotalCount(condition));
            RepeaterPubGG.DataSource = newmgr.FindAllByPageDesc(((Pager.CurrentPageIndex - 1) * Pager.PageSize).ToString(), Pager.PageSize.ToString(), condition);
            RepeaterPubGG.DataBind();
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            InfoBind();
        }

        protected void ImgBtnSearch_Click(object sender, ImageClickEventArgs e)
        {
            InfoBind();
        }


        //删除
        protected void btnDelete_Clik(object sender, CommandEventArgs e)
        {

            string fid = e.CommandName;
            CommonDao<SafeBook> newmgr = new CommonDao<SafeBook>();
            SafeBook sf = newmgr.FindById(fid);

            if (newmgr.Del(sf))
            {
                MsgShow("恭喜您，删除记录成功!");
                InfoBind();
            }
            else
            {
                MsgShow("Sorry，删除记录失败!");

            }
        }


        protected void btnUpdate_Clik(object sender, CommandEventArgs e)
        {
        }


        private void MsgShow(string infos)
        {
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, this.GetType(), "", "alert('" + infos + "');", true);

        }
    }
}