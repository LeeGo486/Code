<!-- #include file="Setup.asp" -->
<%
HtmlTop

if CookieUserName=empty then error("您还未<a href=Login.asp?ReturnUrl="&ReturnUrl&">登录</a>论坛")
if CookieUserAccountStatus<>1 then error("您的帐号未通过审核！")


	if CookieReputation < SiteConfig("InPrisonReputation") then error("您的声望低于"&SiteConfig("InPrisonReputation")&"，无法发表帖子！")

	
	
	
	if SiteConfig("RegUserTimePost") > 0 then
		StopPostTime=int(DateDiff("n",CookieUserRegisterTime,Now()))
		if StopPostTime < SiteConfig("RegUserTimePost") then error("<li>新注册用户必须等待 "&SiteConfig("RegUserTimePost")&" 分钟后才能发帖！<li>您必须再等待 "&SiteConfig("RegUserTimePost")-StopPostTime&" 分钟！")
	end if

	if SiteConfig("PostInterval") > 0 then
		StopPostTime=int(DateDiff("s",CookieUserPostTime,Now()))
		if StopPostTime < SiteConfig("PostInterval") then error("论坛限制一个人两次发帖间隔必须大于 "&SiteConfig("PostInterval")&" 秒！<li>您必须再等待 "&SiteConfig("PostInterval")-StopPostTime&" 秒！")
	end if

ThreadID=RequestInt("ThreadID")
PostID=RequestInt("PostID")


sql="Select * From [BBSXP_Threads] where ThreadID="&ThreadID&""
Rs.Open sql,Conn,1
	if Rs.Eof then error("系统不存在此主题的资料")
	if Rs("IsDel")=1 then error("此主题已经删除，不接受新的回复")
	if Rs("IsLocked")=1 then error("此主题已经关闭，不接受新的回复")
	ForumID=Rs("ForumID")
	PostsTableName=Rs("PostsTableName")
	Topic=Rs("Topic")
	Tags=Rs("Tags")
	
	PostAuthor=Rs("PostAuthor")
Rs.close

'if Execute("Select PostID from [BBSXP_Posts"&PostsTableName&"] where ThreadID="&ThreadID&" and PostID="&PostID&"").Eof then error("系统没有找到回复帖ID")

sql="Select * from [BBSXP_Forums] where ForumID="&ForumID&""
Set Rs=Execute(sql)
	ForumName=Rs("ForumName")
	Moderated=Rs("Moderated")
	ParentID=Rs("ParentID")
	GroupID=Rs("GroupID")
	ForumUrl=Rs("ForumUrl")
	IsActive=Rs("IsActive")
Rs.close

%>
<!-- #include file="Utility/ForumPermissions.asp" -->
<%
if ForumUrl<>"" then response.redirect ForumUrl
if IsActive=0 and PermissionManage=0 then error"<li>该版块已经关闭！"

if PermissionReply=0 then error("您的<a href=ShowForumPermissions.asp?ForumID="&ForumID&">权限</a>不够")

if Request.ServerVariables("Request_method") = "POST" then
	if Request.Form = RequestApplication("LastPost") and SiteConfig("AllowDuplicatePosts")=0 then error("请不要提交重复数据")



	Subject=HTMLEncode(Request.Form("PostSubject"))
	Body=BodyEncode(Request.Form("Body"))
	TagsPost=HTMLEncode(Request.Form("Tags"))
	
	if Tags="" then
			Tags=TagsPost
	else
			TagArray=split(TagsPost,",")
			for i=0 to ubound(TagArray)
				if instr(","&Tags&",",","&TagArray(i)&",")<1 then Tags=Tags&","&TagArray(i)
			next
	end if
	Tags=Left(Tags,255)

	
	if Request.Form("DisableYBBCode")<>1 then Body=YbbEncode(Body)
	if Len(Body)<2 then Message=Message&"<li>文章内容不能小于 2 字符"
	if Message<>"" then error(""&Message&"")


	Execute("update [BBSXP_Users] Set TotalPosts=TotalPosts+1,UserMoney=UserMoney+"&SiteConfig("IntegralAddPost")&",experience=experience+"&SiteConfig("IntegralAddPost")&",UserPostTime="&SqlNowString&" where UserID="&CookieUserID&"")

	if Request.Form("UpFileID")<>"" then
		UpFileID=split(Request.Form("UpFileID"),",")
		for i = 0 to ubound(UpFileID)-1
			Execute("update [BBSXP_PostAttachments] Set Description='"&Subject&"' where UpFileID="&int(UpFileID(i))&" and UserName='"&CookieUserName&"'")
		next
	end if
	
	UpdateStatistics 0,0,1
	Execute("insert into [BBSXP_Posts"&PostsTableName&"] (ThreadID,ParentID,PostAuthor,Subject,Body,IPAddress) values ('"&ThreadID&"','"&PostID&"','"&CookieUserName&"','"&Subject&"','"&Body&"','"&REMOTE_ADDR&"')")
	Execute("update [BBSXP_Threads] Set lastname='"&CookieUserName&"',Tags='"&Tags&"',TotalReplies=TotalReplies+1,lasttime="&SqlNowString&" where ThreadID="&ThreadID&"")
	Execute("update [BBSXP_Forums] Set MostRecentPostSubject='"&Topic&"',MostRecentPostAuthor='"&CookieUserName&"',MostRecentPostDate="&SqlNowString&",TodayPosts=TodayPosts+1,TotalPosts=TotalPosts+1,MostRecentThreadID="&ThreadID&" where ForumID="&ForumID&" or ForumID="&ParentID&"")

	ResponseApplication "LastPost",Request.Form

