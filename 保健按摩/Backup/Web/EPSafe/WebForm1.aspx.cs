using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
 
using DAO;
using EPReper.Model;
using Maticsoft.Common;

namespace EPReper.Web.EPSafe
{
    public partial class WebForm1 : System.Web.UI.Page
    { 
    protected void Page_Load(object sender, EventArgs e)
        {

            GetInfo();
        }

  
        private void GetInfo()
        {
            CommonDao<SafePitFalls> yhmgr = new CommonDao<SafePitFalls>();
            
            SafePitFalls SafePitFalls = yhmgr.FindById(Request["fid"].ToString());
            if (SafePitFalls == null)
            {
                this.lbtitle.Text = "无法找到该记录，可能已经被删除！";
                return;
            }
            this.lbtitle.Text = SafePitFalls.area;
            this.Title = SafePitFalls.createperson;
            this.lbcontent.Text = SafePitFalls.pitcontents;
            this.lbAinfo.Text = " &nbsp;&nbsp;创建者者：" + SafePitFalls.createperson + " &nbsp;&nbsp;创建时间：" + SafePitFalls.createtime;

            this.aqyh.DataSource = yhmgr.FindByCondition(" fid='" + SafePitFalls.fid + "'");
            this.aqyh.DataBind();

        }


        
    }
}