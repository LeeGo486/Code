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
    public partial class ZhuanTiList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetSafeZhuan();
            GetZhuanTiList();
        }


        private void GetSafeZhuan()
        {
            CommonDao<Safezhuan> sugmgr = new CommonDao<Safezhuan>();
            RepeaterSafeZhuanTi.DataSource = sugmgr.FindAll();
            RepeaterSafeZhuanTi.DataBind();

        }

        private void GetZhuanTiList()
        {
            string fid = "";
            string condition = "";
            if (Request["ZhuanName"] != null)
            {
                fid = Request["ZhuanName"].ToString();
                CommonDao<Safezhuan> sugmgr = new CommonDao<Safezhuan>();
                Safezhuan safezhuan = sugmgr.FindByConditions(" fid='"+fid+"' ");

                this.lableType.InnerHtml = " <span style='color: #0087ce;'>" +safezhuan.ZhuanName.ToString() + "</span>";
                condition = condition +  " NewsZhuan ='" + fid + "' ";
            }

            CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
            SafeNews s = new SafeNews();
          

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
            GetZhuanTiList();
        }

        protected void ImgBtnSearch_Click(object sender, ImageClickEventArgs e)
        {
            GetZhuanTiList();
        }

    }
}