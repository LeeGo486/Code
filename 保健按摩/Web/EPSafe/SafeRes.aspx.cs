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
    public partial class SafeRes : System.Web.UI.Page
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

            CommonDao<SafePitFalls> newmgr = new CommonDao<SafePitFalls>();
            string condition = " 1=1  ";

            if (TextBoxyh.Text.Trim().Length > 0)
            {
                condition = condition + " and  PitContents like '%" + this.TextBoxyh.Text.Trim().ToString() + "%'";
            } 
                if (TextBoxdept.Text.Trim().Length > 0)
            {
                condition = condition + " and dept like '%" + this.TextBoxdept.Text.Trim().ToString() + "%'";
            }
              
            if (TextBoxperson.Text.Trim().Length > 0)
            {
                condition = condition + " and person like '%" + this.TextBoxperson.Text.Trim().ToString() + "%'";
            }
             
            if (TextBoxqy.Text.Trim().Length > 0)
            {
                condition = condition + " and Area like '%" + this.TextBoxqy.Text.Trim().ToString() + "%'";
            }
             
            if (TextBoxtime.Text.Trim().Length > 0)
            {
                condition = condition + " and time = '" + this.TextBoxtime.Text.Trim().ToString()+"'";
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