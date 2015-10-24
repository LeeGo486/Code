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
    public partial class SafeDu : System.Web.UI.Page
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

            CommonDao<SafeDuty> newmgr = new CommonDao<SafeDuty>();
            string condition = " ";

            if (TextBoxSearch.Text.Trim().Length > 0)
            {
                condition = condition + " Area like '%" + this.TextBoxSearch.Text.Trim().ToString() + "%'";
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

    }
}