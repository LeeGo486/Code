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


ForumID=RequestInt("ForumID")

sql="Select * from [BBSXP_Forums] where ForumID="&ForumID&""
Set Rs=Execute(sql)
	if Rs.Eof then error("ϵͳ�����ڴ���̳������")
	ForumName=Rs("ForumName")
	Moderated=Rs("Moderated")
	ParentID=Rs("ParentID")
	GroupID=Rs("GroupID")
	TotalCategorys=Rs("TotalCategorys")
	IsModerated=Rs("IsModerated")
	ForumUrl=Rs("ForumUrl")
	IsActive=Rs("IsActive")
Rs.close

%>
<!-- #include file="Utility/ForumPermissions.asp" -->
<%
if ForumUrl<>"" then response.redirect ForumUrl
if IsActive=0 and PermissionManage=0 then error"<li>�ð���Ѿ��رգ�"

if PermissionPost=0 then error("����<a href=ShowForumPermissions.asp?ForumID="&ForumID&">Ȩ��</a>����")
if Request.ServerVariables("Request_method") = "POST" then
	if Request.Form=RequestApplication("LastPost") and SiteConfig("AllowDuplicatePosts")=0 then error("�벻Ҫ�ύ�ظ�����")
	if SiteConfig("EnableAntiSpamTextGenerateForPost")=1 then
		if Request.Form("VerifyCode")<>Session("VerifyCode") or Session("VerifyCode")="" then Message=Message&"<li>��֤�����</li>"
	end if
	Subject=HTMLEncode(Request.Form("Subject"))
	Category=HTMLEncode(Request.Form("Category"))
	Body=BodyEncode(Request.Form("Body"))
	Tags=HTMLEncode(Request.Form("Tags"))
	ThreadEmoticonID=RequestInt("ThreadEmoticonID")

	if Request.Form("DisableYBBCode")<>1 then Body=YbbEncode(Body)
	if Len(Subject)<2 then Message=Message&"<li>�������ⲻ��С�� 2 �ַ�"
	if Len(Body)<2 then Message=Message&"<li>�������ݲ���С�� 2 �ַ�"
	if len(Tags)>255 then Message=Message&"<li>��ǩ���ܴ���255�ַ�"

	Vote=Request.Form("Vote")
	if Vote<>"" then
		if instr(Vote,"|") > 0 then error("ͶƱѡ���в��ܺ��С�|���ַ�")
		pollTopic=split(Vote,chr(13)&chr(10))
		j=0
		for i = 0 to ubound(pollTopic)
			if not (pollTopic(i)="" or pollTopic(i)=" ") then
				allpollTopic=""&allpollTopic&""&pollTopic(i)&"|"
				j=j+1
			end if
		next
		if j<SiteConfig("MinVoteOptions") then error("<li>ͶƱѡ������� "&SiteConfig("MinVoteOptions")&" ��")
		if j>SiteConfig("MaxVoteOptions") then error("<li>ͶƱѡ��� "&SiteConfig("MaxVoteOptions")&" ��")
		
		for y = 1 to j
			Votenum=""&Votenum&"0|"
		next
	end if
	

	IsMultiplePoll=RequestInt("IsMultiplePoll")
	VoteItems=HTMLEncode(allpollTopic)
	VoteExpiry=now()+RequestInt("VoteExpiry")

	if Not Isdate(VoteExpiry) then error("<li>ͶƱ����ʱ�����")

	if Message<>"" then error(""&Message&"")



	Execute("update [BBSXP_Users] Set TotalPosts=TotalPosts+1,UserMoney=UserMoney+"&SiteConfig("IntegralAddThread")&",experience=experience+"&SiteConfig("IntegralAddThread")&",UserPostTime="&SqlNowString&" where UserID="&CookieUserID&"")




	Rs.Open "Select * from [BBSXP_Threads]",Conn,1,3
	Rs.addNew
		if PermissionManage=1 then Rs("ThreadStyle")=BodyEncode(Request.Form("ThreadStyle"))
		Rs("PostAuthor")=CookieUserName
		Rs("PostTime")=now()
		Rs("lastname")=CookieUserName
		Rs("lasttime")=now()
		Rs("Topic")=Subject
		Rs("ForumID")=ForumID
		Rs("Category")=Category
		Rs("Tags")=Tags
		Rs("ThreadEmoticonID")=ThreadEmoticonID
		if Request("Vote")<>"" then Rs("IsVote")=1
		if Request("IsLocked")=1 then Rs("IsLocked")=1
		if IsModerated=1 and CookieModerationLevel=0 then Rs("IsApproved")=0
	Rs.update
	ThreadID=Rs("ThreadID")
	PostsTableName=Rs("PostsTableName")
	Rs.close
	
	
	if Request.Form("Vote")<>"" then
		Execute("insert into [BBSXP_Votes] (ThreadID,IsMultiplePoll,Items,Result,Expiry) values ('"&ThreadID&"',"&IsMultiplePoll&",'"&VoteItems&"','"&Votenum&"','"&VoteExpiry&"')")
	end if
	
	if Request.Form("UpFileID")<>"" then
		UpFileID=split(Request.Form("UpFileID"),",")
		for i = 0 to ubound(UpFileID)-1
			Execute("update [BBSXP_PostAttachments] Set Description='"&Subject&"',ThreadID='"&ThreadID&"' where UpFileID="&int(UpFileID(i))&" and UserName='"&CookieUserName&"'")
		next
	end if
	
	UpdateStatistics 0,1,1
	Execute("insert into [BBSXP_Posts"&PostsTableName&"] (ThreadID,PostAuthor,Subject,Body,IPAddress) values ('"&ThreadID&"','"&CookieUserName&"','"&Subject&"','"&Body&"','"&REMOTE_ADDR&"')")
	Execute("update [BBSXP_Forums] Set MostRecentPostSubject='"&Subject&"',MostRecentPostAuthor='"&CookieUserName&"',MostRecentPostDate="&SqlNowString&",TodayPosts=TodayPosts+1,TotalThreads=TotalThreads+1,TotalPosts=TotalPosts+1,MostRecentThreadID="&ThreadID&" where ForumID="&ForumID&" or ForumID="&ParentID&"")


	Session("VerifyCode")=""
	ResponseApplication "LastPost",Request.Form


	if IsModerated=1 and CookieModerationLevel=0 then
		EnableCensorship="������̳��������ƶȣ��������������Ҫ�ȴ����������ʾ��"
	else
		EnableCensorship="<a href=ShowPost.asp?ThreadID="&ThreadID&">��������</a>"
	end if

	Message="<li>�����ⷢ��ɹ�</li><li>"&EnableCensorship&"</li><li><a href=ShowForum.asp?ForumID="&ForumID&">������̳</a></li>"
	succeed Message,"ShowForum.asp?ForumID="&ForumID&""

