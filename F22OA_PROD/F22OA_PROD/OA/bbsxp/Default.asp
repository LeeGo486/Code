<!-- #include file="Setup.asp" -->
<%
GroupID=RequestInt("GroupID")
HtmlTop
%>
<div id="CommonBreadCrumbArea">

	<div style="float:left"><%ClubTree%></div>

	<div style="float:right"><a href="Archiver.asp">Archiver</a></div>

</div>
<%
sql="[BBSXP_Threads] where IsApproved=1 and IsDel=0 and ThreadTop=2 order by ThreadID Desc"
Set Rs=Execute(sql)
if Not Rs.Eof Then 
%>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td>����</td>
	</tr>
	<tr id=CommonListCell>
		<td>
			<marquee onMouseOver="this.stop();" onMouseOut="this.start();" scrollAmount="3">
	<%
		Do While Not Rs.Eof
			Response.Write "<a href='ShowPost.asp?ThreadID="&Rs("ThreadID")&"'><b>"&Rs("Topic")&"</b> ("&FormatDateTime(Rs("PostTime"),2)&")</a>����"
			Rs.MoveNext
		Loop
	%>	
			</marquee>
		</td>
	</tr>
</table>

<%
End If
Rs.Close





if GroupID>0 then GroupIDSQL=" and GroupID="&GroupID&""
GroupGetRow=FetchEmploymentStatusList("Select GroupID,GroupName,GroupDescription From [BBSXP_Groups] where SortOrder>0 "&GroupIDSQL&" order by SortOrder")

if IsArray(GroupGetRow) then

	for j=0 to Ubound(GroupGetRow,2)
	
		if RequestCookies("ForumGroupDisplay"&GroupGetRow(0,j)&"")="none" then
			ForumGroupDisplay="style='display:none;'"
			ForumGroupDisplayImg="group_expand.gif"
		else
			ForumGroupDisplay=""
			ForumGroupDisplayImg="group_collapse.gif"
		end if
%>

<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="7">
			<table width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td><a href="default.asp?GroupID=<%=GroupGetRow(0,j)%>" title="<%=GroupGetRow(2,j)%>"><%=GroupGetRow(1,j)%></a></td>
					<td align="right"><img style="CURSOR: pointer" onMouseDown="ForumGroupToggleCollapsed('<%=GroupGetRow(0,j)%>')" src="images/<%=ForumGroupDisplayImg%>" id="ForumGroupImg<%=GroupGetRow(0,j)%>" ></td>
				</tr>
			</table>
		</td>
	</tr>
	<tbody id="ForumGroup<%=GroupGetRow(0,j)%>" <%=ForumGroupDisplay%>>
	<tr id=CommonListHeader align="center">
		<td width="30"></td>
		<td>���</td>
		<td width="50">����</td>
		<td width="50">����</td>
		<td width="200">��󷢱�</td>
		<td width="100">����</td>
	</tr>
<%
		sql="Select * From [BBSXP_Forums] where GroupID="&GroupGetRow(0,j)&" and ParentID=0 and SortOrder>0 and IsActive=1 order by SortOrder"
		Set Rs=Execute(sql)
		do while not Rs.eof
			ShowForum
			Rs.Movenext
		loop
		Rs.close
		response.write "</table>"
	next

end if





ForumName=SiteConfig("SiteName")
ForumID=0


%>


<br>
<!-- #include file="Utility/OnLine.asp" -->
<%
regOnline=Execute("Select count(sessionid) from [BBSXP_UserOnline] where UserName<>''")(0)
if BestOnline < Onlinemany then
	Execute("update [BBSXP_SiteSettings] Set BestOnline="&Onlinemany&",BestOnlineTime="&SqlNowString&"")
end if
if SiteConfig("DisplayWhoIsOnline")=1 then
%>

<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="2">�û�������Ϣ</td>
	</tr>
	<tr id=CommonListCell><td align="center" width="5%"><img src="images/whos_online.gif"></td>
		<td>
		<img src="images/plus.gif" id="followImg" style="cursor:pointer;" onClick="loadThreadFollow(<%=ForumID%>)">
		<%Response.Write("Ŀǰ��̳�ܹ� �� <b>"&Onlinemany&"</b> �����ߡ�����ע���û� <b>"&regOnline&"</b> �ˣ��ÿ� <b>"&Onlinemany-regOnline&"</b> �ˡ�������� <font color='red'><b>"&BestOnline&"</b></font> �ˣ������� <b>"&BestOnlineTime&"</b>")%>
		<div style="display:none" id="follow">
			<hr width="90%" SIZE="1" align="left"><span id=followTd><img src=images/loading.gif>���ڼ���...</span>
		</div>
		</td>
	</tr>
