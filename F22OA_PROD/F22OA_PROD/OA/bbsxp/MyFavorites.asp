<!-- #include file="Setup.asp" -->
<%

if CookieUserName=empty then error("����δ<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>��̳")
if ReturnUrl="" then ReturnUrl="Default.asp"

FavoriteID=RequestInt("FavoriteID")
ThreadID=RequestInt("ThreadID")
ForumID=RequestInt("ForumID")
FriendUserName=HTMLEncode(Request("FriendUserName"))




HtmlTop
TotalFavoriteThread=Execute("Select count(FavoriteID) From [BBSXP_FavoriteThreads] where OwnerUserName='"&CookieUserName&"'")(0)
TotalFavoriteForums=Execute("Select count(FavoriteID) From [BBSXP_FavoriteForums] where OwnerUserName='"&CookieUserName&"'")(0)
TotalFavoriteFriend=Execute("Select count(FavoriteID) From [BBSXP_FavoriteUsers] where OwnerUserName='"&CookieUserName&"'")(0)

select case Request("menu")

	case "FavoriteFriend"
		if Ucase(FriendUserName)=Ucase(CookieUserName) then error("��������Լ���")
		if TotalFavoriteFriend>20 then error("�����ղؼ����ֻ�����20�ˣ�")
		
		if Execute("Select UserName from [BBSXP_Users] where UserName='"&FriendUserName&"'").eof then error("ϵͳ��û�� "&FriendUserName&" �����ϣ�")

		Rs.Open "Select * from [BBSXP_FavoriteUsers] where OwnerUserName='"&CookieUserName&"' and FriendUserName='"&FriendUserName&"'",Conn,1,3
		if Rs.eof then Rs.addNew
			Rs("OwnerUserName")=CookieUserName
			Rs("FriendUserName")=FriendUserName
		Rs.update
		Rs.close
		succeed "��ӳɹ�",""

	case "FavoriteThread"
		if TotalFavoriteThread>20 then error("�����ղؼ����ֻ����� 20 �����ݣ�")
		
		if Execute("Select ThreadID from [BBSXP_Threads] where ThreadID="&ThreadID&"").eof then error("ϵͳ��û��IDΪ "&ThreadID&" �����⣡")

		Rs.Open "Select * from [BBSXP_FavoriteThreads] where OwnerUserName='"&CookieUserName&"' and ThreadID="&ThreadID&"",Conn,1,3
		if Rs.eof then Rs.addNew
			Rs("OwnerUserName")=CookieUserName
			Rs("ThreadID")=ThreadID
		Rs.update
		Rs.close
		succeed "��ӳɹ�",""
		
	case "FavoriteForums"
		if TotalFavoriteForums>20 then error("��̳�ղؼ����ֻ����� 20 �����ݣ�")
		
		if Execute("Select ForumID from [BBSXP_Forums] where ForumID="&ForumID&"").eof then error("ϵͳ��û��IDΪ "&ForumID&" ����̳��")

		Rs.Open "Select * from [BBSXP_FavoriteForums] where OwnerUserName='"&CookieUserName&"' and ForumID="&ForumID&"",Conn,1,3
		if Rs.eof then Rs.addNew
			Rs("OwnerUserName")=CookieUserName
			Rs("ForumID")=ForumID
		Rs.update
		Rs.close
		succeed "��ӳɹ�",""
		
		
		

	case "DelFavoriteForums"
		Execute("delete from [BBSXP_FavoriteForums] where OwnerUserName='"&CookieUserName&"' and ForumID="&ForumID&"")
		succeed "ɾ���ɹ�",""
				
	case "DelFavoriteThreads"
		Execute("delete from [BBSXP_FavoriteThreads] where OwnerUserName='"&CookieUserName&"' and ThreadID="&ThreadID&"")
		succeed "ɾ���ɹ�",""
		
	case "DelFavoriteFriend"
		Execute("delete from [BBSXP_FavoriteUsers] where OwnerUserName='"&CookieUserName&"' and FriendUserName='"&FriendUserName&"'")
		succeed "ɾ���ɹ�",""
	case else
		default
	end select
