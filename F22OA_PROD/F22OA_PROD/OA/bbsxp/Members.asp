<!-- #include file="Setup.asp" -->
<%
HtmlTop

if SiteConfig("PublicMemberList")=0 then error("ϵͳ�ѽ�ֹ��ʾ��Ա�б�")

if SiteConfig("MemberListAdvancedSearch")=1 then
	SearchType=HTMLEncode(Request("SearchType"))
	SearchText=HTMLEncode(Request("SearchText"))
	SearchRole=HTMLEncode(Request("SearchRole"))
	CurrentAccountStatus=HTMLEncode(Request("CurrentAccountStatus"))
	JoinedDateComparer=Left(Request("JoinedDateComparer"),1)
	LastPostDateComparer=Left(Request("LastPostDateComparer"),1)
	JoinedDate_picker=HTMLEncode(Request("JoinedDate_picker"))
	LastPostDate_picker=HTMLEncode(Request("LastPostDate_picker"))
	
	if SearchType="all" then SearchType="UserEmail like '%"&SearchText&"%' or UserName"
	if SearchText<>"" then item=item&" and ("&SearchType&" like '%"&SearchText&"%')"
	if JoinedDate_picker<>"" and JoinedDateComparer<>"" then item=item&" and DateDiff("&SqlChar&"d"&SqlChar&",'"&JoinedDate_picker&"',UserRegisterTime) "&JoinedDateComparer&" 0"
	if LastPostDate_picker<>"" and LastPostDateComparer<>"" then item=item&" and DateDiff("&SqlChar&"d"&SqlChar&",'"&LastPostDate_picker&"',UserActivityTime) "&LastPostDateComparer&" 0"
	if SearchRole <> "" then item=item&" and UserRoleID="&SearchRole&""
	if CurrentAccountStatus <> "" then item=item&" and UserAccountStatus="&CurrentAccountStatus&""

	if item<>"" then item=" where "&mid(item,5)
end if

%>
<SCRIPT type="text/javascript" src="Utility/calendar.js"></SCRIPT>


<div id="CommonBreadCrumbArea"><%ClubTree%> �� <a href="?">��Ա�б�</a></div>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<TR align=center id=CommonListTitle>
		<TD><a href="?MemberSortDropDown=UserName">�û���</a></TD>
		<TD><a href="?MemberSortDropDown=UserRoleID">��ɫ</a></TD>
		<TD>��ѶϢ</TD>
		<TD><a href="?MemberSortDropDown=UserRegisterTime">ע��ʱ��</a></TD>
		<TD><a href="?MemberSortDropDown=Reputation">����</a></TD>
		<TD><a href="?MemberSortDropDown=TotalPosts">������</a></TD>
		<TD><a href="?MemberSortDropDown=UserMoney">���</a></TD>
		<TD><a href="?MemberSortDropDown=experience">����ֵ</a></TD>
		<TD><a href="?MemberSortDropDown=UserActivityTime">���ʱ��</a></TD>
	</TR>
<%
MemberSortDropDown=HTMLEncode(Request("MemberSortDropDown"))
SortOrderDropDown=HTMLEncode(Request("SortOrderDropDown"))
if Len(MemberSortDropDown)>20 then error("�Ƿ�����")

if SortOrderDropDown="" then SortOrderDropDown="Desc"
if MemberSortDropDown<>"" then SqlOrder=" order by "&MemberSortDropDown&" "&SortOrderDropDown
if MemberSortDropDown="UserRoleID" then SqlOrder=" order by "&MemberSortDropDown&""

TotalCount=Execute("Select count(UserID) From [BBSXP_Users]"&item)(0) '��ȡ��������
PageSetup=SiteConfig("MemberListPageSize") '�趨ÿҳ����ʾ����
TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '��ҳ��
PageCount = RequestInt("PageIndex") '��ȡ��ǰҳ
if PageCount <1 then PageCount = 1
if PageCount > TotalPage then PageCount = TotalPage

sql="Select * from [BBSXP_Users] "&item&" "&SqlOrder&""

if PageCount<11 then
	Set Rs=Execute(sql)
else
	rs.Open sql,Conn,1
end if

if TotalPage>1 then RS.Move (PageCount-1) * pagesetup
i=0
Do While Not Rs.EOF and i<PageSetup
	i=i+1
