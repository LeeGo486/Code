<!-- #include file="Setup.asp" --><%
HtmlTop
ForumID=RequestInt("ForumID")
sql="Select * from [BBSXP_Forums] where ForumID="&ForumID&""
Set Rs=Execute(sql)
	if Rs.eof then error"<li>ϵͳ�Ҳ�������̳������"
	ForumName=Rs("ForumName")
	Moderated=Rs("Moderated")
	ParentID=Rs("ParentID")
	GroupID=Rs("GroupID")
Rs.close
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� <%=ForumTree(ParentID)%><a href="ShowForum.asp?ForumID=<%=ForumID%>"><%=ForumName%></a> �� Ȩ���б�</div>

<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td>��ɫ</td>
		<td align="center" width="9%">���</td>
		<td align="center" width="9%">�Ķ�</td>
		<td align="center" width="9%">����</td>
		<td align="center" width="9%">�ظ�</td>
		<td align="center" width="9%">�༭</td>
		<td align="center" width="9%">ɾ��</td>
		<td align="center" width="9%">����ͶƱ</td>
		<td align="center" width="9%">ͶƱ</td>
		<td align="center" width="9%">����</td>
		<td align="center" width="9%">����</td>
	</tr>
<%
sql="Select * from [BBSXP_ForumPermissions] where ForumID="&ForumID&" order by RoleID"
Set Rs=Execute(sql)
	Do While Not Rs.EOF 
%>
	<tr id=CommonListCell>
		<td><%=Execute("Select Name From [BBSXP_Roles] where RoleID="&RS("RoleID")&"")(0)%></td>
		<td align="center"><img src="Images/ForumPermissions<%=RS("PermissionView")%>.gif"></td>
		<td align="center"><img src="Images/ForumPermissions<%=RS("PermissionRead")%>.gif"></td>
		<td align="center"><img src="Images/ForumPermissions<%=RS("PermissionPost")%>.gif"></td>
		<td align="center"><img src="Images/ForumPermissions<%=RS("PermissionReply")%>.gif"></td>
		<td align="center"><img src="Images/ForumPermissions<%=RS("PermissionEdit")%>.gif"></td>
		<td align="center"><img src="Images/ForumPermissions<%=RS("PermissionDelete")%>.gif"></td>
		<td align="center"><img src="Images/ForumPermissions<%=RS("PermissionCreatePoll")%>.gif"></td>
		<td align="center"><img src="Images/ForumPermissions<%=RS("PermissionVote")%>.gif"></td>
		<td align="center"><img src="Images/ForumPermissions<%=RS("PermissionAttachment")%>.gif"></td>
		<td align="center"><img src="Images/ForumPermissions<%=RS("PermissionManage")%>.gif"></td>
	</tr>
<%
		Rs.MoveNext
	loop
Rs.Close
%>
</table>
<center><br><a href="javascript:history.back()">&lt; �� �� &gt;</a>
<%
HtmlBottom
%>