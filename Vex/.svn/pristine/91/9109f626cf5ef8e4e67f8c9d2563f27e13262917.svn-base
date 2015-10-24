using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Check();
    }

    private void Check()
    {

        string strMenuID, strEnv;
        string strReturn = "";
        strMenuID = Request["MenuID"];
        strEnv = Request["Env"];

        if (strMenuID == null || strMenuID == "")
        {
            strReturn = "缺少参数：MenuID";

        }
        else if (strEnv == null || strEnv == "")
        {
            strReturn = "缺少参数：Env";

        }
        else
        {

            //WS ws = new WS();
            //strReturn = ws.View(strMenuID, "", "", strEnv);
        }

        if (Request["jsoncallback"] != null)
        {
            Response.Write(Request["jsoncallback"]);
        }
        Response.Write("var msg={msg:\"" + strReturn + "\"};");
        Response.End();
    }
}