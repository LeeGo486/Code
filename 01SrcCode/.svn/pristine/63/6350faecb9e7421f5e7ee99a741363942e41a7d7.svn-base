using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;

public partial class CoderBar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string num = Request["code"].ToString();
        System.IO.MemoryStream ms = new System.IO.MemoryStream();
        System.Drawing.Image myimg = BarCodeHelper.MakeBarcodeImage(num, 2, true);
        myimg.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
        Response.ClearContent();
        Response.BinaryWrite(ms.ToArray());
        Response.End();
    }
}