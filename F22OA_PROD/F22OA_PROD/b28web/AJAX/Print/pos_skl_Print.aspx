<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Print_pos_skl_Print, App_Web_pos_skl_print.aspx.c366eeb9" %>

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
            table-layout:fixed;
            white-space:normal;
            font-size: 1.1em;
            margin-top: 5px;
            width: 98%;
        }
        img
        {
            border:none 0px inherit;
            width:150px;
            height:70px;    
        }
        ul{}
        li
        {
            font-size:1.1em;
            list-style-type:decimal;
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

               //eprint.marginLeft = 5;
               //eprint.marginTop = 28.00;
               //eprint.marginRight= 3.00;
               //eprint.marginBottom= 1.00;

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
    <form id="form1" runat="server">
    <div id="main">
        <div class="topDiv">
            <img src="images/logo1.png"/><br />
            <asp:Label ID="lab_head" runat="server" Text="Label"></asp:Label>
        </div>
        <div class="baseDiv">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td  width="15%">
                        单号：
                    </td>
                    <td colspan="3"width="85%">
                        <asp:Label ID="lab_rid" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td  width="15%">
                        日期：
                    </td>
                    <td  width="35%">
                        <asp:Label ID="lab_date" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td  width="15%">
                        VIP卡：
                    </td>
                    <td  width="35%">
                        <asp:Label ID="lab_vip" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="detDiv">
            <asp:Repeater ID="rep_list" runat="server">
                <HeaderTemplate>
                    <table width="90%" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <td>
                                    款号
                                </td>
                                <td>
                                    颜色
                                </td>
                                <td>
                                    尺码
                                </td>
                                <td>
                                    数量
                                </td>
                                <td>
                                    零售价
                                </td>
                                <td>
                                    结算价
                                </td>
                            </tr>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tbody>
                        <tr>
                            <td>
                                <%#Eval("styleid")%>
                            </td>
                            <td>
                                <%#Eval("c_name") %>
                            </td>
                            <td>
                                <%#Eval("s_name") %>
                            </td>
                            <td>
                                <%#Eval("nums") %>
                            </td>
                            <td>
                                <%#Eval("x_price")%>
                            </td>
                            <td>
                                <%#Eval("s_price") %>
                            </td>
                        </tr>
                    </tbody>
                </ItemTemplate>
                <FooterTemplate>
                    <tfoot>
                        <tr>
                            <td colspan="4">
                                总计：
                            </td>
                            <td>
                                <asp:Label ID="lab_txp" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lab_tsp" runat="server" Text="Label"></asp:Label>
                            </td>
                        </tr>
                    </tfoot>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <div class="contentDiv">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="20%">
                        支付：
                    </td>
                    <td width="30%">
                        <asp:Label ID="lab_price" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td width="20%">
                        找零：
                    </td>
                    <td width="30%">
                        <asp:Label ID="lab_back" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="25%" >
                        收款方式：
                    </td>
                    <td width="75%" colspan="3">
                        <asp:Label ID="lab_type" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        收款员：
                    </td>
                    <td width="75%" colspan="3">
                        <asp:Label ID="lab_user" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="msgDiv">
           注：
           <ul>
           <li>本店售出货品，如有质量问题，必须凭此单半月内调换。</li>
           <li>换货品必须7天内进行，已使用或遭损毁或经修改的货品，恕不退换。</li>
           <li>本店保留鉴定货品是否有上述情况出现的权利。</li>
           <li>货品售出，恕不退款。</li>
           </ul>
           <br />
           <br /><br /><br /><br />
        </div>
    </div>
    </form>
</body>
</html>
