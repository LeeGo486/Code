<!-- #include file="Setup.asp" --><%
HtmlTop
count=Execute("Select count(sessionid)from [BBSXP_UserOnline]")(0)
regOnline=Execute("Select count(sessionid)from [BBSXP_UserOnline] where UserName<>''")(0)
TotalThreads=Execute("Select SUM(TotalThreads)from [BBSXP_Forums]")(0)
TolReTopic=Execute("Select SUM(TotalPosts)from [BBSXP_Forums]")(0)
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� �鿴��̳״̬</div>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td width="16%" align="center"><a href="?">�������</a></td>
		<td width="16%" align="center"><a href="?menu=cutline">����ͼ��</a></td>
		<td width="16%" align="center"><a href="?menu=UserSex">�Ա�ͼ��</a></td>
		<td width="16%" align="center"><a href="?menu=TodayPage">����ͼ��</a></td>
		<td width="16%" align="center"><a href="?menu=board">����ͼ��</a></td>
		<td width="16%" align="center"><a href="?menu=TotalPosts">����ͼ��</a></td>
	</tr>
	<tr id=CommonListCell>
		<td width="48%" align="center" colspan="3">������ <%=count%> �ˡ�����ע���û� <%=regOnline%> �ˣ��ÿ� <%=count-regOnline%> �ˡ�</td>
		<td width="48%" align="center" colspan="3">������ <%=TolReTopic%> ƪ���������� <%=TotalThreads%> ƪ������ <%=tolReTopic-TotalThreads%> ƪ��</td>
	</tr>
</table>
<br>
<%
select case Request("menu")
	case ""
		default
	case "cutline"
		cutline
	case "board"
		board
	case "TotalPosts"
		TotalPosts
	case "TodayPage"
		TodayPage
	case "UserSex"
		UserSex
end select

Sub default
	if Request.ServerVariables("Request_method") = "POST" and BestRole<>1 then error("ֻ�г������������Ա����ʹ�ò�ѯ����")
	Key=HTMLEncode(Request.Form("Key"))
	Find=HTMLEncode(Request.Form("Find"))

	if Len(Find)>10 then error("�Ƿ�����")
	if Key<>empty then SqlFind=" where "&Find&"='"&Key&"'"
	sql="Select * from [BBSXP_UserOnline] "&SqlFind&" order by LastTime Desc"
	Rs.Open sql,Conn,1
		PageSetup=20 '�趨ÿҳ����ʾ����
		Rs.Pagesize=PageSetup
		TotalPage=Rs.Pagecount  '��ҳ��
		PageCount = RequestInt("PageIndex")
		if PageCount <1 then PageCount = 1
		if PageCount > TotalPage then PageCount = TotalPage
		if TotalPage>0 then Rs.absolutePage=PageCount '��ת��ָ��ҳ��
		i=0
		Do While Not Rs.EOF and i<PageSetup
			i=i+1
			if BestRole<>1 then
				ips=split(Rs("IPAddress"),".")
				ShowIP=""&ips(0)&"."&ips(1)&".*.*"
			else
				ShowIP=""&Rs("IPAddress")&""
			end if


			if ""&Rs("UserName")&""="" then
				UserName="<FONT COLOR=#C0C0C0>"&Rs("SessionID")&"</FONT>"
			else
				if Rs("IsInvisible")=0 or BestRole=1 then UserName="<a href=Profile.asp?UserName="&Rs("UserName")&">"&Rs("UserName")&"</a>"
				if Rs("IsInvisible")=1 then UserName=UserName&"(����)"
			end if


			place2=""
			if Rs("act")<>"" then
				place2 = "<a href="&Rs("acturl")&">"&Rs("act")&"</a>"
				place = "�� "&Rs("ForumName")&" ��"
			else
				place = "�� <a href="&Rs("acturl")&">"&Rs("ForumName")&"</a> ��"
			end if

			allline=""&allline&"<TR align=center id=CommonListCell><TD width=120>"&ShowIP&"</TD><TD width=120>"&Rs("cometime")&"</TD><TD width=120>"&UserName&"</TD><TD width=120>"&place&"</TD><TD height=24>"&place2&"</TD><TD width=120>"&Rs("lasttime")&"</TD></TR>"

			Rs.Movenext
		loop
	Rs.close
%>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr align="center" id=CommonListTitle>
		<td width=120>IP��ַ</td>
		<td width=120>��¼ʱ��</td>
		<td width=120>�û�</td>
		<td width=120>������̳</td>
		<td>��������</td>
		<td width=120>�ʱ��</td>
	</tr>
	<%=allline%>
</table>
<table cellspacing=0 cellpadding=0 border=0 width=100%>
	<tr>
		<td valign="top"><%ShowPage()%></td>

		<td align="right">
		<form action="ViewOnline.asp" method="POST">
			<select name=Find>
				<option value="UserName">��ѯ�û�</option>
				<option value="IPAddress">��ѯ�ɣ�</option>
			</select>	<input size="15" value="<%=Key%>" name="Key"> <input type="submit" value=" ȷ�� ">
		</form>
		</td>
	</tr>
</table>
<%
End Sub

Sub cutline
	sql="Select * from [BBSXP_Forums] where SortOrder>0 and IsActive=1"
	Set Rs=Execute(sql)
%>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td valign="bottom" align="center">��̳����</td>
		<td valign="bottom" align="center">ͼ�α���</td>
		<td valign="bottom" align="center">��������</td>
	</tr>
