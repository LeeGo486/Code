<%@ page language="C#" autoeventwireup="true" inherits="b28web_Modal_IsCash_Records, App_Web_iscash_records.aspx.a056ca89" enableviewstatemac="false" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>选择 已刷卡记录</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <link href="../Utility/jQuery.f35.grid.css" rel="stylesheet" type="text/css" />
    <script src="../Utility/jquery-1.2.6.min.js" type="text/javascript"></script>
    <script src="../Utility/jquery.hotkeys-0.7.9.min.js" type="text/javascript"></script>
    <script src="../Utility/jQuery.f35.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {

            $('#posGrid1').f35grid({
                width: ['80', '140', '120', '80', '80'],
                choosebox: { type: 'checkbox' },
                rowDblClick: rowdblClick
            })

            $("#posGrid1 tr").click(function () {
                $(this).addClass("selected").siblings().removeClass("selected");
            });

            $("#posGrid1 thead tr td:first span").remove();
            //确定
            $("#Button2").click(function () {
                var rows = $('#posGrid1').f35gridGetRow('.selected');
                if (rows.length > 1) { alert('只能选择一条记录!'); return false; }
                var logid = $('#posGrid1').f35gridGetCol(0, rows);
                returnValue = logid;
                window.close();
            });

        });

        function rowdblClick() {
            $('#Button2').click();
        }

        function KeyDown() {
            with (event) {
                if (keyCode == 113) {//确定
                    document.getElementById('Button2').click();
                    event.keyCode = 0;
                    event.cancelBubble = true;
                    return false;
                }
                if (keyCode == 27) {//ESC返回输入状态
                    document.getElementById('Button3').click();
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
        <table style="width:98%;">
            <tr>
                <td>
                <div style="height:240px; overflow:auto;padding:10px 0;">
                    <asp:Repeater ID="rp1" runat="server" EnableViewState="false">
                    <HeaderTemplate>
                        <table id="posGrid1">
                        <thead>
                            <tr><td>流水号</td><td>消费时间</td><td>银行卡号</td><td>金额</td><td>检索号</td></tr>
                        </thead>
                        <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%#Eval("logid")%></td>
                            <td><%#Eval("crdate")%></td>
                            <td><%#Eval("cardid")%></td>
                            <td><%#Eval("sums")%></td>
                            <td><%#Eval("sn")%></td>
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
                    <asp:Button ID="Button3" runat="server" Text="取消[Esc]" CssClass="btn2" 
                     OnClientClick="window.close()"
                        UseSubmitBehavior="False" Width="100px" />
                </td>
            </tr>
        </table>
    

    </div>
    </form>
</body>
</html>