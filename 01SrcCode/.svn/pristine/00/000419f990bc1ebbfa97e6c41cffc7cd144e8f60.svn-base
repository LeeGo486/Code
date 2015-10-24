using DBHelper;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GoodsAllocation_Create : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            LoadData();
    }
  
    private void LoadData()
    {
        try
        {
            if (string.IsNullOrEmpty(Request["depotid"]) || string.IsNullOrEmpty(Request["userid"]))
            {
                lbresult.Text = "参数异常！";
                return;
            }
            TxtBillNo.Text = WMSFactory.Allocation.CreateAllocationId(Request["userid"]);
            TxtId.Text = TxtBillNo.Text;
            TxtSendShop.Text = WMSFactory.Allocation.GetShopName(Request["depotid"]);
            DdlReceive.DataSource = WMSFactory.Allocation.GetReceiveShops(Request["depotid"]);
            DdlReceive.DataBind();
            DDLChange();
        }
        catch (Exception err)
        {
            lbresult.Text = "异常：" + err.Message;
        }
    }

    protected void BtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            d_Move move = new d_Move();
            move.move = TxtBillNo.Text;
            move.moveid = TxtId.Text;
            move.set_depotid = Request["depotid"];
            move.get_depotid = DdlReceive.SelectedValue;
            move.setdate = DateTime.Now.ToString();
            move.set_sure = 0;
            move.get_sure = 0;
            move.setchk_sure = 0;
            move.getchk_sure = 0;
            move.setcr_name = WMSFactory.d_Move.GetCurUser(Request["userid"]);
            move.setcr_date = DateTime.Now.ToString();
            move.crdate = DateTime.Now.ToString();
            move.backdate = DateTime.Now.AddDays(10).ToString();
            move.backrate = decimal.Parse(TxtChangeRange.Text.Trim());
            move.selltype = TxtSellType.Text;
            move.set_comment = TxtRemark.Text.Trim();
            if (WMSFactory.d_Move.Add(move))
            {
                lbresult.Text = "跨公司调拨单创建成功!";
                Response.Redirect("Detail.aspx?depotid=" + Request["depotid"] + "&userid=" + Request["userid"] + "&moveid=" + this.TxtId.Text + "&get_depotid=" + DdlReceive.SelectedItem.Text);
            }
            else
            {
                lbresult.Text = "跨公司调拨单创建失败，请您重试!";
            }
        }
        catch (Exception error)
        {
            lbresult.Text = "异常:"+error.Message;
        }
    }
    protected void DdlReceive_SelectedIndexChanged(object sender, EventArgs e)
    {
        DDLChange();
    }

    private void DDLChange()
    {
        if (DdlReceive.Items.Count <= 0) return;
        this.lbRecShopName.Text = DdlReceive.SelectedValue + "-" + DdlReceive.SelectedItem.Text;
        this.TxtRemark.Text = TxtSendShop.Text.Trim() + "->" + DdlReceive.SelectedItem.Text;
    }
}