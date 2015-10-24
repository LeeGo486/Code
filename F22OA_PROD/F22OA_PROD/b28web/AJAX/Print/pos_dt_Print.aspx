<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Print_pos_dt_Print, App_Web_pos_dt_print.aspx.c366eeb9" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>打印小票</title>
    <style type="text/css">
        body
        {
            margin:0px;
            padding:0px;
            font-size:10.0px;
        }
        #main
        {
            margin:0px auto;
            padding:0px;
            width:68mm;
            min-height:10mm;
        }
        #main .topDiv
        {
            text-align:center;
            width:100%;
            height:15mm;
            padding-top:2mm;
        }
        #main .topDiv span
        {
            font-size:1.5em;
            font-weight:bold;    
        }
        #main .contentDiv
        {
            width:100%;
            min-height:5mm;
        }
        #main .bomDiv
        {
            width:100%;
            min-height:5mm;
        }
        #main .bomDiv table
        {
            width:100%;
            text-align:center;   
         }
        #main .bsDiv
        {
            min-height:10mm;
            width:100%;
        }
        #main .reDiv
        {
            text-align:center;    
        }
    </style>
    <style type="text/css" media="print">
        .NoPrint
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

                 eprint.pageHeight = 165.00;
                 eprint.pageWidth = 170.00;

                 eprint.marginLeft = 18.00;
                 eprint.marginTop = 28.00;
                 eprint.marginRight= 1.00;
                 eprint.marginBottom= 1.00;

                 eprint.header = "";
                 eprint.footer = "";

                 if (eprint.defaultPrinterName.length == 0) {
                     alert("没有设置打印机！")
                 } else {
                     eprint.Print(true);     //不出打印对话框直接打印
                      //eprint.Preview();     //打印预览
                 }
             } catch (e) {
                 alert('打印时发生错误，请确认当前电脑上已安装了打印插件！')
             }
             //setTimeout(function(){window.close()},0);
             window.close();

         }
         //自动打印
         function window.onload() {
             pagePrint();
         }
    </script>
</head>
<body>
<object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext style="display:none;"></object>
    <div id="main">
        <div class="topDiv">
            <asp:Label ID="lab_header" runat="server" Text="Label"></asp:Label>
        </div>
        <div class="contentDiv">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="20%">单号：</td>
                    <td colspan="3"  width="80%">
                        <asp:Label ID="lab_retailid" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td  width="20%">店名:</td>
                    <td  width="30%">
                        <asp:Label ID="lab_dname" runat="server" Text="Label"></asp:Label></td>
                    <td  width="20%">VIP卡号:</td>
                    <td width="30%">
                        <asp:Label ID="lab_vipcode" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td  width="20%">日期:</td>
                    <td  width="30%">
                        <asp:Label ID="lab_data" runat="server" Text="Label"></asp:Label></td>
                    <td  width="20%">时间:</td>
                    <td  width="30%">
                        <asp:Label ID="lab_time" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
        </div>
        <div class="bomDiv">
            <asp:Repeater ID="rep_list" runat="server">
                <HeaderTemplate>
                    <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>货号</td>
                        <td>款名</td>
                        <td>数量</td>
                        <td>吊牌价</td>
                        <td>折扣</td>
                        <td>折后价</td>
                    </tr>
                    <tr>
                        <td colspan="6"><hr /></td>
                    </tr>
                </HeaderTemplate>
                <ItemTemplate><tr>
                        <td><%#Eval("s_name") %></td>
                        <td><%#Eval("clothingid") %></td>
                        <td><%#Eval("nums") %></td>
                        <td><%#Eval("x_price") %></td>
                        <td><%#Decimal.Round(Convert.ToDecimal(Eval("discount")), 1)%></td>
                        <td><%#Eval("sums") %></td>
                    </tr></ItemTemplate>
                <FooterTemplate></table></FooterTemplate>
            </asp:Repeater>
        </div>
        <div class="bsDiv">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="4"><hr /></td>
                </tr>
                <tr>
                    <td  width="20%">总件数：</td>
                    <td  width="30%">
                        <asp:Label ID="lab_totcount" runat="server" Text="Label"></asp:Label></td>
                    <td width="20%">总金额:</td>
                    <td width="30%">
                        <asp:Label ID="lab_totprice" runat="server" Text="Label"></asp:Label></td>    
                </tr>
                <tr>
                    <td width="20%">收款总数:</td>
                    <td width="30%">
                        <asp:Label ID="lab_Price" runat="server" Text="Label"></asp:Label></td>
                    <td width="20%">找回金额:</td>
                    <td width="30%">
                        <asp:Label ID="lab_backprice" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td width="20%">收款方式</td>
                    <td width="30%">
                        <asp:Label ID="lab_type" runat="server" Text="Label"></asp:Label></td>
                    <td width="20%">营业员:</td>
                    <td width="30%">
                        <asp:Label ID="lab_user" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
        </div>
        <div  class="reDiv">
            <b>谢谢惠顾 请再光临<br />
            Thank You And Please Come Again<br />
                www.donoratico.net.cn</b>
        </div>
         <div class="NoPrint">
            <input id="btn_print" type="button" value="打印" />
            <input id="btn_close" type="button" value="关闭" onclick="javascript:window.close();" />
        </div>
    </div>
    </form>
</body>
</html>
