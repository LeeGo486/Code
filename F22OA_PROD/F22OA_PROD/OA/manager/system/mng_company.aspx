<%@ page language="C#" autoeventwireup="true" inherits="manager_system_mng_company, App_Web_mng_company.aspx.abfa359c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>mng_company</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class=content>
		    <h2><strong>公司信息设置</strong></h2>
		</div>
			<TABLE bgcolor="white" align="center" cellSpacing="1" cellPadding="1" width="353" border="0"
				style="WIDTH: 353px; HEIGHT: 244px">
				<TBODY>
					<TR>
						<TD class="tdright">单位名称</TD>
						<TD>
							<asp:TextBox id="tbcompany" runat="server" CssClass="bt" Width="175px"></asp:TextBox></TD>
						<TD>
						</TD>
					</TR>
					<TR>
						<TD class="tdright">公司总机</TD>
						<TD>
							<asp:TextBox id="tbtel" runat="server" CssClass="bt" Width="175px"></asp:TextBox></TD>
						<TD>
						</TD>
					</TR>
					<TR>
						<TD class="tdright">传真</TD>
						<TD>
							<asp:TextBox id="Tbfax" runat="server" CssClass="bt" Width="175px"></asp:TextBox></TD>
						<TD></TD>
					</TR>
					<TR>
						<TD class="tdright">地址</TD>
						<TD>
							<asp:TextBox id="Tbaddress" runat="server" CssClass="bt" Width="175px"></asp:TextBox></TD>
						<TD></TD>
					</TR>
					<TR>
						<TD class="tdright">网站</TD>
						<TD>
							<asp:TextBox id="Tbwebsite" runat="server" CssClass="bt" Width="175px"></asp:TextBox></TD>
						<TD></TD>
					</TR>
					<TR>
						<TD class="tdright">首页LOGO</TD>
						<TD colspan="2"><INPUT id="File1" class="bt" runat="server" style="WIDTH: 248px; HEIGHT: 22px" type="file" size="22"
								name="File"></TD>
					</TR>
					<TR>
						<TD class="tdright">标题栏LOGO</TD>
						<TD colspan="2"><INPUT id="File2" class="bt" runat="server" style="WIDTH: 248px; HEIGHT: 22px" type="file" size="22"
								name="File"></TD>
					</TR>
					<TR>
						<TD class="tdright">标题栏文字</TD>
						<TD>
							<asp:TextBox id="Tbtitle" runat="server" CssClass="bt" Width="175px"></asp:TextBox></TD>
						<TD></TD>
					</TR>
				</TBODY>
				<tfoot>
					<tr height="35">
						<td colspan="3" align="center">
							<asp:Button id="btOK" runat="server" Width="71px" CssClass="bt" Text="确定(S)" AccessKey="s" OnClick="btOK_Click"></asp:Button></td>
					</tr>
				</tfoot>
			</TABLE>
    </div>
    </form>
</body>
</html>
