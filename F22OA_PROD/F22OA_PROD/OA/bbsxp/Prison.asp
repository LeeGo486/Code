<!-- #include file="Setup.asp" --><%
HtmlTop
if CookieUserName=empty then error("您还未<a href=Login.asp?ReturnUrl="&ReturnUrl&">登录</a>论坛")


%>
<div id="CommonBreadCrumbArea">
	<%ClubTree%> → <a href="Prison.asp">社区监狱</a></div>
<br>
<table cellspacing="1" cellpadding="5" border="0" width="100%" id="CommonListArea">
	<tr id="CommonListTitle" align="center">
		<td width="15%">用户名</td>
		<td width="15%">声望</td>
		<td>注册时间</td>
		<td>帖子数</td>
		<td>金钱数</td>
		<td>经验值</td>
		<td>最后活动时间</td>
		<td width="10%">动作</td>
	</tr>
	<%
Rs.Open "[BBSXP_Users] where Reputation < "&SiteConfig("InPrisonReputation")&" order by UserActivityTime Desc",Conn,1
PageSetup=20 '设定每页的显示数量
Rs.Pagesize=PageSetup
TotalPage=Rs.Pagecount  '总页数

PageCount = cint(Request.QueryString("PageIndex"))
if PageCount <1 then PageCount = 1
if PageCount > TotalPage then PageCount = TotalPage
if TotalPage>0 then Rs.absolutePage=PageCount '跳转到指定页数
i=0
Do While Not Rs.EOF and i<PageSetup
i=i+1

%>
	<tr id="CommonListCell" align="center">
		<td><a href="Profile.asp?UserName=<%=Rs("UserName")%>"><%=Rs("UserName")%></a></td>
		<td><%=Rs("Reputation")%></td>
		<td><%=Rs("UserRegisterTime")%></td>
		<td><%=Rs("TotalPosts")%></td>
		<td><%=Rs("UserMoney")%></td>
		<td><%=Rs("experience")%></td>
		<td><%=Rs("UserActivityTime")%></td>
		<td>
		<a href="javascript:BBSXP_Modal.Open('Reputation.asp?CommentFor=<%=Rs("UserName")%>', 500, 180);">评价</a></td>
	</tr>
	<%
Rs.MoveNext
loop
Rs.Close

%>
</table>		
<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td align="right" colspan="2"><%ShowPage()%></td>
	</tr>
	<tr>
		<td align="center">
		
		　</td>

	</tr>
</table>

<%
HtmlBottom
%>