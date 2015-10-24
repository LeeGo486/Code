<!-- #include file="Setup.asp" -->
<%
if CookieUserName=empty then error("您还未<a href=Login.asp?ReturnUrl="&ReturnUrl&">登录</a>论坛")

if Request.ServerVariables("Request_method") <> "POST" then error("提交方式错误！")

HtmlTop
PostID=RequestInt("PostID")
ThreadID=RequestInt("ThreadID")

sql="Select * From [BBSXP_Threads] where ThreadID="&ThreadID&""
Rs.Open sql,Conn,1
	if Rs.eof then error"<li>系统不存在该帖子的资料"
	ForumID=Rs("ForumID")
	PostsTableName=Rs("PostsTableName")
	PostAuthor=Rs("PostAuthor")
	ThreadID=Rs("ThreadID")
	TotalReplies=Rs("TotalReplies")
	Topic=Rs("Topic")
Rs.close
Moderated=Execute("Select Moderated From [BBSXP_Forums] where ForumID="&ForumID&" ")(0)
%>
<!-- #include file="Utility/ForumPermissions.asp" -->
<%
if PermissionManage=0 then error("您的<a href=ShowForumPermissions.asp?ForumID="&ForumID&">权限</a>不够")
select case Request("menu")
	case "Top"
		if BestRole = 1 then
			Execute("update [BBSXP_Threads] Set ThreadTop=2 where ThreadID="&ThreadID&"")
			succtitle="公告主题成功"
		else
			error("您的权限不够")
		end if

	case "UnTop"
		if BestRole = 1 then
			Execute("update [BBSXP_Threads] Set ThreadTop=0 where ThreadID="&ThreadID&"")
			succtitle="取消公告主题成功"
		else
			error("您的权限不够")
		end if
	case "Fix"
		TotalCount=Execute("Select count(PostID) From [BBSXP_Posts"&PostsTableName&"] where ThreadID="&ThreadID&"")(0)
		Execute("update [BBSXP_Threads] Set TotalReplies="&TotalCount&"-1 where ThreadID="&ThreadID&"")
		succtitle="修复主题成功"
	case "MoveNew"
		Execute("update [BBSXP_Threads] Set lasttime="&SqlNowString&" where ThreadID="&ThreadID&"")
		succtitle="拉前主题成功"
	case "Move"
		AimForumID=RequestInt("AimForumID")
		if AimForumID=0 then error("您没有选择要将主题移动哪个论坛")
		Execute("update [BBSXP_Threads] Set ForumID="&AimForumID&",ThreadTop=0,IsGood=0,IsLocked=0,ThreadStyle='' where ThreadID="&ThreadID&"")
		succtitle="移动主题成功"
	case "IsGood"
		if Execute("Select IsGood From [BBSXP_Threads] where ThreadID="&ThreadID&" ")(0)=1 then error("此帖子已经加入精华区了，无需重复添加")
		Execute("update [BBSXP_Threads] Set IsGood=1 where ThreadID="&ThreadID&"")
		Execute("update [BBSXP_Users] Set UserMoney=UserMoney+"&SiteConfig("IntegralAddValuedPost")&",experience=experience+"&SiteConfig("IntegralAddValuedPost")&" where UserName='"&PostAuthor&"'")
		succtitle="加为精华主题成功"
	case "DelIsGood"
		if Execute("Select IsGood From [BBSXP_Threads] where ThreadID="&ThreadID&" ")(0)=0 then error("此帖子已经移出精华区了")
		Execute("update [BBSXP_Threads] Set IsGood=0 where ThreadID="&ThreadID&"")
		Execute("update [BBSXP_Users] Set UserMoney=UserMoney+"&SiteConfig("IntegralDeleteValuedPost")&",experience=experience+"&SiteConfig("IntegralDeleteValuedPost")&" where UserName='"&PostAuthor&"'")
		succtitle="取消精华主题成功"
	case "ThreadTop"
		Execute("update [BBSXP_Threads] Set ThreadTop=1 where ThreadID="&ThreadID&"")
		succtitle="置顶主题成功"
	case "DelTop"
		Execute("update [BBSXP_Threads] Set ThreadTop=0 where ThreadID="&ThreadID&"")
		succtitle="取消置顶主题成功"
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	case "IsLocked"
		Execute("update [BBSXP_Threads] Set IsLocked=1 where ThreadID="&ThreadID&"")
		succtitle="锁定主题成功"
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	case "DelIsLocked"
		Execute("update [BBSXP_Threads] Set IsLocked=0 where ThreadID="&ThreadID&"")
		succtitle="解锁主题成功"
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
end select
if succtitle="" then error("无效指令")
UpForumMostRecent(ForumID)
Log(""&succtitle&"，标题："&Topic&"，主题ID："&ThreadID&"")
Message="<li>"&succtitle&"</li><li><a href=ShowForum.asp?ForumID="&ForumID&">返回论坛</a></li>"
succeed Message,"ShowForum.asp?ForumID="&ForumID&""
%>