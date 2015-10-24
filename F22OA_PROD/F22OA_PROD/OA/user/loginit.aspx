<%@ page language="C#" autoeventwireup="true" inherits="user_loginit, App_Web_loginit.aspx.7fdd8e9f" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>登录</title>	
		<LINK href="../css/project.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table align="center" id="table3" borderColor="#0099cc" height="205" cellSpacing="0" cellPadding="0"
				width="300" border="1" class=tbox>
				<tr class="header">
					<td width="297"   height="22">请登录以访问所有功能</td>
				</tr>
				<tr>
					<td vAlign="top" bgColor="#f1f2f2">
						<table id="table1" style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellSpacing="0"
							cellPadding="2" width="99%" border="0">
							<tr>
								<td colSpan="2">&nbsp;</td>
							</tr>
							<tr>
								<td style="WIDTH: 61px" vAlign="top" align="right">
                                    用户名(A): &nbsp;
								</td>
								<td align="left">
									<asp:TextBox id="tbuser" runat="server" Width="120px" CssClass="tb" AccessKey="a"></asp:TextBox>
									<asp:RequiredFieldValidator id="rv" runat="server" ErrorMessage="必须填写" ControlToValidate="tbuser"></asp:RequiredFieldValidator>
								</td>
							</tr>
							<tr>
								<td style="WIDTH: 61px" vAlign="top" align="right">密&nbsp;码(B): &nbsp;
								</td>
								<td align="left">
									<asp:TextBox id="tbpwd" runat="server" Width="120px" CssClass="tb" TextMode="Password" AccessKey="b"></asp:TextBox>
									<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="密码必须填写" ControlToValidate="tbpwd"></asp:RequiredFieldValidator>
								</td>
							</tr>
							<tr vAlign="bottom">
								<td colSpan="2">
									<table id="table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td align="right" width="130">
												<asp:Button id="btlogin" runat="server" Text="登录(Z)" Width="70px" CssClass="bt" AccessKey="z" OnClick="btlogin_Click"></asp:Button>&nbsp;</td>
											<td align="center"><A href="register.aspx" target="_self"><FONT color="#990000"><U>没有注册？点此处注册</U></FONT></A></td>
										</tr>
									</table>
									<asp:Label id="lberror" runat="server" ForeColor="Red"></asp:Label>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td vAlign="middle" background="/Member/bg.jpg" bgColor="#0066cc" height="20"><FONT color="#ffffff">&nbsp;忘记密码？</FONT></td>
				</tr>
				<tr>
					<td vAlign="top" bgColor="#f1f2f2" height="32">
						<table id="table7" height="48" cellSpacing="0" cellPadding="0" width="230" align="center"
							border="0">
							<tr>
								<td width="230" height="42"><br>
									你可以通过以下方式新设密码：<br>
									<U><FONT color="#0000ff"><IMG height="16" src="../icon/email.gif" width="20"></FONT></U><A href="#"><U><FONT color="#0000ff">把新设密码的连接发到注册Email</FONT></U></A>
									<br>
									<br>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