<%
	i=0
		Do While Not Rs.EOF
			Onlinemany=Execute("Select count(sessionid)from [BBSXP_UserOnline] where ForumID="&Rs("ForumID")&"")(0)
%>
	<tr id=CommonListCell>
		<td width="21%" align="center"><a href="ShowForum.asp?ForumID=<%=Rs("ForumID")%>"><%=Rs("ForumName")%></a></td>
		<td width="65%"><%PercentBar(Onlinemany/count*100)%></td>
		<td align="center" width="12%"><%=Onlinemany%></td>
	</tr>
	<%		
			i=i+1
			if i=10 then i=0
			Rs.MoveNext
		loop
	Rs.Close   
%>
</table>
<%
End Sub

Sub board
	if TotalThreads=0 then TotalThreads=1
	sql="Select * from [BBSXP_Forums] where SortOrder>0 and IsActive=1 order by TotalThreads Desc"
	Set Rs=Execute(sql)
%>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td valign="bottom" align="center">��̳����</td>
		<td valign="bottom" align="center">ͼ�α���</td>
		<td valign="bottom" align="center">������</td>
	</tr>
	<%
	i=0
	Do While Not Rs.EOF
%>
	<tr id=CommonListCell>
		<td width="21%" align="center"><a href="ShowForum.asp?ForumID=<%=Rs("ForumID")%>"><%=Rs("ForumName")%></a></td>
		<td width="65%"><%PercentBar(Rs("TotalThreads")/TotalThreads*100)%></td>
		<td align="center" width="12%"><%=Rs("TotalThreads")%></td>
	</tr>
	<%
		i=i+1
		if i=10 then i=0		
		Rs.MoveNext
	loop
	Rs.Close   
%>
</table>
<%
End Sub

Sub TotalPosts
	if tolReTopic=0 then tolReTopic=1
	sql="Select * from [BBSXP_Forums] where SortOrder>0 and IsActive=1 order by TotalPosts Desc"
	Set Rs=Execute(sql)
%>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td valign="bottom" align="center">��̳����</td>
		<td valign="bottom" align="center">ͼ�α���</td>
		<td valign="bottom" align="center">������</td>
	</tr>
	<%
	i=0
	Do While Not Rs.EOF
%>
	<tr id=CommonListCell>
		<td width="21%" align="center"><a href="ShowForum.asp?ForumID=<%=Rs("ForumID")%>"><%=Rs("ForumName")%></a></td>
		<td width="65%"><%PercentBar(Rs("TotalPosts")/tolReTopic*100)%></td>
		<td align="center" width="12%"><%=Rs("TotalPosts")%></td>
	</tr>
	<%		
		i=i+1
		if i=10 then i=0		
		Rs.MoveNext
	loop
	Rs.Close
%>
</table>
<%
End Sub

Sub TodayPage
	tolTodayPosts=Execute("Select SUM(TodayPosts)from [BBSXP_Forums]")(0)
	if tolTodayPosts=0 then tolTodayPosts=1
	sql="Select * from [BBSXP_Forums] where SortOrder>0 and IsActive=1 order by TodayPosts Desc"
	Set Rs=Execute(sql)
%>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td valign="bottom" align="center">��̳����</td>
		<td valign="bottom" align="center">ͼ�α���</td>
		<td valign="bottom" align="center">��������</td>
	</tr>
	<%
	i=0
	Do While Not Rs.EOF
%>
	<tr id=CommonListCell>
		<td width="21%" align="center"><a href="ShowForum.asp?ForumID=<%=Rs("ForumID")%>"><%=Rs("ForumName")%></a></td>
		<td width="65%"><%PercentBar(Rs("TodayPosts")/tolTodayPosts*100)%></td>
		<td align="center" width="12%"><%=Rs("TodayPosts")%></td>
	</tr>
	<%		
		i=i+1
		if i=10 then i=0			
		Rs.MoveNext
	loop
	Rs.Close   
%>
</table>
<%
End Sub

Sub UserSex
	count=Execute("Select count(UserID) from [BBSXP_Users]")(0)
	male=Execute("Select count(UserID) from [BBSXP_Users] where UserSex=1")(0)
	female=Execute("Select count(UserID) from [BBSXP_Users] where UserSex=2")(0)
%>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td valign="bottom" align="center">�Ա�</td>
		<td valign="bottom" align="center">ͼ�α���</td>
		<td valign="bottom" align="center">����</td>
	</tr>
	<tr id=CommonListCell>
		<td width="10%" align="center"><img src="images/Sex_1.gif"></td>
		<td width="75%"><%PercentBar(male/count*100)%></td>
		<td align="center" width="12%"><%=male%></td>
	</tr>
	<tr id=CommonListCell>
		<td width="10%" align="center"><img src="images/Sex_2.gif"></td>
		<td width="75%"><%PercentBar(female/count*100)%></td>
		<td align="center" width="12%"><%=female%></td>
	</tr>
	<tr id=CommonListCell>
		<td width="10%" align="center">δ֪</td>
		<td width="75%"><%PercentBar((count-male-female)/count*100)%></td>
		<td align="center" width="12%"><%=count-male-female%></td>
	</tr>
</table>
<%
End Sub
function PercentBar(PercentWidth)
	response.write("<div class='percent'><div style='width:"&int(PercentWidth)&"%'></div></div>")
end function
HtmlBottom
%>