<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Vip_vipAdjust, App_Web_vipadjust.aspx.3005feca" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript">
        $(function () {
            var row = $("#dlbody").find("tr");
            $("#dlbody").find("tr:even").css('background-color', '#F7F6F3');
            $.each(row, function (i, obj) {

                $(obj).click(function () {
                    $("#dlbody").find("tr").css('background-color', '#FFFFFF');
                    $("#dlbody").find("tr:even").css('background-color', '#F7F6F3');
                    $(obj).css("background-color", "#E2DED6");
                });
            });
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Repeater ID="Repeater1" runat="server">
        <HeaderTemplate>
            <table id="dltab" class="dltab" cellpadding="4" cellspacing="0" border="0" width="100%">
                <thead>
                    <tr>
                        <td>
                            调整日期
                        </td>
                        <td>
                            调整积分
                        </td>
                        <td>
                            调整储值
                        </td>
                        <td>
                            调整类型
                        </td>
                        <td>
                            说明
                        </td>
                    </tr>
                </thead>
                <tbody id="dlbody">
        </HeaderTemplate>
        <ItemTemplate>
            <tr style="text-align: center;">
                <td>
                    <%#Eval("suredate")%>
                </td>
                <td>
                    <%#Eval("centum")%>
                </td>
                <td>
                    <%#Eval("sums")%>
                </td>
                 <td>
                    <%#Eval("d_type")%>
                </td>
                <td>
                    <%#Eval("comment")%>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </tbody>
            <tfoot>
                <tr>
                    <td><b>合计：</b><asp:Label ID="ncount" runat="server" Text="0"></asp:Label>
                    </td>
                    <td> <asp:Label ID="vipcentum" runat="server" Text="0"></asp:Label>
                    </td>
                    <td><asp:Label ID="vipcz" runat="server" Text="0"></asp:Label>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
            </tfoot>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    </form>
</body>
</html>
