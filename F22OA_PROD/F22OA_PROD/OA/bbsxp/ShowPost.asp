<!-- #include file="Setup.asp" --><%
ForumID=RequestInt("ForumID")
ThreadID=RequestInt("ThreadID")


if Request("ViewMode")<>"" then  ResponseCookies "ViewMode",Request("ViewMode"),"9999"
if RequestCookies("ViewMode")="" then ResponseCookies "ViewMode",SiteConfig("ViewMode"),"9999"
ViewMode=RequestCookies("ViewMode")


HtmlTop

if Request("menu")="Next" then
	sql="Select top 1 * from [BBSXP_Threads] where ThreadID > "&ThreadID&" and ForumID="&ForumID&" and IsApproved=1 and IsDel=0 order by ThreadID"
elseif Request("menu")="Previous" then
	sql="Select top 1 * from [BBSXP_Threads] where ThreadID < "&ThreadID&" and ForumID="&ForumID&" and IsApproved=1 and IsDel=0 order by ThreadID Desc"
else
	sql="Select * from [BBSXP_Threads] where ThreadID="&ThreadID&""
end if

Rs.Open SQL,Conn,1
	if Rs.eof or Rs.bof then error"<li>系统不存在该帖子的资料"
	Topic=ReplaceText(Rs("Topic"),"<[^>]*>","")
	Tags=Rs("Tags")
	TotalReplies=Rs("TotalReplies")
	TotalViews=Rs("TotalViews")
	IsVote=Rs("IsVote")
	IsGood=Rs("IsGood")
	ThreadTop=Rs("ThreadTop")
	IsLocked=Rs("IsLocked")
	IsApproved=Rs("IsApproved")
	IsDel=Rs("IsDel")
	PostsTableName=Rs("PostsTableName")
	Category=Rs("Category")
	ThreadID=Rs("ThreadID")
	ForumID=Rs("ForumID")
	ThreadStatus=Rs("ThreadStatus")
	UserName=Rs("PostAuthor")
	lastname=Rs("lastname")
	lasttime=Rs("lasttime")
	RatingSum=Rs("RatingSum")
	TotalRatings=Rs("TotalRatings")
Rs.close

if TotalRatings>0 then
	VoteRatings=RatingSum/TotalRatings
else
	VoteRatings=0
end if


sql="Select * from [BBSXP_Forums] where ForumID="&ForumID&""
Set Rs=Execute(sql)
	ForumName=Rs("ForumName")
	Moderated=Rs("Moderated")
	ParentID=Rs("ParentID")
	GroupID=Rs("GroupID")
	ForumUrl=Rs("ForumUrl")
	IsActive=Rs("IsActive")
Rs.Close

%>
<!-- #include file="Utility/ForumPermissions.asp" --><%

if ForumUrl<>"" then response.redirect ForumUrl
if IsActive=0 and PermissionManage=0 then error"<li>该版块已经关闭！"

if PermissionRead=0 then error"<li>您没有<a href=ShowForumPermissions.asp?ForumID="&ForumID&">权限</a>阅读帖子"
if IsDel=1 and PermissionManage=0 then error"<li>该主题在回收站中！"
if IsApproved=0 and PermissionManage=0 then error"<li>该主题正在审核中！"

Execute("update [BBSXP_Threads] Set TotalViews=TotalViews+1,LastViewedDate="&SqlNowString&" where ThreadID="&ThreadID&"")


AdvertisementGetRow=GetEmploymentStatusList("Advertisements","select Body from [BBSXP_Advertisements] where DateDiff("&SqlChar&"d"&SqlChar&","&SqlNowString&",ExpireDate) > 0")

if IsArray(AdvertisementGetRow) then
	Randomize
	AdvertisementNum=Ubound(AdvertisementGetRow,2)+1
End if

%>
<script type="text/javascript" src="Utility/PopupMenu.js"></script>
<title><%=Topic%> - <%=SiteConfig("SiteName")%> - Powered By BBSXP</title>

