<!-- #include file="Setup.asp" --><%
HtmlTop
ForumID=RequestInt("ForumID")
SortOrder=RequestInt("SortOrder")
TimeLimit=RequestInt("TimeLimit")
GoodTopic=RequestInt("GoodTopic")
order=HTMLEncode(Request("order"))
Category=HTMLEncode(Request("Category"))

if Len(order)>12 then error("�Ƿ�����")
if Len(Category)>25 then error("�������̫��")

sql="Select * from [BBSXP_Forums] where ForumID="&ForumID&""
Set Rs=Execute(sql)
	if Rs.eof then error"<li>�Ҳ����ð�������"
	ForumName=Rs("ForumName")
	TotalThreads=Rs("TotalThreads")
	Moderated=Rs("Moderated")
	ParentID=Rs("ParentID")
	GroupID=Rs("GroupID")
	IsModerated=Rs("IsModerated")
	ForumRules=YbbEncode(Rs("ForumRules"))
	TotalCategorys=Rs("TotalCategorys")
	ForumUrl=Rs("ForumUrl")
	IsActive=Rs("IsActive")
Rs.close

%>
<!-- #include file="Utility/ForumPermissions.asp" --><%
if ForumUrl<>"" then response.redirect ForumUrl
if IsActive=0 and PermissionManage=0 then error"<li>�ð���Ѿ��رգ�"

if PermissionView=0 then error("����<a href=ShowForumPermissions.asp?ForumID="&ForumID&">Ȩ��</a>����")

if TotalCategorys<>"" then
	filtrate=split(TotalCategorys,"|")
	CategorysList="[<a href='ShowForum.asp?ForumID="&ForumID&"'>ȫ��</a>] "
	for i = 0 to ubound(filtrate)
		CategorysList=CategorysList&"[<a href='ShowForum.asp?ForumID="&ForumID&"&Category="&filtrate(i)&"'>"&filtrate(i)&"</a>] "
	next
end if

%>
<title><%=ForumName%></title>
<meta http-equiv="refresh" content="300">


<div id="CommonBreadCrumbArea">
	<div style="float:left"><%ClubTree%> �� <%=ForumTree(ParentID)%><a href="ShowForum.asp?ForumID=<%=ForumID%>"><%=ForumName%></a></div>
<%
if Moderated<>empty then
	filtrate=split(Moderated,"|")
	for i = 0 to ubound(filtrate)
		ModeratedList=ModeratedList&"<div class=menuitems><a href=Profile.asp?UserName="&filtrate(i)&">"&filtrate(i)&"</a></div>"
	next
%>
	<div style="float:right"><img src="images/team.gif"> <a onMouseOver="showmenu(event,'<%=ModeratedList%>')" style="cursor:default">��̳����</a></div>
<%end if%>

</div>
<%
sql="Select * From [BBSXP_Forums] where ParentID="&ForumID&" and SortOrder>0 and IsActive=1 order by SortOrder"
Set Rs=Execute(sql)
	if not Rs.eof then
	%><table cellspacing="1" cellpadding="5" width="100%" id="CommonListArea">
	<tr id="CommonListTitle">
		<td colspan="7"><a href="ShowForum.asp?ForumID=<%=ForumID%>"><%=ForumName%></a></td>
	</tr>
	<tr id="CommonListHeader" align="center">
		<td width="30"></td>
		<td>��̳</td>
		<td width="50">����</td>
		<td width="50">����</td>
		<td width="150">��󷢱�</td>
		<td width="100">����</td>
	</tr>
	<%
	do while not Rs.eof
		ShowForum()
		Rs.Movenext
	loop
	response.write "</table><br>"
	end if
Rs.close


if ForumRules<>"" then
%>

<table cellpadding="8" id="CommonListCell" width="100%" style=" BORDER-RIGHT:#ccc 1px dotted; BORDER-TOP:#ccc 1px dotted; BORDER-LEFT:#ccc 1px dotted; BORDER-BOTTOM:#ccc 1px dotted;">
	<tr>
		<td><strong><font color="#ff0000">�� �� �� �� ��</font></strong><br>
		<%=ForumRules%></td>
	</tr>
</table><br>
<%end if%>

