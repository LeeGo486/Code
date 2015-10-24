using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.Resources;

namespace EPReper.Web.EPSafe
{
    public partial class LiTest : System.Web.UI.Page
    {
        public IList<string> list = new List<string>();
        protected void Page_Load(object sender, EventArgs e)
        {

            getli();
        }
        public void getli()
        {
            //
            //HtmlGenericControl li = new HtmlGenericControl();
            //li.InnerHtml = string.Format("<li><a href='#'>{0}</a></li>", "我是动态添加的");
            ////innerHtml内容决定Html控件类型           
            //MyUL.Controls.Add((Control)li);
            string infoinnerhtml = "";
            string listinnerhtml = "";
            for (int i = 0; i < 5; i++)
            {
                infoinnerhtml = infoinnerhtml + "<div><dl><dt><a href='#nogo'>";
                infoinnerhtml = infoinnerhtml + " <img src='images/0.jpg' alt='' />";
                infoinnerhtml = infoinnerhtml + "<span>The Light Works The Thunders Trance New 1</span> </a></dt>";
                infoinnerhtml = infoinnerhtml + "</dl></div>";

            }
            info.InnerHtml = infoinnerhtml;


            listinnerhtml = listinnerhtml + "<h2><span>图片新闻</span></h2><ul id='list'>";
            listinnerhtml = listinnerhtml + "<li class='cur'><a href='#nogo'>Paul Van Dyk World Tour GT. G+ </a></li>";

            for (int i = 0; i < 4; i++)
            {
                listinnerhtml = listinnerhtml + "<li><a href='#nogo'>Paul Van Dyk World Tour GT. G+ </a></li>";
            }
            listinnerhtml = listinnerhtml + "</ul>";

            Newslist.InnerHtml = listinnerhtml;
        }

    }


}