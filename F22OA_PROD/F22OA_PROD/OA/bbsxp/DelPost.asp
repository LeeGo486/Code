<!-- #include file="Setup.asp" --><%
HtmlTop
if CookieUserName=empty then error("����δ<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>��̳")

ThreadID=RequestInt("ThreadID")
PostID=RequestInt("PostID")
sql="Select * From [BBSXP_Threads] where ThreadID="&ThreadID&""
Rs.Open sql,Conn,1
	if Rs.eof or Rs.bof then error"<li>ϵͳ�����ڸ����ӵ�����"
	ForumID=Rs("ForumID")
	PostsTableName=Rs("PostsTableName")
	Topic=Rs("Topic")
Rs.close

sql="Select * from [BBSXP_Forums] where ForumID="&ForumID&""
Set Rs=Execute(sql)
	ForumName=Rs("ForumName")
	Moderated=Rs("Moderated")
	ParentID=Rs("ParentID")
	GroupID=Rs("GroupID")
Rs.close

%>
<!-- #include file="Utility/ForumPermissions.asp" -->
<%
if PermissionDelete=0 then error("����<a href=ShowForumPermissions.asp?ForumID="&ForumID&">Ȩ��</a>����")
if Execute("Select IsDel From [BBSXP_Threads] where ThreadID="&ThreadID&" ")(0)=1 then error("�������Ѿ��ڻ���վ��")
	
sql="Select * from [BBSXP_Posts"&PostsTableName&"] where PostID="&PostID&""
Rs.Open sql,Conn,1,3
	if Rs.eof or Rs.bof then error"<li>ϵͳ�����ڸ����ӵ�����"
	if Rs("PostAuthor")<>CookieUserName and PermissionManage=0 then error("����<a href=ShowForumPermissions.asp?ForumID="&ForumID&">Ȩ��</a>������")
	Subject=Rs("Subject")
	PostBody=Rs("Body")
Rs.close

if Request.ServerVariables("Request_method") <> "POST" then

%>

<div id="CommonBreadCrumbArea"><%ClubTree%> �� <%=ForumTree(ParentID)%> <a href=ShowForum.asp?ForumID=<%=ForumID%>><%=ForumName%></a> �� <a href="ShowPost.asp?ThreadID=<%=ThreadID%>"><%=Topic%></a> �� ɾ������</div>

<script language="JavaScript">
var XmlDom = GetXmlDom();
XmlDom.async = false;
XmlDom.load("Utility/Templates.xml");
var XmlDomRoot = XmlDom.documentElement;
TemplateNode = XmlDomRoot.getElementsByTagName('template');

function PostDelReason(i) {  //ԭ��
	var ElementNode = TemplateNode[i].getElementsByTagName('body')[0];
	ReasonText = GetNodeValue(ElementNode);
	ReasonText = ReasonText.replace('\[SiteName\]','<%=SiteConfig("SiteName")%>');
	document.getElementById("ReasonBody").value = ReasonText;
}

function DelReasonOptions() { //ԭ��������
	for( var i=0;i<TemplateNode.length;i++) {
		var ElementNode = TemplateNode[i].getElementsByTagName('title')[0];
		document.write("<option value="+TemplateNode[i].getAttributeNode('id').nodeValue+">"+GetNodeValue(ElementNode)+"</option>");
	}
}
</script>
<form method="Post" action="?<%=Request.ServerVariables("Query_String")%>">
	<table cellspacing="1" cellpadding="5" width=100% id=CommonListArea>
		<tr id=CommonListTitle>
			<td colspan="2" align="center">ɾ������</td>
		</tr>
		<tr id=CommonListCell>
			<td width="200">�ꡡ�⣺</td>
			<td><%=Subject%></td>
		</tr>
		<tr id=CommonListCell>
			<td width="200">ɾ���ˣ�</td>
			<td><%=CookieUserName%></td>
		</tr>
		<tr id=CommonListCell>
			<td>ɾ�����ӵ�ԭ��</td>
			<td><select name="PostDeleteReason" onchange="PostDelReason(this.options[this.selectedIndex].value)"><script language="JavaScript">DelReasonOptions()</script></select></td>
		</tr>
		<tr id=CommonListCell>
			<td>ԭ��</td>
			<td><textarea id="ReasonBody" name="ReasonBody" rows="12" cols="80"></textarea></td>
		</tr>
		<tr id=CommonListCell>
			<td colspan="2" align="center"><input type="submit" value=" ȷ�� ">������<input onclick="history.back()" type="button" value=" ȡ�� "></td>
		</tr>
	</table>
