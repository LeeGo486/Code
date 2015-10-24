<%@ page language="C#" autoeventwireup="true" inherits="init, App_Web_init.aspx.becd6e10" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>登录</title>
<style type="text/css">
body{
margin:0px;
padding:0px;
background:#ebf3f6;
}
*{
font-size:12px;
}
#globTable{
margin-top:200px;
background:url(../images/login_05.gif) repeat-x;
table-layout:fixed;
}
.Login_Ipt{
border:solid 1px #1c4779;
}
#TipsFontIcon{
font-family:Webdings;
color:#ff3300;
font-size:16px;
}
#TipsFont{
color:#ff3300
}
.btSubmit{
width:94px;height:30px;}
</style>
</head>
<body>
<form id="form1" runat="server">
<div>
	<asp:ScriptManager ID="ScriptManager1" runat="server">
	</asp:ScriptManager>
	        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
<table width="370" border="0" align="center" cellpadding="0" cellspacing="0" id="globTable">
  <tr>
    <td width="16"><img src="../images/login_08.gif" width="15" height="260" /></td>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="../images/link_07.gif" width="118" height="54" /></td>
      </tr>
      <tr>
        <td height="125"><table border="0" align="center" cellpadding="0" cellspacing="8">
		<colgroup>
		<col style="text-align:right;font-weight:bold;color:white;" />
		<col />
		<col style="color:white;" />
		</colgroup>
        <tr>
            <td>服务器名：</td>
            <td><asp:TextBox ID="TxtServer" runat="server" AccessKey="a" cname="服务器名" CssClass="tbinput" 
			nullable="n" strnum="y"></asp:TextBox></td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtServer"
                                ErrorMessage="*"></asp:RequiredFieldValidator></td>
          </tr>
           <tr>
            <td>用户名(A):</td>
            <td><asp:TextBox ID="tbuser" runat="server" cname="用户编号" CssClass="tbinput" nullable="n"
                                strnum="y" AccessKey="a"></asp:TextBox></td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbuser"
                                ErrorMessage="*"></asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td>密&nbsp;&nbsp;码：</td>
            <td><asp:TextBox ID="tbpwd"  runat="server" cname="密码" CssClass="tbinput" nullable="n"  
			TextMode="Password" Width="127px"></asp:TextBox></td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbpwd"
                                ErrorMessage="*"></asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td >修改密码：</td>
            <td><asp:TextBox ID="TxtChangepwd"  runat="server" cname="密码" CssClass="tbinput" nullable="n" TextMode="Password" Width="127px"></asp:TextBox></td>
            <td></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="45" valign="top">
		<div style="margin-right:30px;text-align:right;"> 
                            <asp:ImageButton ImageUrl="../images/link_11.gif" ID="btok" runat="server" CssClass="btSubmit" OnClick="btok_Click" Text="测试连接(D)" AccessKey="d" />&nbsp; &nbsp;
							<asp:ImageButton ImageUrl="../images/link_14.gif" ID="BtnChange" runat="server" CssClass="btSubmit"  Text="修改连接" AccessKey="d" OnClick="BtnChange_Click" CausesValidation="False" /></div>
           
		</td>
      </tr>
      <tr>
        <td><div id="TipsFont"><asp:Label ID="lbtip" runat="server"></asp:Label></div></td>
      </tr>
    </table></td>
    <td width="10"><img src="../images/login_03.gif" width="17" height="260" alt="" /></td>
  </tr>
</table>

    <asp:HiddenField ID="HFserver" runat="server" />
    <asp:HiddenField ID="HFuid" runat="server" />
    <asp:HiddenField ID="HFpwd" runat="server" />
    
                </ContentTemplate>
        </asp:UpdatePanel>
          
    </div>
        
    </form>
</body>
</html>
