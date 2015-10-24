<%@ page language="C#" autoeventwireup="true" inherits="Modal_retail_gift, App_Web_retail_gift.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>确认促销赠品</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">

    function KeyDown(){
        with (event){ 
            if(keyCode==116){//F5键确定
                document.getElementById('Button5').click();
                event.keyCode = 0; 
                event.cancelBubble = true; 
                return false;
            }
            
            if(keyCode==27){//ESC返回输入状态
                document.getElementById('Button2').click();
                event.keyCode = 0; 
                event.cancelBubble = true; 
                return false;
            }
        }
    }
    document.onkeydown = KeyDown;
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding:10px;">
                    <div>
                    <p style="line-height:30px; text-align:center;">
                    <asp:Label ID="Label7" runat="server" Text="当前销售单待赠品列表" Font-Bold="true"></asp:Label>
                    </p>
                    <div style="margin: 10px 0 0 0; text-align: center; overflow: auto; height: 200px;">
                        <asp:Repeater ID="Repeater1" runat="server">
                            <HeaderTemplate>
                                <table width="95%" cellspacing="1" cellpadding="3">
                                    <tr>
                                         <td align="center">
                                            <b>款号</b>
                                        </td>
                                        <td align="center">
                                            <b>颜色</b>
                                        </td>
                                        <td align="center">
                                            <b>原价</b>
                                        </td>
                                        <td align="center">
                                            <b>现价</b>
                                        </td>
                                        <td align="center">
                                            <b>折扣</b>
                                        </td>
                                        <td align="center">
                                            <b>结算价</b>
                                        </td>
                                     </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="styleid" runat="server" Text='<%#Eval("styleid")%>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <%#Eval("colorid")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("j_price")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("x_price")%>
                                    </td>
                                    <td align="center">
                                        <%# Eval("rate")%>
                                    </td>
                                    <td align="center">
                                        <%# Eval("s_price")%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                    <div style="text-align:center;">
                        <asp:Label ID="Label8" runat="server" Text="赠送款号："></asp:Label>
                        <asp:TextBox ID="TextBox6" runat="server" Width="117px" CssClass="input" 
                            ontextchanged="TextBox6_TextChanged"></asp:TextBox>
                            &nbsp;
                        <asp:Button ID="Button5" runat="server" Text="确　定[F5]" CssClass="btn2" 
                         UseSubmitBehavior="false"
                            onclick="Button5_Click"/>
                        <asp:Button ID="Button2" runat="server" Text="取　消[Esc]" CssClass="btn2"
                         UseSubmitBehavior="false"
                         OnClientClick="window.close();" />
                   </div>
                    <p style="line-height:30px; text-align:center;">
                    <asp:Label ID="Label2" runat="server" Text="已选赠品列表" Font-Bold="true"></asp:Label>
                        <asp:Label ID="Label3" runat="server" Text="　　　可赠送数量：" ForeColor="Red"></asp:Label>
                        <asp:Label ID="Label1" runat="server" Text="0" ForeColor="Red"></asp:Label>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                    </p>
                         <asp:Repeater ID="Repeater2" runat="server">
                            <HeaderTemplate>
                                <table width="95%" cellspacing="1" cellpadding="3">
                                    <tr>
                                         <td align="center">
                                            <b>款号</b>
                                        </td>
                                        <td align="center">
                                            <b>颜色</b>
                                        </td>
                                        <td align="center">
                                            <b>尺码</b>
                                        </td>
                                        <td align="center">
                                            <b>原价</b>
                                        </td>
                                        <td align="center">
                                            <b>现价</b>
                                        </td>
                                        <td align="center">
                                            <b>折扣</b>
                                        </td>
                                        <td align="center">
                                            <b>结算价</b>
                                        </td>
                                        <td align="center">
                                            <b>数量</b>
                                        </td>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="styleid" runat="server" Text='<%#Eval("styleid")%>'></asp:Label>
                                        <asp:HiddenField ID="clothingid" runat="server" Value='<%#Eval("clothingid")%>' />
                                    </td>
                                    <td align="center">
                                        <%#Eval("colorid")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("sizeid")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("j_price")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("x_price")%>
                                    </td>
                                    <td align="center">
                                        <%# Decimal.Round(Decimal.Parse(Eval("discount").ToString()), 6) %>
                                    </td>
                                    <td align="center">
                                        <%# Eval("s_price")%>
                                    </td>
                                    <td align="center">
                                         <%# Eval("nums")%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>

                   
                   
                   
                   
                </div>
    </form>
</body>
</html>
