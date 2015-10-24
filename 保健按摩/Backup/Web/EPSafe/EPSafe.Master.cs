using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPReper.Model;
using DAO;

namespace EPReper.Web.EPSafe
{
    public partial class EPSafe : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetInfoImgs();
        }

        //绑定新闻flash图片
        public string pics = "'";
        public string links = "'";
        public string texts = "'";
        private void GetInfoImgs(){
        //{
        //    CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
        //    IList<SafeNews> list = newmgr.FindByIDdesc("2", " NewsInfoType = '安全新闻' and  newstype = '图片新闻'");

        //    foreach (SafeNews sn in list)
        //    {
        //        string img = GetFirstImg(sn.newspics);
        //        if (img != "")
        //        {
        //           pics += img + "|";
        //           links += "Details.aspx?fid=" + sn.fid.ToString() + "|";
        //           texts += (sn.newstitle.Length > 15 ? sn.newstitle.Substring(0, 15) + "..." : sn.newstitle) + "|";
        //        }

               
        //    }
            pics = "'images/1.jpg|images/2.jpg|images/3.jpg|";
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