using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class export : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["txt_Excel_exportName"] == null || Request["txt_Excel_exportContent"] == null )
        {
            return;
        }

        Response.Clear();
        Response.Buffer = true;
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        Response.HeaderEncoding = System.Text.Encoding.UTF8;
        Response.AppendHeader("content-disposition", "attachment;filename=\"" + HttpUtility.UrlEncode(Request["txt_Excel_exportName"] ?? DateTime.Now.ToString("yyyyMMdd"), System.Text.Encoding.UTF8) + ".xls\"");
        Response.ContentType = "Application/ms-excel";
        Response.Write("<html>\n<head>\n");
        Response.Write("<style type=\"text/css\">\n.pb{font-size:13px;border-collapse:collapse;} " +
                       "\n.pb th{font-weight:bold;text-align:center;border:0.5pt solid windowtext;padding:2px;} " +
                       "\n.pb td{border:0.5pt solid windowtext;padding:2px;}\n</style>\n"
                       + "<meta http-equiv=\"content-type\" content=\"application/ms-excel; charset=UTF-8\"/></head>\n");
        Response.Write("<body>\n" + Request["txt_Excel_exportContent"] + "\n</body>\n</html>");
        Response.Flush();
        Response.End();
    }
}