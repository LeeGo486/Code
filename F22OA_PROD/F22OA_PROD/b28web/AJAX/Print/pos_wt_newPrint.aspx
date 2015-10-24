<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Print_wt_Print_pos_wt_newPrint, App_Web_pos_wt_newprint.aspx.c366eeb9" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>威特小票</title>
    <style type="text/css">
        body
        {
            margin:0px;
            font-size:10px;	
        }
        #mainContent
        {
        	margin:0px auto;
        	width:62mm;
        	min-height:100mm;
        }
        #mainContent .top
        {
        	font-weight:bold;
        	text-align:center;
        	width:100%;
        	font-size:3em;
        	height:10mm;
        }
        #mainContent .base
        {
        	width:100%;
        	font-size:1.0em;
        	min-height:13mm;
        }
        #mainContent .detail
        {
        	width:100%;
        	font-size:1.1em;
        	min-height:30mm;
        }
        #mainContent .totle
        {
        	white-space:pre;
        	width:100%;
        	font-size:1.1em;
        	min-width:30mm;
        }
        #mainContent .commom
        {
            width:100%;
            font-size:1.5em;
            min-height:28mm;
        }
        #mainContent .NoPrint
        {
        	text-align:center;
        	width:100%;
        	height:15mm;
        }
    </style>
    <style type="text/css" media="print">
        .NoPrint
        {
            display:none;	   
        }
    </style>
     <script type="text/javascript" defer="defer">
        function pagePrint()
        {
            var printcopies='<%=printcount%>';
            try{
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
 
                eprint.header="";
                eprint.footer="";
               
                if (eprint.defaultPrinterName.length==0)
                {
                    alert("没有设置打印机！")
                }
                else
                {
                   for (i = 0; i < printcopies; i++)
                   {
                     eprint.Print(true); //不出打印对话框直接打印
                   }
                   //eprint.Preview();     //打印预览
                }
            }catch(e){
                alert('打印时发生错误，请确认当前电脑上已安装了打印插件！')
            }
            setTimeout(function(){window.close()},0);

        }
        //自动打印
        function window.onload()
        {
            pagePrint();
        }
    </script>
</head>
<body>
<object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext style="display:none;"></object>
    <form id="form1" runat="server">
    <div id="mainContent">
        <div class="top">
            POLO  VILLAE
        </div>
        <div class="base">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>单号：</td>
                    <td colspan="3">
                        <asp:Literal ID="lit_retailid" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td>店铺名称：</td>
                    <td>
                        <asp:Literal ID="lit_depotName" runat="server"></asp:Literal></td>
                    <td>VIP卡号：</td>
                    <td>
                        <asp:Literal ID="lit_vipCode" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td>日期：</td>
                    <td>
                        <asp:Literal ID="lit_date" runat="server"></asp:Literal></td>
                    <td>打印</td>
                    <td>
                        <asp:Literal ID="lit_printTime" runat="server"></asp:Literal></td>
                </tr>
            </table>
        </div>
        <div class="detail">
            <asp:Repeater ID="rep_detail" runat="server">
                <HeaderTemplate>
                    <table border="0" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <td width="31%">货号</td>
                                <td width="16%">颜色</td>
                                <td width="12%">尺码</td>
                                <td width="13%">数量</td>
                                <td width="14%">零售价</td>
                                <td width="14%">结算价</td>
                            </tr>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tbody>
                        <tr>
                            <td width="31%"><%#Eval("styleid") %></td>
                            <td width="16%"><%#Eval("colorid") %></td>
                            <td width="12%"><%#Eval("sizeid") %></td>
                            <td width="13%"><%#Eval("nums") %></td>
                            <td width="14%"><%#Convert.ToInt32( Eval("x_price")) %></td>
                            <td width="14%"><%#Convert.ToInt32( Eval("s_price")) %></td>
                        </tr>
                    </tbody>
                </ItemTemplate>
                <FooterTemplate>
                        <tr>
                    <td width="59%" colspan="3" style="text-align:center; ">总计</td>
                    <td width="13%"><%=snums %></td>
                    <td width="14%"><%=sxprice %></td>
                    <td width="14%"><%=ssprice %></td>
                </tr>
                    </talbe>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <div class="totle">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>支付：</td>
                    <td><asp:Literal ID="lit_pay" runat="server"></asp:Literal></td>
                     <td>找零：</td>
                     <td><asp:Literal ID="lit_re" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td>营业员：</td>
                    <td colspan="3"><asp:Literal ID="lit_saler" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td>收款方式：</td>
                    <td colspan="3"><asp:Literal ID="lit_payType" runat="server"></asp:Literal></td>
                </tr>
             
            </table>
            
        </div>
        <div class="commom">
            <table border="0" align="center" cellpadding="0" cellspacing="0">
                <tr align="center" >
                    <td><font class=f1>**** 多谢惠顾 ****</font></td></tr>
                <tr><td><br></td></tr>
                <tr height="50">
                <td align="left">
                    &nbsp;&nbsp;&nbsp;&nbsp;注：至购买日起7日内如出现质量问题凭小票给予调换，特价商品除外。<br>
                <td align="center">&nbsp;</td>
                </tr></table>
        </div>
        <div class="NoPrint">
            <input id="btn_print" type="button" value="打印" />
            <input id="btn_close" type="button" value="关闭" onclick="javascript:window.close();" />
        </div>
    </div>
    </form>
</body>
</html>