<div id="CommonBreadCrumbArea">
		<div style="float:left"><%ClubTree%> → <%=ForumTree(ParentID)%><a href="ShowForum.asp?ForumID=<%=ForumID%>"><%=ForumName%></a> → <a href="?ThreadID=<%=ThreadID%>"><%=Topic%></a></div>
		<div style="float:right">
		<a href="javascript:window.print();">
		<img title="打印本页" src="images/Print.gif" border="0"></a>　<script language="JavaScript">
		document.write("<a target=_blank href='Mailto:?subject="+document.title+"&body="+encodeURIComponent(location.href)+"'>");</script><img title="通过电子邮件发送本页面" src="images/mail.gif" border="0"></a>　<a href="javascript:window.external.AddFavorite(location.href,document.title)"><img title="添加到IE收藏夹" src="images/favs.gif" border="0"></a><%if CookieUserName<>empty then%>　<script language="JavaScript">
		document.write("<a onclick=\"javascript:BBSXP_Modal.Open(\'MyMessage.asp?menu=Post&ForumID=<%=ForumID%>&subject=问题帖子报告&Body=【问题帖子】："+encodeURIComponent(location.href)+"\', 600, 350);\">");</script><img title="报告本帖" src="images/feedback.gif" border="0"></a><%end if%>　<a href="?menu=Previous&ForumID=<%=ForumID%>&ThreadID=<%=ThreadID%>"><img title="浏览上一篇主题" src="images/previous.gif" border="0"></a>　<a href="?menu=Next&ForumID=<%=ForumID%>&ThreadID=<%=ThreadID%>"><img title="浏览下一篇主题" src="images/next.gif" border="0"></a>
		</div>　 
</div>




<table cellspacing="1" cellpadding="5" width="100%" id="CommonListArea">
	<tr id="CommonListTitle">
		<td colspan="2"><div style=float:left><%=Topic%></div><%if Tags<>"" then%><div style=float:right><img src="images/tag.gif" title="标签：<%=Tags%>"></div><%end if%></td>
	</tr>
	<tr id="CommonListCell">
		<td align="center" width="5%"><img src="images/totel.gif"></td>
		<td>发起人：<a href="Profile.asp?UserName=<%=UserName%>"><%=UserName%></a>　　回复数：<b><%=TotalReplies%></b>　　浏览数：<b><%=TotalViews%></b>　　最后更新：<%=lasttime%> 
		by <a href="Profile.asp?UserName=<%=lastname%>"><%=lastname%></a></td>
	</tr>
</table>


<br>


<div class="PopupMenu" id="View" style="DISPLAY: none">
	<table cellspacing="0" cellpadding="1">
		<tr>
			<td><a href="?ThreadID=<%=ThreadID%>&ViewMode=0">简洁模式</a></td>
		</tr>
		<tr>
			<td><a href="?ThreadID=<%=ThreadID%>&ViewMode=1">完整模式</a></td>
		</tr>
	</table>
</div>

