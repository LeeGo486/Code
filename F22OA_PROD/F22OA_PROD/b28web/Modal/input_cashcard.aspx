<%@ page language="C#" autoeventwireup="true" inherits="Modal_input_cashcard, App_Web_input_cashcard.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>使用充值卡</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
    td
    {
    	height:25px;
    	line-height:25px;
    	font-size:14px;
    	}
    td span
    {
    	height:25px;
    	line-height:25px;
    	font-family:Arial;
    	}
    	
    </style>
    <script type="text/javascript">
    
    //转换为数字类型
    function reNumber(val){
	    if(parseFloat(val)>0||parseFloat(val)<0){
		    str=parseFloat(val);
	    }else{
		    val=0;
	    }
      return val;
    }
    
    //计算消费金额
    function chkPay(t){
        var yf = document.getElementById('HiddenField1');
        var ye = document.getElementById('Label1');
        var xe = document.getElementById('Label2');
        
        t.value=parseFloat(reNumber(t.value)).toFixed(2);
        
        var max = 0;

        if(parseFloat(reNumber(yf.value)) <= parseFloat(reNumber(ye.innerText))){
           max=parseFloat(reNumber(yf.value)).toFixed(2);
        }else{
           max=parseFloat(reNumber(ye.innerText)).toFixed(2);
        }
        if(parseFloat(reNumber(t.value))>max) t.value = max; 

        xe.innerText = parseFloat(reNumber(ye.innerText)- reNumber(t.value)).toFixed(2);
        
        document.getElementById('HiddenField2').value = xe.innerText
        
    }
    
    function KeyDown(){
        with (event){ 
            if(keyCode==113){//确定
                document.getElementById('Button2').click();
                event.keyCode = 0; 
                event.cancelBubble = true; 
                return false;
            }
            if(keyCode==27){//ESC返回输入状态
                document.getElementById('Button3').click();
                event.keyCode = 0; 
                event.cancelBubble = true; 
                return false;
            }
        }
    }
    document.onkeydown = KeyDown;
    </script>
    <style type="text/css">
        .style1
        {
            height: 38px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding:10px;">
    
        <table style="width:100%;">
            <tr>
                <td align="right" width="100px">
                    收款方式：</td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server">
                        <asp:ListItem>充值卡</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    输入卡号：</td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="binput" Width="140px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    卡号密码：</td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="binput" TextMode="Password" 
                        Width="140px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="center" class="style1" colspan="2">
                    <asp:Button ID="Button1" runat="server" Text="查　询" CssClass="btn2" 
                        UseSubmitBehavior="False" Width="80px" onclick="Button1_Click" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    卡上余额：</td>
                <td style="height:25px;">
                    ￥&nbsp;&nbsp;<asp:Label ID="Label1" runat="server" Text="0"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    本次消费：</td>
                <td>
                    ￥&nbsp;&nbsp;<asp:TextBox ID="TextBox4" runat="server" CssClass="binput" Width="100px" Font-Bold="true">0</asp:TextBox>
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    消费后余额：</td>
                <td style="height:25px;">
                    ￥&nbsp;&nbsp;<asp:Label ID="Label2" runat="server" Text="0"></asp:Label>
                </td>
            </tr>
            <tr>
                <td  align="center" class="style1" colspan="2">
                    <asp:Button ID="Button2" runat="server" Text="确　定[F2]" CssClass="btn2" 
                        UseSubmitBehavior="False" Width="100px" onclick="Button2_Click" />&nbsp;
                    <asp:Button ID="Button3" runat="server" Text="取消[Esc]" CssClass="btn2" 
                     OnClientClick="window.close()"
                        UseSubmitBehavior="False" Width="80px" /><asp:HiddenField ID="HiddenField2" runat="server" />
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
