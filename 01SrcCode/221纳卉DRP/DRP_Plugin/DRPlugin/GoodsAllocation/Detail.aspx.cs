using DBHelper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GoodsAllocation_Detail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindParams();
            LoadMoveSub();
        }
    }

    private void BindParams()
    {
        this.lbinfo.Text = "单号：" + Request["moveid"] + "  收货店铺：" + Request["get_depotid"];
    }

    protected void btnSure_Click(object sender, EventArgs e)
    {
        try
        {
            if (TxtSkc.Text.Trim().Length <= 0) return;
            DoAction();
            TxtSkc.Text = "";
            TxtSkc.Focus();
        }
        catch (Exception error)
        {
            lbResult.Text = "异常：" + error.Message;
        }
    }

    private void LoadMoveSub()
    {
        string loadplanid = WMSFactory.d_Movesub.GetLoadPlanId(Request["moveid"]);
        lbbrand.Text = loadplanid;
        DataTable dt = WMSFactory.d_Movesub.GetMoveSub(Request["moveid"]);
        lbtotal.Text = dt.Compute("SUM(set_nums)", "").ToString();
        RP.DataSource = dt;
        RP.DataBind();
    }

    private void DoAction()
    {
        lbResult.Text = "";
        //验证是否存在款式
        DataTable dt = WMSFactory.d_Movesub.CheckClothingExists(TxtSkc.Text.Trim().Replace("'", "").Replace("--", ""));
        if (dt.Rows.Count != 1)
        {
            lbResult.Text = TxtSkc.Text.Trim()+" 款式编码错误，请检查！";
            return;
        }
        string styleid = dt.Rows[0]["styleid"].ToString();
        string clothingid = dt.Rows[0]["clothingid"].ToString();
        //验证权限
        if (WMSFactory.d_Movesub.CheckAccess(Request["userid"], styleid, Request["depotid"]) <= 0)
        {
            lbResult.Text = "很抱歉，"+TxtSkc.Text.Trim()+" 该款式您没有操作权限！";
            return;
        }
        //验证品牌
        string brand = WMSFactory.d_Movesub.CheckBrand(styleid);
        brand = (brand.Trim() == "J" ? "JL" : "EP");
        string loadplanid = WMSFactory.d_Movesub.GetLoadPlanId(Request["moveid"]);
        if (string.IsNullOrEmpty(loadplanid))
        {
            if (!WMSFactory.d_Move.UpdateDMoveBrand(brand, Request["moveid"]))
            {
                lbResult.Text = "调拨单主表品牌保存失败，请重试！";
                return;
            }
        }
        else
        {
            if (loadplanid != brand)
            {
                lbResult.Text = TxtSkc.Text.Trim() + " 单据货品品牌不一致，必须要相同，请检查！";
                return;
            }
        }
        lbbrand.Text = brand;
        //检查数量格式
        int num = 0;
        if (!int.TryParse(TxtNum.Text.Trim(), out num))
        {
            lbResult.Text = "数量非法，请检查！";
            return;
        }
        if (RbtnF.Checked)
            num = num * -1;
        //开始插入记录
        dt = WMSFactory.d_Movesub.GetClotingInfo(Request["depotid"], clothingid);
        if (dt.Rows.Count <= 0)
        {
            lbResult.Text = "找不到该款式对应的价格信息！";
            return;
        }
        //判断子表是否存在该款式？
        if (WMSFactory.d_Movesub.FindByCondition("moveid='" + Request["moveid"] + "' and clothingid='" + clothingid + "'").Count > 0)
        {
            if (WMSFactory.d_Movesub.UpdateByConditions("set_nums=set_nums+" + num.ToString(), "moveid='" + Request["moveid"] + "' and clothingid='" + clothingid + "'"))
            {
                lbResult.Text = "成功更新！";
            }
            else
            {
                lbResult.Text = "更新失败，请重试！";
                return;
            }
        }
        else
        {
            d_Movesub sub = new d_Movesub();
            sub.boxid = "";
            sub.clothingid = clothingid;
            sub.colorid = dt.Rows[0]["colorid"].ToString();
            sub.crdate = DateTime.Now.ToString();
            sub.discount = decimal.Parse(dt.Rows[0]["discount"].ToString());
            sub.set_nums = num;
            sub.sizeid = dt.Rows[0]["sizeid"].ToString();
            sub.styleid = dt.Rows[0]["styleid"].ToString();
            sub.x_price = decimal.Parse(dt.Rows[0]["x_price"].ToString());
            sub.j_cost = decimal.Parse(dt.Rows[0]["j_cost"].ToString());
            sub.j_price = decimal.Parse(dt.Rows[0]["j_price"].ToString());
            sub.moveid = Request["moveid"];
            sub.s_price = decimal.Parse(dt.Rows[0]["s_price"].ToString());
            if (WMSFactory.d_Movesub.Add(sub))
            {
                lbResult.Text = "成功保存！";
            }
            else
            {
                lbResult.Text = "保存失败，请重试！";
                return;
            }
        }
        LoadMoveSub();
    }
}