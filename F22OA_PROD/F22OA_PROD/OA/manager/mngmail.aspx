<%@ page language="C#" autoeventwireup="true" inherits="manager_mngmail, App_Web_mngmail.aspx.3665c05a" %>

<%@ Register Src="../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>邮件管理</title>
		<LINK href="../css/project.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../js/project.js" type="text/javascript"></script>
</head>
<body  topMargin="1" leftmargin="1" rightmargin="0">
    <form id="form1" runat="server">
    <div> <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
        <div class=content> <h2><strong>
           
        </strong></h2>
				</div>
			<TABLE class="newsitem" id="Table1" cellSpacing="0"
				cellPadding="0" width="96%" align="center" border="0">
			
			
				<SCRIPT language="javascript"  type="text/javascript" src="js/calendar2.js"></SCRIPT>
				<SCRIPT language="javascript"  type="text/javascript" src="js/dateValidate.js"></SCRIPT>
				<tr>
					<td style="HEIGHT: 21px">
						<table><tr><td><asp:checkbox id="cbclass" accessKey="e" runat="server" Text="[已读]" ToolTip="选定后，根据是否对方已读分类"></asp:checkbox></td>
						<td>开始日期:</td>
						<td>
                            <igsch:WebDateChooser ID="tbfrom" runat="server">
                            </igsch:WebDateChooser></td><td style="width: 51px">结束日期</td><td><igsch:WebDateChooser ID="tbto" runat="server">
                            </igsch:WebDateChooser>
                            </td><td><asp:button id="btsearch" accessKey="s" runat="server" Text="搜 索...(S)" OnClick="btsearch_Click" CssClass="btn"></asp:button></td></tr></table>
							
							
							
					</td>
				</tr>
				<TR>
					<TD><asp:datagrid id="dg" runat="server" ToolTip="点击新闻标题，可以修改" CssClass="tbGrid"  CellSpacing="1" Width="100%" AutoGenerateColumns="False"
							ShowFooter="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated" OnSelectedIndexChanged="dg_SelectedIndexChanged">
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
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.mailid") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="文件明细">
									<ItemStyle HorizontalAlign="Left"></ItemStyle>
									<ItemTemplate>
										<A  href='../isprit/mail/maildetail.aspx?mailid=<%# Eval("mailid") %>'>
											<%# Eval("title") %>
										</A>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="发件人">
									<ItemTemplate>
										<asp:Label ID="Label2" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.fromname") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="收件人">
									<ItemTemplate>
										<asp:Label ID="Label3" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.toname") %>' >
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText=" 传送时间">
									<HeaderStyle Width="100px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label ID="Label4" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.crdate", "{0:d}") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="收件人未读">
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<%# DataBinder.Eval(Container, "DataItem.readit") == "False" ? "是" : "否"%>
										
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="发件人未删">
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<%# DataBinder.Eval(Container, "DataItem.fromuse").ToString()=="False"?"否":"是" %>
										
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="收件人未删">
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<%# DataBinder.Eval(Container, "DataItem.touse") == "False" ? "否" : "是"%>
									
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<HeaderTemplate>
										删除
									</HeaderTemplate>
									<ItemTemplate>
										<asp:ImageButton id="IbDel" runat="server" ToolTip="删除此行?" ImageUrl="icon/delete.gif" CommandName="delete"></asp:ImageButton>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Center" ForeColor="White" Position="TopAndBottom" BackColor="#2461BF"></pagerStyle>
                        <EditItemStyle BackColor="#2461BF" />
                        <AlternatingItemStyle BackColor="White" />
						</asp:datagrid>
						<P><asp:button id="btOK" accessKey="d" runat="server" Text="删除选定的记录(D)" Width="160px" OnClick="btOK_Click" CssClass="btr"></asp:button>
           <input type="button" onclick="closeTab(0)" value="关 闭" class="btn" />
            </P>
					</TD>
				</TR>
			</TABLE>
    </div>
    </form>
</body>
</html>
