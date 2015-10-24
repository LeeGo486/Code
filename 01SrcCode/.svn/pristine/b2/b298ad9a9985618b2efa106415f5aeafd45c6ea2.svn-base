using DBHelper;
using Ext.Net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GoodsAllocation_Search : System.Web.UI.Page
{
    protected void Page_PreLoad(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.DateFrom.SelectedDate = DateTime.Now;
            this.DateEnd.SelectedDate = DateTime.Now;
        }
    }

    //绑定Grid
    protected void d_Move_DataBind(object sender, StoreRefreshDataEventArgs e)
    {
        if (string.IsNullOrEmpty(Request["userid"])) return;
        string condition = "shjjdepotid is not null and shjjdepotid!='' and setcr_name='" + WMSFactory.d_Move.GetCurUser(Request["userid"]) + "' ";
        if (this.TxtMoveId.Text.Trim().Length > 0)
            condition += string.Format("and moveid like '%{0}%' ", Server.HtmlEncode(TxtMoveId.Value.ToString().Replace("'", "")));
        if (DateFrom.SelectedValue != null)
            condition += "and setcr_date>='" + ((DateTime)DateFrom.SelectedValue).ToString("yyyy-MM-dd") + "' ";
        if (DateEnd.SelectedValue != null)
            condition += "and setcr_date<='" + ((DateTime)DateEnd.SelectedValue).ToString("yyyy-MM-dd") + " 23:59:59' ";

        IList<d_Move> list = WMSFactory.d_Move.FindByCondition(condition);
        d_Move_MainStore.DataSource = list;
        d_Move_MainStore.DataBind();
    }
    //删除数据
    protected void BtnDel_Click(object sender, DirectEventArgs e)
    {
        int Success = 0, Failed = 0;
        RowSelectionModel sm = d_Move_Grid.SelectionModel.Primary as RowSelectionModel;
        foreach (SelectedRow row in sm.SelectedRows)
        {
            d_Move _d_Move = new d_Move();
            _d_Move.moveid = (row.RecordID);
            if (WMSFactory.d_Move.DelByConditions("moveid='" + row.RecordID + "'"))
            {
                WMSFactory.d_Movesub.DelByConditions("moveid='" + row.RecordID + "'");
                Success++;
            }
            else Failed++;
        }
        d_Move_Grid.Reload();
        if (Failed > 0)
            MsgBox.MessageShow("删除操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
        else
            MsgBox.NotifiShow("删除操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
    }
    //审核反审核
    protected void BtnChk_Click(object sender, DirectEventArgs e)
    {
        string username=WMSFactory.d_Move.GetCurUser(Request["userid"]);
        int Success = 0, Failed = 0;
        RowSelectionModel sm = d_Move_Grid.SelectionModel.Primary as RowSelectionModel;
        foreach (SelectedRow row in sm.SelectedRows)
        {
            d_Move _d_Move = new d_Move();
            _d_Move.moveid = (row.RecordID);
            if (WMSFactory.d_Move.UpdateByConditions("setchk_sure=" + e.ExtraParams["Flag"].ToString(), "moveid='" + row.RecordID + "'"))
            {
                WMSFactory.d_Move.UpdateByConditions("setchk_date=getdate(),setchk_name='" + username + "'", "moveid='" + row.RecordID + "'");
                Success++;
            }
            else Failed++;
        }
        d_Move_Grid.Reload();
        if (Failed > 0)
            MsgBox.MessageShow("操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
        else
            MsgBox.NotifiShow("操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
    }
    //登帐反登帐
    protected void BtnDZ_Click(object sender, DirectEventArgs e)
    {
        string username = WMSFactory.d_Move.GetCurUser(Request["userid"]);
        int Success = 0, Failed = 0;
        RowSelectionModel sm = d_Move_Grid.SelectionModel.Primary as RowSelectionModel;
        foreach (SelectedRow row in sm.SelectedRows)
        {
            d_Move _d_Move = new d_Move();
            _d_Move.moveid = (row.RecordID);
            if (e.ExtraParams["Flag"].ToString() == "1")
            {
                if (WMSFactory.d_Move.UpdateByConditions("set_sure=1,setsure_date=getdate(),setsure_name='" + username + "'", "moveid='" + row.RecordID + "'"))
                    Success++;
                else 
                    Failed++;
            }
            else
            {
                if (WMSFactory.d_Move.UpdateByConditions("set_sure=0", "moveid='" + row.RecordID + "'"))
                {
                    WMSFactory.d_Move.UpdateByConditions("setsure_date=getdate(),setsure_name='" + username + "'", "moveid='" + row.RecordID + "'");
                    Success++;
                }
                else Failed++;
            }
        }
        d_Move_Grid.Reload();
        if (Failed > 0)
            MsgBox.MessageShow("操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
        else
            MsgBox.NotifiShow("操作完成，成功" + Success.ToString() + "条，失败" + Failed.ToString() + "条！", "OK");
    }
}