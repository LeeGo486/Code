<%@ page language="C#" autoeventwireup="true" inherits="isprit_news_bindsmallclass, App_Web_bindsmallclass.aspx.9a188d08" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>smallclass</title>
	
		<LINK href="news.css" type="text/css" rel="STYLESHEET">
</head>
<body>
    <form id="form1" runat="server">
    <div>
  <TABLE id="Table1" align="center" width="760" border="0">
				<TR>
					<TD><FONT face="宋体">新闻大类</FONT></TD>
					<TD><FONT face="宋体">新闻子类</FONT></TD>
					<TD style="width: 22px"><FONT face="宋体"></FONT></TD>
					<TD><FONT face="宋体">相关大类的新闻</FONT></TD>
				</TR>
				<TR>
					<TD>
						<asp:ListBox id="lbbig" runat="server" Width="144px" Height="256px" CssClass="textbox" AutoPostBack="True" OnSelectedIndexChanged="lbbig_SelectedIndexChanged"></asp:ListBox></TD>
					<TD><FONT face="宋体">
							<asp:ListBox id="lbsmall" runat="server" Width="128px" CssClass="textbox" Height="256px"></asp:ListBox></FONT></TD>
					<TD style="width: 22px">
						<asp:Button id="btrelation" runat="server" Text="<设定关联>" CssClass="button" OnClick="btrelation_Click"></asp:Button></TD>
					<TD>
						<asp:ListBox id="lbnews" runat="server" Width="349px" CssClass="textbox" Height="256px" SelectionMode="Multiple"></asp:ListBox></TD>
				</TR>
				<TR>
					<TD colspan="4">
						<asp:Label id="lbtip" runat="server"></asp:Label></TD>
				</TR>
			</TABLE>
    </div>
    </form>
</body>
</html>
