<!-- #include file="Setup.asp" -->
<%
HtmlTop
if CookieUserName=empty then error("����δ<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>��̳")
ForumID=RequestInt("ForumID")


if ForumID>0 then
	sql="Select * from [BBSXP_Forums] where ForumID="&ForumID&""
	Set Rs=Execute(sql)
		ParentID=Rs("ParentID")
		GroupID=Rs("GroupID")
		ForumName=Rs("ForumName")
		Moderated=Rs("Moderated")
		TotalCategorys=Rs("TotalCategorys")
	Rs.close
	
	ForumSql=" and ForumID="&ForumID
	ForumListStr=" �� "&ForumTreeList&" <a href='ShowForum.asp?ForumID="&ForumID&"'>"&ForumName&"</a>"
	
	
	filtrate=split(""&TotalCategorys&"","|")
	for i = 0 to ubound(filtrate)
		TotalCategorysOptionList=TotalCategorysOptionList&"<option value="&filtrate(i)&">"&filtrate(i)&"</option>"
	next

%><!-- #include file="Utility/ForumPermissions.asp" --><%
	if PermissionManage=0 then error("����<a href=ShowForumPermissions.asp?ForumID="&ForumID&">Ȩ��</a>����")
elseif BestRole=1 then
	ForumSql=""
	ForumListStr=""
else
	error("���Ȩ�޲�����")
end if

if Request.ServerVariables("Request_method") = "POST" then

select case Request.Form("Item")
	case "BatchDel"
		IsDel=RequestInt("IsDel")
		for each ho in Request.Form("ThreadID")
			ho=int(ho)
			Execute("update [BBSXP_Threads] Set IsDel="&IsDel&",lasttime="&SqlNowString&",lastname='"&CookieUserName&"' where ThreadID="&ho&ForumSql&"")
		next
		
		succtitle="����ɾ��������ID��"&Request.Form("ThreadID")&""


	case "BatchApproved"
		IsApproved=RequestInt("IsApproved")
		for each ho in Request.Form("ThreadID")
			ho=int(ho)
			Execute("update [BBSXP_Threads] Set IsApproved="&IsApproved&",lasttime="&SqlNowString&",lastname='"&CookieUserName&"' where ThreadID="&ho&ForumSql&"")
		next
		
		succtitle="������ˣ�����ID��"&Request.Form("ThreadID")&""


	case "BatchGOOD"
		IsGooD=RequestInt("IsGooD")
		for each ho in Request.Form("ThreadID")
			ho=int(ho)
			Execute("update [BBSXP_Threads] Set IsGooD="&IsGooD&",lasttime="&SqlNowString&" where ThreadID="&ho&ForumSql&"")
		next
		
		succtitle="��������������ID��"&Request.Form("ThreadID")&""


	case "BatchLocked"
		IsLocked=RequestInt("IsLocked")
		for each ho in Request.Form("ThreadID")
			ho=int(ho)
			Execute("update [BBSXP_Threads] Set IsLocked="&IsLocked&",lasttime="&SqlNowString&" where ThreadID="&ho&ForumSql&"")
		next
		
		succtitle="��������������ID��"&Request.Form("ThreadID")&""

		
	case "BatchCategory"
		Category=HTMLEncode(Request.Form("Category"))
		for each ho in Request.Form("ThreadID")
			ho=int(ho)
			Execute("update [BBSXP_Threads] Set Category='"&Category&"',lasttime="&SqlNowString&" where ThreadID="&ho&ForumSql&"")
		next

		succtitle="�����������ID��"&Request.Form("ThreadID")&""


	case "BatchMoveTopic"
		AimForumID=RequestInt("AimForumID")
		if AimForumID=0 then error("��û��ѡ��Ҫ�������ƶ����ĸ���̳")
		for each ho in Request.Form("ThreadID")
			ho=int(ho)
			Execute("update [BBSXP_Threads] Set ForumID="&AimForumID&",ThreadTop=0,IsGood=0,IsLocked=0 where ThreadID="&ho&ForumSql&"")
		next
		
		succtitle="�����ƶ�������ID��"&Request.Form("ThreadID")&""
		
	case "ClearRecycle"
		if BestRole <> 1 then error("����Ȩ�޲���")
		TimeLimit=RequestInt("TimeLimit")
		if TimeLimit < 1 then error("ֻ�����24Сʱ֮ǰ������")
		
		Execute("Delete from [BBSXP_Threads] where IsDel=1 and DateDiff("&SqlChar&"d"&SqlChar&",lasttime,"&SqlNowString&") > "&TimeLimit&"")
		
		succtitle="��ջ���վ�� "&TimeLimit&" ����ǰ�����⣡"

end select


if succtitle="" then error("��Чָ��")

if ForumID>0 then UpForumMostRecent(ForumID)

Log(""&succtitle&"")
succeed succtitle,""

