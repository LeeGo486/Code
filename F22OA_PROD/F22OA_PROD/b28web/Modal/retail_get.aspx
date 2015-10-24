<%@ page language="C#" autoeventwireup="true" inherits="Retail_Modal_retail_get, App_Web_retail_get.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>挂单取单</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body
        {
            margin: 0;
            padding: 0;
        }
    </style>

    <script type="text/javascript">

        window.returnValue = 0;

        function qd(retailid) {
            window.returnValue = retailid;
            window.close();
        }
        //    
        //    function window.onload(){
        //        var t = document.getElementById("HiddenField1");
        //        var Y = t.value;
        //        if(Y){Y = Y.replace("px","")}
        //        var n = (parseFloat(Y)+160)+"px";
        //        window.dialogHeight = n;
        //    }

        function KeyDown() {
            with (event) {
                if (keyCode == 27) {//ESC返回输入状态
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
    <div style="padding: 10px;">
        <fieldset>
            <legend>
                <h3>
                    取单</h3>
            </legend>
            <div style="text-align: center;">
                <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                    <HeaderTemplate>
                        <table width="100%" cellspacing="1" cellpadding="3">
                            <tr style="background: #036; color: White;">
                                <td align="center" width="220">
                                    <b>单号</b>
                                </td>
                                <td align="center">
                                    <b>说明</b>
                                </td>
                                <td align="center" width="60">
                                    <b>取单</b>
                                </td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td align="center">
                                <asp:Label ID="retailid" runat="server" Text='<%# Eval("retailid") %>'></asp:Label>
                            </td>
                            <td align="center">
                                <%# Eval("intra")%>
                            </td>
                            <td align="center">
                                <asp:LinkButton ID="qd" runat="server" CommandName="Repeater1_ItemCommand" 
                                OnClientClick="return confirm('取单操作会替换收银界面现有的数据\n确定要取单吗？')">取单</asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:HiddenField ID="HiddenField1" runat="server" />
            </div>
        </fieldset>
        <fieldset>
            <legend>
                <h3>
                    挂单</h3>
            </legend>
            <div style="text-align: left; padding: 0 10px 20px 20px;">
                <p>
                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                </p>
                <p>
                    <asp:Label ID="Label2" runat="server" Text="挂单说明："></asp:Label>
                    <asp:TextBox ID="TextBox1" runat="server" Width="200px" CssClass="input"></asp:TextBox>
                    <asp:Button ID="Button1" runat="server" Text="确　定" CssClass="btn2" OnClick="Button1_Click"
                        UseSubmitBehavior="false" />
                    <asp:Button ID="Button2" runat="server" Text="取消[Esc]" CssClass="btn2" OnClientClick="window.close()"
                        UseSubmitBehavior="false" />
                </p>
            </div>
        </fieldset>
    </div>
    </form>
</body>
</html>
