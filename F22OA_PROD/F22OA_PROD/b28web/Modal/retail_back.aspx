<%@ page language="C#" autoeventwireup="true" inherits="Modal_retail_back, App_Web_retail_back.aspx.a056ca89" enableviewstatemac="false" enableEventValidation="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>退换货</title>
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
    <div style="padding:10px;">
                    <div>
                        <asp:RadioButton ID="RadioButton1" runat="server" Text="整单退货" 
                            GroupName="thType" Checked="true" />
                        <asp:RadioButton ID="RadioButton2" runat="server" Text="部分退货" 
                            GroupName="thType"/>
                        <asp:RadioButton ID="RadioButton3" runat="server" Text="同款换货" 
                            GroupName="thType" />
                    </div>
                    <div style=" padding-top: 10px;">
                        <asp:Label ID="Label6" runat="server" Text="销售单号："></asp:Label>
                        <asp:TextBox ID="TextBox5" runat="server" Width="220px" CssClass="input"></asp:TextBox>
                    </div>
                    <asp:Label ID="Label7" runat="server" Text="" ForeColor="Red"></asp:Label>
        <div style="text-align: center; padding-top: 10px;">
            <asp:Button ID="Button5" runat="server" Text="确 定" CssClass="btn2"
            OnClick="Button5_Click" UseSubmitBehavior="False"/>
            <asp:Button ID="Button2" runat="server" Text="关 闭[Esc]" CssClass="btn2"
             UseSubmitBehavior="false"
             OnClientClick="window.close();" />
        </div>
    </div>
    </form>
</body>
</html>
