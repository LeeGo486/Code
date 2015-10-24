<%@ page language="C#" autoeventwireup="true" inherits="manager_userlist, App_Web_userlist.aspx.3665c05a" %>

<%@ Register Src="../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>userlist</title>
		<LINK href="../css/project.css" type="text/css" rel="STYLESHEET">
    <script src="../js/project.js"></script>
    
</head>
<body topmargin="1" leftmargin="1">
    <form id="form1" runat="server">
    <div>
     <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <div class=content><h2><strong>
       
        </strong></h2></div>
			<table align="center" style="WIDTH: 598px">
				<tr>
					<td class="tilte">
						<asp:DropDownList id="ddarea" runat="server" Width="141px" CssClass="bt" AutoPostBack="True" OnSelectedIndexChanged="ddarea_SelectedIndexChanged"></asp:DropDownList><A  href="javascript:history.go(-1)">返回</A>
					</td>
				</tr>
				<tr>
					<td class="news" style="HEIGHT: 177px"><FONT face="宋体">
							<asp:datagrid id="dgUser" runat="server" GridLines="None"  CssClass="tbGrid"  CellSpacing="1" 
 AutoGenerateColumns="False" ShowFooter="True" CellPadding="1" ForeColor="#333333" PageSize="20"
								Width="576px" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated" OnItemDataBound="dguser_itembound">
								<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader" Height="26px"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
								<Columns>
									<asp:TemplateColumn HeaderText="ID">
										<ItemTemplate>
											<a href='../isprit/member/updateDetail.aspx?admin=Manage&userid=<%# DataBinder.Eval(Container, "DataItem.id") %>&posname=<%# DataBinder.Eval(Container, "DataItem.username") %>&poscode=<%# DataBinder.Eval(Container, "DataItem.f21id") %>'
											title='<%# DataBinder.Eval(Container,"DataItem.username") %>'
											onclick="LoadClass(this.href,this.title);return false;">
												<asp:Label ID=tbid runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.id") %>'>
												</asp:Label></a>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="用户登录ID">
										<ItemTemplate>
											<a href='../isprit/member/showuser.aspx?userid=<%# DataBinder.Eval(Container, "DataItem.id") %>'
                       title='<%# DataBinder.Eval(Container,"DataItem.username") %>' onclick="LoadClass(this.href,this.title);return false;">
												<%# DataBinder.Eval(Container, "DataItem.userid") %>
											</a>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:BoundColumn DataField="username" HeaderText="姓名"></asp:BoundColumn>
									<asp:TemplateColumn HeaderText="登录密码">
										<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<ItemTemplate>
											***
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:BoundColumn DataField="ddepartment" HeaderText="所属地区|部门"></asp:BoundColumn>
									<asp:BoundColumn DataField="email" HeaderText="电邮"></asp:BoundColumn>
									<asp:TemplateColumn HeaderText="启用">
										<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<ItemTemplate>
											<asp:CheckBox ID=cb Runat=server Checked='<%# DataBinder.Eval(Container,"DataItem.usable") %>'>
											</asp:CheckBox>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="删除">
										<ItemTemplate>
											<asp:LinkButton ID="btDel" runat="server" Text="删除" CommandName="Delete" CausesValidation="false"></asp:LinkButton>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid></FONT>
						<webdiyer:AspNetpager id="ap" runat="server" PageSize="15" ShowInputBox="Always" SubmitButtonText="前往"
							InputBoxClass="tb" InputBoxStyle="bt" SubmitButtonClass="bt" ShowBoxThreshold="15" AlwaysShow="True" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager>
					</td>
				</tr>
				<tr>
					<td align="center">
						<asp:Button id="btnouse" runat="server" CssClass="btn" Text="查询未启用用户" OnClick="btnouse_Click"></asp:Button>
						<asp:Button id="btupdate" runat="server" Text="禁用|启用用户" CssClass="btn" OnClick="btupdate_Click"></asp:Button>
						<asp:Button id="btadd" runat="server" CssClass="btn" Text="添加用户" OnClick="btadd_Click"></asp:Button>
					</td>
				</tr>
				<tr>
					<td align="center">
						<asp:Label ID="lbtip" Runat="server" ForeColor="#C04000"></asp:Label>
					</td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
