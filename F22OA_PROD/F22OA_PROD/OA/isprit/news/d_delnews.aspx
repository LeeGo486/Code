<%@ page language="C#" autoeventwireup="true" inherits="OA_isprit_news_d_delnews, App_Web_d_delnews.aspx.9a188d08" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>新闻编辑</title>
	<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
	<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
    <SCRIPT language="javascript" src="js/calendar2.js"></SCRIPT>
    <SCRIPT language="javascript" src="js/dateValidate.js"></SCRIPT>
</head>
<body  topMargin="20" leftmargin="1" rightmargin="0">
    <form id="form1" runat="server">

				<TABLE class="newsitem" id="Table1" accessKey="t" cellSpacing="5"
					cellPadding="0" width="780" align="center" border="0">

					<tr>
						<td style="HEIGHT: 21px">
						<table>
						<tr>
						<td>搜索条件:<asp:checkbox id="cbclass" accessKey="e" runat="server" ToolTip="选定后，根据新闻类别分类后搜索!"></asp:checkbox>
								<asp:dropdownlist id="ddclass" accessKey="q" runat="server" DataValueField="classid" DataTextField="newsclass"
									Width="104px" CssClass="button"></asp:dropdownlist>(Q)&nbsp;  根据日期:</td>
						<td><igsch:WebDateChooser ID="wdc1" ToolTip="开始日期" runat="server">
                </igsch:WebDateChooser></td>
						<td>至</td>
						<td><igsch:WebDateChooser ID="wdc2" runat="server" ToolTip="结束日期">
                    </igsch:WebDateChooser></td>
                    <td><asp:button id="btsearch" accessKey="s" runat="server" Text="搜 索...(S)" OnClick="btsearch_Click" CssClass="btn"></asp:button>
                    &nbsp;<a href="newsclass.aspx">新增新闻类别</a></td>
						</tr>
						</table>
							
						</td>
					</tr>
					<TR>
						<TD  height="200px" valign="top" >
						<asp:datagrid id="dg" runat="server" ToolTip="点击新闻标题进入修改" CssClass="tbGrid"  CellSpacing="1"  CellPadding="4" ShowFooter="True" AutoGenerateColumns="False"
								Width="760px" GridLines="None" ForeColor="#333333" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated" >
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
											<A  href='d_newsadd.aspx?action=edit&newsid=<%# Eval("newsid") %>'>
												<%# Eval("title") %>
											</A>
										</ItemTemplate>
									</asp:TemplateColumn>
									
									<asp:TemplateColumn HeaderText="发布时间">
										<HeaderStyle Width="100px"></HeaderStyle>
										<ItemTemplate>
											<asp:Label ID="Label3" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.crdate", "{0:d}") %>'>
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="置顶">
										<HeaderStyle></HeaderStyle>
										<ItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" Enabled="false" runat="server" Checked='<%# s2b(Int32.Parse(Eval("location").ToString())) %>' />											
										</ItemTemplate>
										<EditItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" Enabled="true" runat="server" Checked='<%# s2b(Int32.Parse(Eval("location").ToString())) %>' />	
                                        </EditItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="锁定">
										<HeaderStyle></HeaderStyle>
										<ItemTemplate>
                                                <asp:CheckBox ID="isLock" Enabled="false" runat="server" Checked='<%# DataBinder.Eval(Container, "DataItem.isLock") %>' />								
										</ItemTemplate>
										<EditItemTemplate>
                                                <asp:CheckBox ID="isLock" Enabled="true" runat="server" Checked='<%# DataBinder.Eval(Container, "DataItem.isLock") %>' />
                                        </EditItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="可用">
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<ItemTemplate>
											<asp:CheckBox id="cbUse" runat="server" Enabled="false" Checked='<%# DataBinder.Eval(Container, "DataItem.usable") %>'>
											</asp:CheckBox>
										</ItemTemplate>
										<EditItemTemplate>
											<asp:CheckBox id="cbUse" runat="server" Enabled="true" Checked='<%# DataBinder.Eval(Container, "DataItem.usable") %>'>
											</asp:CheckBox>
										</EditItemTemplate>

									</asp:TemplateColumn>
									<asp:EditCommandColumn UpdateText="更新" HeaderText="操作" CancelText="取消" EditText="修改">
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
											<asp:ImageButton id="IbDel" runat="server" ToolTip="确定删除这条记录吗?" CommandName="delete" ImageUrl="../icon/delete.gif"></asp:ImageButton>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<HeaderTemplate>
											查询新闻回复
										</HeaderTemplate>
										<ItemTemplate>
											<a href="d_newscallback.aspx?newsid=<%# Eval("newsid") %>">查询新闻回复</a>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
								<pagerStyle HorizontalAlign="Center" ForeColor="White" Position="TopAndBottom" BackColor="#666666"></pagerStyle>
                            <EditItemStyle  />
							</asp:datagrid>
                            
						<P><asp:button id="btOK" accessKey="d" runat="server" Width="160px" Text="删除选定的公告(D)" OnClick="btOK_Click" CssClass="btr"></asp:button></P>
						</TD>
					</TR>
				</TABLE>

    </form>
</body>
</html>