<table cellspacing="0" cellpadding="0" border="0" width="100%">
		<tr>
			<td>
			<%if CookieUserName<>"" then%>
			<a class="CommonTextButton"><script type="text/javascript" src="Utility/vote.js"></script><script language="JavaScript">ThreadID=<%=ThreadID%>;showData("<%=VoteRatings%>");</script></a>
			<%
				if SiteConfig("SelectMailMode")<>"" then
					if Execute("Select UserName from [BBSXP_Subscriptions] where UserName='"&CookieUserName&"' and ThreadID="&ThreadID&"").eof then
						BgImage="tracktopic.gif"
						ButtonText="订阅主题"
					else
						BgImage="tracktopic-on.gif"
						ButtonText="取消订阅"
					end if
					%>
					<span id="ThreadSubscription"><a class="CommonImageTextButton" style="BACKGROUND-IMAGE: url(images/<%=BgImage%>)" href="javascript:Ajax_CallBack(false,'ThreadSubscription','Loading.asp?menu=Subscription&ThreadID=<%=ThreadID%>')"><%=ButtonText%></a></span>
					<%
				end if
				
			end if
			%>
			<a class="CommonImageTextButton" style="BACKGROUND-IMAGE: url(images/view.gif)" onmouseover="MouseOverOpen('View',this.id);" id="View1">选择查看</a>
			<%if PermissionPost=1 then%><a class="CommonImageTextButton" style="BACKGROUND-IMAGE: url(images/NewPost.gif)" href="AddTopic.asp?ForumID=<%=ForumID%>">发表新帖</a> <%end if%>
			</td>
			<td align="right" valign="bottom"><a href="http://www.duoci.com/search/?Charset=gb2312&Word=<%=server.urlencode(Topic)%>" target="_blank" title="在更多网站中搜索此类问题">搜索更多相关主题</a>
			<%if SiteConfig("DisplayThreadStatus")=1 and (PermissionManage=1 or UserName=CookieUserName) then%> 
			　主题状态：<select onchange="javascript:if(this.options[this.selectedIndex].value)Ajax_CallBack(false,false,'loading.asp?menu=ThreadStatus&amp;ThreadID=<%=ThreadID%>&amp;ThreadStatus='+this.options[this.selectedIndex].value)">
			<option value="0" <%if threadstatus=0 then%>selected<%end if%>>--
			</option>
			<option value="1" <%if threadstatus=1 then%>selected<%end if%>>已解决
			</option>
			<option value="2" <%if threadstatus=2 then%>selected<%end if%>>未解决
			</option>
			</select> <%end if%> 　帖子排序：<select onchange="javascript:if(this.options[this.selectedIndex].value)window.location.href='ShowPost.asp?<%=ReplaceText(Request.QueryString,"&SortOrder=([0-9]*)","")%>&amp;SortOrder='+this.options[this.selectedIndex].value">
			<option value="0" <%if Request("sortorder")="0" then%>selected<%end if%>>
			从旧到新</option>
			<option value="1" <%if Request("sortorder")="1" then%>selected<%end if%>>
			从新到旧</option>
			</select> </td>
		</tr>

</table>
<%
'''''''投票''''''''
if IsVote=1 then
%>
<table cellspacing="1" cellpadding="5" width="100%" id="CommonListArea">
	<tr id="CommonListTitle">
		<td width="40%" align="center">选项</td>
		<td width="10%" align="center">票数</td>
		<td width="50%" align="center" colspan="2">百分比</td>
	</tr>
	<form action="PostVote.asp?ThreadID=<%=ThreadID%>" method="Post">
		<%
sql="Select * from [BBSXP_Votes] where ThreadID="&ThreadID&""
Set Rs=Execute(sql)
	if Rs("IsMultiplePoll")=1 then
		multiplicity="checkbox"
	else
		multiplicity="radio"
	end if
	allticket=0
	Result=split(Rs("Result"),"|")
	for i = 0 to ubound(Result)
		if not Result(i)="" then allticket=Result(i)+allticket
	next
	Vote=split(Rs("Items"),"|")
	for i = 0 to ubound(Vote)
		if not Vote(i)="" then
			if allticket=0 then
				Votepercent=0
			else
				Votepercent=Formatpercent(result(i)/allticket)
			end if
%>
		<tr id="CommonListCell">
			<td width="40%">
			<input type="<%=multiplicity%>" value="<%=i%>" name="PostVote" id="PostVote<%=i%>"><label for="PostVote<%=i%>"><%=Vote(i)%></label></td>
			<td width="10%" align="center"><%=Result(i)%></td>
			<td width="40%">
			<div class="percent">
				<div style="width:<%=Votepercent%>">
				</div>
			</div>
			</td>
			<td width="10%" align="center"><%=Votepercent%></td>
		</tr>
		<%
		end if
next
%>
		<tr id="CommonListCell">
			<td align="center"><%
	if  PermissionVote=0 then
		response.write "您没有权限投票"
	elseif instr("|"&Rs("BallotUserList")&"|","|"&CookieUserName&"|")>0 then
		response.write "您已经投过票了"
	elseif instr("|"&Rs("BallotIPList")&"|","|"&REMOTE_ADDR&"|")>0 then
		response.write "此IP已经投过票了"
	elseif Rs("Expiry")< now() then
		response.write "投票已过期"
	else
		response.write "<INPUT type=submit value='投　票'>"
	end if
%> </td>
			<td align="center">总票数：<%=allticket%></td>
			<td colspan="2" align="center">截止投票时间：<%=Rs("Expiry")%></td>
		</tr>
	</form>
</table>
<%
Rs.Close
end if
'''''''投票 END''''''''