Sub Default
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� �ղؼ�</div>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<TR id=CommonListTitle align="center">
		<TD><a href="EditProfile.asp">�����޸�</a></td>
		<TD><a href="EditProfile.asp?menu=pass">�����޸�</a></td>
		<TD><a href="MyUpFiles.asp">�ϴ�����</a></td>
		<TD><a href="MyFavorites.asp">�� �� ��</a></td>
		<TD><a href="MyMessage.asp">���ŷ���</a></td>
	</TR>
</TABLE>
<br>
<%
FavoriteUsers
WatchingYou
FavoriteThreads
FavoriteForums

End Sub


Sub FavoriteUsers

	SQL = FetchEmploymentStatusList("Select FriendUserName from [BBSXP_FavoriteUsers] where OwnerUserName='"&CookieUserName&"' order by FavoriteID desc")
	if Not IsArray(SQL) then Exit Sub

%>
<table cellspacing="1" cellpadding="5" width="100%" id=CommonListArea>
	<tr id="CommonListTitle"><td colspan=7>�����б�</td></tr>
	<tr id="CommonListHeader" align="center">
		<td>�û���</td>
		<td width="10%">������</td>
		<td width="10%">������</td>
		<td width="10%">����</td>
		<td width="10%">��Ǯ</td>
		<td width="25%">����</td>
		<td width="10%">����</td>
	</tr>
<%

	
	For i=0 To Ubound(SQL,2)

		Set Rs=Execute("[BBSXP_Users] where UserName='"&SQL(0,i)&"'")
		if Rs.eof then Execute("delete from [BBSXP_FavoriteUsers] where FriendUserName="&SQL(0,i)&"")

%>
	<tr align=center id="CommonListCell">
		<td vAlign=center><a target="_blank" href=Profile.asp?UserName=<%=Rs("UserName")%>><%=Rs("UserName")%></a>
		<td><a onclick="javascript:BBSXP_Modal.Open('MyMessage.asp?menu=Post&RecipientUserName=<%=Rs("UserName")%>', 600, 350);"><img border="0" src="Images/message.gif"></a></td>
		<td><%=Rs("TotalPosts")%></td>
		<td><%=Rs("Experience")%></a>
		<td><%=Rs("UserMoney")%></a>
		<td><%=Rs("UserActivityTime")%></td>
		<td><a onclick="return window.confirm('ȷʵҪ�� <%=Rs("UserName")%> �Ӻ����б���ɾ��?')" href="?menu=DelFavoriteFriend&FriendUserName=<%=Rs("UserName")%>"><img src=images/delete.gif border=0></a></td>
	</tr>
<%
		Set Rs = Nothing
	Next
%>

</table>

<%
End Sub

Sub WatchingYou

	SQL = FetchEmploymentStatusList("Select OwnerUserName from [BBSXP_FavoriteUsers] where FriendUserName='"&CookieUserName&"' order by FavoriteID desc")
	if Not IsArray(SQL) then Exit Sub

%>
<table cellspacing="1" cellpadding="5" width="100%" id=CommonListArea>
	<tr id="CommonListTitle"><td colspan=7>��ע�����û�</td></tr>
	<tr id="CommonListHeader" align="center">
		<td>�û���</td>
		<td width="10%">������</td>
		<td width="10%">������</td>
		<td width="10%">����</td>
		<td width="10%">��Ǯ</td>
		<td width="25%">����</td>
		<td width="10%">����</td>
	</tr>
	</tr>
<%

	For i=0 To Ubound(SQL,2)

		Set Rs=Execute("[BBSXP_Users] where UserName='"&SQL(0,i)&"'")
		if Rs.eof then Execute("delete from [BBSXP_FavoriteUsers] where OwnerUserName="&SQL(0,i)&"")

%>
	<tr align=center id="CommonListCell">
		<td vAlign=center><a target="_blank" href=Profile.asp?UserName=<%=Rs("UserName")%>><%=Rs("UserName")%></a>
		<td><a onclick="javascript:BBSXP_Modal.Open('MyMessage.asp?menu=Post&RecipientUserName=<%=Rs("UserName")%>', 600, 350);"><img border="0" src="Images/message.gif"></a></td>
		<td><%=Rs("TotalPosts")%></td>
		<td><%=Rs("Experience")%></a>
		<td><%=Rs("UserMoney")%></a>
		<td><%=Rs("UserActivityTime")%></td>
		<td><a title="�� <%=Rs("UserName")%> ��Ϊ����" href="MyFavorites.asp?menu=FavoriteFriend&FriendUserName=<%=Rs("UserName")%>"><img src=images/favs.gif border=0></a></td>
	</tr>
