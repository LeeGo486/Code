<!-- #include file="Setup.asp" -->
<%
UserName=HTMLEncode(Request("UserName"))
HtmlTop
select case Request("menu")
	case ""
		ForumTitle="��������"
		sql="Select top 200 * from [BBSXP_Threads] where IsApproved=1 and IsDel=0 order by ThreadID Desc"
	case "HotViews"
		ForumTitle="��������"
		sql="Select top 200 * from [BBSXP_Threads] where IsApproved=1 and IsDel=0 and DateDiff("&SqlChar&"d"&SqlChar&",PostTime,"&SqlNowString&") < "&SiteConfig("PopularPostThresholdDays")&" order by TotalViews Desc"
	case "HotReplies"
		ForumTitle="��������"
		sql="Select top 200 * from [BBSXP_Threads] where IsApproved=1 and IsDel=0 and DateDiff("&SqlChar&"d"&SqlChar&",PostTime,"&SqlNowString&") < "&SiteConfig("PopularPostThresholdDays")&" order by TotalReplies Desc"
	case "GoodTopic"
		ForumTitle="��������"
		sql="Select top 200 * from [BBSXP_Threads] where IsApproved=1 and IsDel=0 and IsGood=1 order by ThreadID Desc"
	case "VoteTopic"
		ForumTitle="ͶƱ����"
		sql="Select top 200 * from [BBSXP_Threads] where IsApproved=1 and IsDel=0 and IsVote=1 order by ThreadID Desc"
	case "MyTopic"
		ForumTitle="�ҵ�����"
		sql="Select top 200 * from [BBSXP_Threads] where IsApproved=1 and IsDel=0 and PostAuthor='"&UserName&"' order by ThreadID Desc"
	case "NoReplies"
		ForumTitle="δ�ظ���"
		sql="Select top 200 * from [BBSXP_Threads] where IsApproved=1 and IsDel=0 and TotalReplies=0 order by ThreadID Desc"
	case else
		error("���������")
end select

Rs.Open sql,Conn,1
%>

<div id="CommonBreadCrumbArea"><%ClubTree%> �� <%=ForumTitle%></div>

<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<TR id=CommonListTitle>
      <Td width="14%" align="center"><a href="?">��������</a></td>
      <TD width="14%" align="center"><a href="?menu=HotViews">��������</a></td>
      <TD width="14%" align="center"><a href="?menu=HotReplies">��������</a></td>
      <TD width="14%" align="center"><a href="?menu=NoReplies">δ�ظ���</a></td>
      <TD width="14%" align="center"><a href="?menu=GoodTopic">��������</a></td>
      <TD width="14%" align="center"><a href="?menu=VoteTopic">ͶƱ����</a></td>
      <TD width="14%" align="center"><a href="?menu=MyTopic&UserName=<%=CookieUserName%>">�ҵ�����</a></td>
	</TR>
</TABLE>
<br>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="5">����</td>
	</tr>
	<tr id=CommonListHeader align=center>
		<td>����</td>
		<td>����</td>
		<td>�ظ�</td>
		<td>�鿴</td>
		<td>������</td>
	</tr>
<%

	PageSetup=SiteConfig("ThreadsPerPage") '�趨ÿҳ����ʾ����
	Rs.Pagesize=PageSetup
	TotalPage=Rs.Pagecount  '��ҳ��
	PageCount = RequestInt("PageIndex")
	if PageCount <1 then PageCount = 1
	if PageCount > TotalPage then PageCount = TotalPage
	if TotalPage>0 then Rs.absolutePage=PageCount '��ת��ָ��ҳ��
	i=0
	Do While Not RS.EOF and i<pagesetup
		i=i+1
		ShowThread()
		Rs.MoveNext
	loop
Rs.Close
%>
</table>
<table cellspacing=0 cellpadding=0 border=0 width=100%><tr><td><%ShowPage()%></td></tr></table>
<%
HtmlBottom
%>