<%@ page language="C#" autoeventwireup="true" inherits="Project_show_linkman_all, App_Web_linkman_all.aspx.8e3465e2" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>linkman_all</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
</head>
<body  topmargin="0" leftmargin="1" rightmargin="0">
    <form id="form1" runat="server">
    <div>
    <div class="content">
			<br />		
        <h2>
            <strong>联系人资料</strong></h2>
    </div>
					
				<table width="100%">
					<tr>
						<td>
							
							<!-- 
								关键字:
								<asp:TextBox id="tbsearch" runat="server" onfocus="javascript:highlight(1)" onblur="javascript:highlight(0)"
									cssclass="on" tooltip="可以输入编号、名称"></asp:TextBox>
								<asp:ImageButton id="imbSearch" runat="server" ImageUrl="../../icon/search.gif"></asp:ImageButton>
                                -->
                                <asp:CheckBox ID="ckpublic" runat="server" AutoPostBack="True" Text="打勾，查询公共联系人"
                                    ToolTip="不打勾只查询我的私有联系人" />(<a href="../client/e_linkman_all.aspx">进入管理</a>)
						</td>
					</tr>
					<tr>
						<td>
							<asp:datagrid id="dgmng" runat="server" GridLines="None"  CssClass="tbGrid"  CellSpacing="1" 
							Width="100%" AutoGenerateColumns="False" ShowFooter="True" CellPadding="4" ForeColor="#333333" OnItemDataBound="dgmain_ItemBound">
								<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
								<Columns>
									<asp:TemplateColumn HeaderText="姓名">
										<ItemTemplate>
											<a href='linkman_one.aspx?contactid=<%# DataBinder.Eval(Container, "DataItem.contactid") %>&action=show'>
												<%# DataBinder.Eval(Container, "DataItem.username") %>
											</a>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:BoundColumn DataField="duty" HeaderText="职务"></asp:BoundColumn>
									<asp:BoundColumn DataField="phone" HeaderText="电话"></asp:BoundColumn>
									<asp:BoundColumn DataField="mobile" HeaderText="手机"></asp:BoundColumn>
									<asp:BoundColumn DataField="email" HeaderText="电子邮件"></asp:BoundColumn>
                                    <asp:TemplateColumn HeaderText="编辑">
                                        <ItemTemplate>
   <a href='../client/e_linkman_add.aspx?contactid=<%# DataBinder.Eval(Container, "DataItem.contactid") %>' target=_self>
											编辑</a>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
								</Columns>
							</asp:datagrid></td>
					</tr>
					<tr>
						<td>
							<webdiyer:AspNetpager id="ap" runat="server" PageSize="15" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager></td>
					</tr>
				</table>
		
    </div>
    </form>
</body>
</html>
