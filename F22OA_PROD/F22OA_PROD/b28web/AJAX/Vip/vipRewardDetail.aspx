<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Vip_vipRewardDetail, App_Web_viprewarddetail.aspx.3005feca" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
                            发放日期
                        </td>
                        <td>
                            赠送积分
                        </td>
                        <td>
                            消费开始日期
                        </td>
                        <td>
                            消费结束日期
                        </td>
                        <td>
                            备注
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
                    <%#Eval("begdate")%>
                </td>
                <td>
                    <%#Eval("enddate")%>
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
                    <td>
                        合计：<asp:Label ID="ncount" runat="server" Text="0"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="vipcentum" runat="server" Text="0"></asp:Label>
                    </td>
                    <td>
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