end if
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� <%=ForumTree(ParentID)%> <a href=ShowForum.asp?ForumID=<%=ForumID%>><%=ForumName%></a> �� ��������</div>
<form name="form" method="post" onSubmit="return CheckForm(this);">
<input name="Body" type="hidden">
<input name="UpFileID" type="hidden">
<input name="ThreadStyle" id="ThreadStyle" type="hidden">
<input type=hidden name=ForumID value=<%=ForumID%>>
<table cellspacing=1 cellpadding=5 border=0 align=center id=CommonListArea  width=100%>
	<TR id=CommonListTitle>
		<TD vAlign=Left colSpan=2>��������</TD>
	</TR>
	<TR id=CommonListCell>
		<TD width="180"><B>����</B><%if PermissionManage=1 then%>��<a href="javascript:BBSXP_Modal.Open('Utility/SelectStyle.htm',500,420);">����</a>��<%end if%></TD>
		<TD><INPUT type="text" maxLength="50" size="60" id="Subject" name="Subject"></TD>
	</TR>
	<TR id=CommonListCell>
		<TD width="180"><B>���</B></TD>
		<TD>
			<select name=Category size=1><OPTION value="" selected>��</OPTION>
<%
	if TotalCategorys<>empty then
		filtrate=split(TotalCategorys,"|")
		for i = 0 to ubound(filtrate)
			response.write "<OPTION value='"&filtrate(i)&"'>"&filtrate(i)&"</OPTION>"
		next
	end if
