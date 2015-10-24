<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Print_pos_sc_Print, App_Web_pos_sc_print.aspx.c366eeb9" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>小票打印</title>
    <style type="text/css">
            body
        {
            font-size: 10px;
        }
        #main
        {
            width: 70mm;
        }
        #main .topDiv
        {
            width: 100%;
            text-align: center;
            font-size: 2.0em;
            font-weight: bold;
        }
        #main .baseDiv
        {
            font-size:1.4em;
            text-align:left;
            margin-top: 5px;
            width: 100%;
        }
        #main .detDiv
        {
            font-size:1.4em;
            margin-top: 5px;
            width: 100%;
        }
        #main .contentDiv
        {
            font-size:1.4em;
            text-align:left;
            margin-top: 5px;
            width: 100%;
        }
        #main .msgDiv
        {
            text-align:center;
            table-layout:fixed;
            white-space:normal;
            font-size: 1.1em;
            margin-top: 5px;
            width: 98%;
        }
        ul
        {
           
        }
        li
        {
            text-align:left;
            font-size:1.1em;
            list-style-type:none;
        }
        h3
        {
            font-size:1.2em;
            font-weight:bold;        
        }
        table
        {
            width:100%    
        }
        </style>
        <style type="text/css" media="print">
            .noPrint
            {
                display:none;        
            }
        </style>
         <script type="text/javascript" defer="defer">
             function pagePrint() {
                 try {
                     eprint.InitPrint();
                     eprint.setMarginMeasure(1);

                     eprint.paperSize = "美国标准 Fanfold"; //用户自定义 
                     eprint.orientation = 1;

                     ///eprint.pageHeight = 165.00;
                     //eprint.pageWidth = 76;

                     //eprint.marginLeft = 0;
                     //eprint.marginTop = 28.00;
                     //eprint.marginRight = 0.00;
                     //eprint.marginBottom= 1.00;

                     eprint.header = "";
                     eprint.footer = "";

                     if (eprint.defaultPrinterName.length == 0) {
                         alert("没有设置打印机！")
                     } else {
                        eprint.Print(true);      //不出打印对话框直接打印
                         //eprint.Preview();     //打印预览
                     }
                 } catch (e) {
                    alert('打印时发生错误，请确认当前电脑上已安装了打印插件！');
                    window.open("../../../Setup/webprint.exe", '', "height=0, width=0, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no");
                 }
                 //setTimeout(function(){window.close()},0);
                 window.close();

             }
             //自动打印
             function window.onload() {
                // pagePrint();
             }
   </script>
</head>
<body>
<object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext style="display:none;"></object>
    <form id="form1" runat="server">
    <div id="main">
        <div class="topDiv">
            <asp:Label ID="lab_tit" runat="server" Text="Label"></asp:Label>
        </div>
        <div class="baseDiv">
            <table>
                <tr>
                    <td>店铺:</td>
                    <td>
                        <asp:Label ID="lab_dep" runat="server" Text="Label"></asp:Label></td>
                    <td>日期:</td>
                    <td>
                        <asp:Label ID="lab_date" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td>单号:</td>
                    <td colspan="3">
                        <asp:Label ID="lab_rid" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td>电话:</td>
                    <td>
                        <asp:Label ID="lab_pho" runat="server" Text="Label"></asp:Label></td>
                    <td>VIP卡号:</td>
                    <td>
                        <asp:Label ID="lab_vip" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td>导购员</td>
                   <td colspan="3">
                       <asp:Label ID="lab_sale" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
        </div>
        <div class="detDiv">
            <asp:Repeater ID="rep_list" runat="server">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <td>款号</td>
                            <td>尺码</td>
                            <td>数量</td>
                            <td>单价</td>
                            <td>折扣</td>
                            <td>结算价</td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tbody>
                        <tr>
                            <td><%#Eval("clothingid")%></td>
                            <td><%#Eval("sizeid")%></td>
                            <td><%#Eval("nums")%></td>
                            <td><%#Eval("s_price")%></td>
                            <td><%# Convert.ToDecimal(Eval("discount")).ToString("#.##")%></td>
                            <td><%#Eval("sums")%></td>
                        </tr>
                    </tbody>
                </ItemTemplate>
                <FooterTemplate>
                        <tfoot>
                            <tr>
                                <td colspan="5" align="right">付款合计</td>
                                <td>
                                    <asp:Label ID="lab_totpay" runat="server" Text="Label"></asp:Label></td>
                            </tr>
                        </tfoot>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <div class="contentDiv">
            <table>
                <tr>
                    <td>应收</td>
                    <td>
                        <asp:Label ID="lab_pay" runat="server" Text="Label"></asp:Label></td>
                    <td>实收</td>
                    <td>
                        <asp:Label ID="lab_give" runat="server" Text="Label"></asp:Label></td>
                    <td>找回金额</td>
                    <td>
                        <asp:Label ID="lab_back" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="2">收款方式</td>
                    <td colspan="4">
                        <asp:Label ID="lab_type" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="2">顾客姓名</td>
                    <td colspan="4">
                        <asp:Label ID="lab_cname" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="2">电话</td>
                    <td colspan="4">
                        <asp:Label ID="lab_cpho" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
        </div>
        <div class="msgDiv">
            <ul>
                <li> &nbsp;&nbsp;&nbsp;&nbsp;请在购买日起计二天内凭本单和完整的吊牌回本店办理换货手续，逾期恕不接受换货，如属人为损坏，本店万分愿提供有偿服务，尽力帮助您将货品修补好。</li>
                <li>成交时间:<asp:Label ID="lab_tt" runat="server" Text="Label"></asp:Label></li>
                <li>特价货品，剪洗水唛对角线一角，不予退换。</li>
                <li></li>
                <li>请顾客确认签名______________</li>
            </ul>
            <br />
            <h3>本品牌统一零售价九折。多谢惠顾，欢迎再次光临</h3>
        </div>
    </div>
    <div class="noPrint">
        <input id="btn_print" type="button" value="打印" onclick="javascript:pagePrint();" />
        <input id="btn_look" type="button" value="关闭" onclick="javascript:window.close();"/>
    </div>
    </form>
</body>
</html>