</form>
<%
HtmlBottom
end if

sql="Select * from [BBSXP_Posts"&PostsTableName&"] where PostID="&PostID&""
Rs.Open sql,Conn,1
	if Rs.eof or Rs.bof then error"<li>ϵͳ�����ڸ����ӵ�����"
	if Rs("PostAuthor")<>CookieUserName and PermissionManage=0 then error("����<a href=ShowForumPermissions.asp?ForumID="&ForumID&">Ȩ��</a>������")
	PostID=Rs("PostID")
	ThreadID=Rs("ThreadID")
	ParentID=Rs("ParentID")
	PostAuthor=Rs("PostAuthor")
	PostDate=Rs("PostDate")
Rs.close
	
	if ParentID=0 then
		succtitle="ɾ������ɹ�"
		Execute("update [BBSXP_Users] Set TotalPosts=TotalPosts-1,UserMoney=UserMoney+"&SiteConfig("IntegralDeleteThread")&",experience=experience+"&SiteConfig("IntegralDeleteThread")&" where UserName='"&PostAuthor&"'")
		Execute("update [BBSXP_Threads] Set ThreadTop=0,IsDel=1,lastname='"&CookieUserName&"',lasttime="&SqlNowString&" where ThreadID="&ThreadID&"")
		Execute("update [BBSXP_Forums] Set TotalThreads=TotalThreads-1,TotalPosts=TotalPosts-1 where ForumID="&ForumID&"")
	else
		succtitle="ɾ�������ɹ�"
		Execute("Delete from [BBSXP_Posts"&PostsTableName&"] where PostID="&PostID&"")
		Execute("update [BBSXP_Users] Set TotalPosts=TotalPosts-1,UserMoney=UserMoney+"&SiteConfig("IntegralDeletePost")&",experience=experience+"&SiteConfig("IntegralDeletePost")&" where UserName='"&PostAuthor&"'")

		sql="Select top 1 * from [BBSXP_Posts"&PostsTableName&"] where ThreadID="&ThreadID&" order by PostID DESC"
		Rs.Open sql,Conn,1
		LastName=Rs("PostAuthor")
		LastTime=Rs("PostDate")
		Rs.close
		Execute("update [BBSXP_Threads] Set TotalReplies=TotalReplies-1,LastName='"&LastName&"',LastTime='"&LastTime&"' where ThreadID="&ThreadID&"")
		Execute("update [BBSXP_Forums] Set TotalPosts=TotalPosts-1 where ForumID="&ForumID&"")
	end if
	
UpForumMostRecent(ForumID)

		MailAddRecipient=Execute("Select UserEmail from [BBSXP_Users] where UserName='"&PostAuthor&"'")(0)
		LoadingEmailXml("MessageDeleted")
		MailBody=Replace(MailBody,"[Moderator]",CookieUserName)
		MailBody=Replace(MailBody,"[Topic]",Topic)
		MailBody=Replace(MailBody,"[Subject]",Subject)
		MailBody=Replace(MailBody,"[Body]",PostBody)
		MailBody=Replace(MailBody,"[DeleteReasons]",HTMLEncode(Request("ReasonBody")))
		SendMail MailAddRecipient,MailSubject,MailBody

if succtitle="" then error("��Ч����")
Log(""&succtitle&"�����⣺"&Subject&"������ID��"&ThreadID&"������ID��"&PostID&"")
Message="<li>"&succtitle&"<li><a href=ShowForum.asp?ForumID="&ForumID&">������̳</a>"
succeed Message,"ShowForum.asp?ForumID="&ForumID&""
%>