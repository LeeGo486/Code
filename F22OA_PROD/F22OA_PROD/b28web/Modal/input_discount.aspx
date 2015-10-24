<%@ page language="C#" autoeventwireup="true" inherits="Modal_input_discount, App_Web_input_discount.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>整单打折</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        window.returnValue=0;
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
    <div>
    <div style="padding:20px;text-align:center;">

        <asp:Label ID="Label1" runat="server" Text="输入折扣："></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server" Width="40px" Text="1" CssClass="input"></asp:TextBox>
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:Button ID="Button1" runat="server" Text="确　定" onclick="Button1_Click"
         CssClass="btn2" UseSubmitBehavior="false" />
        <asp:Button ID="Button2" runat="server" Text="取消[Esc]" UseSubmitBehavior="false" 
            onclientclick="window.close()"   CssClass="btn2"/>
    </div>
    </div>
    </form>
</body>
</html>
