<!-- #include file="Setup.asp" -->
<%
ThreadID=RequestInt("ThreadID")
if CookieUserName=empty then error("������<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>�����ͶƱ")
if Request("PostVote")="" then error("��ѡ����ҪͶƱ����Ŀ��")
sql="Select * from [BBSXP_Votes] where ThreadID="&ThreadID&""
Rs.Open sql,Conn,1,3
	if instr("|"&Rs("BallotUserList")&"|","|"&CookieUserName&"|")>0 then error("���Ѿ�Ͷ��Ʊ�ˣ������ظ�ͶƱ��")
	if instr("|"&Rs("BallotIPList")&"|","|"&REMOTE_ADDR&"|")>0 then error("��IP�Ѿ�Ͷ��Ʊ�ˣ������ظ�ͶƱ��")
	if Rs("Expiry")< now() then error("ͶƱ�ѹ���")
	for each ho in Request.Form("PostVote")
		pollresult=split(Rs("Result"),"|")
		for i = 0 to ubound(pollresult)
			if not pollresult(i)="" then
				if int(ho)=i then
					pollresult(i)=pollresult(i)+1
				end if
				allpollresult=""&allpollresult&""&pollresult(i)&"|"
			end if
		next
		Rs("Result")=allpollresult
		Rs.update
		allpollresult=""
	next
	Rs("BallotUserList")=""&Rs("BallotUserList")&""&CookieUserName&"|"
	Rs("BallotIPList")=""&Rs("BallotIPList")&""&REMOTE_ADDR&"|"
Rs.update
Rs.close
Execute("update [BBSXP_Threads] Set lasttime="&SqlNowString&",lastname='"&CookieUserName&"' where ThreadID="&ThreadID&"")
response.redirect ReturnUrl
%>