<!-- #include file="Setup.asp" -->

<%
if RequestCookies("Userpass")="" or RequestCookies("Userpass")<>session("pass") then response.redirect "Admin_Default.asp"

AdminTop
Log("")

select case Request("Menu")
	case "ViewComment"
		ViewComment
	case "DeleteComment"
		ReputationID=RequestInt("ReputationID")
		if ReputationID>0 then Conn.Execute("Delete from [BBSXP_Reputation] where ReputationID="&ReputationID&"")
		Response.write("ɾ���ɹ�")
	case else
		Default
end select

Sub Default
%>
<SCRIPT type="text/javascript" src="Utility/calendar.js"></SCRIPT>
�û����ۣ�<b><font color=red><%=Execute("Select count(ReputationID) from [BBSXP_Reputation]")(0)%></font></b> ��
<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
	<form method="POST" action="?menu=ViewComment">
	<tr id=CommonListTitle>
		<td align=center colspan=2>��ʾ��������</td>
	</tr>
	<tr id=CommonListCell>
		<td align=right width=30%>�� �� �ˣ�</td>
		<td><input type=text name=CommentBy size=24></td>
	</tr>
	<tr id=CommonListCell>
		<td align=right width=30%>�������ˣ�</td>
		<td><input type=text name=CommentFor size=24></td>
	</tr>
	<tr id=CommonListCell>
		<td align=right width=30%>��ʼ���ڣ�</td>
		<td><input type=text name=StartDate size=24 onclick="showcalendar(event, this)"></td>
	</tr>
	<tr id=CommonListCell>
		<td align=right width=30%>�������ڣ�</td>
		<td><input type=text name=EndDate size=24 onclick="showcalendar(event, this)"></td>
	</tr>
	<tr id=CommonListCell>
		<td align=center colspan=2><input type=submit value=" ִ�� ">��<input type=Reset value=" ���� "></td>
	</tr>
	</form>
</table>
<br>
<%
End Sub

Sub ViewComment
%>
<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
	<TR align=center id=CommonListTitle>
		<TD>������</TD>
		<TD colspan=2>��������</TD>
		<td>����</td>
		<TD>��������</TD>
		<TD>����</TD>
	</TR>
<%
	CommentBy=HTMLEncode(Request("CommentBy"))
	CommentFor=HTMLEncode(Request("CommentFor"))
	StartDate=HTMLEncode(Request("StartDate"))
	EndDate=HTMLEncode(Request("EndDate"))
	

	if CommentBy<>"" then item=item&" and CommentBy like '%"&CommentBy&"%'"
	if CommentFor<>"" then item=item&" and CommentFor like '%"&CommentFor&"%'"
	if IsDate(StartDate) then item=item&" and DateDiff("&SqlChar&"d"&SqlChar&",'"&StartDate&"',DateCreated)>0"
	if IsDate(EndDate) then item=item&" and DateDiff("&SqlChar&"d"&SqlChar&",DateCreated,'"&EndDate&"')>0"

	if item<>"" then item=" where "&mid(item,5)

	sql="[BBSXP_Reputation]"&item&" order by DateCreated desc"
	
	TotalCount=Execute("Select count(ReputationID) From [BBSXP_Reputation]"&item&"")(0) '��ȡ��������
	PageSetup=20 '�趨ÿҳ����ʾ����
	TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '��ҳ��
	PageCount = RequestInt("PageIndex") '��ȡ��ǰҳ
	if PageCount <1 then PageCount = 1
	if PageCount > TotalPage then PageCount = TotalPage
	if PageCount<11 then
		Set Rs=Execute(sql)
	else
		Rs.Open sql,Conn,1
	end if
	if TotalPage>1 then Rs.Move (PageCount-1) * pagesetup
	i=0
	Do While Not Rs.EOF and i<PageSetup
		i=i+1
		if Rs("Reputation")>0 then
			ReputationTitle="����"
			ImgUrl="Reputation_Excellent.gif"
			FontColor="#FF0000"
			Reputation="+"&Rs("Reputation")
		elseif Rs("Reputation")=0 then
			ReputationTitle="����"
			ImgUrl="Reputation_Average.gif"
			FontColor="#007700"
			Reputation="���Ʒ�"
		else
			ReputationTitle="����"
			ImgUrl="Reputation_Poor.gif"
			FontColor=""
			Reputation=Rs("Reputation")
		end if
%>

	<TR align=center id=CommonListCell>
		<TD><a href="Profile.asp?UserName=<%=Rs("CommentBy")%>" target=_blank><%=Rs("CommentBy")%></a></TD>
		<TD><img src='images/<%=ImgUrl%>' align=absmiddle title='<%=ReputationTitle%>'> <font color='<%=FontColor%>'><%=ReputationTitle%></font></TD>
		<TD align=left><%=Rs("Comment")%> <em><font color=#C0C0C0><%=Rs("DateCreated")%></font></em></TD>
		<td><%=Reputation%></td>
		<TD><a href="Profile.asp?UserName=<%=Rs("CommentFor")%>" target=_blank><%=Rs("CommentFor")%></a></TD>
		<TD><a onclick="return window.confirm('��ȷ��Ҫɾ����������?')" href=?menu=DeleteComment&ReputationID=<%=Rs("ReputationID")%>>ɾ��</a></TD>
	</TR>

<%
		Rs.movenext
	loop
	Rs.close
%>
</table>
<table border=0 width=100% align=center><tr><td><%ShowPage()%></tr></td></table>
<%
End Sub


AdminFooter
%>