using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class b28web_AJAX_Print_elegant_ho : System.Web.UI.Page
{
    private string id = "";
    private DataTable dtmain, dtdetail, dtskfs;
    private int pages = 0;
    private int spage = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            id = Request["id"];              //通过传零售ID生成打印小票

            if (string.IsNullOrEmpty(id) || id == "")
            {
                id = Request["retailid"];
            }

            InnerHtml();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            Response.End();
        }
    }


    private void InnerHtml()
    {
        string html = "";
        dtmain = getMain(id);
        dtdetail = getDetail(id);
        dtskfs = getskfs(id);

        int n = dtdetail.Rows.Count;
        spage = n / 8 + (n % 8 == 0 ? 0 : 1);
    //    html = HeadHtml(dtmain.Rows[0]);
   //     html += "<tbody>" + BodyHtml(dtdetail) + "</tbody>";
   //     html += BottonHtml();

        html = BodyHtml(dtdetail);
        printdata.InnerHtml = html;
    }

    #region gethtml

    //获取body html
    private string BodyHtml(DataTable dt)
    {
        string body = "";
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (i == 0 || i % 8 == 0)
            {
                ++pages;
                body += HeadHtml(dtmain.Rows[0]) + "<tbody>";

                body += @"<tr>
                            <td class='prolist'> 
                                <table  id='tbdetail'>
                        ";
            }

            body += " <tr> " +
                           " <td style='width:20mm;font-size:12px'>" + dt.Rows[i]["clothingid"].ToString().Trim() + "</td> " +
                           " <td style='width:20mm;font-size:12px'>" + dt.Rows[i]["s_name"].ToString().Trim() + "</td> " +
                           " <td style='width:22mm;font-size:12px;'>" + dt.Rows[i]["x_price"].ToString().Trim() + "</td> " +
                           " <td style='width:22mm;font-size:12px'>" + dt.Rows[i]["s_price"].ToString().Trim() + "</td> " +
                           " <td style='width:10mm;font-size:12px'>" + dt.Rows[i]["nums"].ToString().Trim() + "</td> " +
                           " <td style='font-size:12px'>" + dt.Rows[i]["snums"].ToString().Trim() + "</td> " +
                     "<td style='width:3mm'></td></tr> ";

            if ((i + 1) % 8 == 0 || i == dt.Rows.Count - 1)
            {
                body += @"
                            </table>
                          </td>
                        </tr>
                        ";
                body += "</tbody>" + BottonHtml();
            }

        }

        return body;
    }

    /// <summary>
    /// 抬头HTML
    /// </summary>
    /// <param name="dr"></param>
    /// <returns></returns>
    private string HeadHtml(DataRow dr)
    {
        string head = @"
         <table class='maintable'  align='center' >
           <thead style=''>
              <tr>
                <td>
                    <table class='detailhead'>
                    <tr>
                        <td>  
                            <span class='head1' >销售清单</span><br /><span class='head2'>SALES INVOICE</sapn>
                        </td>
                        <td align='right'>
                             <img src='images/GL.gif' alt='logo'   />
                        </td>
                    </tr>
                    <tr>
                        <td colspan='2' style='font-size:12px;'> 
                            <span>销售单号/<a>NO.</a>:</span>{0}
                        </td>
                    </tr>
                    <tr>
                        <td colspan='2' style='font-size:12px;'>
                            <span>店铺名称/<a>SHOP</a>:</span>{1}
                        </td>
                    </tr>
                    <tr>
                        <td colspan='2' style='font-size:12px;'>
                            <span>地址/<a>ADD</a>:</span>{2}
                        </td>
                    </tr>
                    <tr>
                        <td colspan='2' style='font-size:12px;'>
                            <span>店铺电话/<a>TEL</a>:</span>{3}
                        </td>
                    </tr>
                    <tr>
                        <td colspan='2' style='font-size:12px;'>
                            <span>客户经理/<a>SALES</a>:</span>{4}
                        </td>
                    </tr>
                </table>
               </td>
            </tr>
        <tr>
          <td>
            <hr />
                <table id='tbdetail'>
                    <tr>
                        <td style='width:20mm;'>款号</td>
                        <td style='width:20mm;'>货品名称</td>
                        <td style='width:22mm;'>零售价</td>
                        <td style='width:22mm;'>结算单价</td>
                        <td style='width:10mm;'>数量</td>
                        <td>结算金额</td>
						<td style='width:3mm'></td>
                    </tr>
                    <tr>
                        <td><a style='font-size:12px;width:20mm;'>SKU#</a></td>
                        <td><a style='font-size:12px;width:20mm;'>NAME</a></td>
                        <td><a style='font-size:12px;width:22mm;'>RP</a></td>
                        <td><a style='font-size:12px;width:22mm;'>BUP</a></td>
                        <td><a style='font-size:12px;width:10mm;'>QTY</a></td>
                        <td><a style='font-size:12px;'>NET</a></td>
						<td style='width:3mm'></td>
                    </tr>
                </table>
           </td>
        </tr>
      </thead> ";

        head = string.Format(head, dr["retailid"].ToString(), dr["d_name"].ToString(), dr["address"].ToString(), dr["Tel"].ToString(), GetUserName(id));
        return head;
    }

    /// <summary>
    /// 尾部HTML
    /// </summary>
    /// <returns></returns>
    private string BottonHtml()
    {
        string bottomhtml = @"
         <tfoot style=''>
            <tr>
                <td>
                     <table class='bottonTable'>
                            <tr><td><hr/></td></tr>
                            <tr>
                                <td class='showborder'>
                                    <table id='tbdetail'>
                                    <tr>
                                        <td style='width:88mm'>总计/<a>TOTAL</a>:</td>
                                        <td style='width:10mm'>{7}</td>
                                        <td>{8}</td>
										<td style='width:3mm'></td>
                                    </tr>
                                    </table>
                                </td>
                                
                            </tr>
                            <tr>
                                <td>
                                    <table class='tbskfs'>
                                        <tr>
                                            <td><span>现金/<a>CASH</a>:</span>{0}</td>

                                            <td><span>信用卡/<a>CREDIT CARD</a>:</span>{1}</td>

                                            <td><span>折扣券/<a>COUPON</a>:</span>{2}</td>
                                        </tr>

                                        <tr>

                                            <td><span>积分/<a>CREDITS</a>:</span>{3}</td>

                                            <td><span>其他/<a>OTHER</a>:</span>{4}</td>

                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td colspan='3'><span>收银员签名/<a>CASHIER</a>:</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr width:12.6cm>
                                <td class='paddingleft'>
                                    <table class='showDottedBorder' cellpadding='0' cellspacing='0' >
                                        <tr>
                                            <td>											
											    银行卡号:<br/>
                                                <a>BANKCARD NO.</a><br/>
                                                顾客签名:<br />
                                                <a>CUSTOMER SIGNATURE</a><br/>
                                                联系电话:<br />
                                                <a>TEL</a>
                                            </td>
                                           <td style='width:5.2cm;vertical-align:top;' align='left'>{9}</td>
                                        </tr>
                                    </table>
                                 </td>
                            </td>
                            <tr>
                               <td class='bottonTxt'> 
                                    谢谢惠顾,欢迎再次光临!<br /> 
                                    Thank you for shopping at GRACELAND and welcome back again!<br />
                                    请保留此收据作为退换货品的依据.您所购产品均为贵重商品,敬请按照洗唛说明洗涤保养.<br />
                                    Please keep the invoice as the proof when exchanging or returning products.<br />
                                    As the products you have bought are valuable,please do clearning and maintenance according to the instruction of the care label.<br/>
                                    官方网址 http://www.graceland-china.com/  <br/>
                                    客服热线 400-1666555
                                </td>
                            </tr>
                            <tr><td class='bottonTxt' style='text-align:center;'>{5}  第{6}页</td></tr>
                    </table>   
               </td>
            </tr>
           </tfoot> 
        </table>
                ";

        DataRow dr = dtskfs.Rows[0];
        DataRow drmain = dtmain.Rows[0];
		
		if (drmain["bank_cardid"].ToString().Length ==0)
		{
		        bottomhtml = string.Format(bottomhtml,
                                    dr["skfs_xj"].ToString(),
                                    dr["skfs_sk"].ToString(),
                                    //dr["skfs_xyk"].ToString(),
                                    dr["skfs_j"].ToString(),
                                    dr["skfs_jf"].ToString(),
                                    dr["skfs_qt"].ToString(),
                                    DateTime.Now.ToString("yyyy.M.d"),
                                    pages + "/" + spage,
                                    drmain["znums"].ToString(),
                                    drmain["zssums"].ToString(),
									drmain["bank_cardid"].ToString()
                                     );
        return bottomhtml;
		}
		else
		{
        bottomhtml = string.Format(bottomhtml,
                                    dr["skfs_xj"].ToString(),
                                    dr["skfs_sk"].ToString(),
                                    //dr["skfs_xyk"].ToString(),
                                    dr["skfs_j"].ToString(),
                                    dr["skfs_jf"].ToString(),
                                    dr["skfs_qt"].ToString(),
                                    DateTime.Now.ToString("yyyy.M.d"),
                                    pages + "/" + spage,
                                    drmain["znums"].ToString(),
                                    drmain["zssums"].ToString(),
                                    drmain["bank_cardid"].ToString().Substring(0, 6) + "******" + drmain["bank_cardid"].ToString().Substring(12, 7)
                                     );
        return bottomhtml;
		}
    }

    #endregion


    #region getdata

    /// <summary>
    /// 获取主表信息
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    private DataTable getMain(string id)
    {
        string sql = @"select  b.Tel,b.[address],b.d_name,a.sure_date,a.retailid,a.s_name,a.s_sums,a.z_sums,a.znums,a.zssums,a.bank_cardid from d_retail a inner join j_depot b on a.depotid =b.depotid  
                         where retailid=@id";
        SqlParameter[] sps = new SqlParameter[]{
                            new SqlParameter("@id",id)
        };
        return app_cn.getTable(sql, sps, CommandType.Text);
    }
    /// <summary>
    /// 获取单据明细
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    private DataTable getDetail(string id)
    {
        string sql = @"select a.clothingid,a.styleid,a.sizeid,a.colorid,b.c_name,a.s_price,a.nums,a.j_price,a.x_price,
                     CONVERT(decimal(5,2),a.discount) discount,a.nums,a.s_price*a.nums snums,c.s_name
                     from d_Retailsub a
                    inner join j_color b on a.colorid=b.colorid 
                    inner join j_style c on a.styleid= c.styleid where retailid=@id";
        SqlParameter[] sps = new SqlParameter[]{
                            new SqlParameter("@id",id)
        };
        return app_cn.getTable(sql, sps, CommandType.Text);
    }

    /// <summary>
    /// 获取营业员
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    private string GetUserName(string id)
    {
        DataTable dt;
        string str = "", sql = "select names from jk_retailhistory where retailid=@id";
        SqlParameter[] sps = new SqlParameter[]{
            new SqlParameter("@id",id)
        };
        dt = app_cn.getTable(sql, sps, CommandType.Text);

        foreach (DataRow dr in dt.Rows)
        {
            if (str != "")
            {
                str += ",";
            }
            str += dr["names"].ToString();
        }
        return str;
    }
    /// <summary>
    /// 获取单据收款方式  --根据雅莹收款方式固定取值
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    private DataTable getskfs(string id)
    {
        string sql = @" select (select sums from pos_skfs where retailid=@id and retype='现金') skfs_xj,
                               (select sum(sums) from pos_skfs where retailid=@id and (retype='刷卡' or retype='信用卡')) skfs_sk,
	                           (select sums from pos_skfs where retailid=@id and retype='信用卡' ) skfs_xyk,
	                           (select sum(sums) from pos_skfs where retailid=@id and (retype='现金券' or retype='抵值券')) skfs_j,
                               (select sums from pos_skfs where retailid=@id and retype='积分抵扣') skfs_jf,
                               (select sum(sums) from pos_skfs where retailid=@id 
		                        and (retype='百联OK卡' or retype='充值卡' or retype='第三方卡' or retype='预存款' )) skfs_qt";
        SqlParameter[] sps = new SqlParameter[]{
                            new SqlParameter("@id",id)
        };
        return app_cn.getTable(sql, sps, CommandType.Text);
    }
    #endregion
}