%>
			</SELECT> <a href="javascript:BBSXP_Modal.Open('Utility/AddCategory.htm', 500, 100);">������</a></TD>
	</TR>
	<TR id=CommonListCell>
		<TD vAlign=top align=Left><B>����</B></TD>
		<TD><INPUT type=radio value=0 name=ThreadEmoticonID <%if ThreadEmoticonID=0 then%>checked<%end if%> >��<br>
		<script language="JavaScript">
		for(i=1;i<=30;i++) {
			document.write("<INPUT type=radio value="+i+" name=ThreadEmoticonID><IMG src=images/Emoticons/"+i+".gif>��")
			if (i ==10 || i ==20){document.write("<br>")}
		}
		</script>		</TD>
	</TR>
<%if PermissionCreatePoll=1 and Request("Poll")=1 then%>
	<TR id=CommonListCell>
		<TD vAlign=top align=Left><FONT color=000000><B>ͶƱ</B><BR>ÿ��һ��ͶƱ��Ŀ<BR>
<INPUT type=radio CHECKED value=0 name=IsMultiplePoll id=IsMultiplePoll><label for=IsMultiplePoll>��ѡͶƱ</label><BR><INPUT type=radio value=1 name=IsMultiplePoll id=IsMultiplePoll_1><label for=IsMultiplePoll_1>��ѡͶƱ</label></FONT> <br>����ʱ�� <INPUT type="text" size="2" name="VoteExpiry" value="7" onkeyup=if(isNaN(this.value))this.value='7'> ���
			
			
</TD>
		<TD><TEXTAREA name=Vote rows=5 cols="80"></TEXTAREA></TD>
	</TR>
<%end if%>
	<TR id=CommonListCell>
		<TD vAlign=top>
		<br><B>����</B><BR>��<a href="javascript:CheckLength();">�鿴���ݳ���</a>��<BR><BR>
		<INPUT id=LockMyPost name=IsLocked type=checkbox value="1"><label for=LockMyPost> ��������</label><br><INPUT id=DisableYBBCode name=DisableYBBCode type=checkbox value=1><label for=DisableYBBCode> ����YBB����</label>
		<%if SiteConfig("UpFileOption")<>empty and PermissionAttachment=1 then%>
			<BR><BR><span id=UpFile></span><a href="javascript:BBSXP_Modal.Open('UploadAttachment.asp',500,150);" class="CommonTextButton">�ϴ�����</a>
		<%end if%>
		</TD>
		<TD height=250><script type="text/javascript" src="Editor/Post.js"></script></TD>
	</TR>
<%if SiteConfig("DisplayPostTags")=1 then%>
	<TR id=CommonListCell>
		<TD><b>��ǩ<br></b>�Զ��š�,���ָ�</TD>
		<TD><input type="text" name="Tags" size="80" /></TD>
	</TR>
<%end if%>
<%if SiteConfig("EnableAntiSpamTextGenerateForPost")=1 then%>
	<tr id=CommonListCell>
		<TD><b>��֤��</b></TD>
		<TD><input type="text" name="VerifyCode" MaxLength="4" size="10" onblur="CheckVerifyCode(this.value)" onKeyUp="if (this.value.length == 4)CheckVerifyCode(this.value)"> <img src="VerifyCode.asp" title="��֤��,�������?����ˢ����֤��" style="cursor:pointer" onclick="this.src='VerifyCode.asp?'+Math.random()"> <span id="CheckVerifyCode" style="color:red"></span></TD>
	</tr>
<%end if%>
	<TR id=CommonListCell>
		<TD align=center colSpan=2><INPUT type=submit value=" ���� " name=EditSubmit>��<input type="Button" value=" Ԥ�� " onclick="Preview();">��<INPUT onclick="history.back()" type="button" value=" ȡ�� "></TD>
	</TR>
</TABLE>
</FORM>
<div name="Preview" id="Preview"></div>
<%
HtmlBottom
%>