end if



	if Request("menu")="Censorship" then
		sql="[BBSXP_Threads] where IsApproved=0 and IsDel=0"&ForumSql&""
		ForumTitle="�������"
	elseif Request("menu")="Recycle" then
		sql="[BBSXP_Threads] where IsDel=1"&ForumSql&""
		ForumTitle="����վ"
	else
		sql="[BBSXP_Threads] where IsApproved=1 and IsDel=0"&ForumSql&""
		ForumTitle="�������"
	end if


%>
<div id="CommonBreadCrumbArea"><%ClubTree%><%=ForumListStr%> �� <a href="?menu=<%=Request("menu")%>&ForumID=<%=ForumID%>&checkbox=1"><%=ForumTitle%></a></div>

<table cellspacing="1" cellpadding="5" width="100%" id="CommonListArea">
<form method="POST" action="Moderation.asp" onsubmit="return VerifyRadio('Item');">
<input type="hidden" name="ForumID" value="<%=ForumID%>">
	<tr id="CommonListTitle">
		<td colspan="5">����</td>
	</tr>
	<tr id="CommonListHeader" align="center">
		<td>����</td>
		<td>����</td>
		<td>�ظ�</td>
		<td>�鿴</td>
		<td>������</td>
	</tr>
<%

	TotalCount=Execute("Select count(ThreadID) From "&sql&" ")(0) '��ȡ��������
	PageSetup=SiteConfig("ThreadsPerPage") '�趨ÿҳ����ʾ����
	TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '��ҳ��
	PageCount = RequestInt("PageIndex") '��ȡ��ǰҳ
	if PageCount <1 then PageCount = 1
	if PageCount > TotalPage then PageCount = TotalPage

	sql="Select * from "&sql&" order by lasttime Desc"
	if PageCount<11 then
		Set Rs=Execute(sql)
	else
		rs.Open sql,Conn,1
	end if
	if TotalPage>1 then RS.Move (PageCount-1) * pagesetup
	i=0
	Do While Not RS.EOF and i<PageSetup
		i=i+1
		ShowThread()
		Rs.MoveNext
	loop
	Rs.Close
%>
	<tr id="CommonListCell">
		<td colspan="5">
		<input type="checkbox" name="chkall" onclick="CheckAll(this.form)" value="ON">ȫѡ
		<input type="radio" value="BatchDel" name="Item"><select name="IsDel">
		<option value="1">ɾ������</option>
		<option value="0">��ԭ����</option>
		</select>
		
		
		<input type="radio" value="BatchApproved" name="Item"><select name="IsApproved">
		<option value="1">���ͨ��</option>
		<option value="0">���ʧ��</option>
		</select>
		
		<input type="radio" value="BatchGOOD" name="Item"><select name="IsGOOD">
		<option value="1">���뾫��</option>
		<option value="0">ȡ������</option>
		</select>
		
		<input type="radio" value="BatchLocked" name="Item"><select name="IsLocked">
		<option value="1">��������</option>
		<option value="0">�������</option>
		</select>

		
		<input type="radio" value="BatchCategory" name="Item"><select name="Category">
		<option value="">�������</option>
		<%=TotalCategorysOptionList%>
		<option value="">ȡ�����</option>
		</select>
		
		<input type="radio" value="BatchMoveTopic" name="Item"><select name="AimForumID">
		<option value="0">�ƶ���������̳</option>
		<%=GroupList(0)%></select>&nbsp;
		<input onclick="return window.confirm('��ȷ��ִ�б��β���?');" type="submit" value=" ִ �� ">
		</td>
	</tr>
</form>
</table>
<table border="0" width="100%" align="center">
	<tr>
		<td valign="top"><%ShowPage()%></td>
		
		<%if Request("menu")="Recycle" and BestRole = 1 then%>
		<form name="form" method="POST" action="Moderation.asp"><input type="hidden" name="Item" value="ClearRecycle">
		<td align="right">
			��� <input size="1" value="7" name="TimeLimit"> ����ǰɾ�������� <input type="submit" onclick="return window.confirm('ִ�б���������ջ���վ������?');" value="ȷ��">
		</td>
		</form>
		<%end if%>
	</tr>
</table>
<script language="JavaScript">
function VerifyRadio() {
	objYN=false;

	for (i=0;i<document.getElementsByName("ThreadID").length;i++) {
	if (document.getElementsByName("ThreadID")[i].checked) {objYN= true;}
	}
	
	if (objYN==false) {alert ('��ѡ����Ҫ���������⣡');return false;}




	objYN=false;

	for (i=0;i<document.getElementsByName("Item").length;i++) {
	if (document.getElementsByName("Item")[i].checked) {objYN= true;}
	}
	
	if (objYN==false) {alert ('��ѡ����Ҫ��������Ŀ��');return false;}


}
</SCRIPT>

<%
HtmlBottom
%>