<!-- #include file="conn.asp" -->
<%
if Request.ServerVariables("Request_method") <> "POST" then Response.End

	RandomID=""&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&""

	TargetUser=HTMLEncode(Request("TargetUser"))
	
if CookieUserName="" then ConciseMsg("���¼���ٽ��в���")
	
select case Request("menu")
	case "MarryRequest"
		if CookieUserName=TargetUser then ConciseMsg("�����Լ����Լ����")
		if CookieUserMate<>"" then ConciseMsg("���Ѿ�����ż��")
		if Execute("Select UserMate From [BBSXP_Users] where UserName='"&TargetUser&"'")(0)<>"" then  ConciseMsg(""&TargetUser&"�Ѿ�����ż��")
		AddApplication "Message_"&TargetUser,"��ϵͳѶϢ��<span id="&RandomID&">"&CookieUserName&"������飡��ѡ�� <a href=javascript:Ajax_CallBack(false,'"&RandomID&"','UserMate.asp?menu=marry&TargetUser="&CookieUserName&"');>����</a> �� <a href=javascript:Ajax_CallBack(false,'"&RandomID&"','UserMate.asp?menu=refused&TargetUser="&CookieUserName&"');>�ܾ�</a> ��</span>"
		ConciseMsg("��������ѷ���")

	case "marry"
		if CookieUserName=TargetUser then ConciseMsg("�����Լ����Լ����")
		if CookieUserMate<>"" then ConciseMsg("���Ѿ�����ż��")	
		if Execute("Select UserMate From [BBSXP_Users] where UserName='"&TargetUser&"'")(0)<>"" then  ConciseMsg(""&TargetUser&"�Ѿ�����ż��")	
		Execute("Update [BBSXP_Users] Set UserMate='"&TargetUser&"' where UserName='"&CookieUserName&"'")
		Execute("Update [BBSXP_Users] Set UserMate='"&CookieUserName&"' where UserName='"&TargetUser&"'")
		AddApplication "Message_"&TargetUser,"��ϵͳѶϢ��"&CookieUserName&"���������"
		ConciseMsg("���Ѿ��� "&TargetUser&" �Ľ����")

	case "refused"
		AddApplication "Message_"&TargetUser,"��ϵͳѶϢ��"&CookieUserName&"�ܾ��������"
		ConciseMsg("���Ѿ��ܾ��� "&TargetUser&" �Ľ������")

	case "divorce"
		Execute("Update [BBSXP_Users] Set UserMate='' where UserName='"&CookieUserName&"' or UserName='"&CookieUserMate&"' ")
		AddApplication "Message_"&CookieUserMate,"��ϵͳѶϢ��"&CookieUserName&"�Ѿ��������"
		ConciseMsg("���ɹ�")
	
end select






%>