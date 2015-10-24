<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Vip_vipDeductible, App_Web_vipdeductible.aspx.3005feca" %>

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
                            销售单号
                        </td>
                        <td>
                            销售日期
                        </td>
                        <td>
                            店铺编号
                        </td>
                        <td>
                            店铺名称
                        </td>
                        <td>
                            VIP卡号
                        </td>
                        <td>
                            抵扣金额
                        </td>
                        <td>
                            抵扣积分
                        </td>
                    </tr>
                </thead>
                <tbody id="dlbody">
        </HeaderTemplate>
        <ItemTemplate>
            <tr style="text-align: center;">
                <td>
                    <%#Eval("retailid")%>
                </td>
                <td>
                    <%#Eval("xsdate")%>
                </td>
                <td>
                    <%#Eval("depotid")%>
                </td>
                <td>
                    <%#Eval("d_name")%>
                </td>
                <td>
                    <%#Eval("vipcode")%>
                </td>
                <td>
                    <%#Eval("dk_price")%>
                </td>
                <td>
                    <%#Eval("dk_centum")%>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </tbody>
            <tfoot>
                <tr>
                    <td>
                        <b>合计：</b>
                    </td>
                    <td>
                        <asp:Label ID="ncount" runat="server" Text="0"></asp:Label>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                        <asp:Label ID="vipsums" runat="server" Text="0"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="vipcentum" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
            </tfoot>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    </form>
</body>
</html>
