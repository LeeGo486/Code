<!-- #include file="Setup.asp" -->
<%
HtmlTop

if CookieUserName=empty then error("����δ<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>��̳")
if CookieUserAccountStatus<>1 then error("�����ʺ�δͨ����ˣ�")


	if CookieReputation < SiteConfig("InPrisonReputation") then error("������������"&SiteConfig("InPrisonReputation")&"���޷��������ӣ�")

	
	
	
	if SiteConfig("RegUserTimePost") > 0 then
		StopPostTime=int(DateDiff("n",CookieUserRegisterTime,Now()))
		if StopPostTime < SiteConfig("RegUserTimePost") then error("<li>��ע���û�����ȴ� "&SiteConfig("RegUserTimePost")&" ���Ӻ���ܷ�����<li>�������ٵȴ� "&SiteConfig("RegUserTimePost")-StopPostTime&" ���ӣ�")
	end if

	if SiteConfig("PostInterval") > 0 then
		StopPostTime=int(DateDiff("s",CookieUserPostTime,Now()))
		if StopPostTime < SiteConfig("PostInterval") then error("��̳����һ�������η������������� "&SiteConfig("PostInterval")&" �룡<li>�������ٵȴ� "&SiteConfig("PostInterval")-StopPostTime&" �룡")
	end if

ThreadID=RequestInt("ThreadID")
PostID=RequestInt("PostID")


sql="Select * From [BBSXP_Threads] where ThreadID="&ThreadID&""
Rs.Open sql,Conn,1
	if Rs.Eof then error("ϵͳ�����ڴ����������")
	if Rs("IsDel")=1 then error("�������Ѿ�ɾ�����������µĻظ�")
	if Rs("IsLocked")=1 then error("�������Ѿ��رգ��������µĻظ�")
	ForumID=Rs("ForumID")
	PostsTableName=Rs("PostsTableName")
	Topic=Rs("Topic")
	Tags=Rs("Tags")
	
	PostAuthor=Rs("PostAuthor")
Rs.close

'if Execute("Select PostID from [BBSXP_Posts"&PostsTableName&"] where ThreadID="&ThreadID&" and PostID="&PostID&"").Eof then error("ϵͳû���ҵ��ظ���ID")

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
if IsActive=0 and PermissionManage=0 then error"<li>�ð���Ѿ��رգ�"

if PermissionReply=0 then error("����<a href=ShowForumPermissions.asp?ForumID="&ForumID&">Ȩ��</a>����")

if Request.ServerVariables("Request_method") = "POST" then
	if Request.Form = RequestApplication("LastPost") and SiteConfig("AllowDuplicatePosts")=0 then error("�벻Ҫ�ύ�ظ�����")



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
	if Len(Body)<2 then Message=Message&"<li>�������ݲ���С�� 2 �ַ�"
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


	Message=Message&"<li>�ظ�����ɹ�<li><a href=ShowPost.asp?ThreadID="&ThreadID&">��������</a><li><a href=ShowForum.asp?ForumID="&ForumID&">������̳</a>"
	succeed Message,"ShowForum.asp?ForumID="&ForumID&""
end if
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	sql="Select * from [BBSXP_Posts"&PostsTableName&"] where PostID="&PostID&""
	Set Rs=Execute(sql)
		ReBody="<table width=100% cellspacing=1 cellpadding=5 id=CommonListArea>"
		ReBody=ReBody&"<tr id=CommonListTitle><td colspan=2><span id=RePostAuthor>"&Rs("PostAuthor")&"</span> �����ڣ�"&Rs("PostDate")&"</td></tr>"
		ReBody=ReBody&"<tr id=CommonListCell><td><span id=ReBody>"&Rs("Body")&"</span><br><br>"
		ReBody=ReBody&"<a class='CommonImageTextButton' style='BACKGROUND-IMAGE:url(images/Quote.gif)' title='���ûظ��������' href='javascript:ReplyQuote();'> ����</a>"
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
<div id="CommonBreadCrumbArea"><%ClubTree%> �� <%=ForumTree(ParentID)%> <a href=ShowForum.asp?ForumID=<%=ForumID%>><%=ForumName%></a> �� <a href="ShowPost.asp?ThreadID=<%=ThreadID%>"><%=Topic%></a> �� �ظ�����</div>
<%=ReBody%>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
<form name="form" method="post" onSubmit="return CheckForm(this);">
<input name="Body" type="hidden">
<input type=hidden name=ThreadID value=<%=ThreadID%>>
<input type=hidden name=PostID value=<%=PostID%>>
<input name="UpFileID" type="hidden">
	<TR id=CommonListTitle>
		<TD vAlign=Left colSpan=2><b>�ظ�����</b></TD>
	</TR>
	<TR id=CommonListCell>
		<TD width=180><B>���� </B> </TD>
		<TD><INPUT type="text" maxLength="50" size="60" name="PostSubject"></TD>
	</TR>
	<TR id=CommonListCell>
		<TD vAlign=top>
			<br><B>����</B><BR>��<a href="javascript:CheckLength();">�鿴���ݳ���</a>��<BR><BR><INPUT id=DisableYBBCode name=DisableYBBCode type=checkbox value=1><label for=DisableYBBCode> ����YBB����</label>
			<%if SiteConfig("UpFileOption")<>empty and PermissionAttachment=1 then%>
					<BR><BR><span id=UpFile></span><a href="javascript:BBSXP_Modal.Open('UploadAttachment.asp',500,150);" class="CommonTextButton">�ϴ�����</a>
			<%end if%>
		</TD>
		<TD height=250><SCRIPT type="text/javascript" src="Editor/Post.js"></SCRIPT></TD>
	</TR>
<%if SiteConfig("DisplayPostTags")=1 then%>
	<TR id=CommonListCell>
		<TD><b>��ǩ<br></b>�Զ��š�,���ָ�</TD>
		<TD><input type="text" name="Tags" size="80" /></TD>
	</TR>
<%end if%>
	<TR id=CommonListCell>
		<TD align=center colSpan=2><INPUT type=submit value=" �ظ� " name=EditSubmit>��<input type="Button" value=" Ԥ�� " onclick="Preview()">��<INPUT onclick="history.back()" type="button" value=" ȡ�� "></TD>
	</TR>
</FORM>
</TABLE>
<div name="Preview" id="Preview"></div>
<%
HtmlBottom
%>