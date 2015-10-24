using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBHelper;
using System.Data;

public partial class PrintDP : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Request["id"]))
        {
            Response.Write("参数错误！");
            return;
        }
        if (!IsPostBack)
        {
            Y_StyleFoundation sf = WMSFactory.Y_StyleFoundation.FindById(Request["id"]);
            lbbn.Text = sf.BrName;
            lbcf.Text = sf.Fabric.Replace(";", "<br />");
            lbfrom.Text = sf.Production;
            lbpm.Text = sf.S_Name;
            lbsize.Text = sf.SizeId;
            lbprice.Text = sf.J_Price.ToString();
            lbhh.Text = sf.ClothingId;
            //颜色
            DataTable dt = WMSFactory.Y_GBCode.Query("SELECT c_name FROM F22.dbo.j_color where colorid='" + sf.ColorId + "'");
            if (dt != null && dt.Rows.Count > 0)
                lbcolor.Text = dt.Rows[0][0].ToString();
            //条码
            ImgGBK.ImageUrl = "CodeBar.aspx?code=" + sf.ClothingId;
            //国标信息
            //获取国标码信息
            IList<Y_StylePrint> printlist = WMSFactory.Y_StylePrint.FindByCondition("StyleId='" + sf.StyleId + sf.ColorId + "'");
            if (printlist.Count > 0)
            {
                lbdo.Text = printlist[0].DoType;
                lbdj.Text = printlist[0].Grade;
                lbsafe.Text = printlist[0].SafeType;
            }
        }
    }
}