<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td align="Left"><%if PermissionPost=1 then%>
		<a class="CommonImageTextButton" style="BACKGROUND-IMAGE: url(images/NewPost.gif)" href="AddTopic.asp?ForumID=<%=ForumID%>">
		��������</a> <%end if%> <%if PermissionCreatePoll=1 then%>
		<a class="CommonImageTextButton" style="BACKGROUND-IMAGE: url(images/Poll.gif)" href="AddTopic.asp?ForumID=<%=ForumID%>&Poll=1">
		����ͶƱ</a> <%end if%> </td>
		<td align="right"><%if IsModerated=1 then%>
		<a href="Moderation.asp?ForumID=<%=ForumID%>&checkbox=1&Menu=Censorship">
		�������(<%=Execute("Select count(ThreadID) From [BBSXP_Threads] where IsApproved=0 and IsDel=0 and ForumID="&ForumID&"")(0)%>)</a> 
		| <%end if%> <a href="?ForumID=<%=ForumID%>&GoodTopic=1">��������</a> |
		<a href="ShowForumPermissions.asp?ForumID=<%=ForumID%>">��̳Ȩ��</a> |
		<a href="ForumManage.asp?menu=ForumData&ForumID=<%=ForumID%>">������</a> |
<script language="JavaScript">
var AllForumNameList=getCookie("ForumNameList");
var NowForumName="<option value='ShowForum.asp?ForumID=<%=ForumID%>'>" + document.title + "</option>";
if(AllForumNameList.indexOf(NowForumName)==-1){document.cookie= "ForumNameList" + "=" + escape(NowForumName+AllForumNameList);}
document.write("<select onchange='location=this.options[this.selectedIndex].value;'><option>������ʵİ��...</option>" + AllForumNameList+ "</select>");
</script>
		</td>
	</tr>
</table>

<table cellspacing="1" cellpadding="5" width="100%" id="CommonListArea">

	<tr id="CommonListTitle">
		<td colspan="5">
		<div style="float:left">����</a></div>
		<div style="float:right"><%=CategorysList%></div>
		</td>
	</tr>
	<tr id="CommonListHeader" align="center">
		<td>����</td>
		<td>����</td>
		<td>�ظ�</td>
		<td>�鿴</td>
		<td>������</td>
	</tr>
	<%
	if RequestInt("PageIndex") < 2 then
		sql="[BBSXP_Threads] where IsApproved=1 and IsDel=0 and ThreadTop=2 or (ThreadTop=1 and ForumID="&ForumID&") order by ThreadTop DESC"
		Set Rs=Execute(sql)
	
		if Not RS.EOF then
			Do While Not RS.EOF
				ShowThread()
				Rs.MoveNext
			loop
			response.write "<tr id=CommonListHeader><td colspan=5>�������</td></tr>"
		end if

		Rs.Close
	end if

	if order="" then order="lasttime"
	if Category<>"" then SQLCategory="and Category='"&Category&"'"
	if GoodTopic > 0 then SQLGoodTopic="and IsGood=1"
			
	if TimeLimit > 0 then SQLTimeLimit="and DateDiff("&SqlChar&"d"&SqlChar&",lasttime,"&SqlNowString&") < "&TimeLimit&""
		
	if SortOrder="1" then
		SqlSortOrder=""
	else
		SqlSortOrder="Desc"
	end if
	

	topsql="[BBSXP_Threads] where IsApproved=1 and IsDel=0 and ForumID="&ForumID&" and ThreadTop=0 "&SQLCategory&" "&SQLTimeLimit&" "&SQLGoodTopic&""
	TotalCount=Execute("Select count(ThreadID) From "&topsql&" ")(0) '��ȡ��������
	PageSetup=SiteConfig("ThreadsPerPage") '�趨ÿҳ����ʾ����
	TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '��ҳ��
	PageCount = RequestInt("PageIndex") '��ȡ��ǰҳ
	if PageCount <1 then PageCount = 1
	if PageCount > TotalPage then PageCount = TotalPage
	
	sql="Select * from "&topsql&" order by "&order&" "&SqlSortOrder&""

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
</table>
<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td>
		<a onMouseDown="ToggleMenuOnOff('ForumOption')" class="CommonImageTextButton" style="BACKGROUND-IMAGE: url(images/ForumSettings.gif)" href="#ForumOption">
		ѡ��</a> </td>
		<td align="right"><%ShowPage()%></td>
	</tr>
