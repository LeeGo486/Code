using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPReper.Web
{
    public partial class main : System.Web.UI.Page
    {
        EPReper.BLL.SysInfo si = new BLL.SysInfo();
        protected void Page_Load(object sender, EventArgs e)
        {
            List<EPReper.Model.SysInfo> syslist = si.GetModelList();
            int tdwidth = 100;
            if (syslist.Count >= 3)
            {
                tdwidth = 30;
            }
            else
            {
                tdwidth = 100 / syslist.Count;
            }
            string liststr = "";
            //if (syslist.Count <= 3)
            //{
            //    liststr += "<tr align=\"center\">";
            //    for (int i = 0; i < syslist.Count; i++)
            //    {
            //        liststr += "<td valign=\"middle\" width=\"" + tdwidth + "%\">";
            //        liststr += "<a href=\"" + syslist[i].sysaddr + "\">" + syslist[i].sysname + "</a>";
            //        liststr += "</td>";
            //    }
            //    liststr += "</tr>";
            //}
            //else
            {

                for (int i = 0; i < syslist.Count; i++)
                {
                    if (i == 0 || i % 3 == 0)
                    {
                        liststr += "<tr align=\"center\">";
                    }
                    //if(i!=0&&(i+1)%3==0)
                    liststr += "<td valign=\"middle\" width=\"" + tdwidth + "%\">";
                    liststr += "<a href=\"" + syslist[i].sysaddr + "\">" + syslist[i].sysname + "</a>";
                    liststr += "</td>";
                    if ((i + 1) % 3 == 0)
                    {
                        liststr += "</tr>";
                    }
                }

            }
            listtable.InnerHtml = liststr;
        }
    }
}