<%
if CookieUserName<>empty then SqlLineUser=" and UserName='"&CookieUserName&"'"
sql="Select * from [BBSXP_UserOnline] where IPAddress='"&REMOTE_ADDR&"' "&SqlLineUser&" or sessionid='"&session.sessionid&"' "
Rs.Open sql,Conn,1,3
	if Rs.eof then Rs.addNew
	Rs("act")=""&act&""
	Rs("acturl")=""&Request.ServerVariables("script_name")&"?"&Request.ServerVariables("Query_String")&""
	Rs("ForumID")=ForumID
	Rs("ForumName")=""&ForumName&""
	Rs("lasttime")=now
	if RequestCookies("Invisible")<>empty then Rs("IsInvisible")=RequestCookies("Invisible")
	Rs("IPAddress")=REMOTE_ADDR
	Rs("UserName")=CookieUserName
	Rs("sessionid")=session.sessionid
Rs.update
Rs.close

if CookieUserName<>"" then Execute("update [BBSXP_Users] set UserActivityTime="&SqlNowString&",UserActivityIP='"&REMOTE_ADDR&"' where UserName='"&CookieUserName&"'")
Execute("Delete from [BBSXP_UserOnline] where DateDiff("&SqlChar&"n"&SqlChar&",lasttime,"&SqlNowString&")>"&SiteConfig("UserOnlineTime")&" ")
Onlinemany=Execute("Select count(sessionid) from [BBSXP_UserOnline]")(0)
%>