<%@ page language="C#" autoeventwireup="true" inherits="isprit_member_colleague, App_Web_colleague.aspx.be6dd291" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>同事</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
</head>
<body topmargin="2" leftmargin="1" bgcolor="#f7f7f7">
    <form id="form1" runat="server">
    <div>
    <div id="container">
				<div class="content">
					<h2><strong>同事资料查询</strong></h2>
				</div>
				<TABLE id="Table1" width="100%">
					<tr>
						<td><FIELDSET align="left">
								<LEGEND align="left" style="WIDTH: 96px; HEIGHT: 14px">
									搜索同事信息</LEGEND>
								<TABLE id="Table2" cellSpacing="1" cellPadding="1" width="100%" border="0">
									<TR>
										<TD style="WIDTH: 130px">姓名:<INPUT class="tbox" cname="姓名" nullable="n" id="tbname" style="WIDTH: 91px; "
												type="text" size="9" runat="server"></TD>
										<TD style="WIDTH: 63px">
											<asp:DropDownList id="ddl" runat="server"  CssClass="button">
												<asp:ListItem Value="or" Selected="True">或者</asp:ListItem>
												<asp:ListItem Value="and">并且</asp:ListItem>
											</asp:DropDownList></TD>
										<TD style="WIDTH: 171px">部门: <INPUT class="tbox" id="tbdepart" style="WIDTH: 110px;" type="text" size="13"
												name="Text2" runat="server"></TD>
										<TD>
											<asp:ImageButton id="imbfind" runat="server" Height="18px" ImageUrl="../../icon/search.gif" OnClick="imbfind_Click"></asp:ImageButton></TD>
										<TD>
											<P><FONT face="宋体">姓名和部门都留空，则查询所有记录!</FONT></P>
										</TD>
									</TR>
								</TABLE>
							</FIELDSET>
						</td>
					</tr>
					<TR>
						<TD>
							<asp:DataList id="dlc" runat="server" Width="100%" ShowFooter="False"  >
								<HeaderTemplate>
									<tr class="dgHeader" align="center" style="height:26px">
										<td>姓名</td>
										<td>手机</td>
										<td>电话</td>
										<td>电邮</td>
										<td>部门</td>
										<td>职位</td>
										<td>状态</td>
									</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr align="center" height="20px" onmouseover="this.bgColor='#ddeeee'" onmouseout="this.bgColor=''">
										<td><a href='showuser.aspx?userid=<%# DataBinder.Eval(Container, "DataItem.id") %>' >
												<%# DataBinder.Eval(Container, "DataItem.username") %>
											</a>
										</td>
										<td><%# DataBinder.Eval(Container, "DataItem.mobile") %></td>
										<td><%# DataBinder.Eval(Container, "DataItem.phone") %></td>
										<td><a href='mailto:<%# DataBinder.Eval(Container, "DataItem.email") %>'><%# DataBinder.Eval(Container, "DataItem.email") %></a></td>
										<td><%# DataBinder.Eval(Container, "DataItem.ddepartment") %></td>
										<td><%# DataBinder.Eval(Container, "DataItem.dduty") %></td>
										<td><%# cto(Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.usable"))) %></td>
									</tr>
								</ItemTemplate>
							</asp:DataList></TD>
					</TR>
					<TR>
						<TD  align="left">
							<webdiyer:AspNetpager id="ap" runat="server" AlwaysShow="True" SubmitButtonText="转到" InputBoxClass="button"
								PageSize="15" ShowInputBox="Always" InputBoxStyle="button" SubmitButtonClass="button" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager></TD>
					</TR>
				</TABLE>
			</div>
    </div>
    </form>
</body>
</html>
