<!--#include file="conn.asp"--><%

if SiteConfig("EnableForumsRSS")=0 then
	response.write "ϵͳ�ر��� RSS ����Դ����"
	Response.End
end if

ForumID=RequestInt("ForumID")


if ForumID > 0 then

	Rs.Open "[BBSXP_ForumPermissions] where ForumID="&ForumID&" and RoleID=0",Conn,1
		
	if Rs.Eof then
		response.write "�Ҳ���ָ���İ���Ȩ�ޱ�"
		Response.End
	end if
	
	PermissionRead=Rs("PermissionRead")
	PermissionView=Rs("PermissionView")
	Rs.Close

	if PermissionView=0 or PermissionRead=0 then
		response.write "�ð��û�п����ο�������Ķ�Ȩ�ޣ��޷�ʹ�� RSS ����Դ��"
		Response.End
	end if


	ChannelTitle=Execute("Select ForumName from [BBSXP_Forums] where ForumID="&ForumID&"")(0)
	ChannelLink=""&SiteConfig("SiteUrl")&"/ShowForum.asp?ForumID="&ForumID&""
end if


Response.contentType="application/xml"

%><?xml version="1.0" encoding="gb2312"?>
<rss version="2.0">
<channel>

	<title><%=ChannelTitle%></title>
	<link><%=ChannelLink%></link>

	<image>
		<title><%=SiteConfig("SiteName")%></title> 
		<url><%=SiteConfig("SiteUrl")%>/images/logo.gif</url>
		<link><%=SiteConfig("SiteUrl")%>/Default.asp</link>
	</image>

<%
	sql="Select top "&SiteConfig("RSSDefaultThreadsPerFeed")&" * from [BBSXP_Threads] where IsDel=0 and IsApproved=1 and ForumID="&ForumID&" order by ThreadID desc"
	Set Rs=Execute(sql)
		do while Not Rs.Eof
%>
	<item>
		<title><%=Rs("Topic")%></title>
		<link><%=SiteConfig("SiteUrl")%>/ShowPost.asp?ThreadID=<%=Rs("ThreadID")%></link><category><%=Rs("Category")%></category><author><%=Rs("PostAuthor")%></author><pubDate><%=FormatTime(Rs("PostTime"))%></pubDate><description><![CDATA[<%=Execute("Select Body From [BBSXP_Posts"&Rs("PostsTableName")&"] where ThreadID="&Rs("ThreadID")&" and ParentID=0")(0)%>]]></description></item><%
		Rs.MoveNext
		Loop
	Set Rs = Nothing
%></channel></rss>