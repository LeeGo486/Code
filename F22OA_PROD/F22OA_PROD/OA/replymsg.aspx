<%@ page language="C#" autoeventwireup="true" inherits="replymsg, App_Web_replymsg.aspx.766205c1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">

<title>回复</title>
		<LINK href="css/project.css" type="text/css" rel="stylesheet">
		
	</head>
	<body bgcolor="#eeffff" topmargin="0" leftmargin="0">
	<iframe name="main" src="" style=" display:none"></iframe>
		<form id="Form1" method="post" runat="server"  target="main">
			<table>
				<tbody>
					<tr>
						<td align="right" style="WIDTH: 42px" class="tdright">发送:</td>
						<td>
							<asp:Label id="lbfrom" runat="server" Width="112px" ForeColor="Brown"></asp:Label></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td align="right" style="WIDTH: 42px" class="tdright">时间:</td>
						<td colspan="3">
							<asp:Label id="lbtime" runat="server" Width="176px" ForeColor="Blue"></asp:Label></td>
					</tr>
					<tr>
						<td align="right" style="WIDTH: 42px" valign="top" class="tdright">信息:</td>
						<td colspan="3">
						<asp:TextBox id="tbcontent" runat="server" TextMode="MultiLine" Width="240px" Height="88px" BackColor="WhiteSmoke" ReadOnly="true"></asp:TextBox></td>
					</tr>
					<tr>
						<td align="right" style="WIDTH: 42px" valign="top" class="tdright">内容:</td>
						<td colspan="3">
							<asp:TextBox id="tbmsg" runat="server" TextMode="MultiLine" Width="248px" Height="88px" BackColor="WhiteSmoke"></asp:TextBox></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" align="center">
							<input type="submit" style="WIDTH: 86px; HEIGHT: 22px" name="btok" value="发送(S)" class="bt"
								runat="server" id="btknow" accesskey="s" onserverclick="btknow_ServerClick"/></td>
					</tr>
				</tfoot>
			</table>
		</form>
	</body>
</html>