TotalCount=TotalReplies+1
PageSetup=SiteConfig("PostsPerPage") '设定每页的显示数量
TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '总页数
PageCount = RequestInt("PageIndex") '获取当前页
if PageCount <1 then PageCount = 1
if PageCount > TotalPage then PageCount = TotalPage

if Request("SortOrder")="1" then
	SqlSortOrder="Desc"
else
	SqlSortOrder=""
end if

	sql="Select PostID,ThreadID,ParentID,PostAuthor,Subject,Body,IPAddress,PostDate from [BBSXP_Posts"&PostsTableName&"] where ThreadID="&ThreadID&" order by PostID "&SqlSortOrder&""
	Set Rs=Execute(sql)
	If Rs.Eof then Execute("Delete from [BBSXP_Threads] where ThreadID="&ThreadID&"")
	If TotalPage>1 then RS.Move (PageCount-1) * pagesetup
	IF Not Rs.Eof then PostGetRows=Rs.GetRows(pagesetup)
	Rs.close
	
if IsArray(PostGetRows) then
	For i=0 To Ubound(PostGetRows,2)
	
		PostID=PostGetRows(0,i)
		ThreadID=PostGetRows(1,i)
		ParentID=PostGetRows(2,i)
		PostAuthor=PostGetRows(3,i)
		Subject=PostGetRows(4,i)
		Body=PostGetRows(5,i)
		IPAddress=PostGetRows(6,i)
		PostDate=PostGetRows(7,i)
		
		if ViewMode=0 then
			ShowPostSimple
		else
			ShowPost
		end if
		
	Next
End if
%>
<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td><%ShowPage()%></td>
		<td align="right"><a href="#">返回页首↑</a> </td>
	</tr>
</table>
<%if IsLocked=0 and PermissionReply=1 then%>
<a name="QuickReply"></a>
<form name="form" method="POST" action="AddPost.asp" onsubmit="return CheckForm(this);">
	<input type="hidden" value="<%=ThreadID%>" name="ThreadID">
	<input type="hidden" value="<%=PostID%>" name="PostID">
	<input name="Body" type="hidden">
	<table cellspacing="1" cellpadding="5" width="100%" id="CommonListArea">
		<tr id="CommonListTitle">
			<td colspan="2"><b>快速回复</b></td>
		</tr>
		<tr id="CommonListCell">
			<td valign="top" height="50%" width="180">
					<br>
					<b>文章内容</b><br>
					（<a href="javascript:CheckLength();">查看内容长度</a>）<br>
					<br>
					<input id="DisableYBBCode" name="DisableYBBCode" type="checkbox" value="1"><label for="DisableYBBCode"> 
					禁用YBB代码</label>
			</td>
			<td height="200">
			<SCRIPT type="text/javascript" src="Editor/Post.js"></SCRIPT>
			</td>
		</tr>
		<tr id="CommonListCell">
			<td valign="top" height="50%" colspan="2" align="center">
			<input type="submit" value=" 回复 " name="EditSubmit">　<input type="Button" value=" 预览 " onclick="Preview()">　<input onclick="history.back()" type="button" value=" 取消 "></td>
		</tr>
	</table>
