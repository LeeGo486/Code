<%@ page language="C#" autoeventwireup="true" inherits="manager_area, App_Web_area.aspx.3665c05a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>新闻类别</title>
		<LINK href="../css/project.css" type="text/css" rel="STYLESHEET">
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <TABLE id="Table1" cellSpacing="1" cellPadding="1" width="600" border="0" class="news"
				align="center">
				<TR>
					<TD style="WIDTH: 23px"></TD>
					<TD>部门|地区管理</TD>
					<TD><FONT face="宋体"></FONT></TD>
				</TR>
				<TR>
					<TD colspan="2" style="HEIGHT: 28px">
						<asp:datagrid id="dgmain" runat="server" BorderColor="#999999" BorderStyle="None" BorderWidth="1px"
							BackColor="White" CellPadding="3" Width="584px" PageSize="100" AutoGenerateColumns="False"
							OnPageIndexChanged="dg_page" CssClass="news" GridLines="Vertical" OnItemCommand="dg_ItemCommand" OnItemCreated="dgmain_ItemCreated">
							<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#008A8C"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="Gainsboro"></AlternatingItemStyle>
							<ItemStyle ForeColor="Black" BackColor="#EEEEEE"></ItemStyle>
							<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#000084"></HeaderStyle>
							<FooterStyle ForeColor="Black" BackColor="#CCCCCC"></FooterStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="编号">
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.departid") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="部门|地区">
									<ItemTemplate>
										<asp:label ID=lb runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.department") %>'>
										</asp:label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:textbox ID="tb" CssClass="textbox" Width=120 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.department") %>'>
										</asp:textbox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="排序">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemTemplate>
										<asp:label ID="lborder" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.order") %>'>
										</asp:label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:textbox ID="tborderby" CssClass="textbox" Width=70 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.order") %>'>
										</asp:textbox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="备注">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemTemplate>
										<asp:label ID="lbintro" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.intro") %>'>
										</asp:label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:textbox ID="tbintro" CssClass="textbox" Width=70 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.intro") %>'>
										</asp:textbox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="更新" HeaderText="修改" CancelText="取消" EditText="修改类别">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
								</asp:EditCommandColumn>
								<asp:TemplateColumn HeaderText="删除">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<P>
											<asp:ImageButton id="imbdel" runat="server" ImageUrl="icon/delete.gif" ToolTip="删除部门,会删除属于该部门|地区的人员"
												CommandName="delete"></asp:ImageButton></P>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Center" ForeColor="Black" BackColor="#999999" Mode="NumericPages"></pagerStyle>
						</asp:datagrid>
					<TD style="HEIGHT: 28px"></TD>
				</TR>
				<TR>
					<TD align="right"><FONT face="宋体">地区:</FONT></TD>
					<TD vAlign="top" style="HEIGHT: 30px">
						<asp:textbox id="tbclass" runat="server" BorderWidth="1px" BorderStyle="Solid" Height="20px"
							accessKey="d" CssClass="textbox"></asp:textbox><FONT face="宋体">(D)</FONT></TD>
					<TD style="HEIGHT: 30px"><FONT face="宋体"></FONT></TD>
				</TR>
				<tr>
					<td align="right"><FONT face="宋体">备注:</FONT></td>
					<td style="HEIGHT: 31px">
						<asp:textbox id="tborder" accessKey="d" runat="server" CssClass="textbox" Height="20px" BorderStyle="Solid"
							BorderWidth="1px"></asp:textbox><FONT face="宋体">(F)</FONT></td>
					<td style="HEIGHT: 31px"></td>
				</tr>
				<tr>
					<td style="HEIGHT: 36px"></td>
					<td style="HEIGHT: 36px">
						<asp:Button id="btadd" runat="server" BorderWidth="1px" BorderStyle="Solid" Text="新增地区(A)" Height="20px"
							accessKey="a" CssClass="button" OnClick="btadd_Click"></asp:Button></td>
					<td style="HEIGHT: 36px"></td>
				</tr>
				<tr>
					<td colspan="3" align="center"><A href="javascript:history.go(-1)">返回</A> <a href="javascript:window.close()">关闭窗口</a></td>
				</tr>
			</TABLE>
    </div>
    </form>
</body>
</html>
