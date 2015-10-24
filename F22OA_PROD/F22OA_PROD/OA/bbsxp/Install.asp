<!-- #include file="Setup.asp" -->

<%
youip="127.0.0.1" '您本机的IP地址

if Not Execute("Select UserName from [BBSXP_Users] where UserRoleID=1").eof then

	if REMOTE_ADDR<>youip then error("为了安全起见，请编辑 <font color=red>Install.asp</font> 内的IP地址<li>请把它设置成 <font color=red>"&REMOTE_ADDR&"</font>")

end if

AdminUserName=HTMLEncode(Request("UserName"))

HtmlTop

if Request("menu")="ok" then
	if AdminUserName="" then error("您没有输入管理员")
	If Execute("Select UserID From [BBSXP_Users] where UserName='"&AdminUserName&"'" ).eof Then error(""&AdminUserName&"的用户资料还未<a href=CreateUser.asp>注册</a>")

	Execute("Update [BBSXP_Users] Set UserRoleID=1 where UserName='"&AdminUserName&"'")

	Message=Message&"<li>添加成功</li><li><a href=Admin_Default.asp target=_top>返回论坛管理</a></li>"
	succeed Message,"Default.asp"
elseif Request("menu")="DeleteAdmin" then
	Execute("Update [BBSXP_Users] Set UserRoleID=3 where UserName='"&AdminUserName&"'")
	succeed "删除成功","Default.asp"
end if

%>
<title>安装BBSXP...</title>
<form method="POST"><input type="hidden" value="ok" name="menu">
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td align=center colspan="2">设置论坛管理员</td>
	</tr>
	<tr id=CommonListCell><td align=right width="40%">管 理 员：</td>
		<td><input name=UserName size="40"></td>
	</tr>
	<tr id=CommonListCell>
		<td align=center colspan="2"><input type="submit" value=" 添 加 "></td>
	</tr>
</table>
</form>
<center>注：<a target="_blank" href="CreateUser.asp">如果 <b>用户名</b> 还没有注册请点击这里进行注册</a></center>
<br>
<table border="0" cellpadding="5" cellspacing="1" id=CommonListArea width=100%>
  <tr id=CommonListTitle align="center">
    <td width="12%">用户名</td>
    <td width="12%">角色</td>
    <td width="13%">注册时间</td>
    <td width="17%">活动时间</td>

    <td width="13%">权限</td>
  </tr>
<%
sql="Select * from [BBSXP_Users] where UserRoleID=1"
Rs.open sql,conn,1
do while not rs.eof
%>
  <tr id=CommonListCell align="center">
    <td><a target="_blank" href="Profile.asp?UserName=<%=Rs("UserName")%>"><%=Rs("UserName")%></a></td>
    <td><%=ShowRole(RS("UserRoleID"))%></td>
    
    <td><%=Rs("UserRegisterTime")%><br><%=Rs("UserRegisterIP")%></td>
    <td><%=Rs("UserActivityTime")%><br><%=Rs("UserActivityIP")%></td>
    <td><a href="?menu=DeleteAdmin&UserName=<%=Rs("UserName")%>" onclick="return window.confirm('您确定要去掉该管理员的权限?');">删除</a></td>
  </tr>
<%
	Rs.movenext
loop
Rs.close
%>
</table>
<%
UpdateStatistics 0,0,0
HtmlBottom
%>