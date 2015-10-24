<%@ page language="C#" autoeventwireup="true" inherits="manager_menus, App_Web_menus.aspx.3665c05a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>menus</title>
		
		<LINK href="../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../js/project.js" type="text/javascript"></script>
</head>
<body topmargin="0" leftmargin="1">
    <form id="form1" runat="server">
    <div>
    <div id="container">
				<div class="content">
					<h2><strong>菜单管理</strong></h2>
				</div>
				<hr>
				<asp:DataGrid id="dg" runat="server" AutoGenerateColumns="False" Width="100%" BorderColor="#336666"
					BorderStyle="Double" BorderWidth="3px" BackColor="White" CellPadding="4" OnItemCreated="dg_ItemCreated">
					<FooterStyle ForeColor="#333333" BackColor="White"></FooterStyle>
					<ItemStyle Wrap="False" ForeColor="#333333" BackColor="White"></ItemStyle>
					<HeaderStyle Font-Bold="True" HorizontalAlign="Center" ForeColor="White" BackColor="#336666"></HeaderStyle>
					<Columns>
						<asp:TemplateColumn>
							<HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
							<HeaderTemplate>
								<asp:CheckBox id="chkAll1" runat="server" BorderColor="Silver" BorderWidth="0px"></asp:CheckBox>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:CheckBox  id="ck" runat="server" BorderWidth="1px" EnableViewState="true"></asp:CheckBox>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="ID">
							<ItemTemplate>
								<asp:Label ID="LBID" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.id") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:BoundColumn DataField="parentid" HeaderText="父结点"></asp:BoundColumn>
						<asp:BoundColumn DataField="title" HeaderText="菜单名"></asp:BoundColumn>
						<asp:BoundColumn DataField="url" HeaderText="URL"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="图标名">
							<ItemTemplate>
								<img border=0 src='../icon/menu/<%# DataBinder.Eval(Container, "DataItem.icon") %>' />
								<%# DataBinder.Eval(Container, "DataItem.icon") %>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:BoundColumn DataField="orderby" HeaderText="排序号"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="更改">
							<ItemTemplate>
								<a href="#" onclick='javascript:LoadClass("menu_edit.aspx?action=edit&id=<%# DataBinder.Eval(Container, "DataItem.id") %>",'菜单更改')'>
									更改</a>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
					<pagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></pagerStyle>
				</asp:DataGrid><br>
				<a href="#" class="pjt_bt" onclick='javascript:LoadClass("menu_edit.aspx?action=add","新增菜单")'>
					新增菜单</a>
				<asp:Button id="btdel" runat="server" Text="删除选定行?" CssClass="pjt_bt" OnClick="btdel_Click"> </asp:Button>&nbsp;
                <A  href="javascript:history.go(-1)">返回</A>
			</div>
    </div>
    </form>
</body>
</html>
