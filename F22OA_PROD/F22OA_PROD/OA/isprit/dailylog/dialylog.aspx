<%@ page language="C#" autoeventwireup="true" inherits="isprit_dailylog_dialylog, App_Web_dialylog.aspx.d55211a1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    	<title>dialylog</title>
		<link href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
	    <script language="javascript" type="text/javascript" src="../../js/project.js" ></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class="content"><h2><strong>日志查询</strong></h2></div>
		    
			<table width="100%" border="0" cellspacing="1">			
			<tr><td><table><tr><td>选择时间段:</td><td>
                <igsch:WebDateChooser ID="wdc1" ToolTip="开始日期" runat="server">
                </igsch:WebDateChooser>
            </td>
			    <td>   <igsch:WebDateChooser ID="wdc2" runat="server" ToolTip="结束日期">
                    </igsch:WebDateChooser></td><td>
                        <asp:TextBox ID="tbsearch" Width="120px" runat="server"></asp:TextBox></td><td>
                    <asp:ImageButton ID="imbsearch" runat="server" AlternateText="查询" ImageUrl="../../icon/search.gif" ToolTip="有查询字符时，是没有时间限制的" OnClick="imbsearch_Click" /></td>
			</tr></table></td></tr>	
				<tr>
					<td>
						<asp:datagrid id="dg" runat="server" GridLines="None"  CssClass="tbGrid"  CellSpacing="1" CellPadding="4" AutoGenerateColumns="False" ShowFooter="True" Width="100%" OnItemCreated="dg_ItemCreated" OnItemDataBound="dg_itembound">
							<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center" Width="50px"></ItemStyle>
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
								<asp:TemplateColumn HeaderText="日志时间">
									<HeaderStyle Width="65px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.logdate", "{0:yyyy-M-d}") %>' ID="Label1" >
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="类别">
									<HeaderStyle Width="80px"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# i2c( Convert.ToInt16(DataBinder.Eval(Container, "DataItem.class"))) %>' ID="Label3" >
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="日志内容">
									<ItemTemplate>
										<a  href='dialylog_show.aspx?id=<%# Eval("id") %>'>
											<%# cutstr(Eval("content").ToString())%>
										</a>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="编辑">
									<HeaderStyle Width="40px"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<a href='dialylog_add.aspx?action=edit&amp;id=<%# DataBinder.Eval(Container, "DataItem.id") %>'>
											编辑</a>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle HorizontalAlign="Center" Width="30px"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<HeaderTemplate>
										删除
									</HeaderTemplate>
									<ItemTemplate>
										<asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../../icon/delete.gif" CommandName="delete"></asp:ImageButton>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="ID">
									<ItemStyle HorizontalAlign="Center" Width="60px"></ItemStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.id") %>' ID="Label2" >
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle Position="TopAndBottom"></pagerStyle>
						</asp:datagrid>
						<webdiyer:AspNetpager id="ap" runat="server" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager>
                        <asp:Label ID="lberr" runat="server" CssClass="tip"></asp:Label></td>
				</tr>
				<tr>
					<td><asp:Button ID="btdel" runat="server" Text="删除选定日志(D)" OnClick="btdel_Click" CssClass="btr"></asp:Button>
						</td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
