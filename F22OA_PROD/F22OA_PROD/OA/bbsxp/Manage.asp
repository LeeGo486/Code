<!-- #include file="Setup.asp" -->
<%
if CookieUserName=empty then error("����δ<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>��̳")

if Request.ServerVariables("Request_method") <> "POST" then error("�ύ��ʽ����")

HtmlTop
PostID=RequestInt("PostID")
ThreadID=RequestInt("ThreadID")

sql="Select * From [BBSXP_Threads] where ThreadID="&ThreadID&""
Rs.Open sql,Conn,1
	if Rs.eof then error"<li>ϵͳ�����ڸ����ӵ�����"
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
if PermissionManage=0 then error("����<a href=ShowForumPermissions.asp?ForumID="&ForumID&">Ȩ��</a>����")
select case Request("menu")
	case "Top"
		if BestRole = 1 then
			Execute("update [BBSXP_Threads] Set ThreadTop=2 where ThreadID="&ThreadID&"")
			succtitle="��������ɹ�"
		else
			error("����Ȩ�޲���")
		end if

	case "UnTop"
		if BestRole = 1 then
			Execute("update [BBSXP_Threads] Set ThreadTop=0 where ThreadID="&ThreadID&"")
			succtitle="ȡ����������ɹ�"
		else
			error("����Ȩ�޲���")
		end if
	case "Fix"
		TotalCount=Execute("Select count(PostID) From [BBSXP_Posts"&PostsTableName&"] where ThreadID="&ThreadID&"")(0)
		Execute("update [BBSXP_Threads] Set TotalReplies="&TotalCount&"-1 where ThreadID="&ThreadID&"")
		succtitle="�޸�����ɹ�"
	case "MoveNew"
		Execute("update [BBSXP_Threads] Set lasttime="&SqlNowString&" where ThreadID="&ThreadID&"")
		succtitle="��ǰ����ɹ�"
	case "Move"
		AimForumID=RequestInt("AimForumID")
		if AimForumID=0 then error("��û��ѡ��Ҫ�������ƶ��ĸ���̳")
		Execute("update [BBSXP_Threads] Set ForumID="&AimForumID&",ThreadTop=0,IsGood=0,IsLocked=0,ThreadStyle='' where ThreadID="&ThreadID&"")
		succtitle="�ƶ�����ɹ�"
	case "IsGood"
		if Execute("Select IsGood From [BBSXP_Threads] where ThreadID="&ThreadID&" ")(0)=1 then error("�������Ѿ����뾫�����ˣ������ظ����")
		Execute("update [BBSXP_Threads] Set IsGood=1 where ThreadID="&ThreadID&"")
		Execute("update [BBSXP_Users] Set UserMoney=UserMoney+"&SiteConfig("IntegralAddValuedPost")&",experience=experience+"&SiteConfig("IntegralAddValuedPost")&" where UserName='"&PostAuthor&"'")
		succtitle="��Ϊ��������ɹ�"
	case "DelIsGood"
		if Execute("Select IsGood From [BBSXP_Threads] where ThreadID="&ThreadID&" ")(0)=0 then error("�������Ѿ��Ƴ���������")
		Execute("update [BBSXP_Threads] Set IsGood=0 where ThreadID="&ThreadID&"")
		Execute("update [BBSXP_Users] Set UserMoney=UserMoney+"&SiteConfig("IntegralDeleteValuedPost")&",experience=experience+"&SiteConfig("IntegralDeleteValuedPost")&" where UserName='"&PostAuthor&"'")
		succtitle="ȡ����������ɹ�"
	case "ThreadTop"
		Execute("update [BBSXP_Threads] Set ThreadTop=1 where ThreadID="&ThreadID&"")
		succtitle="�ö�����ɹ�"
	case "DelTop"
		Execute("update [BBSXP_Threads] Set ThreadTop=0 where ThreadID="&ThreadID&"")
		succtitle="ȡ���ö�����ɹ�"
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	case "IsLocked"
		Execute("update [BBSXP_Threads] Set IsLocked=1 where ThreadID="&ThreadID&"")
		succtitle="��������ɹ�"
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	case "DelIsLocked"
		Execute("update [BBSXP_Threads] Set IsLocked=0 where ThreadID="&ThreadID&"")
		succtitle="��������ɹ�"
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
end select
if succtitle="" then error("��Чָ��")
UpForumMostRecent(ForumID)
Log(""&succtitle&"�����⣺"&Topic&"������ID��"&ThreadID&"")
Message="<li>"&succtitle&"</li><li><a href=ShowForum.asp?ForumID="&ForumID&">������̳</a></li>"
succeed Message,"ShowForum.asp?ForumID="&ForumID&""
%>