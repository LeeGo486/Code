<%
if CookieUserRoleID="" then
	CookieUserRoleID=0
elseIf Execute("Select RoleID From [BBSXP_ForumPermissions] where ForumID="&ForumID&" and RoleID="&CookieUserRoleID&"" ).eof Then
	CookieUserRoleID=0
	NotFindRole=1
end if

SQL="Select * from [BBSXP_ForumPermissions] where ForumID="&ForumID&" and RoleID="&CookieUserRoleID&""
Rs.Open sql,Conn,1,3
	if Rs.eof then
		Rs.addNew
		Rs("ForumID")=ForumID
		Rs.update
	end if
	PermissionView=Rs("PermissionView")
	PermissionRead=Rs("PermissionRead")
	PermissionPost=Rs("PermissionPost")
	PermissionReply=Rs("PermissionReply")
	PermissionEdit=Rs("PermissionEdit")
	PermissionDelete=Rs("PermissionDelete")
	PermissionCreatePoll=Rs("PermissionCreatePoll")
	PermissionVote=Rs("PermissionVote")
	PermissionAttachment=Rs("PermissionAttachment")
	PermissionManage=Rs("PermissionManage")
Rs.close

if CookieUserName=empty then
	PermissionPost=0
	PermissionReply=0
	PermissionEdit=0
	PermissionDelete=0
	PermissionCreatePoll=0
	PermissionVote=0
	PermissionAttachment=0
	PermissionManage=0
elseif (NotFindRole=1 and BestRole=1) or instr("|"&Moderated&"|","|"&CookieUserName&"|")>0 then
	PermissionView=1
	PermissionRead=1
	PermissionPost=1
	PermissionReply=1
	PermissionEdit=1
	PermissionDelete=1
	PermissionCreatePoll=1
	PermissionVote=1
	PermissionAttachment=1
	PermissionManage=1
end if
%>