</form>
<div name="Preview" id="Preview"></div>
<script language="JavaScript">
function QuickReply(NO){
	document.form.PostID.value =NO;
	window.location="#QuickReply";
	BBSXPEditorForm.focus();
}
</script>
<%
end if
if PermissionManage=1 then
	response.write "<br><table cellspacing=0 cellpadding=0 width=100% align=center border=0><tr><td align=center>管理选项："
	if ThreadTop=2 then
		response.write "<a href=javascript:UrlPost('Manage.asp?menu=UnTop&ThreadID="&ThreadID&"')>取消公告</a> | "
	else
		response.write "<a href=javascript:UrlPost('Manage.asp?menu=Top&ThreadID="&ThreadID&"')>设为公告</a> | "
	end if

	if ThreadTop=1 then
		response.write "<a href=javascript:UrlPost('Manage.asp?menu=DelTop&ThreadID="&ThreadID&"')>取消置顶</a> | "
	else
		response.write "<a href=javascript:UrlPost('Manage.asp?menu=ThreadTop&ThreadID="&ThreadID&"')>置顶主题</a> | "
	end if
	response.write "<a href=javascript:UrlPost('Manage.asp?menu=MoveNew&ThreadID="&ThreadID&"')>拉前主题</a> | "
	if IsLocked=1 then
		response.write "<a href=javascript:UrlPost('Manage.asp?menu=DelIsLocked&ThreadID="&ThreadID&"')>解锁主题</a> | "
	else
		response.write "<a href=javascript:UrlPost('Manage.asp?menu=IsLocked&ThreadID="&ThreadID&"')>锁定主题</a> | "
	end if
	if IsGood=1 then
		response.write "<a href=javascript:UrlPost('Manage.asp?menu=DelIsGood&ThreadID="&ThreadID&"')>取消精华主题</a>"
	else
		response.write "<a href=javascript:UrlPost('Manage.asp?menu=IsGood&ThreadID="&ThreadID&"')>加为精华主题</a>"
	end if
	response.write " | <a href=MoveThread.asp?ThreadID="&ThreadID&">移动主题</a> | <a title='修复帖子的回复数' href=javascript:UrlPost('Manage.asp?menu=Fix&ThreadID="&ThreadID&"')>修复主题</a></td></tr></table>"
end if

act=topic
%><!-- #include file="Utility/OnLine.asp" --><%

HtmlBottom



Sub ShowPostSimple()

%>
<table cellspacing="1" cellpadding="5" width="100%" id="CommonListArea" style="TABLE-LAYOUT:fixed;">
	<tr id="CommonListHeader">
		<td>
			<div style=float:left><b><a target="_blank" href="Profile.asp?UserName=<%=PostAuthor%>"><%=PostAuthor%></a></b> 发表于 <%=PostDate%></div>
			<div style=float:right>
						<%if IsLocked=1 then%>
						<a onclick="window.alert('该帖已锁定不允许回复。');">锁定</a>
						<%elseif PermissionReply=1 then%>
						<a href="AddPost.asp?ThreadID=<%=ThreadID%>&PostID=<%=PostID%>" title="回复帖子">回复</a>
						<%end if%>
						<a href="EditPost.asp?ThreadID=<%=ThreadID%>&PostID=<%=PostID%>" title="编辑帖子">编辑</a>
						<a href="DelPost.asp?ThreadID=<%=ThreadID%>&PostID=<%=PostID%>" title="删除帖子">删除</a>
			</div>
		</td>
	</tr>
	<tr id="CommonListCell">
		<td>
		<%
		if Subject<>"" then response.write "<div class=ForumPostTitle>"&Subject&"</div>"
		response.write "<div class=ForumPostContentText>"&Body&"</div>"
		%>
		
				<div style=float:right>
				<%if PermissionManage=1 then response.write "IP："&IPAddress&"　"%>
				<%if IsLocked=0 and PermissionReply=1 then response.write "<a onclick=javascript:QuickReply("&PostID&")>快速回复</a>"%>
				</div>

		
		</td>
	</tr>
</table>
<%


End Sub




Sub ShowPost()

	Set Rs=Execute("Select top 1 * from [BBSXP_Users] where UserName='"&PostAuthor&"'")
	if Rs.EOF then
		Rs.close
		Exit Sub
	End if
	ShowRank(Rs("experience"))
