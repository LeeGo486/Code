<%@ page language="C#" autoeventwireup="true" inherits="manager_user_setuserrole, App_Web_setuserrole.aspx.d341d34a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>SetUserRole</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class=content><h2><strong>设定用户角色</strong></h2></div>
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="536" border="0">
				<TR>
					<TD style="WIDTH: 175px; HEIGHT: 21px">
						<asp:DropDownList id="ddldepart" runat="server" Width="176px" AutoPostBack="True" OnSelectedIndexChanged="ddldepart_SelectedIndexChanged"></asp:DropDownList></TD>
					<TD style="WIDTH: 43px; HEIGHT: 21px"></TD>
					<TD style="HEIGHT: 21px">角色</TD>
				</TR>
				<TR>
					<TD style="WIDTH: 175px" vAlign="top"><FONT face="宋体">
							<asp:ListBox id="lbuser" runat="server" Width="176px" Height="384px" SelectionMode="Multiple"></asp:ListBox></FONT></TD>
					<TD style="WIDTH: 43px" vAlign="middle">
						<asp:Button id="btset" runat="server" Text="设定" Width="80px" OnClick="btset_Click"></asp:Button></TD>
					<TD vAlign="top">
						<asp:RadioButtonList id="RBLrole" runat="server"></asp:RadioButtonList></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 175px"></TD>
					<TD style="WIDTH: 43px"></TD>
					<TD></TD>
				</TR>
			</TABLE>
    </div>
    </form>
</body>
</html>
