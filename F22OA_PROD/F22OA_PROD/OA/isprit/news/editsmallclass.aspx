<%@ page language="C#" autoeventwireup="true" inherits="isprit_news_editsmallclass, App_Web_editsmallclass.aspx.9a188d08" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>新闻类别</title>
	
		<LINK href="../../css/project.css"type="text/css" rel="STYLESHEET">
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <TABLE id="Table1" cellSpacing="1" cellPadding="1" width="600" border="0" class="news"
				align="center">
				<TR>
					<TD style="WIDTH: 23px"></TD>
					<TD>新闻子类别管理</TD>
					<TD><FONT face="宋体"></FONT></TD>
				</TR>
				<TR>
					<TD colspan="2" style="HEIGHT: 28px">
						<asp:datagrid id="dgmain" runat="server" GridLines="Vertical" CssClass="tbGrid"  CellSpacing="1" AutoGenerateColumns="False"
							AllowPaging="True" PageSize="14" AllowCustomPaging="True" Width="584px" CellPadding="3" BackColor="White"
							BorderWidth="1px" BorderStyle="None" BorderColor="#999999">
							<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="编号">
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.smallclassid") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="新闻类别">
									<ItemTemplate>
										<asp:label ID=lb runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.smallclass") %>'>
										</asp:label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:textbox ID="tb" CssClass="textbox" Width=120 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.smallclass") %>'>
										</asp:textbox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="排序ID" HeaderStyle-HorizontalAlign="Center">
									<ItemTemplate>
										<asp:label ID="lborder" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.orderby") %>'>
										</asp:label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:textbox ID="tborderby" CssClass="textbox" Width=30 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.orderby") %>'>
										</asp:textbox>
										<asp:RangeValidator id="Rangevalidator1" runat="server" ErrorMessage="*只能为整数*" Type="Integer" MaximumValue="65535"
											MinimumValue="0" ControlToValidate="tborderby"></asp:RangeValidator>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:EditCommandColumn HeaderStyle-HorizontalAlign="Center" HeaderText="修改" ButtonType="LinkButton" UpdateText="更新"
									CancelText="取消" EditText="修改类别"></asp:EditCommandColumn>
								<asp:TemplateColumn HeaderText="删除" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
									<ItemTemplate>
										<P>
											<asp:ImageButton id="imbdel" runat="server" ImageUrl="../icon/delete.gif" ToolTip="删除新闻类别,且会删除属于该类的新闻"
												CommandName="delete"></asp:ImageButton></P>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="查看" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
									<ItemTemplate>
										<asp:Image id="Image1" runat="server" ImageUrl="../icon/arr.gif"></asp:Image><FONT face="宋体"></FONT>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Center" ForeColor="Black" BackColor="#999999" Mode="NumericPages"></pagerStyle>
						</asp:datagrid>
					<TD style="HEIGHT: 28px"></TD>
				</TR>
				<TR>
					<TD align="right"><FONT face="宋体">新闻子类别:</FONT></TD>
					<TD vAlign="top" style="HEIGHT: 30px">
						<asp:textbox id="tbclass" runat="server" BorderWidth="1px" BorderStyle="Solid" Height="20px"
							accessKey="d" CssClass="textbox"></asp:textbox><FONT face="宋体">(D)</FONT></TD>
					<TD style="HEIGHT: 30px"><FONT face="宋体"></FONT></TD>
				</TR>
				<tr>
					<td align="right"><FONT face="宋体">排序ID:</FONT></td>
					<td style="HEIGHT: 31px">
						<asp:textbox id="tborder" accessKey="d" runat="server" CssClass="textbox" Height="20px" BorderStyle="Solid"
							BorderWidth="1px"></asp:textbox><FONT face="宋体">(F)
							<asp:RangeValidator id="rv" runat="server" ErrorMessage="*只能为整数*" Type="Integer" MaximumValue="65535"
								MinimumValue="0" ControlToValidate="tborder"></asp:RangeValidator></FONT></td>
					<td style="HEIGHT: 31px"></td>
				</tr>
				<tr>
					<td style="HEIGHT: 36px" align="right"><FONT face="宋体">所属新闻大类:</FONT></td>
					<td style="HEIGHT: 36px"><FONT face="宋体">
							<asp:DropDownList id="ddclass" runat="server" CssClass="textbox" Width="152px"></asp:DropDownList></FONT></td>
					<td style="HEIGHT: 36px"></td>
				</tr>
				<tr>
					<td style="HEIGHT: 36px"></td>
					<td style="HEIGHT: 36px">
						<asp:Button id="btadd" runat="server" BorderWidth="1px" BorderStyle="Solid" Text="新增新闻子类别(A)"
							Height="20px" accessKey="a" CssClass="button" OnClick="btadd_Click"></asp:Button></td>
					<td style="HEIGHT: 36px"></td>
				</tr>
				<tr>
					<td colspan="3" align="center"><a href="javascript:window.close()">关闭窗口</a></td>
				</tr>
			</TABLE>
    </div>
    </form>
</body>
</html>
