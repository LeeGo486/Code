<%@ page language="C#" autoeventwireup="true" inherits="isprit_mail_mail_inbox, App_Web_mail_inbox.aspx.2cabe2e1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>inbox</title>
    <META http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
		<LINK href="../../css/project.css" type="text/css" rel="stylesheet">
		<base target="_self" />
		<script language="javascript">
        
        //inbox
        function inbox(){
        
        
			window.open("box.aspx?box=1","","target=_self")
        }
        //outbox
        function outbox(){
        
        
			window.open("box.aspx?box=2","","target=_self")
        }
		</script>
</head>
<body leftMargin="0" topMargin="0" bgcolor="#eeeeff"> 
    <form id="form1" runat="server">
    <div>
    <TABLE id="Table1" cellSpacing="1" cellPadding="1" align="center" border="0" width="100%">
				<TR>
					<TD><FONT face="宋体" color="#003366">&nbsp;<IMG alt="" src="../icon/email.gif">&nbsp;邮件收件箱</FONT><a href="mail_outbox.aspx">[转到发件箱]</a></TD>
				</TR>
				<tr>
				   <td><table><tr><td>选择时间段:</td><td>
                <igsch:WebDateChooser ID="wdc1" ToolTip="开始日期" runat="server">
                </igsch:WebDateChooser>
            </td>
			    <td>
			        <igsch:WebDateChooser ID="wdc2" runat="server" ToolTip="结束日期">
                    </igsch:WebDateChooser>
                </td>
                <td>
                 <asp:DropDownList ID="dlsearchname" runat="server" Width="65px">
                     <asp:ListItem Value="username">发件人</asp:ListItem>
                     <asp:ListItem Value="title">标题</asp:ListItem>
                     <asp:ListItem Value="a_mail.remark">内容</asp:ListItem>
                     
                    </asp:DropDownList>
                    <asp:TextBox ID="tbsearch" Width="120px" runat="server"></asp:TextBox></td><td>
                    <asp:ImageButton ID="imbsearch" runat="server" AlternateText="查询" ImageUrl="../../icon/search.gif" ToolTip="有查询字符时，是没有时间限制的" OnClick="imbsearch_Click" /></td>
			</tr></table></td>
				</tr>
				<tr>
					<td>
						<webdiyer:AspNetpager id="ap" runat="server" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager></td>
				</tr>
				<TR>
					<TD vAlign="top">
					<asp:datagrid id="dgbox" runat="server" GridLines="None" ToolTip="点击标题,查看明细" CssClass="tbGrid"  CellSpacing="1" 
							Width="100%" AutoGenerateColumns="False" ShowFooter="True" CellPadding="4" ForeColor="#333333" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated">
							<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
									<HeaderTemplate>
										<asp:CheckBox id="chkAll1" runat="server" BorderColor="Silver" BorderWidth="0px" Text="全选"></asp:CheckBox>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="cb" runat="server" BorderColor="Silver" BorderWidth="0px"></asp:CheckBox>
									</ItemTemplate>
									<FooterTemplate>
										<asp:CheckBox id="chkAll" runat="server" BorderColor="Silver" BorderWidth="0px" Text="全选"></asp:CheckBox>
									</FooterTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="ID">
									<ItemStyle HorizontalAlign="Left" Width="25px"></ItemStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.mailid") %>' ID="Label2" NAME="Label2">
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="标题">
									<ItemStyle HorizontalAlign="Left"></ItemStyle>
									<ItemTemplate>
										<A  href='maildetail.aspx?mailid=<%# Eval("mailid") %>&action=inbox'>
											<%# Eval("title") %>
											<asp:Image ID="imgnew" Runat="server" ImageUrl="../icon/email_new.gif" Visible='<%# Eval("readit") %>'>
											</asp:Image>
										</A>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="来自">
									<HeaderStyle Width="100px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.username") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="发送时间">
									<HeaderStyle Width="100px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.crdate", "{0:d}") %>' ID="Label21" NAME="Label21">
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<HeaderTemplate>
										删除
									</HeaderTemplate>
									<ItemTemplate>
										<asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../icon/delete.gif" CommandName="delete"></asp:ImageButton>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Center" ForeColor="White" Position="TopAndBottom" BackColor="#2461BF"></pagerStyle>
                        <EditItemStyle BackColor="#2461BF" />
						</asp:datagrid></TD>
				</TR>
				<TR>
					<TD><FONT face="宋体"><asp:button id="btOK" accessKey="d" runat="server" CssClass="btr" Width="160px" Text="删除选定的邮件(D)" OnClick="btOK_Click"></asp:button></FONT></TD>
				</TR>
			</TABLE>
    </div>
    </form>
</body>
</html>
