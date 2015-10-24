<%@ page language="C#" autoeventwireup="true" inherits="isprit_news_newsclass, App_Web_newsclass.aspx.9a188d08" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>新闻类别</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="stylesheet"/>
</head>
<body  topMargin="1" leftmargin="1" rightmargin="0">
    <form id="form1" runat="server">
    <div><uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <div class="content"><h2><strong>
        
        </strong></h2></div>
			<table id="table1" cellSpacing="0" cellPadding="0" width="600" border="0" 
				align="center">
		
				<tr>
					<td colspan="2" style="HEIGHT: 28px">
						<asp:datagrid id="dgmain" runat="server" CssClass="tbGrid"  CellSpacing="1"  CellPadding="4" Width="584px" AllowCustomPaging="true" PageSize="15" AutoGenerateColumns="False"
							OnPageIndexChanged="dg_page"  GridLines="None" ForeColor="#333333" OnItemCommand="dg_ItemCommand" OnItemCreated="dgmain_ItemCreated" HorizontalAlign="Center">
						<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="编号">
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.classid") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="新闻类别">
									<ItemTemplate>
										<asp:label ID=lb runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.newsclass") %>'>
										</asp:label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:textbox ID="tb" CssClass="textbox" Width=120 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.newsclass") %>'>
										</asp:textbox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="排序ID">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
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
								<asp:EditCommandColumn UpdateText="更新" HeaderText="修改" CancelText="取消" EditText="修改类别">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
								</asp:EditCommandColumn>
								<asp:TemplateColumn HeaderText="删除">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<P>
											<asp:ImageButton id="imbdel" runat="server" ImageUrl="../icon/delete.gif" ToolTip="删除新闻类别,且会删除属于该类的新闻" 
												CommandName="DELETE"></asp:ImageButton></P>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#2461BF"></pagerStyle>
                            <EditItemStyle BackColor="#EFF3FB" />
						</asp:datagrid>
					<td style="HEIGHT: 28px"></td>
				</tr>
				<tr>
					<td align="right"><FONT face="宋体">新闻类别:</FONT></td>
					<td vAlign="top" style="HEIGHT: 30px">
						<asp:textbox id="tbclass" runat="server" BorderWidth="1px" BorderStyle="Solid" Height="20px"
							accessKey="d" CssClass="textbox" Width="160px"></asp:textbox><FONT face="宋体">(D)</FONT></td>
					<td style="HEIGHT: 30px"><FONT face="宋体"></FONT></td>
				</tr>
				<tr>
					<td align="right"><FONT face="宋体">排序ID:</FONT></td>
					<td style="HEIGHT: 31px">
						<asp:textbox id="tborder" accessKey="d" runat="server" CssClass="textbox" Height="20px" BorderStyle="Solid"
							BorderWidth="1px" Width="72px">10</asp:textbox><FONT face="宋体">(F)
							<asp:RangeValidator id="rv" runat="server" ErrorMessage="*只能为整数*" Type="Integer" MaximumValue="65535"
								MinimumValue="0" ControlToValidate="tborder"></asp:RangeValidator></FONT></td>
					<td style="HEIGHT: 31px"></td>
				</tr>
				<tr>
					<td style="HEIGHT: 36px"></td>
					<td style="HEIGHT: 36px">
						<asp:Button id="btadd" runat="server"  Text="新增新闻类别(A)"
							 accessKey="a" CssClass="btr"  OnClick="btadd_Click"></asp:Button></td>
					<td style="HEIGHT: 36px"></td>
				</tr>
				<tr>
					<td colspan="3" align="center">
                        <ol>
                            <li style="text-align: left">添加新闻类别后、会自动生成添加新闻的菜单</li>
                            <li style="text-align: left">如果更改新闻类别名、菜单的名称不会自动更改需要到菜单管理界面更改</li>
                            <li style="text-align: left">新闻类别名和菜单中的名称要一致，否则在删除新闻类别时，不会自动删除菜单</li>
                            <li style="text-align: left">授权访问页面时请按流程，新增类别---菜单管理，设为后台管理的子菜单-----角色管理---授于某人访问该项</li>
                        </ol>
                    </td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
