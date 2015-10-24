using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPReper.Model;
using EPReper.Common;
using DAO;

namespace EPReper.Web
{
    public partial class RepairHealth : System.Web.UI.Page
    {
      
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn1_Clik(object sender, CommandEventArgs e)
        {


            CommonDao<HealthIPAddress> ipmgr = new CommonDao<HealthIPAddress>();


            IList<HealthIPAddress> listhealthip = ipmgr.FindAll();
            int count1 = 0;

            string clientIP = HttpContext.Current.Request.UserHostAddress.ToString();
            count1 = int.Parse(ipmgr.GetTotalCount(" style='repair' and  left(IPAddress, len(IPAddress)-2)='" + ReturnIP(clientIP) + "'"));
            if (count1 > 0)
            {
                Response.Redirect("index.aspx");
            }
            else
            {
                MsgShow("对不起，该功能未对您开通。");
            }


        }

        protected void btn2_Clik(object sender, CommandEventArgs e)
        {
            CommonDao<HealthIPAddress> ipmgr = new CommonDao<HealthIPAddress>();


            IList<HealthIPAddress> listhealthip = ipmgr.FindAll();
            int count1 = 0;
            string clientIP = HttpContext.Current.Request.UserHostAddress.ToString();
            count1 = int.Parse(ipmgr.GetTotalCount(" style='health' and  left(IPAddress, len(IPAddress)-2)='" + ReturnIP(clientIP) + "'"));
            count1 = 1;
            if (count1 > 0)
            {
                Response.Redirect("View/Default.aspx");
            }

            else
            {
                MsgShow("对不起，该功能未对您开通。");
            }

        }

        protected void btn3_Clik(object sender, CommandEventArgs e)
        {

            Response.Redirect("EPSafe/Default.aspx");
        }


        public string ReturnIP(string clientIP)
        {
            int clientipcount = 0;
            int j = 0;
            for (int i = 0; i < clientIP.Length; i++)
            {
                clientipcount++;
                if (clientIP[i] == '.')
                {
                    j++;
                }
                if (j == 3)
                {
                    break;
                }
            }
            return clientIP.Substring(0, clientipcount - 1);
        }
        private void MsgShow(string infos)
        {
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, this.GetType(), "", "alert('" + infos + "');", true);

        }
    }
}