%>
<div class="PopupMenu" id="ContactMenu<%=PostID%>" style="DISPLAY: none">
	<table cellspacing="0" cellpadding="1">
		<tr>
			<td><a style="BACKGROUND-IMAGE:url(images/profile.gif)" href="Profile.asp?UserName=<%=Rs("UserName")%>">查看 <%=Rs("UserName")%> 的资料</a></td>
		</tr>
		<%if CookieUserName<>"" then%><tr>
			<td><a style="BACKGROUND-IMAGE:url(images/privatemessage.gif)" href="javascript:BBSXP_Modal.Open('MyMessage.asp?menu=Post&RecipientUserName=<%=Rs("UserName")%>', 600, 350);">给 <%=Rs("UserName")%> 发送讯息</a></td>
		</tr>
		<%end if%>
		<tr>
			<td><a style="BACKGROUND-IMAGE:url(images/email.gif)" href="Mailto:<%=Rs("UserEmail")%>">给 <%=Rs("UserName")%> 发送邮件</a></td>
		</tr>
		<%if Rs("WebAddress")<>"" then%><tr>
			<td><a style="BACKGROUND-IMAGE:url(images/homepage.gif)" href="<%=Rs("WebAddress")%>" target="_blank">浏览 <%=Rs("UserName")%> 的主页</a></td>
		</tr>
		<%end if%> <%if Rs("WebLog")<>"" then%><tr>
			<td><a style="BACKGROUND-IMAGE:url(images/weblog.gif)" href="<%=Rs("WebLog")%>" target="_blank">浏览 <%=Rs("UserName")%> 的博客</a></td>
		</tr>
		<%end if%> <%if Rs("WebGallery")<>"" then%><tr>
			<td><a style="BACKGROUND-IMAGE:url(images/webgallery.gif)" href="<%=Rs("WebGallery")%>" target="_blank">浏览 <%=Rs("UserName")%> 的相册</a></td>
		</tr>
		<%end if%>
		<tr>
			<td><a style="BACKGROUND-IMAGE:url(images/search.gif)" href="ShowBBS.asp?menu=MyTopic&UserName=<%=Rs("UserName")%>">搜索 <%=Rs("UserName")%> 的帖子</a></td>
		</tr>
	</table>
</div>
<div class="PopupMenu" id="FavoriteMenu<%=PostID%>" style="DISPLAY: none">
	<table cellspacing="0" cellpadding="1">
		<tr>
			<td><a style="BACKGROUND-IMAGE:url(images/favorite.gif)" href="MyFavorites.asp?menu=FavoriteFriend&FriendUserName=<%=Rs("UserName")%>">将 <%=Rs("UserName")%> 加为好友</a></td>
		</tr>
		<tr>
			<td><a style="BACKGROUND-IMAGE:url(images/favorite.gif)" href="MyFavorites.asp?menu=FavoriteThread&ThreadID=<%=ThreadID%>">将该主题加入收藏夹</a></td>
		</tr>
		<tr>
			<td><a style="BACKGROUND-IMAGE:url(images/favorite.gif)" href="MyFavorites.asp?menu=FavoriteForums&ForumID=<%=ForumID%>">将该论坛加入收藏夹</a></td>
		</tr>
	</table>
</div>


