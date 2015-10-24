using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using Tools;
using DBHelper;
using System.Collections;
using System.IO;
using System.Data;

public partial class StyleCareLabel : System.Web.UI.Page
{
    protected void Page_PreLoad(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {

        }
    }
    //删除我的洗唛
    protected void BtnDelMyXM_Click(object sender, DirectEventArgs e)
    {
        int Success = 0, Failed = 0;
        RowSelectionModel sm = Y_CareLabel_Grid.SelectionModel.Primary as RowSelectionModel;
        foreach (SelectedRow row in sm.SelectedRows)
        {
            Y_StyleCareLabel _Y_CareLabel = new Y_StyleCareLabel();
            _Y_CareLabel.Id = int.Parse(row.RecordID);
            if (WMSFactory.Y_StyleCareLabel.Del(_Y_CareLabel)) Success++;
            else Failed++;
        }
        Y_CareLabel_Grid.Reload();
        if (Failed > 0)
            MsgBox.MessageShow("删除操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
        else
            MsgBox.NotifiShow("删除操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
    }
    //删除数据
    protected void BtnDel_Click(object sender, DirectEventArgs e)
    {
        int Success = 0, Failed = 0;
        RowSelectionModel sm = CL_Grid.SelectionModel.Primary as RowSelectionModel;
        foreach (SelectedRow row in sm.SelectedRows)
        {
            Y_CareLabel _Y_CareLabel = new Y_CareLabel();
            _Y_CareLabel= WMSFactory.Y_CareLabel.FindById(row.RecordID);
            if (WMSFactory.Y_CareLabel.Del(_Y_CareLabel))
            {
                if (File.Exists(Server.MapPath("XMimg/" + _Y_CareLabel.LbUrl)))
                    File.Delete(Server.MapPath("XMimg/" + _Y_CareLabel.LbUrl));
                //删除所有关联的图片
                WMSFactory.Y_StyleCareLabel.DelByConditions("LbId=" + _Y_CareLabel.Id);
                Success++;
            }
            else Failed++;
        }
        CL_Grid.Reload();
        if (Failed > 0)
            MsgBox.MessageShow("删除操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
        else
            MsgBox.NotifiShow("删除操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
    }
    //保存洗唛图片
    protected void BtnSave_Click(object sender, DirectEventArgs e)
    {
        Y_CareLabel _Y_CareLabel = new Y_CareLabel();
        string filename = UpFile.PostedFile.FileName;
        if (Hid.Text.Length > 0)
            _Y_CareLabel = WMSFactory.Y_CareLabel.FindById(Hid.Text);
        else
        {
            if (string.IsNullOrEmpty(filename))
            {
                X.Msg.Alert("失败", "请选择图片文件！").Show();
                return;
            }
        }
        if (!string.IsNullOrEmpty(filename))
        {
            string ext = Path.GetExtension(filename).ToLower();
            if (ext != ".png" && ext != ".jpg")
            {
                X.Msg.Notify("失败", "<font color='red'>文件格式不正确，仅支持png,jpg格式文件！</font>").Show();
                return;
            }
            filename = DateTime.Now.ToString("yyyyMMddHHmmss") + ext;
            UpFile.PostedFile.SaveAs(Server.MapPath("XMimg/" + filename));

            if (File.Exists(Server.MapPath("XMimg/" + _Y_CareLabel.LbUrl)))
                File.Delete(Server.MapPath("XMimg/" + _Y_CareLabel.LbUrl));
            _Y_CareLabel.LbUrl = filename; //图标地址
        }
        _Y_CareLabel.LbName = TxtLbName.Text; //图标名称

        bool isok = false;
        if (Hid.Text.Length > 0)
            isok = WMSFactory.Y_CareLabel.Update(_Y_CareLabel);
        else
            isok = WMSFactory.Y_CareLabel.Add(_Y_CareLabel);
        if (isok)
        {
            CL_WinEdit.Hide();
            CL_Grid.Reload();
            MsgBox.NotifiShow("恭喜您，操作成功！", "OK");
        }
        else
            MsgBox.MessageShow("操作失败，请您重试！", "ERROR");
    }
    //查找
    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        StyleIDHidden.Text = "";
        lbinfo.Text = "";
        IList<Y_StyleFoundation> style = WMSFactory.Y_StyleFoundation.FindByCondition(string.Format("(StyleId='{0}' OR OldStyleId='{0}')", TxtStyleId.Text.Trim().Replace("'","").Replace("--","")));
        if (style.Count <= 0)
        {
            lbinfo.Text = "没有找到任何记录，请检查款号！";
            return;
        }
        Y_StyleFoundation sf = style[0];
        lbbrand.Text = sf.BrName;
        lbpm.Text = sf.S_Name;
        lbproduction.Text = sf.Production;
        StyleIDHidden.Text = sf.StyleId;
        Y_CareLabel_Grid.Reload();
    }

    protected void Y_StyleCLBind(object sender,StoreRefreshDataEventArgs e)
    {
        DataTable list = WMSFactory.Y_StyleCareLabel.Query("SELECT s.Id,s.StyleId,cl.LbUrl,cl.LbName FROM Y_CareLabel cl,Y_StyleCareLabel s WHERE s.LbId=cl.Id and StyleId='" + StyleIDHidden.Text + "'");
        Y_CareLabel_MainStore.DataSource = list;
        Y_CareLabel_MainStore.DataBind();
    }

    //绑定Grid
    protected void Y_CL_DataBind(object sender, StoreRefreshDataEventArgs e)
    {

        IList<Y_CareLabel> list = null;
        if (StyleIDHidden.Text == "")
            list = WMSFactory.Y_CareLabel.FindAll();
        else
            list = WMSFactory.Y_CareLabel.FindByCondition("Id NOT IN (SELECT lbid FROM Y_StyleCareLabel WHERE StyleId = '" + StyleIDHidden.Text + "')");
        CLStore.DataSource = list;
        CLStore.DataBind();
    }

    //保存已经选择的图片
    protected void BtnSaveSelected_Click(object sender, DirectEventArgs e)
    {
        if (StyleIDHidden.Text == "")
        {
            MsgBox.MessageShow("请先输入款式编号，然后单击查询按钮！", "ERROR");
            return;
        }
        RowSelectionModel sm = CL_Grid.SelectionModel.Primary as RowSelectionModel;
        foreach (SelectedRow row in sm.SelectedRows)
        {
            Y_StyleCareLabel _Y_CareLabel = new Y_StyleCareLabel();
            _Y_CareLabel.LbId = int.Parse(row.RecordID);
            _Y_CareLabel.StyleId = StyleIDHidden.Text;
            WMSFactory.Y_StyleCareLabel.Add(_Y_CareLabel);
        }
        CL_Win.Hide();
        CL_WinEdit.Hide();
        Y_CareLabel_Grid.Reload();
    }
}