%>
	<TR align=center id=CommonListCell>
		<TD><a href=Profile.asp?UserName=<%=Rs("UserName")%>><%=Rs("UserName")%></a></TD>
		<TD><%=ShowRole(RS("UserRoleID"))%></TD>
		<TD><%if CookieUserName<>empty then%><a href="javascript:BBSXP_Modal.Open('MyMessage.asp?menu=Post&RecipientUserName=<%=Rs("UserName")%>',600, 350);"><img border="0" src="images/message.gif"></a><%end if%></TD>
		<TD><%=Rs("UserRegisterTime")%></TD>
		<TD><%=Rs("Reputation")%></TD>
		<TD><%=Rs("TotalPosts")%></TD>
		<TD><%=Rs("UserMoney")%></TD>
		<TD><%=Rs("experience")%></TD>
		<TD><%=Rs("UserActivityTime")%></TD>
		</TR>
<%
Rs.MoveNext
loop
Set Rs=Nothing
%>
</TABLE>
<table cellspacing=0 cellpadding=0 border=0 width=100%>
<tr>
	<td><%ShowPage()%></td>
<%if SiteConfig("MemberListAdvancedSearch")=1 then%>	
	<td align="right">
		<a onmousedown="ToggleMenuOnOff('ForumOption')" class="CommonImageTextButton" style="BACKGROUND-IMAGE: url(images/ForumSettings.gif)">
		�߼�����</a>
	</td>
<%end if%>
</tr>
</table>

<div id="ForumOption" style="display:none;">
<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
	<form method="POST" action="Members.asp" method=post>
	<tr id=CommonListTitle>
		<td align=center colspan=2>�û�����</td>
	</tr>
	<tr id=CommonListCell>
		<td colspan=2><br>
			<div style="text-align:center"><input size="45" name="SearchText"> <input type="submit" value=" ��  �� "></div>
		<br><br>
		<fieldset>
			<legend>��������</legend>
			<select name=MemberSortDropDown>
				<option value=UserName>�û���</option>
				<option value=UserEmail>�����ʼ�</option>
				<option value=TotalPosts>������</option>
				<option value=UserRegisterTime>ע������</option>
				<option value=UserActivityTime>�������</option>
			</select> 
			<select name=SortOrderDropDown><option value=desc>����</option><option value=asc>˳��</option></select>
		</fieldset><br>
		<fieldset>
			<legend>���ڹ���</legend>
			����ע��ʱ�䣺<select name="JoinedDateComparer" onchange="javascript:if(this.options[this.selectedIndex].value != ''){document.getElementById('UserRegisterTime').style.display='';}else{document.getElementById('UserRegisterTime').style.display='none';}">
					<option value="">----</option>
					<option value="<">�ڴ�֮ǰ</option>
					<option value="=">�ڴ�֮ʱ</option>
					<option value=">">�ڴ�֮��</option>
				</select> <span id=UserRegisterTime style="display:none">
			<input size="24" name="JoinedDate_picker" onclick="showcalendar(event, this)" value="<%=date()%>"></span><br>
			���ʱ�䣺<select name="LastPostDateComparer" onchange="javascript:if(this.options[this.selectedIndex].value != ''){document.getElementById('UserActivityTime').style.display='';}else{document.getElementById('UserActivityTime').style.display='none';}">
					<option value="">----</option>
					<option value="<">�ڴ�֮ǰ</option>
					<option value="=">�ڴ�֮ʱ</option>
					<option value=">">�ڴ�֮��</option>
				</select> <span id="UserActivityTime" style="display:none">
			<input size="24" name="LastPostDate_picker" onclick="showcalendar(event, this)" value="<%=date()%>"></span>
		</fieldset><br>
		<fieldset>
			<legend>�� ��</legend>
			������ɫ��<select name="SearchRole">
				<option value="">�����û�</option>
<%
	sql="Select * from [BBSXP_Roles] where RoleID > 0 order by RoleID"
	Set Rs=Execute(sql)
		Do While Not Rs.EOF
				Response.Write("<option value='"&Rs("RoleID")&"'>"&Rs("Name")&"</option>")
			Rs.MoveNext
		loop
	Rs.Close
%>
			</select><br>
			������Χ��<select name="SearchType">
				<option value="UserName">�û���������</option>
				<option value="UserEmail">���������</option>
				<option value="all">�û��������������</option>
			</select><br>
			����״̬��<select name="CurrentAccountStatus" size="1">
				<option value="">����״̬</option>
				<option value="0">���ȴ����</option>
				<option value="1">��ͨ�����</option>
				<option value="2">�ѽ���</option>
				<option value="3">δͨ�����</option>
			</select>
		</fieldset>
		</td>
	</tr>
	</form>
</table>
</div>

<%
HtmlBottom
%>