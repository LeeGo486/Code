<%@ page language="C#" autoeventwireup="true" inherits="Retail_Modal_retail_save, App_Web_retail_save.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>收银挂单</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        //window.returnValue=0;
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
        <asp:Label ID="Label1" runat="server" Text="挂单说明："></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server" Width="200px" CssClass="input"></asp:TextBox><br /><br />
        <asp:Button ID="Button1" runat="server" Text="确　定" CssClass="btn2"
         onclick="Button1_Click" UseSubmitBehavior="false" />
        <asp:Button ID="Button2" runat="server" Text="取消[Esc]"  CssClass="btn2"
            onclientclick="window.close()" UseSubmitBehavior="false" />
    </div>
    </div>
    </form>
</body>
</html>
