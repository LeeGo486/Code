<%@ page language="C#" autoeventwireup="true" inherits="manager_user_role, App_Web_role.aspx.d341d34a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>role</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class=content>
		        <h2><strong>角色管理</strong></h2>
		    </div>
			<TABLE class="news" id="Table1" cellSpacing="1" cellPadding="1" width="600" align="center" border="0">

				<TR>
					<TD style="HEIGHT: 28px" colSpan="2">
						<asp:datagrid id="dgmain" runat="server" CellPadding="4" Width="584px" PageSize="100" AutoGenerateColumns="False"
							OnPageIndexChanged="dg_page" CssClass="news" GridLines="None" ForeColor="#333333" OnItemCommand="dg_ItemCommand" OnItemCreated="dgmain_ItemCreated">
							<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center"></ItemStyle>
							<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#507CD1"></HeaderStyle>
							<FooterStyle ForeColor="White" BackColor="#507CD1" Font-Bold="True"></FooterStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="编号">
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.roleid") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="角色">
									<ItemTemplate>
										<asp:label ID=lb runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.role") %>'>
										</asp:label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:textbox ID="tb" CssClass="textbox" Width=120 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.role") %>'>
										</asp:textbox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="备注">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemTemplate>
										<asp:label ID="lborder" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
										</asp:label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:textbox ID="tborderby" CssClass="textbox" Width=70 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
										</asp:textbox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:EditCommandColumn UpdateText="更新" HeaderText="修改" CancelText="取消" EditText="更改角色">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
								</asp:EditCommandColumn>
								<asp:TemplateColumn HeaderText="编辑权限">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemTemplate>
										<a href='setmenu.aspx?roleid=<%# DataBinder.Eval(Container, "DataItem.roleid") %>&role=<%# DataBinder.Eval(Container, "DataItem.role") %>'>
											编辑权限</a>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="删除">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<P>
											<asp:ImageButton id="imbdel" runat="server" ImageUrl="../../icon/delete.gif" ToolTip="删除部门,会删除属于该部门|地区的人员"
												CommandName="delete"></asp:ImageButton></P>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#2461BF"></pagerStyle>
                            <EditItemStyle BackColor="#2461BF" />
						</asp:datagrid>
					<TD style="HEIGHT: 28px"></TD>
				</TR>
				<TR>
					<TD align="right"><FONT face="宋体">角色:</FONT></TD>
					<TD style="HEIGHT: 30px" vAlign="top">
						<asp:textbox id="tbclass" accessKey="d" runat="server" BorderStyle="Solid" BorderWidth="1px"
							CssClass="textbox" Height="20px"></asp:textbox><FONT face="宋体">(D)</FONT></TD>
					<TD style="HEIGHT: 30px"></TD>
				</TR>
				<TR>
					<TD align="right"><FONT face="宋体">备注:</FONT></TD>
					<TD style="HEIGHT: 31px">
						<asp:textbox id="tborder" accessKey="d" runat="server" BorderStyle="Solid" BorderWidth="1px"
							CssClass="textbox" Height="20px"></asp:textbox><FONT face="宋体">(F)</FONT></TD>
					<TD style="HEIGHT: 31px"></TD>
				</TR>
				<TR>
					<TD style="HEIGHT: 36px"></TD>
					<TD style="HEIGHT: 36px">
						<asp:Button id="btadd" accessKey="a" runat="server" BorderStyle="Solid" BorderWidth="1px" CssClass="button"
							Height="20px" Text="新增角色(A)" OnClick="btadd_Click"></asp:Button></TD>
					<TD style="HEIGHT: 36px"></TD>
				</TR>
				<TR>
					<TD align="center" colSpan="3"><A  href="javascript:history.go(-1)">返回</A><A href="javascript:window.close()">关闭窗口</A></TD>
				</TR>
			</TABLE>
    </div>
    </form>
</body>
</html>