<a name="<%=PostID%>"></a>
<table cellspacing="1" cellpadding="5" width="100%" id="CommonListArea">
	<tr id="CommonListTitle">
		<td>
			<div style=float:left><img src="images/icon_post_show.gif"> <%=PostDate%></div>
			<div style=float:right><a href="#<%=PostID%>">#<%=i+(PageCount-1)*PageSetup+1%></a></div>
		</td>
	</tr>
	<tr id="CommonListCell">
		<td>


		<table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-left:5px;TABLE-LAYOUT:fixed;">
			<tr>
				<td rowspan="2" valign="top" class="ForumPostUserArea">

				<div style="text-align:left;width:90%;">
					<div style="float:left">
						<%if DateDiff("n",Rs("UserActivityTime"),Now()) < SiteConfig("UserOnlineTime") then%>
						<img title="<%=Rs("UserName")%> 在线. 最后活动时间:<%=Rs("UserActivityTime")%>" src="Images/user_IsOnline.gif" border="0" />
						<%end if%>
						<font style="font-size:10pt"><b><%=Rs("UserName")%></b></font><br><%=Rs("UserTitle")%>
					</div>
					<div style="float:right">
						<a href="javascript:BBSXP_Modal.Open('Reputation.asp?CommentFor=<%=Rs("UserName")%>',550,200);"><img title="对 <%=Rs("UserName")%> 进行声望评价" src="Images/reputation.gif" border="0" align="absmiddle"></a>
					</div>
					
				<br /><br /><br />
				<div style="text-align:center;">
				<%if SiteConfig("EnableAvatars")=1 and SiteConfig("AllowAvatars")=1 then%>
					<img src="<%=Rs("UserFaceUrl")%>" style="max-width:<%=SiteConfig("AvatarWidth")%>px;max-height:<%=SiteConfig("AvatarHeight")%>px;"  />
				<%end if%> <br />
				<img src="<%=RankIconUrl%>" /><br />
				<br />
				</div>
				角　　色：<%
					if instr("|"&Moderated&"|","|"&Rs("UserName")&"|") > 0 then
						Response.Write "版主"
					else
						response.write ShowRole(Rs("UserRoleID"))
					end if
					response.write "<br>等　　级："&RankName&"<br>"
					if Rs("UserMate")<>"" then response.write "配　　偶："&Rs("UserMate")&"<br>"
					response.write "发 帖 数："&Rs("TotalPosts")&"<br>"
					response.write "经 验 值："&Rs("experience")&"<br>"
					response.write "注册时间："&FormatDateTime(Rs("UserRegisterTime"),2)&"<br>"
					
					
					response.write "<img src=images/money.gif title='"&Rs("UserMoney")&"金币'> "&ShowReputation(Rs("Reputation"))&" "&Horoscope(Rs("birthday"))&" "&ShowUserSex(Rs("UserSex"))&""

					%>
				</div>

				</td>
				<td valign="top">
				
				<div class=ForumPostButtons>
						<a class="CommonImageTextButton" style="BACKGROUND-IMAGE: url(images/contact.gif)" onmouseover="MouseOverOpen('ContactMenu<%=PostID%>',this.id);" id="Contact<%=PostID%>">联系</a>
						<a class="CommonImageTextButton" style="BACKGROUND-IMAGE: url(images/favorite.gif)" onmouseover="MouseOverOpen('FavoriteMenu<%=PostID%>',this.id);" id="Favorite<%=PostID%>">收藏</a> 
						<%if IsLocked=1 then%>
						<a class="CommonImageTextButton" style="BACKGROUND-IMAGE:url(images/locked.gif)" onclick="window.alert('该帖已锁定不允许回复。');">锁定</a>
						<%elseif PermissionReply=1 then%>
						<a class="CommonImageTextButton" style="BACKGROUND-IMAGE:url(images/NewPost.gif)" href="AddPost.asp?ThreadID=<%=ThreadID%>&PostID=<%=PostID%>" title="回复帖子">回复</a>
						<%end if%>
						<a class="CommonImageTextButton" style="BACKGROUND-IMAGE:url(images/edit.gif)" href="EditPost.asp?ThreadID=<%=ThreadID%>&PostID=<%=PostID%>" title="编辑帖子">编辑</a>
						<a class="CommonImageTextButton" style="BACKGROUND-IMAGE:url(images/delete.gif)" href="DelPost.asp?ThreadID=<%=ThreadID%>&PostID=<%=PostID%>" title="删除帖子">删除</a>
				</div>

				<div class="ForumPostBodyArea">
					<div class="ForumPostTitle"><%=Subject%></div>

				<%
				if Rs("UserAccountStatus")=2 then
						Response.Write "==============================<br><font color=RED>该用户帐号已被禁用</font><br>=============================="
				elseif Rs("Reputation") < SiteConfig("InPrisonReputation") then
						Response.Write "==============================<br><font color=RED>该用户声望小于"&SiteConfig("InPrisonReputation")&"，帖子内容已被屏蔽</font><br>=============================="
				else
						response.write "<div class=ForumPostContentText>"&Body&"</div>"
						if SiteConfig("EnableSignatures")=1 and SiteConfig("AllowSignatures")=1 then
							if Rs("UserSign")<>"" then response.write "<div class=ForumPostSignature>"&YbbEncode(Rs("UserSign"))&"</div>"
						end if
				end if
				%>
				</div>

				</td>
			</tr>
			<tr>
				<td valign="bottom">
				<table width="100%">
				<tr>
					<td valign="bottom">
				<%
					If AdvertisementNum>0 then
						RndValue=Int(AdvertisementNum * Rnd)
						Response.Write(AdvertisementGetRow(0,RndValue))
					end if
				%>
					</td>
					<td align="right" valign="bottom"><%if PermissionManage=1 then response.write "IP："&IPAddress&"　"%>
				<%if IsLocked=0 and PermissionReply=1 then response.write "<a onclick=javascript:QuickReply("&PostID&")>快速回复</a>"%></td>
				</tr>
				</table>
				</td>
			</tr>
		</table>
		
		</td>
	</tr>
</table>
<%
Rs.close
End Sub
%>