</table>

<br>
<%
end if
if SiteConfig("DisplayStatistics")=1 then
%>

<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="2">ͳ����Ϣ</td>
	</tr>
	<tr id=CommonListCell>
		<td width="5%" align="center"><img src="images/stats.gif" width="30" height="30"></td>
		<td><%
			SQL="Select top 1 * from [BBSXP_Statistics] order by DateCreated desc"
			Set Rs=Execute(sql)
			if Rs.eof then response.redirect "Install.asp"
		%>
		�ܹ� <b><%=Rs("TotalTopics")%></b> ������ / <b><%=Rs("TotalPosts")%></b> ƪ���� / <b><%=Rs("TotalUsers")%></b> λ�û�<br>
		<%=FormatDateTime(Rs("DateCreated"),1)%>���� <b><%=Rs("DaysTopics")%></b> �������� / <b><%=Rs("DaysPosts")%></b> ƪ������ / <b><%=Rs("DaysUsers")%></b> λ���û�<br>
		��ӭ���û� <a href='Profile.asp?UserName=<%=Rs("NewestUserName")%>'><b><%=Rs("NewestUserName")%></b></a>
		<%Rs.close%>
		</td>
	</tr>
</table>
<br>
<%
end if
if SiteConfig("DisplayBirthdays")=1 then
%>

<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="2">��������յ��û�</td>
	</tr>
		<tr id=CommonListCell><td width="5%" align="center"><img src="images/birthday.gif" width="30" height="30"></td><td>
<%
UserBirthdayGetRow=GetEmploymentStatusList("UserBirthday","Select UserName From [BBSXP_Users] where Month(Birthday)="&Month(now())&" and day(Birthday)="&day(now())&"")
if IsArray(UserBirthdayGetRow) then
	For i=0 To Ubound(UserBirthdayGetRow,2)
		%><a href="Profile.asp?UserName=<%=UserBirthdayGetRow(0,i)%>"><%=UserBirthdayGetRow(0,i)%></a>��<%
	Next
Else
	Response.Write "����û�й����յ��û�" 
End if
%></td></tr>
</table><br>
<%
end if
if SiteConfig("DisplayLink")=1 then
%>

<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="2" align="left">��������</td>
	</tr>
	<tr id=CommonListCell>
		<td align="center" width="5%" rowspan="2">
		<img src="images/shareforum.gif"></td>
		<td><%
		
LinksGetRow=GetEmploymentStatusList("Links","Select name,Logo,url,Intro From [BBSXP_Links] where SortOrder>0 order by SortOrder")

if IsArray(LinksGetRow) then
	For i=0 To Ubound(LinksGetRow,2)
	
		if LinksGetRow(1,i)="" or LinksGetRow(1,i)="http://" then
			Link1=Link1+"<a title='"&LinksGetRow(3,i)&"' href="&LinksGetRow(2,i)&" target=_blank>"&LinksGetRow(0,i)&"</a> "
		else
			Link2=Link2+"<a title='"&LinksGetRow(0,i)&""&chr(10)&""&LinksGetRow(3,i)&"' href="&LinksGetRow(2,i)&" target=_blank><img src="&LinksGetRow(1,i)&" border=0 width=88 height=31></a> "
		end if
	Next
End if
if Link2<>"" then Link2="<hr>"&Link2
Link=Link1&Link2
%><%=Link%></td>
	</tr>
</table>

<%
end if
%>
<br />

<table width="50%" align="center">
	<tr>
		<td align="center"><img src="images/forum_status_new.gif" border="0" title="һ�����������ӵ���̳"> ����������̳</td>
		<td align="center"><img src="images/forum_status.gif" border="0" title="һ�����������ӵ���̳"> ����������̳</td>
		<td align="center"><img src="images/forum_link.gif" border="0" title="��ֱ̳��ת���趨������"> �����ӵ���̳</td>
	</tr>
</table>

<%
HtmlBottom
%>