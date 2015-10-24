<%@ page language="C#" autoeventwireup="true" inherits="Project_show_client_all, App_Web_client_all.aspx.8e3465e2" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>client_all</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<base target="_self" />
</head>
<body  topmargin="0" leftmargin="1" rightmargin="0">
    <form id="form1" runat="server">
    <div>
    <div id="container">
				<div class="content">
					<h2><strong>客户资料</strong></h2></div>
					
						<!-- 关键字:
						<asp:TextBox id="tbsearch" runat="server" onfocus="javascript:highlight(1)" onblur="javascript:highlight(0)"
							cssclass="on" tooltip="可以输入编号、名称"></asp:TextBox>
						<asp:ImageButton id="imbSearch" runat="server" ImageUrl="../../icon/search.gif" OnClick="imbSearch_Click"></asp:ImageButton>&nbsp;
						-->
                <asp:CheckBox ID="ckpublic" runat="server" AutoPostBack="True" Text="打勾，查询公共客户" ToolTip="不打勾只查询我的客户" OnCheckedChanged="ckpublic_CheckedChanged" />
					(<a href="../client/e_client_all.aspx">进入管理</a>)
					<asp:datagrid id="dgmng"  runat="server" GridLines="None"  CssClass="tbGrid"  CellSpacing="1" 
							Width="100%" AutoGenerateColumns="False" ShowFooter="True" CellPadding="4" ForeColor="#333333" >
<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
						<Columns>
							<asp:TemplateColumn HeaderText="公司名称">
								<ItemTemplate>
									<a href='client_one.aspx?forshort=<%# DataBinder.Eval(Container, "DataItem.forshort") %>' >
										<%# DataBinder.Eval(Container, "DataItem.company") %>
									</a>
								</ItemTemplate>
							</asp:TemplateColumn>
							<asp:BoundColumn DataField="crname" ReadOnly="True" HeaderText="客户等级" Visible="false"></asp:BoundColumn>
							<asp:BoundColumn DataField="phone" HeaderText="公司电话"></asp:BoundColumn>
							<asp:BoundColumn DataField="fax" HeaderText="传真"></asp:BoundColumn>
							<asp:BoundColumn DataField="email" HeaderText="电邮"></asp:BoundColumn>
								<asp:TemplateColumn HeaderImageUrl="../../icon/menu/address.gif">
										<ItemTemplate>
											<a href='../client/e_client_add.aspx?forshort=<%# DataBinder.Eval(Container, "DataItem.forshort") %>' target=_self>
												编辑</a>
										</ItemTemplate>
									</asp:TemplateColumn>
							
						</Columns>
					</asp:datagrid>
				
				<webdiyer:AspNetpager id="ap" runat="server" PageSize="12" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager>
			</div>
    </div>
    </form>
</body>
</html>
