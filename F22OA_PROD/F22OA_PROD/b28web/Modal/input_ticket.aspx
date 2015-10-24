<%@ page language="C#" autoeventwireup="true" inherits="b28web_Modal_input_ticket, App_Web_input_ticket.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title><%=TicketType==1 ? "使用现金券" : "使用券收银" %></title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <!--通用 -->

    <script src="../Utility/command.js" type="text/javascript"></script>

    <link href="../Utility/jQuery.f35.grid.css" rel="stylesheet" type="text/css" />

    <script src="../Utility/jquery-1.2.6.min.js" type="text/javascript"></script>

    <script src="../Utility/jquery.hotkeys-0.7.9.min.js" type="text/javascript"></script>

    <script src="../Utility/jQuery.f35.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function () {

            //
            $('#posGrid1').f35grid({
                width: ['150', '80', '100', '80','60', '30'],
                align: ['center', 'center', '', '', 'center','center']
            })

            //选择抵值券
            $("#TextBox1").keydown(function () {
                if (event.keyCode == 13 || event.keyCode == 10) {
                    $("#Button1").click();
                    event.keyCode = 0;
                    event.cancelBubble = true;
                    return false;
                }
            });

            //            $('#Button3').click(function() {
            //                window.returnValue = false;
            //                window.close();
            //                return false;
            //            });

            //选择抵值券
            $("#Button5").val('选择<%=TicketType==1 ? "现金券" : "券" %>[F5]').click(function () {
                var url = 'input_vipticket.aspx?ttype=<%=TicketType%>';
                var m = openModal(url, 450, 350);
                if (m) {
                    $("#TextBox1").val(m);
                    $("#Button1").click();
                }
                return false;
            });
        });

        function KeyDown() {
            with (event) {
                if (keyCode == 113) {//确定
                    document.getElementById('Button2').click();
                    event.keyCode = 0;
                    event.cancelBubble = true;
                    return false;
//                } else if (keyCode == 27) {//ESC返回输入状态
//                    document.getElementById('Button3').click();
//                    event.keyCode = 0;
//                    event.cancelBubble = true;
//                    return false;
                } else if (keyCode == 115) {//清除
                    document.getElementById('Button4').click();
                    event.keyCode = 0;
                    event.cancelBubble = true;
                    return false;
                } else if (keyCode == 116) {//选择抵值券
                    document.getElementById('Button5').click();
                    event.keyCode = 0;
                    event.cancelBubble = true;
                    return false;
                }
            }
        }
        document.onkeydown = KeyDown;

        function checkticket() {
            var chklist = $("input:text[name='chktick']");
            var acc = true;
            if (chklist.length > 0) {
                var accessids = [];
                var errorids = []
                $.each(chklist, function () {
                    if ($(this).val() == "") {
                        alert("请输入验证码再提交！");
                        acc = false;
                        return acc;
                    }
                    if ($(this).attr("attr") == $(this).val()) {
                        accessids.push($(this).attr("id").split('_')[1]);
                    } else {
                        errorids.push($(this).attr("id").split('_')[1]);
                    }
                })

                if (errorids.length > 0) {
                    $("#errorids").val(errorids.join(','));
                    var msg = "以下券号验证不成功，不能在收银使用：\r\n" + errorids.join('\r\n');
                    alert(msg);
                }
                return acc;
            } else {
                return acc;
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div style="padding: 10px;">
        <table style="width: 98%;">
            <tr>
                <td>
                    <div>
                        输入券号：<asp:TextBox ID="TextBox1" runat="server" Width="200px" CssClass="input"></asp:TextBox>
                        <asp:HiddenField ID="errorids" runat="server" Value="" />
                        <asp:Button ID="Button1" runat="server" Text="添加" CssClass="btn2" Width="60px" OnClick="Button1_Click" />
                        <input type="button" id="Button5" runat="server" value='选择券[F5]' style="width: 90px;"
                            class="btn2" />
                    </div>
                    <div style="height: 150px; overflow: auto; padding: 10px 0;">
                        <asp:Repeater ID="rp1" runat="server">
                            <HeaderTemplate>
                                <table cellspacing="0" cellpadding="3" border="0" id="posGrid1">
                                    <thead>
                                        <tr style="text-align: center;">
                                            <td>
                                                券号
                                            </td>
                                            <td>
                                                类型
                                            </td>
                                            <td>
                                                名 称
                                            </td>
                                            <td>
                                                面值￥
                                            </td>
                                            <td>
                                                验证码
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </thead>
                                    <tbody id="DataBody">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Label ID="TicketID" runat="server" Text='<%#Eval("ticketid")%>'></asp:Label>
                                    </td>
                                    <td>
                                        <%#Eval("ttype")%>
                                    </td>
                                    <td>
                                        <%#Eval("tckname")%>
                                    </td>
                                    <td>
                                        <%#Convert.ToDecimal(Eval("sums").ToString()).ToString()%>
                                    </td>
                                    <td><%#getverifycode(Eval("ticketid").ToString(), Eval("verifycode").ToString(), Eval("isverify").ToString(), Eval("vipid").ToString())%></td>
                                    <td>
                                        <asp:ImageButton ID="ImageButton1" ImageUrl="~/b28web/Images/del.gif" runat="server"
                                            CommandName='<%# Eval("ticketid")%>' OnCommand="del_Click" ToolTip="删除" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody></table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="Button2" runat="server" Text="确　定[F2]" CssClass="btn2" 
                        Width="100px" OnClick="Button2_Click" OnClientClick="return checkticket()"/>
                    <asp:Button ID="Button4" runat="server" Text="清　除[F4]" CssClass="btn2" UseSubmitBehavior="False"
                        Width="100px" OnClick="Button4_Click" />
<%--                    <input type="button" id="Button3" runat="server" value="关  闭[Esc]" onclick="window.close()"
                        style="width: 100px;" class="btn2" />
--%>                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
