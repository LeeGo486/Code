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
    public partial class SafeNew : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Page_Preload(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetInfoImgs();
                TopNewThemes();
                InfoBind();
            }
        }


        private void TopNewThemes()
        {
            CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
            //RpNewReplay.DataSource = newmgr.FindByIDdesc("10", " NewsInfoType = '安全新闻' ");
            //RpNewReplay.DataBind();

            this.RepeaterBenYue.DataSource = newmgr.FindBydesc("10", " NewsInfoType = '安全新闻' ", "newskits");
            RepeaterBenYue.DataBind();

            this.RepeaterDianJi.DataSource = newmgr.FindBydesc("10", " NewsInfoType = '安全新闻' ", "newskits");
            RepeaterDianJi.DataBind();

            this.RepeaterPicNews.DataSource = newmgr.FindByIDdesc("10", " NewsInfoType = '安全新闻' and  newstype = '图片新闻'");
            RepeaterPicNews.DataBind();
        }


        private void InfoBind()
        {


            CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
            string condition = " NewsInfoType = '安全新闻' ";
            if (TextBoxSearch.Text.Trim().Length > 0)
            {
                condition = condition + " and  newstitle like '%" + this.TextBoxSearch.Text.Trim().ToString() + "%'";
            }

            Pager.RecordCount = int.Parse(newmgr.GetTotalCount(condition));
            RpNewReplay.DataSource = newmgr.FindAllByPageDesc(((Pager.CurrentPageIndex - 1) * Pager.PageSize).ToString(), Pager.PageSize.ToString(), condition);
            RpNewReplay.DataBind();
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            InfoBind();
        }

        protected void ImgBtnSearch_Click(object sender, ImageClickEventArgs e)
        {
            InfoBind();
        }




        //绑定新闻flash图片
        public string pics = "'";
        public string links = "'";
        public string texts = "'";
        private void GetInfoImgs()
        {
            CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
            IList<SafeNews> list = newmgr.FindByIDdesc("5", " NewsInfoType = '安全新闻' and  newstype = '图片新闻'");

            foreach (SafeNews sn in list)
            {

                string img = GetFirstImg(sn.newspics);
                if (img != "")
                {
                    pics += img + "|";
                    links += "Details.aspx?fid=" + sn.fid.ToString() + "|";
                    texts += (sn.newstitle.Length > 16 ? sn.newstitle.Substring(0, 16) + "..." : sn.newstitle) + "|";
                }
            }
            pics = pics.TrimEnd('|') + "'";
            links = links.TrimEnd('|') + "'";
            texts = texts.TrimEnd('|') + "'";
        }
        private string GetFirstImg(string imgsUrl)
        {
            string[] imgs = imgsUrl.Split('|');
            for (int i = 0; i < imgs.Count<string>(); i++)
            {
                if (imgs[i].ToLower().Contains("jpg"))
                    return imgs[i];
            }
            return "";
        }
    }
}