if SiteConfig("SelectMailMode")<>"" then

	Set Rs=Execute("Select top 100 * from [BBSXP_Subscriptions] where ThreadID="&ThreadID&" order by SubscriptionID")
	do while not Rs.eof
			MailAddRecipient=""&Rs("UserName")&"<"&Rs("Email")&">;"&MailAddRecipient
		Rs.movenext
	loop
	Rs.close
	
	LoadingEmailXml("NewMessagePostedToThread")
	MailBody=Replace(MailBody,"[Topic]",Topic)
	MailBody=Replace(MailBody,"[ThreadURL]","<a target=_blank href="&SiteConfig("SiteUrl")&"/ShowPost.asp?ThreadID="&ThreadID&">"&SiteConfig("SiteUrl")&"/ShowPost.asp?ThreadID="&ThreadID&"</a>")
	MailBody=Replace(MailBody,"[UserName]",CookieUserName)
	MailBody=Replace(MailBody,"[PostTime]",now())
	MailBody=Replace(MailBody,"[Subject]",Subject)
	MailBody=Replace(MailBody,"[body]",Body)
	SendMail MailAddRecipient,MailSubject,MailBody
end if


	Message=Message&"<li>回复主题成功<li><a href=ShowPost.asp?ThreadID="&ThreadID&">返回主题</a><li><a href=ShowForum.asp?ForumID="&ForumID&">返回论坛</a>"
	succeed Message,"ShowForum.asp?ForumID="&ForumID&""
end if
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	sql="Select * from [BBSXP_Posts"&PostsTableName&"] where PostID="&PostID&""
	Set Rs=Execute(sql)
		ReBody="<table width=100% cellspacing=1 cellpadding=5 id=CommonListArea>"
		ReBody=ReBody&"<tr id=CommonListTitle><td colspan=2><span id=RePostAuthor>"&Rs("PostAuthor")&"</span> 发表于："&Rs("PostDate")&"</td></tr>"
		ReBody=ReBody&"<tr id=CommonListCell><td><span id=ReBody>"&Rs("Body")&"</span><br><br>"
		ReBody=ReBody&"<a class='CommonImageTextButton' style='BACKGROUND-IMAGE:url(images/Quote.gif)' title='引用回复这个帖子' href='javascript:ReplyQuote();'> 引用</a>"
		ReBody=ReBody&"</td></tr></table>"
	Rs.close
%>
<script language="JavaScript">



function ReplyQuote() { //Edit at 2007-05-26
	var QuoteValue = '[quote user="' + document.getElementById("RePostAuthor").innerHTML + '"]';
	QuoteValue += document.getElementById("ReBody").innerHTML + '[/quote]';
	BBSXPExecute('YuZi_QUOTE', QuoteValue);
}


</script>
<div id="CommonBreadCrumbArea"><%ClubTree%> → <%=ForumTree(ParentID)%> <a href=ShowForum.asp?ForumID=<%=ForumID%>><%=ForumName%></a> → <a href="ShowPost.asp?ThreadID=<%=ThreadID%>"><%=Topic%></a> → 回复帖子</div>
<%=ReBody%>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
<form name="form" method="post" onSubmit="return CheckForm(this);">
<input name="Body" type="hidden">
<input type=hidden name=ThreadID value=<%=ThreadID%>>
<input type=hidden name=PostID value=<%=PostID%>>
<input name="UpFileID" type="hidden">
	<TR id=CommonListTitle>
		<TD vAlign=Left colSpan=2><b>回复帖子</b></TD>
	</TR>
	<TR id=CommonListCell>
		<TD width=180><B>标题 </B> </TD>
		<TD><INPUT type="text" maxLength="50" size="60" name="PostSubject"></TD>
	</TR>
	<TR id=CommonListCell>
		<TD vAlign=top>
			<br><B>内容</B><BR>（<a href="javascript:CheckLength();">查看内容长度</a>）<BR><BR><INPUT id=DisableYBBCode name=DisableYBBCode type=checkbox value=1><label for=DisableYBBCode> 禁用YBB代码</label>
			<%if SiteConfig("UpFileOption")<>empty and PermissionAttachment=1 then%>
					<BR><BR><span id=UpFile></span><a href="javascript:BBSXP_Modal.Open('UploadAttachment.asp',500,150);" class="CommonTextButton">上传附件</a>
			<%end if%>
		</TD>
		<TD height=250><SCRIPT type="text/javascript" src="Editor/Post.js"></SCRIPT></TD>
	</TR>
<%if SiteConfig("DisplayPostTags")=1 then%>
	<TR id=CommonListCell>
		<TD><b>标签<br></b>以逗号“,”分隔</TD>
		<TD><input type="text" name="Tags" size="80" /></TD>
	</TR>
<%end if%>
	<TR id=CommonListCell>
		<TD align=center colSpan=2><INPUT type=submit value=" 回复 " name=EditSubmit>　<input type="Button" value=" 预览 " onclick="Preview()">　<INPUT onclick="history.back()" type="button" value=" 取消 "></TD>
	</TR>
</FORM>
</TABLE>
<div name="Preview" id="Preview"></div>
<%
HtmlBottom
%>