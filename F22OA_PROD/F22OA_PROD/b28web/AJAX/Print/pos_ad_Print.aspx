<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_pos_ad_Print, App_Web_pos_ad_print.aspx.c366eeb9" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>销售小票</title>
    <style type="text/css">
        body
        {
            font-size: 10px;
        }
        #main
        {
            min-height: 10mm;
            width: 65mm;
            margin: 0px auto;
        }
        #main .topDiv
        {
            padding-top: 5mm;
            height: 10mm;
            font-size: 1.5em;
            font-weight: bold;
            text-align: center;
        }
        #main .baseDiv
        {
            font-size: 1.3em;
            min-height: 5mm;
            margin-top: 1mm;
        }
        table
        {
            width: 100%;
        }
        #main .detailDiv
        {
            font-size:1.3em;
            min-height: 5mm;
            margin-top: 1mm;
            text-align: center;
        }
        #main .totDiv
        {
            height: 5mm;
            font-size:1.3em;
            margin-top: 1mm;
        }
        #main .payDiv
        {
            min-height: 5mm;
            font-size:1.3em;
            margin-top: 1mm;
        }
       #main .msgDiv
        {
            min-height: 5mm;
            margin-top: 1mm;
            font-size: 1.0em;
            white-space: normal;
            text-align:left;
        }
        ul
        {
            margin-left:-20px;    
        }
        li
        {
            list-style-type:decimal;  
        }
        #main .depDiv
        {
            font-size:1.3em;
            height: 20mm;
            margin-top: 1mm;
        }
    </style>
        <style type="text/css" media="print">
        .noPrint
        {
            display:none;    
        }
    </style>
    <script type="text/javascript" defer="defer">
        function pagePrint()
        {
            try{
                eprint.InitPrint(); 
                eprint.setMarginMeasure(1); 

                eprint.paperSize = "美国标准 Fanfold"; //用户自定义 
                eprint.orientation = 1;
                
                ///eprint.pageHeight = 165.00;
                //eprint.pageWidth = 170.00;
                
                eprint.marginLeft = 5.00;
                //eprint.marginTop = 28.00;
                eprint.marginRight= 5.00;
                //eprint.marginBottom= 1.00;
 
                eprint.header="";
                eprint.footer="";

                if (eprint.defaultPrinterName.length==0)
                {
                    alert("没有设置打印机！")
                }else{
                    eprint.Print(true);     //不出打印对话框直接打印
                    //eprint.Preview();     //打印预览
                }
            }catch(e){
                alert('打印时发生错误，请确认当前电脑上已安装了打印插件！')
            }
            //setTimeout(function(){window.close()},0);
            window.close();

        }
        //自动打印
        function window.onload()
        {
           //pagePrint();
        }
    </script>
</head>
<body>
<object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext style="display:none;"></object>
    <form id="form1" runat="server">
    <div id="main">
        <div class="topDiv">
            上海哎嘟哔婴童用品有限公司<asp:Label ID="lab_depname" runat="server" Text="Label"></asp:Label>
        </div>
        <div class="baseDiv">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="25%">
                        单据号:
                    </td>
                    <td colspan="3" align="left">
                        <asp:Label ID="lab_retail" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        导购:
                    </td>
                    <td align="left">
                        <asp:Label ID="lab_salse" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td width="25%">
                        收银时间:
                    </td>
                    <td align="left">
                        <asp:Label ID="lab_date" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="detailDiv">
            <asp:Repeater ID="rep_list" runat="server">
                <HeaderTemplate>
                    <table>
                        <thead>
                            <tr>
                                <td>
                                货号/名称
                                </td>
                                <td>
                                数量
                                </td>
                                <td>
                                单价
                                </td>
                                <td>
                                金额
                                </td>
                            </tr>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tbody>
                        <tr>
                            <td align="left">
                            <%#Eval("clothingid")%><br/><%#Eval("s_name")%>
                            </td>
                            <td>
                            <%#Eval("nums")%>
                            </td>
                            <td>
                            <%#Eval("s_price")%>
                            </td>
                            <td>
                            <%#Eval("sums")%>
                            </td>
                        </tr>
                    </tbody>
                </ItemTemplate>
                <FooterTemplate>
                    </table></FooterTemplate>
            </asp:Repeater>
        </div>
        <div class="totDiv">
        <table>
            <tr>
                <td width="25%">数量合计:</td>
                <td align="left">
                    <asp:Label ID="lab_nums" runat="server" Text="Label"></asp:Label></td>
                <td width="25%">金额合计:</td>
                <td align="left">
                    <asp:Label ID="lab_pays" runat="server" Text="Label"></asp:Label></td>
            </tr>
        </table>
        </div>
        <div class="payDiv">
            <table>
                <tr>
                    <td width="25%">现金:</td>
                    <td align="left">
                        <asp:Label ID="lab_cash" runat="server" Text="Label"></asp:Label></td>
                    <td>刷卡:</td>
                    <td align="left">
                        <asp:Label ID="lab_card" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td width="25%">抵用:</td>
                    <td align="left">
                        <asp:Label ID="lab_diyong" runat="server" Text="Label"></asp:Label></td>
                    <td width="25%">贵宾卡:</td>
                    <td align="left">
                        <asp:Label ID="lab_vip" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td width="25%">找零:</td>
                    <td align="left">
                        <asp:Label ID="lab_backpay" runat="server" Text="Label"></asp:Label></td>
                    <td width="25%">实收:</td>
                    <td align="left">
                        <asp:Label ID="lab_getpay" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
        </div>
        <div class="msgDiv">
            <ul>
                <li>本店对所销商品质量负责，如发生质量问题三日内可凭 此票退（换）货；如无此票，一律不予退换；</li>
                <li>如无此票，一律不予退换；</li>
                <li>已洗涤、已穿着、遭损坏或经修改、特价商品、无质量 问题的商品一律不退换</li>
            </ul>
        </div>
        <div class="depDiv">
        <table>
            <tr>
                <td width="25%">店铺地址:</td>
                <td align="left">
                    <asp:Label ID="lab_depadd" runat="server" Text="Label"></asp:Label></td>
            </tr>
            <tr>
                <td width="25%">电话:</td>
                <td align="left">
                    <asp:Label ID="lab_dephont" runat="server" Text="Label"></asp:Label></td>
            </tr>
            <tr>
                <td align="center" colspan="2">谢谢惠顾！欢迎再次光临！</td>
            </tr>
        </table>
        </div>
        <div class="noPrint">
        <input type="button" value="打印" onclick="javascript:pagePrint();"/>
        <input type="button" value="预览"  onclick="javascript:eprint.Preview()"/>
        <input type="button" value="关闭" onclick="javascript:window.close();"/>
    </div>
    </div>
        
    </form>
</body>
</html>
