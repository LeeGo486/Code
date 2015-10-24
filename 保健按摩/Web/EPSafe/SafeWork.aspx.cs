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
    public partial class SafeWork : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InfoBind();
            }
        }

        private void InfoBind()
        {

            CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
            string condition = " NewsInfoType = '安全工作'  ";

            if (TextBoxSearch.Text.Trim().Length > 0)
            {
                condition = condition + " and  newstitle like '%" + this.TextBoxSearch.Text.Trim().ToString() + "%'";
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