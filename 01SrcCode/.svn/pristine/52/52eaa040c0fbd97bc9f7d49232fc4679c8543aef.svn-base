using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DBHelper;
using System.IO;
using System.Data;
using CJ;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

public partial class StyleFoundation : System.Web.UI.Page
{
    protected void Page_PreLoad(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {

        }
    }

    //绑定Grid
    protected void Y_StyleFoundation_DataBind(object sender, StoreRefreshDataEventArgs e)
    {
        e.Total = int.Parse(WMSFactory.Y_StyleFoundation.GetTotalCount(e.Parameters[Y_StyleFoundation_Filter.ParamPrefix], ""));
        IList<Y_StyleFoundation> list = WMSFactory.Y_StyleFoundation.FindAllByPage(e.Start, e.Limit, 1, e.Parameters[Y_StyleFoundation_Filter.ParamPrefix], "");
        Session["cond"] = e.Parameters[Y_StyleFoundation_Filter.ParamPrefix];
        Y_StyleFoundation_MainStore.DataSource = list;
        Y_StyleFoundation_MainStore.DataBind();
    }
    protected void BtnExcel_Click(object sender, DirectEventArgs e)
    {
        try
        {
            if (Session["cond"] == null)
            {
                Session["cond"] = "";
            }
            DataTable dt = WMSFactory.Y_StyleFoundation.GetDtByCondition(Session["cond"].ToString());
            string ErrFile = "File/" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";
            ExcelHelper.ExportExcelWithAspose(dt, Server.MapPath(ErrFile));
            X.Msg.Alert("提醒", "导出完毕,<a href='" + ErrFile + "' target='_blank'>单击下载Excel文档</a>！").Show();
        }
        catch (Exception error)
        {
            X.Msg.Alert("提醒", "异常：" + error.Message).Show();
        }
    }
    //删除数据
    protected void BtnDel_Click(object sender, DirectEventArgs e)
    {
        int Success = 0, Failed = 0;
        RowSelectionModel sm = Y_StyleFoundation_Grid.SelectionModel.Primary as RowSelectionModel;
        foreach (SelectedRow row in sm.SelectedRows)
        {
            Y_StyleFoundation _Y_StyleFoundation = new Y_StyleFoundation();
            _Y_StyleFoundation.Id = int.Parse(row.RecordID);
            IDataParameter[] param = new IDataParameter[] { new SqlParameter("@Id", _Y_StyleFoundation.Id) };
            string result = WMSFactory.Y_StyleFoundation.SynDataByProc("Y_DeleteStyleFoundation", param);
            if (result=="") Success++;
            else Failed++;
        }
        Y_StyleFoundation_Grid.Reload();
        if (Failed > 0)
            MsgBox.MessageShow("删除操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
        else
            MsgBox.NotifiShow("删除操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
    }
    protected void BtnSave_Click(object sender, DirectEventArgs e)
    {
        Y_StyleFoundation sf = new Y_StyleFoundation();

        sf.ClothingId = TxtClothingId.Text; //新条形码
        sf.StyleId = TxtStyleId.Text; //新款式编码
        sf.ColorId = TxtColorId.Text; //新颜色
        sf.SizeId = TxtSizeId.Text; //新尺码

        if (Hid.Text.Length > 0)
            sf = WMSFactory.Y_StyleFoundation.FindById(Hid.Text);

        //_Y_StyleFoundation.Id = ; //自动
        sf.BrName = TxtBrName.Text; //品牌名称
        sf.BrId = TxtBrId.Text; //品牌编码
        sf.Production = TxtProduction.Text; //产地        
        sf.J_Price = decimal.Parse(NFJ_Price.Text); //吊牌价
        sf.J_Cost = decimal.Parse(NFJ_Cost.Text); //成本价
        sf.S_Name = TxtS_Name.Text; //品名
        sf.Fabric = TxtFabric.Text; //成分
        sf.PrintState = int.Parse(NFPrintState.Text); //打印
        sf.St_Year = int.Parse(NFSt_Year.Text); //年份
        sf.St_Month = TxtSt_Month.Text; //季节
        sf.St_Xl = TxtSt_Xl.Text; //款式种类
        sf.St_Dl = TxtSt_Dl.Text; //款式大类
        sf.St_Xz = TxtSt_Xz.Text; //款式小类
        sf.OldClothingId = TxtOldClothingId.Text; //旧条形码
        sf.OldStyleId = TxtOldStyleId.Text; //旧款式编码
        sf.OldColorId = TxtOldColorId.Text; //旧颜色
        sf.OldSizeId = TxtOldSizeId.Text; //旧尺码
        sf.Remark = TxtRemark.Text; //备注

        IDataParameter[] param = new IDataParameter[]{
                                                                    new SqlParameter("@BrName",sf.BrName),
                                                                    new SqlParameter("@BrId",sf.BrId),
                                                                    new SqlParameter("@Production",sf.Production),
                                                                    new SqlParameter("@ClothingId",sf.ClothingId),
                                                                    new SqlParameter("@StyleId",sf.StyleId),
                                                                    new SqlParameter("@ColorId",sf.ColorId),
                                                                    new SqlParameter("@SizeId",sf.SizeId),
                                                                    new SqlParameter("@J_Price",sf.J_Price),
                                                                    new SqlParameter("@J_Cost",sf.J_Cost),
                                                                    new SqlParameter("@S_Name",sf.S_Name),
                                                                    new SqlParameter("@Fabric",sf.Fabric),
                                                                    new SqlParameter("@PrintState",sf.PrintState),
                                                                    new SqlParameter("@St_Year",sf.St_Year),
                                                                    new SqlParameter("@St_Month",sf.St_Month),
                                                                    new SqlParameter("@St_Xl",sf.St_Xl),
                                                                    new SqlParameter("@St_Dl",sf.St_Dl),
                                                                    new SqlParameter("@St_Xz",sf.St_Xz),
                                                                    new SqlParameter("@OldClothingId",sf.OldClothingId),
                                                                    new SqlParameter("@OldStyleId",sf.OldStyleId),
                                                                    new SqlParameter("@OldColorId",sf.OldColorId),
                                                                    new SqlParameter("@OldSizeId",sf.OldSizeId)
                                                                };
        string result = "";

        if (Hid.Text.Length > 0)
            result = WMSFactory.Y_StyleFoundation.SynDataByProc("Y_UpdateStyleFoundation", param);
        else
            result = WMSFactory.Y_StyleFoundation.SynDataByProc("Y_InsertStyleFoundation", param);
        if (result=="")
        {
            Y_StyleFoundation_Win.Hide();
            Y_StyleFoundation_Grid.Reload();
            MsgBox.NotifiShow("恭喜您，操作成功！", "OK");
        }
        else
            MsgBox.MessageShow("操作失败，请您重试！错误：" + result, "ERROR");
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
            CJ_DevelopHelper.SqlStr = "select * from [sheet1$] where 品牌<>''";
            dt = CJ_DevelopHelper.Other_ReturnDateTable;
            if (dt.Rows.Count <= 0)
            {
                X.Msg.Alert("提醒", "导入的文件无记录！").Show();
                return;
            }
            DataTable dtCopy = dt.Clone();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                try
                {
                    //构造一个IDataParamters
                    DataRow dr = dt.Rows[i];
                    IDataParameter[] param = new IDataParameter[]{
                                                                    new SqlParameter("@BrName",dr["品牌"]),
                                                                    new SqlParameter("@BrId",dr["品牌编码"]),
                                                                    new SqlParameter("@Production",dr["产地"]),
                                                                    new SqlParameter("@ClothingId",dr["新条形码"]),
                                                                    new SqlParameter("@StyleId",dr["新款式编码"]),
                                                                    new SqlParameter("@ColorId",dr["新颜色"]),
                                                                    new SqlParameter("@SizeId",dr["新尺码"]),
                                                                    new SqlParameter("@J_Price",dr["吊牌价"]),
                                                                    new SqlParameter("@J_Cost",dr["成本价"]),
                                                                    new SqlParameter("@S_Name",dr["品名"]),
                                                                    new SqlParameter("@Fabric",dr["成份"]),
                                                                    new SqlParameter("@PrintState",dr["打印"]),
                                                                    new SqlParameter("@St_Year",dr["年份"]),
                                                                    new SqlParameter("@St_Month",dr["季节"]),
                                                                    new SqlParameter("@St_Xl",dr["款式种类"]),
                                                                    new SqlParameter("@St_Dl",dr["款式大类"]),
                                                                    new SqlParameter("@St_Xz",dr["款式小类"]),
                                                                    new SqlParameter("@OldClothingId",dr["旧条形码"]),
                                                                    new SqlParameter("@OldStyleId",dr["旧款式编码"]),
                                                                    new SqlParameter("@OldColorId",dr["旧颜色"]),
                                                                    new SqlParameter("@OldSizeId",dr["旧尺码"])
                                                                };
                    string result = WMSFactory.Y_StyleFoundation.SynDataByProc("Y_InsertStyleFoundation", param);
                    if (result != "")
                    {
                        DataRow newDR = dtCopy.NewRow();//新表创建新行
                        newDR.ItemArray = dt.Rows[i].ItemArray;//旧表结构行赋给新表结构行
                        newDR["备注"] = result;
                        dtCopy.Rows.Add(newDR);
                    }
                }
                catch (Exception error)
                {
                    DataRow newDR = dtCopy.NewRow();//新表创建新行
                    newDR.ItemArray = dt.Rows[i].ItemArray;//旧表结构行赋给新表结构行
                    newDR["备注"] = "异常：" + error.Message;
                    dtCopy.Rows.Add(newDR);
                }
            }
            if (File.Exists(Server.MapPath("File/" + filename)))
                File.Delete(Server.MapPath("File/" + filename));

            Y_StyleFoundation_Grid.Reload();

            if (dtCopy.Rows.Count > 0)
            {
                string ErrFile = "File/SF-ERROR-ROWS-" + filename;
                ExcelHelper.ExportExcelWithAspose(dtCopy, Server.MapPath(ErrFile));
                X.Msg.Alert("提醒", "存在错误记录，请先检查！<br />请下载异常文件<a href='" + ErrFile + "' target='_blank'>异常记录</a>，修改后重新上传提交！").Show();
            }
            else
            {
                X.Msg.Alert("提醒", "款式资料导入成功！").Show();
            }
        }
        catch (Exception error)
        {
            X.Msg.Alert("错误", error.Message + "！请认真检查文档！").Show();
        }
    }

}