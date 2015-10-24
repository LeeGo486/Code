<%@ page language="C#" autoeventwireup="true" inherits="b28web_Modal_input_vipticket, App_Web_input_vipticket.aspx.a056ca89" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>选择券</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <link href="../Utility/jQuery.f35.grid.css" rel="stylesheet" type="text/css" />
    <script src="../Utility/jquery-1.2.6.min.js" type="text/javascript"></script>
    <script src="../Utility/jquery.hotkeys-0.7.9.min.js" type="text/javascript"></script>
    <script src="../Utility/jQuery.f35.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $('#posGrid1').f35grid({
                width: ['140', '140', '100'],
                choosebox: { type: 'checkbox' }
            });
            //确定
            $("#Button2").click(function() {
                var rows = $('#posGrid1').f35gridGetRow('.selected');
                var rows = $('#posGrid1').f35gridGetRow('.selected');
                window.returnValue = "" + $('#posGrid1').f35gridGetCol(0, rows) + "";
                window.close();
                return false;
            });
            $('#Button3').click(function() {
                window.returnValue = false;
                window.close();
                return false;
            })
            //
            $(document).bind('keydown', 'f2', function() {
                $('#Button2').click();
                return false;
            });
            $(document).bind('keydown', 'esc', function() {
                $('#Button3').click();
                return false;
            });
        });

    </script>
    </head>
<body>
    <form id="form1" runat="server">
    <div style="padding:10px;">
        <table style="width:98%;">
            <tr>
                <td>
                <div style="height:200px; overflow:auto;padding:10px 0;">
                    <asp:Repeater ID="rp1" runat="server">
                    <HeaderTemplate>
                    <table id="posGrid1">
                        <thead>
                        <tr>
                        <td>券编号</td><td>券名</td><td>￥面值</td>
                        </tr>
                        </thead>
                        <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%#Eval("ticketid")%></td>
                            <td><%#Eval("tckname")%></td>
                            <td><%#Eval("sums")%></td>
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
                <td align="center" >
                    <asp:Button ID="Button2" runat="server" Text="确　定[F2]" CssClass="btn2" 
                        UseSubmitBehavior="False" Width="100px" OnClientClick="return false;" />&nbsp;
                    <asp:Button ID="Button3" runat="server" Text="取消[Esc]" CssClass="btn2"  Width="100px" />
                    <asp:HiddenField ID="ticketid" runat="server" />
                </td>
            </tr>
        </table>
    

    </div>
    </form>
</body>
</html>
