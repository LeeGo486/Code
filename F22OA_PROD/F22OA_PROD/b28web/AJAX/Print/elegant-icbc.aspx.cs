using System;
using System.Data;
using System.Data.SqlClient;

public partial class AJAX_Print_elegant_icbc : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            string id = Request["id"];              //通过传零售ID生成打印小票
            if (string.IsNullOrEmpty(id))
            {
                id = Request["retailid"];
            }

            string html = "", sql = "", retailid = "", setdate = "", depotid = "", depotphone = "", depotaddress = "", saler = "", depotName = "", rclothing = "",
                rretype = "", rtbsums = "", bank_recodes = "", vipcode = "", cashcard = "", cashxfh = "";

            int nums = 0;
            decimal sums = 0;

            //确定数据获取方式
            if (!string.IsNullOrEmpty(id) && id != "")
            {
                # region 店铺信息
                sql = "select a.retailid,a.setdate,b.depotid,b.d_name as depotname,b.tel as depotphone, b.address as depotaddress," +
                    " a.bank_recodes,a.vipcode,isnull(c.cardid,0) as cashcard,isnull(c.sums,0) as  cashxfh" +
                    " from j_depot b,d_retail a left join cashcard.dbo.j_card c on a.cardid=c.cardid" +
                    " where a.retailid=@retailid and a.depotid=b.depotid";

                DataTable dt = new DataTable();
                SqlParameter[] sp = { new SqlParameter("@retailid", SqlDbType.VarChar, 32) };
                sp[0].Value = id;
                dt = app_cn.getTable(sql, sp, CommandType.Text);
                if (dt.Rows.Count > 0)
                {
                    retailid = dt.Rows[0]["retailid"].ToString();
                    setdate = dt.Rows[0]["setdate"].ToString();
                    depotid = dt.Rows[0]["depotid"].ToString();
                    depotName = dt.Rows[0]["depotname"].ToString();
                    depotphone = dt.Rows[0]["depotphone"].ToString();
                    depotaddress = dt.Rows[0]["depotaddress"].ToString();
                    bank_recodes = dt.Rows[0]["bank_recodes"].ToString();
                    vipcode = dt.Rows[0]["vipcode"].ToString();
                    cashcard = dt.Rows[0]["cashcard"].ToString();
                    cashxfh = dt.Rows[0]["cashxfh"].ToString();
                }

                #endregion

                //子表
                sql = "select clothingid,x_price,s_price,nums,FSSums " +
                    " from d_retailsub where retailid=@retailid";
                DataTable dt2 = new DataTable();
                SqlParameter[] sp2 = { new SqlParameter("@retailid", SqlDbType.VarChar, 32) };
                sp2[0].Value = retailid;
                dt2 = app_cn.getTable(sql, sp2, CommandType.Text);

                for (int c = 0; c < dt2.Rows.Count; c++)
                {
                    if (c > 0) rclothing += ",";
                    rclothing += dt2.Rows[c]["clothingid"] + "|" + dt2.Rows[c]["x_price"] + "|" + dt2.Rows[c]["s_price"] + "|" + dt2.Rows[c]["nums"] + "|" + dt2.Rows[c]["FSSums"] + "|";

                    //总金额、数量
                    nums += int.Parse(dt2.Rows[c]["nums"].ToString());
                    sums += decimal.Parse(dt2.Rows[c]["FSSums"].ToString());
                }

                //营业员
                sql = "select employeeid,names from jk_retailhistory where retailid=@retailid";
                DataTable dt3 = new DataTable();
                SqlParameter[] sp3 = { new SqlParameter("@retailid", SqlDbType.VarChar, 32) };
                sp3[0].Value = retailid;
                dt3 = app_cn.getTable(sql, sp3, CommandType.Text);

                for (int c = 0; c < dt3.Rows.Count; c++)
                {
                    if (c > 0) saler += ",";
                    saler += dt3.Rows[c]["names"];
                }

                //收款方式
                sql = "select (case retype when '抵值券' then '折扣券' when '现金券' then '打折券' else retype end) as retype,sums from pos_skfs where retailid=@retailid";
                DataTable dt4 = new DataTable();
                SqlParameter[] sp4 = { new SqlParameter("@retailid", SqlDbType.VarChar, 32) };
                sp4[0].Value = retailid;
                dt4 = app_cn.getTable(sql, sp4, CommandType.Text);

                for (int c = 0; c < dt4.Rows.Count; c++)
                {
                     rretype += dt4.Rows[c]["retype"] + "|";
                     rtbsums += dt4.Rows[c]["sums"] + "|";
                }
            }
            else
            {
                retailid = Request["retailid"];
                setdate = DateTime.Now.ToString();
                depotid = app_user.depotid;
                depotphone = app_user.depotphone.ToString();
                depotaddress = app_user.depotaddress;
                saler = Request["saler"];
                depotName = app_user.DepotName;

                //
                rclothing = Request["clothing"];
                rretype = Request["retype"];
                rtbsums = Request["tbsums"];

                bank_recodes = Request["bank_recodes"];
                nums = int.Parse(Request["nums"].ToString());
                sums = decimal.Parse(Request["sums"].ToString());
                vipcode = Request["vipcode"];
                cashcard = Request["cashcard"];
                cashxfh = Request["cashxfh"];
            }

            //获取所需的数据
            string[] clothing = rclothing.Split(',');
            string[] retype = rretype.Split('|');
            string[] tbsums = rtbsums.Split('|');


            //头部
            html += "<table style=\"width: 123mm;\" cellpadding=\"0\" cellspacing=\"0\" id=\"Table4\">" +
                "<thead style=\"display:table-header-group;\">" +
                "<tr><td>" +
                "<table style=\"width: 100%;\" cellpadding=\"0\" cellspacing=\"0\" id=\"Table1\" class=\"ptable\">" +
                "<tr>" +
                "<td><div style=\"padding-left:19mm;\">" + depotName + "</div></td>" +
                "<td>&nbsp;</td>" +
                "</tr>" +
                "<tr>" +
                "<td><div style=\"padding-left:24mm;\">" + depotid + "</td>" +
                "<td><div style=\"padding-left:23mm;\">" + saler + "</div></td>" +
                "</tr>" +
                "<tr>" +
                "<td><div style=\"padding-left:17mm;\">" + depotphone + "</div></td>" +
                "<td><div style=\"padding-left:30mm;\">" + setdate + "</div></td>" +
                "</tr>" +
                "<tr>" +
                "<td><div style=\"padding-left:20mm;\">" + retailid + "</div></td>" +
                "<td><div style=\"padding-left:30mm;\">" + DateTime.Now.AddSeconds(7).ToString() + "</div></td>" +
                "</tr>" +
                "</table>" +
                "</td></tr>" +
                "</thead>";

            //中间分割款式
            html += "<tbody>";
            int inum = 0;
            for (int n = 0; n < clothing.Length; n++)
            {
                string[] a2 = clothing[n].Split('|');
                if (n % 6 == 0)
                {
                    int Pages = Convert.ToInt32(Math.Ceiling(Convert.ToDouble(clothing.Length) / 6));
                    if (Pages == 0) Pages = 1;
                    inum += 1;

                    //接尾的
                    if (n != 0) html += "</table></td></tr>";

                    html += "\n<tr><td>" +
                            "\n<table style=\"width: 100%;\" cellpadding=\"0\" cellspacing=\"0\" id=\"Table00\" class=\"ptable\">" +
                            "\n<tr><td><div style=\"padding-left:12mm;height:11mm;overflow:hidden\">" + depotaddress + "</div></td><td><div style=\"padding-left:18mm;height:11mm;overflow:hidden\">第" + inum + "页 共" + Pages + "页</div></td></tr></table>" +
                            "\n</td></tr>" +
                            "\n<tr style=\"page-break-after:always;\"><td class=\"prolist\" valign=\"top\" style=\"padding-top:3mm;width:100%;\">" +
                            "\n<table id=\"tab0\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"border-collapse:collapse;width:100%;\">";

                }
                html += "\n<tr><td style=\"width:20%;height:5mm;text-align:center;font-family:arial;\">" + a2[0] +
                    "\n</td><td style=\"width:20%;height:5mm;text-align:center;font-family:arial;\">" + a2[1] +
                    "\n</td><td style=\"width:20%;height:5mm;text-align:center;font-family:arial;\">" + a2[2] +
                    "\n</td><td style=\"width:20%;height:5mm;text-align:center;font-family:arial;\">" + a2[3] +
                    "\n</td><td style=\"width:20%;height:5mm;text-align:center;font-family:arial;\">" + a2[4] + "</td></tr>";

            }
            html += "</table></td></tr></tbody>";


            //底部分割收款方式
            string sm = "";
            string bank_sn = "", bank_poscode = "", bank_merchant = "", bank_cardid = "";
            string payment1 = "", payment2 = "", payment3 = "", payment4 = "";
            int i = 0;
            for (int r = 0; r < retype.Length - 1; r++)
            {
                sm = retype[r] + "：" + Math.Round(Convert.ToDouble(tbsums[r].ToString()), 2).ToString();

                i += 1;
                if (i == 1)
                {
                    if (payment1 != "") payment1 += "；&nbsp;&nbsp;";
                    payment1 += sm;
                }
                else if (i == 2)
                {
                    if (payment2 != "") payment2 += "；&nbsp;&nbsp;";
                    payment2 += sm;
                }
                else if (i == 3)
                {
                    if (payment3 != "") payment3 += "；&nbsp;&nbsp;";
                    payment3 += sm;
                }
                else if (i == 4)
                {
                    if (payment4 != "") payment4 += "；&nbsp;&nbsp;";
                    payment4 += sm;

                    i = 0;
                }
            }

            if (!string.IsNullOrEmpty(bank_recodes) && bank_recodes != "")
            {
                bank_merchant = bank_recodes.Substring(77, 12);
                bank_poscode = bank_recodes.Substring(89, 3);
                bank_cardid = bank_recodes.Substring(2, 6) + "******" + bank_recodes.Substring(14,7);
                bank_sn = bank_recodes.Substring(53, 8);
            }

            html += "<tfoot style=\"display:table-footer-group;\">" +
                "<tr><td>" +
                    "<table style=\"width: 100%;\" cellpadding=\"0\" cellspacing=\"0\" id=\"Table3\" class=\"ptable\">" +
                    "<tr>" +
                    "<td align=\"center\" style=\"width:20%;\">&nbsp;</td>" +
                    "<td align=\"center\" style=\"width:20%;\">&nbsp;</td>" +
                    "<td align=\"center\" style=\"width:20%;\">&nbsp;</td>" +
                    "<td align=\"center\" style=\"width:20%;\">" + nums.ToString() + "</td>" +
                    "<td align=\"center\" style=\"width:20%;\">" + sums.ToString() + "</td>" +
                    "</tr>" +
                    "</table>" +
                    "<table style=\"width: 100%;\" cellpadding=\"0\" cellspacing=\"0\" id=\"Table2\" class=\"ptable\">" +
                    "<tr>" +
                        "<td width=\"50%\"><div style=\"text-align:center;\">" + payment1 + "</div></td>" +
                        "<td width=\"50%\"><div style=\"text-align:center;\">" + payment2 + "</div></td>" +
                    "</tr>" +
                    "<tr>" +
                        "<td><div style=\"text-align:center;\">" + payment3 + "</div></td>" +
                        "<td><div style=\"text-align:center;\">" + payment4 + "</div></td>" +
                    "</tr>" +
                    "<tr>" +
                        "<td><div style=\"padding-left:25mm;height:5.5mm;\">" + vipcode + "</div></td>" +
                        "<td><div style=\"padding-left:46mm;height:5.5mm;\">" + cashcard + "</div></td>" +
                    "</tr>" +
                    "<tr>" +
                        "<td>&nbsp;</td>" +
                        "<td><div style=\"padding-left:25mm;height:6mm;\">" + cashxfh + "</div></td>" +
                    "</tr>" +
                    "<tr>" +
                        "<td><div style=\"padding-left:30mm;height:6mm;\">" + bank_merchant + "</div></td>" +
                        "<td><div style=\"padding-left:30mm;height:6mm;\">" + bank_poscode + "</div></td>" +
                    "</tr>" +
                    "<tr>" +
                        "<td><div style=\"padding-left:20mm;height:5.5mm;\">" + bank_cardid + "</div></td>" +
                        "<td><div style=\"padding-left:25mm;height:5.5mm;\">" + bank_sn + "</div></td>" +
                    "</tr>" +
                    "</table>" +
                "</td>" +
                "</tr>" +
                "</tfoot>" +
                "</table>";

            printdata.InnerHtml = html;

        }
    }
}

