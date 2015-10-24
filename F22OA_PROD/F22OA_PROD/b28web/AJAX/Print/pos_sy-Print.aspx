<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Print_pos_sy_Print, App_Web_pos_sy-print.aspx.c366eeb9" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
       <title>小票</title>
    <style type="text/css">
        body
        {
            margin:0px;
            font-size:5px;	
        }
        #mainContent
        {
        	margin:0px auto;
        	width:56mm;
        	min-height:10mm;
        }
        #mainContent .top
        {
        	font-weight:bold;
        	text-align:center;
        	width:100%;
        	font-size:2.5em;
        	height:10mm;
        	margin-bottom:3px;
        }
        #mainContent .base
        {
        	width:100%;
        	font-size:1.5em;
        }
        #mainContent .detail
        {
        	width:100%;
        	font-size:1.2em;
        }
        #mainContent .totle
        {
        	white-space:pre;
        	width:100%;
        	font-size:1.5em;
        }
        #mainContent .commom
        {
            width:100%;
            font-size:1.5em;
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
            try{
                eprint.InitPrint(); 
                eprint.setMarginMeasure(1); 

                eprint.paperSize = "美国标准 Fanfold"; //用户自定义 
                eprint.orientation = 1;
                
                ///eprint.pageHeight = 165.00;
                //eprint.pageWidth = 170.00;
                
                //eprint.marginLeft = 18.00;
                //eprint.marginTop = 28.00;
                //eprint.marginRight= 1.00;
                //eprint.marginBottom= 1.00;
 
                eprint.header="";
                eprint.footer="";

                if (eprint.defaultPrinterName.length==0)
                {
                    alert("没有设置打印机！")
                }else{
                   eprint.Print(true);     //不出打印对话框直接打印
                  // eprint.Preview();     //打印预览
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
           pagePrint();
        }
    </script>
</head>
<body>
<object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext style="display:none;"></object>
    <form id="form1" runat="server">
    <div id="mainContent">
        <div class="top">
            <asp:Literal ID="lit_header" runat="server"></asp:Literal>
        </div>
        <div class="base">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>地址:</td>
                    <td colspan="3">
                        <asp:Literal ID="lit_add" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                   <td >电话：</td><td>
                       <b> <asp:Literal ID="lit_phone" runat="server"></asp:Literal></b></td>
                    <td >店号：</td><td >
                        <asp:Literal ID="lit_depotid" runat="server"></asp:Literal></td>
                       
                </tr>
                <tr>
                    <td >流水号：</td>
                    <td><asp:Literal ID="lit_retailid" runat="server"></asp:Literal></td>
                    <td >日期:</td><td>
                        <asp:Literal ID="lit_date" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td>售货员：</td>
                    <td><asp:Literal ID="lit_saler" runat="server"></asp:Literal></td> 
                    <td>收银员：</td>
                    <td>
                        <b><asp:Literal ID="lit_suser" runat="server"></asp:Literal></b></td>
                </tr>
                <tr>
                    <td>VIP卡：</td>
                    <td colspan="3">
                        <asp:Literal ID="lit_vipcode" runat="server"></asp:Literal></td>
                </tr>
            </table>
        </div>
        <div class="detail">
            <asp:Repeater ID="rep_detail" runat="server">
                <HeaderTemplate>
                    <table border="0" cellpadding="1" cellspacing="1">
                    <tr>
                        <td colspan="6"><hr size="1"/></td>
                    </tr>
                        <tr>
                            <td width="31%">货品</td>
                            <td width="16%">货品名称</td>
                            <td width="14%">单价</td>
                            <td width="13%">折扣</td>
                            <td width="11%">数量</td>
                            <td width="15%">金额</td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td width="31%"><%#Eval("clothingid") %></td>
                        <td width="16%"><%#Eval("s_name") %></td>
                        <td width="12%"><%#Convert.ToInt32( Eval("x_price")) %></td>
                        <td width="13%"><%#GetString(Convert.ToDecimal(Eval("discount")))%></td>
                        <td width="11%"><%#Convert.ToInt32( Eval("nums")) %></td>
                        <td width="15%"><%#Convert.ToInt32(Eval("sums"))%></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                     <tr>
                        <td colspan="6">
                    <hr size="1"/>
                        </td>
                    </tr>
                    </talbe>
                </FooterTemplate>
            </asp:Repeater>
          </div>
        <div class="totle">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                  <td colspan="2" width="50%"><asp:Literal ID="lit_sums" runat="server"></asp:Literal></td>
                   <td colspan="2" width="50%"><asp:Literal ID="lit_sumPrice" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td colspan="2" width="50%"><asp:Literal ID="lit_pay" runat="server"></asp:Literal></td>
                     <td colspan="2" width="50%"><asp:Literal ID="lit_re" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td width="40%">收款方式：</td>
                    <td colspan="3" width="60%" align ="left"><asp:Literal ID="lit_payType" runat="server"></asp:Literal></td>
                </tr>
             
            </table>
            
        </div>
        <div class="commom">
           <table  border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td><div align="center"><b>谢谢惠顾  再次光临<br />Thank You And Please Come Again 
</b></div></td>
                </tr>
                </table>
        </div>
        <div class="NoPrint">
            <input id="btn_print" type="button" value="打印" />
            <input id="btn_close" type="button" value="关闭" onclick="javascript:window.close();" />
        </div>
    </div>
    </form>
</body>
</html>

