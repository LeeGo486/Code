<!-- #include file="Setup.asp" --><%
HtmlTop
if CookieUserName=empty then error("����δ<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>��̳")


%>
<div id="CommonBreadCrumbArea">
	<%ClubTree%> �� <a href="Prison.asp">��������</a></div>
<br>
<table cellspacing="1" cellpadding="5" border="0" width="100%" id="CommonListArea">
	<tr id="CommonListTitle" align="center">
		<td width="15%">�û���</td>
		<td width="15%">����</td>
		<td>ע��ʱ��</td>
		<td>������</td>
		<td>��Ǯ��</td>
		<td>����ֵ</td>
		<td>���ʱ��</td>
		<td width="10%">����</td>
	</tr>
	<%
Rs.Open "[BBSXP_Users] where Reputation < "&SiteConfig("InPrisonReputation")&" order by UserActivityTime Desc",Conn,1
PageSetup=20 '�趨ÿҳ����ʾ����
Rs.Pagesize=PageSetup
TotalPage=Rs.Pagecount  '��ҳ��

PageCount = cint(Request.QueryString("PageIndex"))
if PageCount <1 then PageCount = 1
if PageCount > TotalPage then PageCount = TotalPage
if TotalPage>0 then Rs.absolutePage=PageCount '��ת��ָ��ҳ��
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
		<a href="javascript:BBSXP_Modal.Open('Reputation.asp?CommentFor=<%=Rs("UserName")%>', 500, 180);">����</a></td>
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
		
		��</td>

	</tr>
</table>

<%
HtmlBottom
%>