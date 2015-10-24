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
		Response.write("删除成功")
	case else
		Default
end select

Sub Default
%>
<SCRIPT type="text/javascript" src="Utility/calendar.js"></SCRIPT>
用户评价：<b><font color=red><%=Execute("Select count(ReputationID) from [BBSXP_Reputation]")(0)%></font></b> 条
<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
	<form method="POST" action="?menu=ViewComment">
	<tr id=CommonListTitle>
		<td align=center colspan=2>显示声望评论</td>
	</tr>
	<tr id=CommonListCell>
		<td align=right width=30%>评 价 人：</td>
		<td><input type=text name=CommentBy size=24></td>
	</tr>
	<tr id=CommonListCell>
		<td align=right width=30%>被评价人：</td>
		<td><input type=text name=CommentFor size=24></td>
	</tr>
	<tr id=CommonListCell>
		<td align=right width=30%>起始日期：</td>
		<td><input type=text name=StartDate size=24 onclick="showcalendar(event, this)"></td>
	</tr>
	<tr id=CommonListCell>
		<td align=right width=30%>结束日期：</td>
		<td><input type=text name=EndDate size=24 onclick="showcalendar(event, this)"></td>
	</tr>
	<tr id=CommonListCell>
		<td align=center colspan=2><input type=submit value=" 执行 ">　<input type=Reset value=" 重置 "></td>
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
		<TD>评论人</TD>
		<TD colspan=2>评论内容</TD>
		<td>声望</td>
		<TD>被评论人</TD>
		<TD>动作</TD>
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
	
	TotalCount=Execute("Select count(ReputationID) From [BBSXP_Reputation]"&item&"")(0) '获取数据数量
	PageSetup=20 '设定每页的显示数量
	TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '总页数
	PageCount = RequestInt("PageIndex") '获取当前页
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
			ReputationTitle="好评"
			ImgUrl="Reputation_Excellent.gif"
			FontColor="#FF0000"
			Reputation="+"&Rs("Reputation")
		elseif Rs("Reputation")=0 then
			ReputationTitle="中评"
			ImgUrl="Reputation_Average.gif"
			FontColor="#007700"
			Reputation="不计分"
		else
			ReputationTitle="差评"
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
		<TD><a onclick="return window.confirm('您确定要删除该条评论?')" href=?menu=DeleteComment&ReputationID=<%=Rs("ReputationID")%>>删除</a></TD>
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