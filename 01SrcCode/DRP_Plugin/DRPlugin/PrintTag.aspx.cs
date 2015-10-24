using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBHelper;
using System.Data;

public partial class PrintTag : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    //查询
    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        lbInfo.Text = "";
        TxtDoType.Text = "";
        TxtGBK.Text = "";
        TxtGrade.Text = "";
        TxtSafeType.Text = "";
        try
        {
            if (TxtStyleId.Text.Trim().Length <= 0 || TxtColorId.Text.Trim().Length <= 0)
            {
                lbInfo.Text = "款式编号和颜色编号不能为空!";
                return;
            }
            IList<Y_StyleFoundation> style = WMSFactory.Y_StyleFoundation.FindByCondition(string.Format("(StyleId='{0}' OR OldStyleId='{0}') AND (ColorId='{1}' OR OldColorId='{1}')", TxtStyleId.Text.Trim(), TxtColorId.Text.Trim()));
            if (style.Count <= 0)
            {
                lbInfo.Text = "没有找到任何记录！";
                return;
            }
            Y_StyleFoundation sf = style[0];
            //赋值,获取基本信息
            lbBrand.Text = sf.BrName;
            lbdprice.Text = sf.J_Price.ToString();
            lbPinM.Text = sf.S_Name;
            lbCd.Text = sf.Production;
            lbcf.Text = sf.Fabric == null ? "" : sf.Fabric.Replace(";", "<br />").Replace("；", "<br />");
            TxtOldStyleID.Text = sf.OldClothingId;
            TxtSpc.Text = sf.Specifications;
            //获取颜色
            DataTable dt = WMSFactory.Y_GBCode.Query("SELECT c_name FROM F22.dbo.j_color where colorid='" + sf.ColorId + "'");
            if (dt != null && dt.Rows.Count > 0)
                lbColor.Text = dt.Rows[0][0].ToString();
            //获取国标码信息
            IList<Y_StylePrint> printlist = WMSFactory.Y_StylePrint.FindByCondition("StyleId='" + sf.StyleId + sf.ColorId + "'");
            if (printlist.Count > 0)
            {
                TxtDoType.Text = printlist[0].DoType;
                TxtGBK.Text = printlist[0].GBCode;
                TxtGrade.Text = printlist[0].Grade;
                TxtSafeType.Text = printlist[0].SafeType;
            }
            else
            {//随机分配一个国标码
                IList<Y_GBCode> codes = WMSFactory.Y_GBCode.FindAllByPage(0, 1, 1, "", "StyleId='' or StyleId is null");
                if (codes.Count > 0)
                {
                    Y_StylePrint p = new Y_StylePrint();
                    p.StyleId = sf.StyleId + sf.ColorId;
                    p.GBCode = codes[0].Code;
                    codes[0].StyleId = p.StyleId;
                    if (WMSFactory.Y_StylePrint.Add(p) && WMSFactory.Y_GBCode.Update(codes[0]))
                    {
                        TxtGBK.Text = codes[0].Code;
                    }
                    else
                    {
                        lbInfo.Text = "国标码分配失败，请重新单击‘查 询’按钮！";
                        return;
                    }
                }
                else
                {
                    lbInfo.Text = "没有可用的国标码了，请上传新的国标码！";
                    return;
                }
            }
            //加载尺码信息
            RPSize.DataSource = style;
            RPSize.DataBind();
        }
        catch (Exception error)
        {
            lbInfo.Text = "异常："+error.Message;
        }
    }
    //保存
    protected void BtnSave_Click(object sender, EventArgs e)
    {
        IList<Y_StylePrint> list = WMSFactory.Y_StylePrint.FindByCondition("GBCode='" + TxtGBK.Text + "'");
        if (list.Count == 1)
        {
            list[0].Grade = TxtGrade.Text.Trim();
            list[0].SafeType = TxtSafeType.Text.Trim();
            list[0].DoType = TxtDoType.Text.Trim();
            if (WMSFactory.Y_StylePrint.Update(list[0]))
            {
                SaveSpec();
                lbInfo.Text = "保存成功！";
            }
            else
                lbInfo.Text = "保存失败，请您重试！";
        }
    }
    /// <summary>
    /// 2014-11-26
    /// </summary>
    private void SaveSpec()
    {
        IList<Y_StyleFoundation> style = WMSFactory.Y_StyleFoundation.FindByCondition(string.Format("(StyleId='{0}' OR OldStyleId='{0}') AND (ColorId='{1}' OR OldColorId='{1}')", TxtStyleId.Text.Trim(), TxtColorId.Text.Trim()));
        if (style.Count <= 0)
        {
            lbInfo.Text = "没有找到任何记录！";
            return;
        }
        Y_StyleFoundation sf = style[0];
        sf.Specifications = TxtSpc.Text.Trim();
        WMSFactory.Y_StyleFoundation.Update(sf);
    }
}