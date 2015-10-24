<!-- #include file="Setup.asp" -->
<%

if CookieUserName=empty then error("您还未<a href=Login.asp?ReturnUrl="&ReturnUrl&">登录</a>论坛")
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
		if Ucase(FriendUserName)=Ucase(CookieUserName) then error("不能添加自己！")
		if TotalFavoriteFriend>20 then error("好友收藏夹最多只能添加20人！")
		
		if Execute("Select UserName from [BBSXP_Users] where UserName='"&FriendUserName&"'").eof then error("系统中没有 "&FriendUserName&" 的资料！")

		Rs.Open "Select * from [BBSXP_FavoriteUsers] where OwnerUserName='"&CookieUserName&"' and FriendUserName='"&FriendUserName&"'",Conn,1,3
		if Rs.eof then Rs.addNew
			Rs("OwnerUserName")=CookieUserName
			Rs("FriendUserName")=FriendUserName
		Rs.update
		Rs.close
		succeed "添加成功",""

	case "FavoriteThread"
		if TotalFavoriteThread>20 then error("帖子收藏夹最多只能添加 20 条数据！")
		
		if Execute("Select ThreadID from [BBSXP_Threads] where ThreadID="&ThreadID&"").eof then error("系统中没有ID为 "&ThreadID&" 的主题！")

		Rs.Open "Select * from [BBSXP_FavoriteThreads] where OwnerUserName='"&CookieUserName&"' and ThreadID="&ThreadID&"",Conn,1,3
		if Rs.eof then Rs.addNew
			Rs("OwnerUserName")=CookieUserName
			Rs("ThreadID")=ThreadID
		Rs.update
		Rs.close
		succeed "添加成功",""
		
	case "FavoriteForums"
		if TotalFavoriteForums>20 then error("论坛收藏夹最多只能添加 20 条数据！")
		
		if Execute("Select ForumID from [BBSXP_Forums] where ForumID="&ForumID&"").eof then error("系统中没有ID为 "&ForumID&" 的论坛！")

		Rs.Open "Select * from [BBSXP_FavoriteForums] where OwnerUserName='"&CookieUserName&"' and ForumID="&ForumID&"",Conn,1,3
		if Rs.eof then Rs.addNew
			Rs("OwnerUserName")=CookieUserName
			Rs("ForumID")=ForumID
		Rs.update
		Rs.close
		succeed "添加成功",""
		
		
		

	case "DelFavoriteForums"
		Execute("delete from [BBSXP_FavoriteForums] where OwnerUserName='"&CookieUserName&"' and ForumID="&ForumID&"")
		succeed "删除成功",""
				
	case "DelFavoriteThreads"
		Execute("delete from [BBSXP_FavoriteThreads] where OwnerUserName='"&CookieUserName&"' and ThreadID="&ThreadID&"")
		succeed "删除成功",""
		
	case "DelFavoriteFriend"
		Execute("delete from [BBSXP_FavoriteUsers] where OwnerUserName='"&CookieUserName&"' and FriendUserName='"&FriendUserName&"'")
		succeed "删除成功",""
	case else
		default
	end select
Sub Default
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> → 收藏夹</div>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<TR id=CommonListTitle align="center">
		<TD><a href="EditProfile.asp">资料修改</a></td>
		<TD><a href="EditProfile.asp?menu=pass">密码修改</a></td>
		<TD><a href="MyUpFiles.asp">上传管理</a></td>
		<TD><a href="MyFavorites.asp">收 藏 夹</a></td>
		<TD><a href="MyMessage.asp">短信服务</a></td>
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
	<tr id="CommonListTitle"><td colspan=7>好友列表</td></tr>
	<tr id="CommonListHeader" align="center">
		<td>用户名</td>
		<td width="10%">发短信</td>
		<td width="10%">发帖数</td>
		<td width="10%">经验</td>
		<td width="10%">金钱</td>
		<td width="25%">最近活动</td>
		<td width="10%">动作</td>
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
		<td><a onclick="return window.confirm('确实要将 <%=Rs("UserName")%> 从好友列表中删除?')" href="?menu=DelFavoriteFriend&FriendUserName=<%=Rs("UserName")%>"><img src=images/delete.gif border=0></a></td>
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
	<tr id="CommonListTitle"><td colspan=7>关注您的用户</td></tr>
	<tr id="CommonListHeader" align="center">
		<td>用户名</td>
		<td width="10%">发短信</td>
		<td width="10%">发帖数</td>
		<td width="10%">经验</td>
		<td width="10%">金钱</td>
		<td width="25%">最近活动</td>
		<td width="10%">动作</td>
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
		<td><a title="将 <%=Rs("UserName")%> 加为好友" href="MyFavorites.asp?menu=FavoriteFriend&FriendUserName=<%=Rs("UserName")%>"><img src=images/favs.gif border=0></a></td>
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
	<tr id="CommonListTitle"><td colspan=3>论坛收藏夹</td></tr>
	<tr id="CommonListHeader" align="center">
		<td width="30%">版块名称</td>
		<td>描述</td>
		<td width="10%">动作</td>
	</tr>
<%





	For i=0 To Ubound(SQL,2)

		Set Rs=Execute("Select * from [BBSXP_Forums] where ForumID="&SQL(0,i)&"")
		if Rs.eof then Execute("delete from [BBSXP_FavoriteForums] where ForumID="&SQL(0,i)&"")

%>
	<tr id="CommonListCell">
		<td><a href="ShowForum.asp?ForumID=<%=Rs("ForumID")%>" target=_blank><%=Rs("ForumName")%></a></td>
		<td><%=YbbEncode(Rs("ForumDescription"))%></td>
		<td align=center><a onclick="return window.confirm('您确定要删除该链接?')" href="?menu=DelFavoriteForums&ForumID=<%=Rs("ForumID")%>"><img src=images/delete.gif border=0></a></td>
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
	<tr id="CommonListTitle"><td colspan=6>帖子收藏夹</td></tr>
	<tr align="center" id="CommonListHeader">
		<td width="40%">主题</td>
		<td width="10%">作者</td>
		<td width="10%">回复</td>
		<td width="10%">查看</td>
		<td>最后更新</td>
		<td width="10%">动作</td>
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
		<td align=center><a onclick="return window.confirm('您确定要删除该链接?')" href="?menu=DelFavoriteThreads&ThreadID=<%=Rs("ThreadID")%>"><img src=images/delete.gif border=0></a></td>
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