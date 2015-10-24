<%@ page language="C#" autoeventwireup="true" inherits="isprit_Module_signature, App_Web_signature.aspx.a91202c5" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>签名</title>
    <LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<base target="_self">
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table style="WIDTH: 336px; HEIGHT: 116px">
				<tr>
					<td class="header">电子签名:
					</td>
				</tr>
				<tr>
					<td>连续用输入户名密码:
						<asp:TextBox id="tbuserpwd" runat="server" Width="168px" CssClass="book_tb" TextMode="Password"
							tabIndex="1"></asp:TextBox>&nbsp;&nbsp;&nbsp;
						<asp:ImageButton id="imbok" runat="server" ToolTip="签名" ImageUrl="../../icon/go.gif" AlternateText="验证密码"
							ImageAlign="Baseline" accessKey="w" OnClick="imbok_Click"></asp:ImageButton>
					</td>
				</tr>
				<tr>
					<td class="tip">&nbsp;&nbsp;&nbsp; 例:用户名abc密码123,连续输入abc123,回车即可.
					</td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
