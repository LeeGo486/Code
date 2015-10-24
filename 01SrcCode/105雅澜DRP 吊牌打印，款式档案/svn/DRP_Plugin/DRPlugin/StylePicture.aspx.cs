using DBHelper;
using Ext.Net;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StylePicture : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Y_PictureBind(object sender, Ext.Net.StoreRefreshDataEventArgs e)
    {
        lbinfo.Text = "";
        try
        {
            if (TxtStyleId.Text.Trim().Length <= 0)
                return;
            string sql = "SELECT DISTINCT F.StyleId,F.ColorId,BrName,S_Name,St_Year,St_Month,St_Xl,St_Xz,St_Dl,P.Picture FROM dbo.Y_StyleFoundation F LEFT JOIN dbo.Y_StylePicture P ON F.StyleId=P.StyleId AND F.ColorId=P.ColorId WHERE F.StyleId='{0}'";
            sql = string.Format(sql, TxtStyleId.Text.Trim().Replace("'", "").Replace("-", ""));
            DataTable dt = DBHelper.WMSFactory.Y_StylePicture.Query(sql);
            if (dt.Rows.Count <= 0)
            {
                lbinfo.Text = "没有任何记录，请检查款号是否正确！";
                return;
            }

            Y_MainStore.DataSource = dt;
            Y_MainStore.DataBind();

        }
        catch (Exception error)
        {
            this.lbinfo.Text = "异常：" + error.Message;
        }
    }
    protected void BtnClearImg_Click(object sender, DirectEventArgs e)
    {
        try
        {
            if (Hid.Text.Length > 0)
            {
                IList<Y_StylePicture> list = WMSFactory.Y_StylePicture.FindByCondition("StyleId+ColorId='" + Hid.Text.Trim() + "'");

                Y_StylePicture _Y_StylePicture = new Y_StylePicture();
                if (list != null && list.Count == 1)
                {
                    _Y_StylePicture = list[0];
                    if (File.Exists(Server.MapPath("StylePicture/" + _Y_StylePicture.Picture)))
                        File.Delete(Server.MapPath("StylePicture/" + _Y_StylePicture.Picture));
                    _Y_StylePicture.Picture = ""; //图标地址
                    if (WMSFactory.Y_StylePicture.Update(_Y_StylePicture))
                    {
                        CL_WinEdit.Hide();
                        Y_Grid.Reload();
                        MsgBox.NotifiShow("恭喜您，图片清除成功！", "OK");
                    }
                    else
                        MsgBox.MessageShow("操作失败，请您重试！", "ERROR");
                }
                else
                {
                    CL_WinEdit.Hide();
                    MsgBox.NotifiShow("恭喜您，图片清除成功！", "OK");
                }
            }
            else
            {
                X.Msg.Alert("失败", "请重新选择要操作的行！").Show();
                return;
            }
        }
        catch (Exception error)
        {
            X.Msg.Alert("失败", "异常：" + error.Message).Show();
            return;
        }
    }
    protected void BtnSave_Click(object sender, DirectEventArgs e)
    {
        try
        {
            Y_StylePicture _Y_StylePicture = new Y_StylePicture();
            string filename = UpFile.PostedFile.FileName;
            if (string.IsNullOrEmpty(filename))
            {
                X.Msg.Alert("失败", "请先选择要上传的图片！").Show();
                return;
            }
            if (Hid.Text.Length > 0)
            {

                string ext = Path.GetExtension(filename).ToLower();
                if (ext != ".png" && ext != ".jpg")
                {
                    X.Msg.Notify("失败", "<font color='red'>文件格式不正确，仅支持png,jpg格式文件！</font>").Show();
                    return;
                }
                filename = DateTime.Now.ToString("yyyyMMddHHmmss") + ext;
                UpFile.PostedFile.SaveAs(Server.MapPath("StylePicture/" + filename));
                IList<Y_StylePicture> list = WMSFactory.Y_StylePicture.FindByCondition("StyleId+ColorId='" + Hid.Text.Trim() + "'");
                bool isok = false;
                if (list != null && list.Count == 1)
                {
                    _Y_StylePicture = list[0];
                    if (File.Exists(Server.MapPath("StylePicture/" + _Y_StylePicture.Picture)))
                        File.Delete(Server.MapPath("StylePicture/" + _Y_StylePicture.Picture));
                    _Y_StylePicture.Picture = filename; //图标地址
                    isok = WMSFactory.Y_StylePicture.Update(_Y_StylePicture);
                }
                else
                {
                    _Y_StylePicture.StyleId = Hid.Text.Trim().Substring(0, Hid.Text.Trim().Length - 1);
                    _Y_StylePicture.ColorId = Hid.Text.Trim().Replace(_Y_StylePicture.StyleId, "");
                    _Y_StylePicture.Picture = filename;
                    isok = WMSFactory.Y_StylePicture.Add(_Y_StylePicture);
                }
                if (isok)
                {
                    CL_WinEdit.Hide();
                    Y_Grid.Reload();
                    MsgBox.NotifiShow("恭喜您，操作成功！", "OK");
                }
                else
                    MsgBox.MessageShow("操作失败，请您重试！", "ERROR");
            }
            else
            {
                X.Msg.Alert("失败", "请重新选择要修改的行！").Show();
                return;
            }
        }
        catch (Exception error)
        {
            X.Msg.Alert("失败", "异常：" + error.Message).Show();
            return;
        }
    }
    //查询
    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        lbinfo.Text = "";
        try
        {
            if (TxtStyleId.Text.Trim().Length <= 0)
                return;
            string sql = "SELECT DISTINCT F.StyleId,F.ColorId,BrName,S_Name,St_Year,St_Month,St_Xl,St_Xz,St_Dl,P.Picture FROM dbo.Y_StyleFoundation F LEFT JOIN dbo.Y_StylePicture P ON F.StyleId=P.StyleId AND F.ColorId=P.ColorId WHERE F.StyleId='{0}'";
            sql = string.Format(sql, TxtStyleId.Text.Trim().Replace("'", "").Replace("-", ""));
            DataTable dt = DBHelper.WMSFactory.Y_StylePicture.Query(sql);
            if (dt.Rows.Count <= 0)
            {
                lbinfo.Text = "没有任何记录，请检查款号是否正确！";
                return;
            }

            lbBrand.Text = dt.Rows[0]["BrName"].ToString();
            lbDl.Text = dt.Rows[0]["St_Dl"].ToString();
            lbPinM.Text = dt.Rows[0]["S_Name"].ToString();
            lbSeason.Text = dt.Rows[0]["St_Month"].ToString();
            lbxl.Text = dt.Rows[0]["St_Xl"].ToString();
            lbxz.Text = dt.Rows[0]["St_Xz"].ToString();
            lbYear.Text = dt.Rows[0]["St_Year"].ToString();

            Y_MainStore.DataSource = dt;
            Y_MainStore.DataBind();

        }
        catch (Exception error)
        {
            this.lbinfo.Text = "异常：" + error.Message;
        }
    }
}