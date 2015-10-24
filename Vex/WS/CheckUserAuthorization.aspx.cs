using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CheckUserAuthorization : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Check();
    }

    private void Check()
    {

        string strSession_ID, strMenuID;
        string strReturn = "";
        strSession_ID = Request["SessionID"];
        strMenuID = Request["MenuID"];

        if (strSession_ID == null || strSession_ID == "")
        {
            strReturn = "缺少参数：SessionID";

        }
        else if (strMenuID == null || strMenuID == "")
        {
            strReturn = "缺少参数：MenuID";

        }
        else
        {

            System.Threading.Thread.Sleep(5000);

            WS ws = new WS();
            strReturn = ws.CheckUser_Authorization(strSession_ID, strMenuID, "", "");
        }

        if (Request["jsoncallback"] != null)
        {
            Response.Write(Request["jsoncallback"]);
        }
        //Response.Write("({\"msg\":\""+strReturn+"\"})");
        Response.Write("var msg={msg:\"" + strReturn + "\"};");
        //Response.Write(strReturn);
        //Response.Write("var ojb = {msg:'js跨域请求成功'};");
        Response.End();
    }
}