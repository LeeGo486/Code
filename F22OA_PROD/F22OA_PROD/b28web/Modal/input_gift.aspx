<%@ page language="C#" autoeventwireup="true" inherits="Modal_input_gift, App_Web_input_gift.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>赠送</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    function KeyDown(){
        with (event){ 
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
    <div style="padding:0 10px;">
           <br />
            <asp:Label ID="Label3" runat="server" Text="款号："></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server" Width="120px" CssClass="input"></asp:TextBox>
            <asp:Label ID="Label5" runat="server" Text="　条码截取："></asp:Label>
            <asp:TextBox ID="TextBox3" runat="server" Width="30px" CssClass="input"></asp:TextBox>
        <div style="text-align: center; padding-top: 10px;">
            <asp:Button ID="Button3" runat="server" Text="确　定" Width="80px" CssClass="btn2"
             OnClick="Button3_Click"
             UseSubmitBehavior="false" />
            <asp:Button ID="Button2" runat="server" Text="关 闭[Esc]" Width="80px" CssClass="btn2"
             UseSubmitBehavior="false"
             OnClientClick="window.close();" />
            </div>
            <asp:Label ForeColor="Red" ID="Label4" runat="server" Text=""></asp:Label>
    </div>
    </form>
</body>
</html>
