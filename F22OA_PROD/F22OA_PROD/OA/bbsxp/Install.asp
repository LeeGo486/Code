<!-- #include file="Setup.asp" -->

<%
youip="127.0.0.1" '��������IP��ַ

if Not Execute("Select UserName from [BBSXP_Users] where UserRoleID=1").eof then

	if REMOTE_ADDR<>youip then error("Ϊ�˰�ȫ�������༭ <font color=red>Install.asp</font> �ڵ�IP��ַ<li>��������ó� <font color=red>"&REMOTE_ADDR&"</font>")

end if

AdminUserName=HTMLEncode(Request("UserName"))

HtmlTop

if Request("menu")="ok" then
	if AdminUserName="" then error("��û���������Ա")
	If Execute("Select UserID From [BBSXP_Users] where UserName='"&AdminUserName&"'" ).eof Then error(""&AdminUserName&"���û����ϻ�δ<a href=CreateUser.asp>ע��</a>")

	Execute("Update [BBSXP_Users] Set UserRoleID=1 where UserName='"&AdminUserName&"'")

	Message=Message&"<li>��ӳɹ�</li><li><a href=Admin_Default.asp target=_top>������̳����</a></li>"
	succeed Message,"Default.asp"
elseif Request("menu")="DeleteAdmin" then
	Execute("Update [BBSXP_Users] Set UserRoleID=3 where UserName='"&AdminUserName&"'")
	succeed "ɾ���ɹ�","Default.asp"
end if

%>
<title>��װBBSXP...</title>
<form method="POST"><input type="hidden" value="ok" name="menu">
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td align=center colspan="2">������̳����Ա</td>
	</tr>
	<tr id=CommonListCell><td align=right width="40%">�� �� Ա��</td>
		<td><input name=UserName size="40"></td>
	</tr>
	<tr id=CommonListCell>
		<td align=center colspan="2"><input type="submit" value=" �� �� "></td>
	</tr>
</table>
</form>
<center>ע��<a target="_blank" href="CreateUser.asp">��� <b>�û���</b> ��û��ע�������������ע��</a></center>
<br>
<table border="0" cellpadding="5" cellspacing="1" id=CommonListArea width=100%>
  <tr id=CommonListTitle align="center">
    <td width="12%">�û���</td>
    <td width="12%">��ɫ</td>
    <td width="13%">ע��ʱ��</td>
    <td width="17%">�ʱ��</td>

    <td width="13%">Ȩ��</td>
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
    <td><a href="?menu=DeleteAdmin&UserName=<%=Rs("UserName")%>" onclick="return window.confirm('��ȷ��Ҫȥ���ù���Ա��Ȩ��?');">ɾ��</a></td>
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