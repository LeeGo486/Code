<%@ page language="C#" autoeventwireup="true" inherits="manager_PublicFolder_folder_add, App_Web_folder_add.aspx.f55e7b9c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>folder_add</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
		<base target="_self">
</head>
<body  topmargin="1" leftmargin="1">
    <form id="form1" runat="server">
    <div>
    <TABLE id="Table1" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 8px" cellSpacing="1"
				cellPadding="1" width="300" bgColor="#999999" border="0">
				<TR>
					<TD class="header" colSpan="2">公共文件夹:</TD>
				</TR>
				<TR>
					<TD class="tdright" style="WIDTH: 92px" bgColor="#ffffff">文件夹名称(B):</TD>
					<TD bgColor="#ffffff">
						<asp:TextBox id="tbname" accessKey="b" runat="server" nullable="n" cname="名称" MaxLength="40"
							CssClass="tbox"></asp:TextBox></TD>
				</TR>
				<TR>
					<TD class="tdright" style="WIDTH: 92px" bgColor="#ffffff">备注(M):</TD>
					<TD bgColor="#ffffff">
						<asp:TextBox id="tbremark" accessKey="b" runat="server" nullable="n" cname="名称" MaxLength="40"
							CssClass="tbox"></asp:TextBox></TD>
				</TR>
				<TR>
					<TD class="tdright" style="WIDTH: 92px" bgColor="#ffffff">排序(Q):</TD>
					<TD bgColor="#ffffff">
						<asp:TextBox id="tbseq" accessKey="c" runat="server" nullable="n" cname="排序" MaxLength="8" CssClass="tbox"
							datatype="n">1</asp:TextBox></TD>
				</TR>
				<TR>
					<TD class="tip" align="center" colSpan="2">&nbsp;
						<asp:Button id="btsave" accessKey="s" runat="server" CssClass="btn" Text="保存(S)" OnClick="btsave_Click"></asp:Button>
						&nbsp;
                        <asp:Button ID="cbtn" runat="server" CssClass="btn" Text="关闭(C)" AccessKey="c" /></TD>
				</TR>
			</TABLE>
    </div>
    </form>
</body>
</html>