<%
		Set Rs = Nothing
	Next

%>
</table>


<%
End Sub


Sub FavoriteForums

	SQL = FetchEmploymentStatusList("Select ForumID from [BBSXP_FavoriteForums] where OwnerUserName='"&CookieUserName&"' order by FavoriteID desc")
	if Not IsArray(SQL) then Exit Sub

%>

<table cellspacing="1" cellpadding="5" width="100%" id=CommonListArea>
	<tr id="CommonListTitle"><td colspan=3>��̳�ղؼ�</td></tr>
	<tr id="CommonListHeader" align="center">
		<td width="30%">�������</td>
		<td>����</td>
		<td width="10%">����</td>
	</tr>
<%





	For i=0 To Ubound(SQL,2)

		Set Rs=Execute("Select * from [BBSXP_Forums] where ForumID="&SQL(0,i)&"")
		if Rs.eof then Execute("delete from [BBSXP_FavoriteForums] where ForumID="&SQL(0,i)&"")

%>
	<tr id="CommonListCell">
		<td><a href="ShowForum.asp?ForumID=<%=Rs("ForumID")%>" target=_blank><%=Rs("ForumName")%></a></td>
		<td><%=YbbEncode(Rs("ForumDescription"))%></td>
		<td align=center><a onclick="return window.confirm('��ȷ��Ҫɾ��������?')" href="?menu=DelFavoriteForums&ForumID=<%=Rs("ForumID")%>"><img src=images/delete.gif border=0></a></td>
	</tr>
<%
		Set Rs = Nothing
	Next
%>
</table>
<%
End Sub




Sub FavoriteThreads

	SQL = FetchEmploymentStatusList("Select ThreadID from [BBSXP_FavoriteThreads] where OwnerUserName='"&CookieUserName&"' order by FavoriteID desc")
	if Not IsArray(SQL) then Exit Sub


%>
<table cellspacing="1" cellpadding="5" width="100%" id=CommonListArea>
	<tr id="CommonListTitle"><td colspan=6>�����ղؼ�</td></tr>
	<tr align="center" id="CommonListHeader">
		<td width="40%">����</td>
		<td width="10%">����</td>
		<td width="10%">�ظ�</td>
		<td width="10%">�鿴</td>
		<td>������</td>
		<td width="10%">����</td>
	</tr>
<%


	For i=0 To Ubound(SQL,2)

		Set Rs=Execute("Select * from [BBSXP_Threads] where ThreadID="&SQL(0,i)&"")
		if Rs.eof then Execute("delete from [BBSXP_FavoriteThreads] where ThreadID="&SQL(0,i)&"")
%>
	<tr id="CommonListCell">
		<td><a href="ShowPost.asp?ThreadID=<%=Rs("ThreadID")%>" target=_blank><%=Rs("Topic")%></a></td>
		<td align=center><a href="Profile.asp?UserName=<%=Rs("PostAuthor")%>" target="_blank"><%=Rs("PostAuthor")%></a><br><%=FormatDateTime(Rs("PostTime"),2)%></td>
		<td align=center><%=Rs("TotalReplies")%></td>
		<td align=center><%=Rs("TotalViews")%></td>
		<td align=center><%=Rs("LastTime")%><br>by <a href="Profile.asp?UserName=<%=Rs("LastName")%>" target="_blank"><%=Rs("LastName")%></a></td>
		<td align=center><a onclick="return window.confirm('��ȷ��Ҫɾ��������?')" href="?menu=DelFavoriteThreads&ThreadID=<%=Rs("ThreadID")%>"><img src=images/delete.gif border=0></a></td>
	</tr>
<%
		Set Rs = Nothing
	Next

%>
</table>

<%
End Sub






HtmlBottom
%>