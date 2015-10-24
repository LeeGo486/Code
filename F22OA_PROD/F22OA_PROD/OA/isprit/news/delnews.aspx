<%@ page language="C#" autoeventwireup="true" inherits="isprit_news_delnews, App_Web_delnews.aspx.9a188d08" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>新闻编辑</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div id="container">
				<div class="content">
					<h2><strong>公告、新闻管理</strong></h2>
				</div>
				<TABLE class="newsitem" id="Table1" accessKey="t" borderColor="silver" cellSpacing="0"
					cellPadding="0" width="780" align="center" border="1">
			
					<SCRIPT language="javascript" src="js/calendar2.js"></SCRIPT>
					<SCRIPT language="javascript" src="js/dateValidate.js"></SCRIPT>
					<tr>
						<td style="HEIGHT: 21px">
							<P>搜索条件:
								<asp:checkbox id="cbclass" accessKey="e" runat="server" ToolTip="选定后，根据新闻类别分类后搜索!"></asp:checkbox>
								<asp:dropdownlist id="ddclass" accessKey="q" runat="server" DataValueField="classid" DataTextField="newsclass"
									Width="104px" CssClass="button"></asp:dropdownlist>(Q)&nbsp; 根据日期:
								<asp:textbox id="tbfrom" accessKey="a" runat="server" Width="80px" ToolTip="日期格式2005-08-12" CssClass="textbox"
									MaxLength="10"></asp:textbox>
								<a href="javascript:showCalendar('tbfrom',false,'tbfrom');" onclick="event.cancelBubble=true;"
									target="_self"><img src="../../icon/calendar2.gif" width="25" height="22" border="0" align="absMiddle"></a>
								至
								<asp:textbox id="TbTo" accessKey="b" runat="server" Width="80px" ToolTip="日期格式2005-08-12" CssClass="textbox"
									MaxLength="10"></asp:textbox>
								<a href="javascript:showCalendar('tbto',false,'tbto');" onclick="event.cancelBubble=true;"
									target="_self"><IMG height="22" src="../../icon/calendar2.gif" width="25" align="absMiddle"
										border="0"></a>
								<asp:button id="btsearch" accessKey="s" runat="server" Text="搜 索...(S)" OnClick="btsearch_Click" CssClass="btn"></asp:button><a href="newsclass.aspx">新增新闻类别</a></P>
						</td>
					</tr>
					<TR>
						<TD  height="200px" valign="top" >
						<asp:datagrid id="dg" runat="server" ToolTip="点击新闻标题，可以修改" CssClass="tbGrid"  CellSpacing="1"  CellPadding="4" ShowFooter="True" AutoGenerateColumns="False"
								Width="760px" GridLines="None" ForeColor="#333333" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated" OnSelectedIndexChanged="dg_SelectedIndexChanged">
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
											<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.newsid") %>'>
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="标题">
										<ItemStyle HorizontalAlign="Left"></ItemStyle>
										<ItemTemplate>
											<A  href='addnews.aspx?action=edit&newsid=<%# Eval("newsid") %>'>
												<%# Eval("title") %>
											</A>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="类别">
										<ItemTemplate>
											<asp:Label ID="Label2" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.newsclass") %>'>
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText=" 发布时间">
										<HeaderStyle Width="100px"></HeaderStyle>
										<ItemTemplate>
											<asp:Label ID="Label3" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.crdate", "{0:d}") %>'>
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="排列位置">
										<HeaderStyle Width="60px"></HeaderStyle>
										<ItemTemplate>
											<asp:Label ID="Label4" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.location") %>'>
											</asp:Label>
										</ItemTemplate>
										<EditItemTemplate>
											<asp:TextBox runat="server" ID="tbplace" Width=40 CssClass=textbox Text='<%# DataBinder.Eval(Container, "DataItem.location") %>'>
											</asp:TextBox>
											<asp:RangeValidator id="rv" ControlToValidate="tbplace" runat="server" ErrorMessage="小于101正数" MinimumValue="1"
												MaximumValue="100" Type="Integer"></asp:RangeValidator>
										</EditItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="可用">
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<ItemTemplate>
											<asp:CheckBox id="cbUse" runat="server" BorderColor="White" BorderWidth="1px" Checked='<%# DataBinder.Eval(Container, "DataItem.usable") %>'>
											</asp:CheckBox>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:EditCommandColumn UpdateText="更新" HeaderText="更改" CancelText="取消" EditText="修改">
										<HeaderStyle Width="60px"></HeaderStyle>
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
									</asp:EditCommandColumn>
									<asp:TemplateColumn>
										<HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<HeaderTemplate>
											删除
										</HeaderTemplate>
										<ItemTemplate>
											<asp:ImageButton id="IbDel" runat="server" ToolTip="删除此行?" CommandName="delete" ImageUrl="../icon/delete.gif"></asp:ImageButton>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
								<pagerStyle HorizontalAlign="Center" ForeColor="White" Position="TopAndBottom" BackColor="#666666"></pagerStyle>
                            <EditItemStyle  />
							</asp:datagrid>
							<P><asp:button id="btOK" accessKey="d" runat="server" Width="160px" Text="删除选定的新闻(D)" OnClick="btOK_Click" CssClass="btr"></asp:button>
                                &nbsp;</P>
						</TD>
					</TR>
				</TABLE>
			</div>
    </div>
    </form>
</body>
</html>
