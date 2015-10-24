using CJ;
using DBHelper;
using Ext.Net;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GBCode : System.Web.UI.Page
{
    protected void Page_PreLoad(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {

        }
    }

    //绑定Grid
    protected void Y_GBCode_DataBind(object sender, StoreRefreshDataEventArgs e)
    {
        e.Total = int.Parse(WMSFactory.Y_GBCode.GetTotalCount(e.Parameters[Y_GBCode_Filter.ParamPrefix], ""));
        IList<Y_GBCode> list = WMSFactory.Y_GBCode.FindAllByPage(e.Start, e.Limit, 1, e.Parameters[Y_GBCode_Filter.ParamPrefix], "");
        Y_GBCode_MainStore.DataSource = list;
        Y_GBCode_MainStore.DataBind();
    }
    //删除数据
    protected void BtnDel_Click(object sender, DirectEventArgs e)
    {
        int Success = 0, Failed = 0;
        RowSelectionModel sm = Y_GBCode_Grid.SelectionModel.Primary as RowSelectionModel;
        foreach (SelectedRow row in sm.SelectedRows)
        {
            Y_GBCode _Y_GBCode = new Y_GBCode();
            _Y_GBCode.Id = int.Parse(row.RecordID);
            if (WMSFactory.Y_GBCode.Del(_Y_GBCode)) Success++;
            else Failed++;
        }
        Y_GBCode_Grid.Reload();
        if (Failed > 0)
            MsgBox.MessageShow("删除操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
        else
            MsgBox.NotifiShow("删除操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
    }
    protected void BtnSave_Click(object sender, DirectEventArgs e)
    {
        Y_GBCode _Y_GBCode = new Y_GBCode();
        if (Hid.Text.Length > 0)
            _Y_GBCode = WMSFactory.Y_GBCode.FindById(Hid.Text);

        //_Y_GBCode.Id = ; //自增
        _Y_GBCode.Code = TxtCode.Text; //国标码
        _Y_GBCode.StyleId = ""; //新款式编号


        bool isok = false;
        if (Hid.Text.Length > 0)
            isok = WMSFactory.Y_GBCode.Update(_Y_GBCode);
        else
            isok = WMSFactory.Y_GBCode.Add(_Y_GBCode);
        if (isok)
        {
            Y_GBCode_Win.Hide();
            Y_GBCode_Grid.Reload();
            MsgBox.NotifiShow("恭喜您，操作成功！", "OK");
        }
        else
            MsgBox.MessageShow("操作失败，请您重试！", "ERROR");
    }

    //导入
    protected void Btnsave_Click(object sender, DirectEventArgs e)
    {
        try
        {
            string filename = UpFile.PostedFile.FileName;
            string ext = Path.GetExtension(filename).ToLower();
            if (ext != ".xls" && ext != ".xlsx")
            {
                X.Msg.Notify("失败", "<font color='red'>文件格式不正确，仅支持.xls(Excel)格式文件！</font>").Show();
                return;
            }
            filename = DateTime.Now.ToString("yyyyMMddHHmmss") + ext;
            UpFile.PostedFile.SaveAs(Server.MapPath("File/" + filename));
            DataTable dt = new DataTable();
            CJ_DevelopHelper.OtherCon_Str = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("File/" + filename) + ";Extended Properties='Excel 8.0;HDR=YES;IMEX=1;'";
            CJ_DevelopHelper.SqlStr = "select 国标码,'' as 备注 from [sheet1$] where 国标码<>''";
            dt = CJ_DevelopHelper.Other_ReturnDateTable;
            if (dt.Rows.Count <= 0)
            {
                X.Msg.Alert("提醒", "导入的文件无记录！").Show();
                return;
            }
            DataTable dtCopy = dt.Clone();
            for(int i=0;i<dt.Rows.Count;i++)
            {
                try
                {
                    Y_GBCode code = new Y_GBCode();
                    code.Code = dt.Rows[i]["国标码"].ToString();
                    code.StyleId = "";
                    if (!WMSFactory.Y_GBCode.Add(code))
                    {
                        DataRow newDR = dtCopy.NewRow();//新表创建新行
                        newDR.ItemArray = dt.Rows[i].ItemArray;//旧表结构行赋给新表结构行
                        newDR["备注"]="请检查长度或是否已存在该国标码";
                        dtCopy.Rows.Add(newDR);
                    }
                }
                catch (Exception error)
                {
                    DataRow newDR = dtCopy.NewRow();//新表创建新行
                    newDR.ItemArray = dt.Rows[i].ItemArray;//旧表结构行赋给新表结构行
                    newDR["备注"] = "异常："+error.Message;
                    dtCopy.ImportRow(newDR);
                }
            }
            if (File.Exists(Server.MapPath("File/" + filename)))
                File.Delete(Server.MapPath("File/" + filename));

            Y_GBCode_Grid.Reload();
            if (dtCopy.Rows.Count > 0)
            {
                string ErrFile = "File/GBK-ERROR-ROWS-" + filename;
                ExcelHelper.ExportExcelWithAspose(dtCopy, Server.MapPath(ErrFile));
                X.Msg.Alert("提醒", "存在错误记录，请先检查！<br />请下载异常文件<a href='" + ErrFile + "' target='_blank'>异常记录</a>，修改后重新上传提交！").Show();
            }
            else
            {
                X.Msg.Alert("提醒", "国标码导入成功！").Show();
            }
        }
        catch (Exception error)
        {
            X.Msg.Alert("错误", error.Message + "！请认真检查文档！").Show();
        }
    }
}