</table>
<div id="ForumOption" style="display:none;">
	<fieldset>
	<legend>ѡ��</legend>
	<table border="0" width="100%">
		<tr>
			<td valign="top">
			<form name="form" action="ShowForum.asp?ForumID=<%=ForumID%>" method="POST">
				�������<select name="order">
				<option value="">������ʱ��</option>
				<option value="ThreadID">���ⷢ��ʱ��</option>
				<option value="IsGood">��������</option>
				<option value="IsVote">ͶƱ����</option>
				<option value="Topic">����</option>
				<option value="PostAuthor">����</option>
				<option value="TotalViews">�����</option>
				<option value="TotalReplies">�ظ���</option>
				</select> ���� <select name="SortOrder">
				<option value="0" selected>����</option>
				<option value="1">����</option>
				</select> ����<br>
				���ڹ��ˣ�<select name="TimeLimit">
				<option value="1" >��������</option>
				<option value="2" >2 ������</option>
				<option value="7" >1 ������</option>
				<option value="10" >10 ������</option>
				<option value="14" >2 ������</option>
				<option value="30" >1 ��������</option>
				<option value="45" >45 ������</option>
				<option value="60" >2 ��������</option>
				<option value="75" >75 ������</option>
				<option value="100" >100 ������</option>
				<option value="365">1 ������</option>
				<option value="-1">�κ�ʱ��</option>
				</select><br>
				<input type="submit" value=" Ӧ�� "></form>
			</td>
			<td valign="top" align="right">�� <b><%if PermissionPost=0 then%>��<%end if%>��</b> 
			�ڴ˰淢��������<br>
			�� <b><%if PermissionReply=0 then%>��<%end if%>��</b> �ڴ˰�ظ�����<br>
			�� <b><%if PermissionEdit=0 then%>��<%end if%>��</b> �ڴ˰��޸������������<br>
			�� <b><%if PermissionDelete=0 then%>��<%end if%>��</b> �ڴ˰�ɾ�������������<br>
			�� <b><%if PermissionCreatePoll=0 then%>��<%end if%>��</b> �ڴ˰淢��ͶƱ<br>
			�� <b><%if PermissionVote=0 then%>��<%end if%>��</b> �ڴ˰����ͶƱ<br>
			�� <b><%if PermissionAttachment=0 then%>��<%end if%>��</b> �ڴ˰��ϴ�����<br>
			�ð�����<b><%if IsModerated=0 then%>��<%end if%>��Ҫ���</b></td>
		</tr>
	</table>
	</fieldset> </div>
	
	
<!-- #include file="Utility/OnLine.asp" -->
<%
	ForumIDOnline=Execute("Select count(sessionid)from [BBSXP_UserOnline] where ForumID="&ForumID&"")(0)
	regForumIDOnline=Execute("Select count(sessionid)from [BBSXP_UserOnline] where ForumID="&ForumID&" and UserName<>''")(0)
%>
	
<table cellspacing="1" cellpadding="5" width="100%" id="CommonListArea">
	<tr id="CommonListTitle">
		<td colspan="2">�û�������Ϣ</td>
	</tr>
	<tr id="CommonListCell">
		<td align="center" width="5%"><img src="images/whos_online.gif"></td>
		<td>
		<img src="images/plus.gif" id="followImg" style="cursor:pointer;" onClick="loadThreadFollow(<%=ForumID%>)"> 
		Ŀǰ��̳������ <b><%=Onlinemany%></b> �ˣ�������̳���� <b><%=ForumIDOnline%></b> �����ߡ�����ע���û� 
		<b><%=regForumIDOnline%></b> �ˣ��ÿ� <b><%=ForumIDOnline-regForumIDOnline%></b> 
		�ˡ�<div style="display:none" id="follow">
			<hr width="90%" size="1" align="left"><span id="followTd">
			<img src="images/loading.gif">���ڼ���...</span></div>
		</td>
	</tr>
</table>
<br />
<table border="0" width="90%" align="center">
	<tr>
		<td><img src="images/topic-announce.gif" border="0" align="absmiddle"> ��������</td>
		<td><img src="images/topic-pinned.gif" border="0" align="absmiddle"> �ö�����</td>
		<td><img src="images/topic-popular.gif" align="absmiddle"> ��������</td>
		<td><img src="images/topic-locked.gif" border="0" align="absmiddle"> ��������</td>
		<td><img src="images/topic-poll.gif" border="0" align="absmiddle"> ͶƱ����</td>
		<td><img src="images/topic-hot.gif" border="0" title="�ظ����ﵽ <%=SiteConfig("PopularPostThresholdPosts")%> ���ߵ�����ﵽ <%=SiteConfig("PopularPostThresholdViews")%>" align="absmiddle"> ��������</td>
		<td><img src="images/topic.gif" border="0" align="absmiddle"> ��ͨ����</td>
	</tr>
</table>
<%
HtmlBottom
%>