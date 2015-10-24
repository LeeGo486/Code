<%@ page language="C#" autoeventwireup="true" inherits="isprit_schedule_dialytask, App_Web_dialytask.aspx.4c52363" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>dialyTask</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
	
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body topmargin="1" leftmargin="1">
    <form id="form1" runat="server">
    <div>
    <table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr class="header">
					<td><IMG alt="" src="../../icon/menu/diary.gif">
						<asp:label id="lbdate0" runat="server"></asp:label>
						<asp:hyperlink id="hladdnew" accessKey="a" runat="server" CssClass="button">新建日程(A)</asp:hyperlink></td>
				</tr>
				<tr>
					<td><IMG alt="" src="../../icon/menu/calendar2.gif">
						<asp:label id="lbdate1" runat="server" CssClass="bt"></asp:label><FONT face="宋体">的日程安排</FONT></td>
				</tr>
				<tr>
					<td>
    <div id="tmTable">
          <asp:datagrid id="dgaffair" runat="server" AutoGenerateColumns="False" Width="80%" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated">
								<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader" Height="26px"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="开始-结束时间">
									<HeaderStyle Width="120px"></HeaderStyle>
									<ItemStyle Wrap="False"></ItemStyle>
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.startdate","{0:HH:mm}") %>'>
										</asp:Label>-
										<asp:Label ID="Label2" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.enddate","{0:HH:mm}") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="日程内容">
									<ItemStyle HorizontalAlign="Left"></ItemStyle>
									<ItemTemplate>
										<img border=0 src='img\<%# DataBinder.Eval(Container, "DataItem.icon") %>'>
										<asp:Label ID="Label3" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vcEvent") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="完成状态">
									<HeaderStyle Width="60px"></HeaderStyle>
									<ItemTemplate>
										<%# c2s(Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.done"))) %>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="更改状态">
									<HeaderStyle Width="60px"></HeaderStyle>
									<ItemTemplate>
										<asp:Button ID="btchange" Runat="server" CssClass="button" Text="更改" CommandName="update"></asp:Button>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="删除">
									<HeaderStyle Width="40px"></HeaderStyle>
									<ItemTemplate>
										<asp:ImageButton id="IbDel" runat="server" ToolTip='<%# DataBinder.Eval(Container, "DataItem.idSchedule") %>' ImageUrl="../icon/delete.gif" CommandName="delete">
										</asp:ImageButton>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></div></td>
				</tr>
			</table>
    </div>
    <script type="text/javascript" defer="defer">
    	jsTable('tmTable','tm','95%','','center')
    </script>
    </form>
</body>
</html>
