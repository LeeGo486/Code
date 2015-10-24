<%@ page language="C#" autoeventwireup="true" inherits="Modal_retail_backsub, App_Web_retail_backsub.aspx.a056ca89" enableviewstatemac="false" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>退换货</title>
    <base target="_self" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <script src="../Utility/command.js" type="text/javascript"></script>
    <script src="../Utility/jquery-1.2.6.min.js" type="text/javascript"></script>
    <style type="text/css">
        table{
            background:#ccc;
        }
        table tr {
            background:#fff;
        }
    </style>
    <script type="text/javascript">
    //手工输入
    $(function(){
//        $("#Button1").click(function(){
//        var sm = openModal('../Modal/input_clothing.aspx?zs=0&back=0&act=rt',500,450);
//            if(sm){
//                var tb = document.getElementById('TextBox5');
//                tb.value = sm;
//                $("#Button6").click();
//            }
//        });
        $("#TextBox5").keydown(function(){
            if(event.keyCode==13||event.keyCode==10){
            $("#Button6").click();
                event.keyCode = 0; 
                event.cancelBubble = true; 
                return false;
            }
        });
    });
    function KeyDown(){
        with (event){ 
            if(keyCode==116){//F5键确定
                document.getElementById('Button5').click();
                event.keyCode = 0; 
                event.cancelBubble = true; 
                return false;
            }
//            if(keyCode==121){//F10键确定
//                document.getElementById('Button1').click();
//                event.keyCode = 0; 
//                event.cancelBubble = true; 
//                return false;
//            }
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
                        <asp:Label ID="Label6" runat="server" Text="退换货款号：" ></asp:Label>
                        <asp:TextBox ID="TextBox5" runat="server" Width="250px" CssClass="input"></asp:TextBox>
                         <asp:RadioButton ID="RadioButton1" runat="server" GroupName="th" Text="退进款号" Checked="true" />
                        <asp:RadioButton ID="RadioButton2" runat="server" GroupName="th"  Text="换走款号"/>
                        <span style="display:none">
                        <asp:Button ID="Button6" runat="server" Text="确定" CssClass="btn2"
                            UseSubmitBehavior="false" onclick="Button6_Click"  /></span>
<%--                        <input id="Button1" type="button" value="手工录入[F10]" class="btn2" />--%>
                    </div>
                    <asp:HiddenField ID="oldretailid" runat="server" />
                    <asp:Label ID="Label7" runat="server" Text="" ForeColor="Red"></asp:Label>
                    <div style="margin: 10px 0 0 0; text-align: center; overflow: auto; height: 200px;">
                        <asp:Repeater ID="Repeater1" runat="server">
                            <HeaderTemplate>
                                <table width="98%" cellspacing="1" cellpadding="3">
                                    <tr>
                                         <td align="center">
                                            <b>款式编号</b>
                                        </td>
                                        <td align="center">
                                            <b>颜色</b>
                                        </td>
                                        <td align="center">
                                            <b>尺码</b>
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
                                         <td align="center">
                                            <b style="color:red;">已退数量</b>
                                        </td>
                                        <td align="center">
                                            <b style="color:Blue;">退换数量</b>
                                        </td>
                                        <td align="center">
                                            <b>现价总额</b>
                                        </td>
                                        <td align="center">
                                            <b>结算总额</b>
                                        </td>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr style="background:<%# i2s(Int32.Parse(Eval("br").ToString()))%>">
                                    <td align="center">
                                        <asp:Label ID="styleid" runat="server" Text='<%#Eval("styleid")%>'></asp:Label>
                                        <asp:HiddenField ID="clothingid" runat="server" Value='<%#Eval("clothingid")%>' />
                                        <asp:HiddenField ID="boxid" runat="server" Value='<%#Eval("boxid")%>' />
                                    </td>
                                    <td align="center">
                                        <%#Eval("colorid")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("sizeid")%>
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
                                        <%# (System.Math.Abs(Decimal.Parse(Eval("nums").ToString()))).ToString()%>
                                    </td>
                                    <td align="center">
                                        <%# (System.Math.Abs(Decimal.Parse(Eval("ret_nums").ToString()))).ToString()%>
                                    </td>
                                    <td align="center">
                                        <%# (System.Math.Abs(Decimal.Parse(Eval("br_nums").ToString()))).ToString()%>
                                    </td>
                                    <td align="center">
                                       <%# (System.Math.Abs(Decimal.Parse(Eval("xsums").ToString()))).ToString()%>
                                    </td>
                                    <td align="center">
                                       <%# (System.Math.Abs(Decimal.Parse(Eval("sums").ToString()))).ToString()%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                    <div style="text-align:center;">
                        <asp:Button ID="Button5" runat="server" Text="确　定[F5]" CssClass="btn2" 
                            onclick="Button5_Click"/>
                        <asp:Button ID="Button2" runat="server" Text="关 闭[Esc]" CssClass="btn2"
                         UseSubmitBehavior="false"
                         OnClientClick="window.close();" />
                         </div>
                </div>
    </form>
</body>
</html>
