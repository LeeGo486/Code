<!-- #include file="Setup.asp" -->

<%
if RequestCookies("Userpass")="" or RequestCookies("Userpass")<>session("pass") then response.redirect "Admin_Default.asp"

UserName=HTMLEncode(Request("UserName"))
RoleID=HTMLEncode(Request("RoleID"))
RoleName=HTMLEncode(Request("RoleName"))
Description=HTMLEncode(Request("Description"))

if Request("menu")="ChangePassword" then ChangePassword


AdminTop
Log("")

select case Request("menu")
	case "UserEdit"
		UserEdit
	case "SearchUser"
		SearchUser
	case "UserDelTopic"
		UserDelTopic
	case "UserDel"
		UserDel
	case "Userok"
		Userok
		
	case "ChangePassword"
		ChangePassword
		
	case "UserRank"
		UserRank
	case "UserRankUp"
		if Request.Form("RankName")<>"" then
			Execute("insert into [BBSXP_Ranks] (RankName,PostingCountMin,RankIconUrl) values ('"&Request.Form("RankName")&"','"&Request.Form("PostingCountMin")&"','"&Request.Form("RankIconUrl")&"')")
		end if
		for each ho in Request.Form("RankID")
			Execute("update [BBSXP_Ranks] Set RankName='"&Request.Form("RankName"&ho)&"',PostingCountMin='"&Request.Form("PostingCountMin"&ho)&"',RankIconUrl='"&Request.Form("RankIconUrl"&ho)&"' where RankID="&ho&"")
		next
		response.write "���³ɹ�"
	case "UserRankDel"
		Execute("Delete from [BBSXP_Ranks] where RankID="&Request("RankID")&"")
		response.write "ɾ���ɹ�"
	case "AllRoles"
		AllRoles
	case "CreateRole"
		if RoleName=empty then Alert("��û�������ɫ����")
		Execute("insert into [BBSXP_Roles] (Name) values ('"&RoleName&"')")
		AllRoles
	case "ViewRole"
		ViewRole
	case "UpRole"
		if RoleName=empty then Alert("��û�������ɫ����")
		Execute("update [BBSXP_Roles] Set Name='"&RoleName&"',Description='"&Description&"' where RoleID="&RoleID&"")
		Response.Write("�༭�ɹ�")
	case "DelRole"
		if Roleid<4 then Alert("�ý�ɫΪϵͳ���ý�ɫ���޷�ɾ��")
		if Not Execute("Select UserID From [BBSXP_Users] where UserRoleID="&RoleID&"" ).eof then Alert("ֻ��ɾ��û�г�Ա�Ľ�ɫ�飡")
		Execute("Delete from [BBSXP_Roles] where RoleID="&RoleID&"")
		Response.Write("ɾ���ɹ�")
	case else
		SearchUserok
end select


Sub ChangePassword
Response.clear
if Request.ServerVariables("Request_method") = "POST" then
	NewPassword1=Trim(Request("NewPassword1"))
	NewPassword2=Trim(Request("NewPassword2"))
	if NewPassword1<>NewPassword2 then  Alert("��2����������벻ͬ")
	if Len(NewPassword1)<6 then  Alert("���벻��С��6λ��")
	Execute("update [BBSXP_Users] Set Userpass='"&DefaultPasswordFormat(NewPassword1)&"' where UserName='"&UserName&"'")
	%><script language="JavaScript">parent.BBSXP_Modal.Close();</script><%
end if
%>
<title>�޸�����</title>
<style>body,table{FONT-SIZE:9pt;}</style>
<form name=form action="Admin_User.asp?menu=ChangePassword" method="POST">
<input type=hidden name="UserName" value="<%=UserName%>">
�޸����� - (<%=UserName%>) <br><br>
<table border="0" width="100%">
	<tr>
		<td>�����룺��</td>
		<td><input name="NewPassword1" type="password" maxlength="15" size="40" /></td>
	</tr>
	<tr>
		<td>�������������룺��</td>
		<td><input name="NewPassword2" type="password" maxlength="15" size="40" /></td>
	</tr>
</table>
<br>
<input type="submit" value=" �޸����� ">
</form>
<%
Response.End
End Sub


Sub SearchUser
%>
<SCRIPT type="text/javascript" src="Utility/calendar.js"></SCRIPT>
�û����ϣ�<b><font color=red><%=Execute("Select count(UserID) from [BBSXP_Users]")(0)%></font></b> ��
<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
	<form method="POST" action="?menu=SearchUserok">
	<tr id=CommonListTitle>
		<td align=center>�û�����</td>
	</tr>
	<tr id=CommonListCell>
		<td><br>
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
				</select> <span id=UserRegisterTime style="display:none"><input size="24" name="JoinedDate_picker" onclick="showcalendar(event, this)" value="<%=date()%>"></span><br>
			���ʱ�䣺<select name="LastPostDateComparer" onchange="javascript:if(this.options[this.selectedIndex].value != ''){document.getElementById('UserActivityTime').style.display='';}else{document.getElementById('UserActivityTime').style.display='none';}">
					<option value="">----</option>
					<option value="<">�ڴ�֮ǰ</option>
					<option value="=">�ڴ�֮ʱ</option>
					<option value=">">�ڴ�֮��</option>
				</select> <span id="UserActivityTime" style="display:none"><input size="24" name="LastPostDate_picker" onclick="showcalendar(event, this)" value="<%=date()%>"></span>
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
<hr noshade="noshade" size="1" color=#999999 />
		<fieldset>
			<legend>��ݷ�ʽ</legend>
			<li><a href="?MemberSortDropDown=TotalPosts&SortOrderDropDown=desc">��������</li></a>
			<li><a href="?LastPostDateComparer==&LastPostDate_picker=<%=date()%>">��ȥ 24 Сʱ�ڻ���û�</li></a>
			<li><a href="?JoinedDateComparer==&JoinedDate_picker=<%=date()%>">��ȥ 24 Сʱ��ע����û�</li></a>
			<li><a href="?CurrentAccountStatus=0">�ȴ���˵��û�</a></li>
		</fieldset>
	</form>
		</td>
	</tr>
</table><br>



<%
End Sub

Sub SearchUserok
%>
<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
	<TR align=center id=CommonListTitle>
		<TD>�û���</TD>
		<TD>Email</TD>
		<TD>������</TD>
		<TD>ע��ʱ��</TD>
		<TD>���ʱ��</TD>
		<TD>����</TD>
	</TR>
<%
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

	sql="[BBSXP_Users]"&item&""

	TotalCount=Execute("Select count(UserID) From "&sql&"")(0) '��ȡ��������
	PageSetup=20 '�趨ÿҳ����ʾ����
	TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '��ҳ��
	PageCount = RequestInt("PageIndex") '��ȡ��ǰҳ
	if PageCount <1 then PageCount = 1
	if PageCount > TotalPage then PageCount = TotalPage
	
	if Request("MemberSortDropDown")<>"" then item=item&" order by "&Request("MemberSortDropDown")&" "&Request("SortOrderDropDown")&""
	sql="[BBSXP_Users]"&item&""
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
		<TD><a href="Admin_User.asp?menu=UserEdit&UserName=<%=Rs("UserName")%>"><%=Rs("UserName")%></a></TD>
		<TD><a href="mailto:<%=Rs("UserEmail")%>"><%=Rs("UserEmail")%></a></TD>
		<TD><%=Rs("TotalPosts")%></TD>
		<TD><%=Rs("UserRegisterTime")%></TD>
		<TD><%=Rs("UserActivityTime")%></TD>
		<TD><a href="Admin_User.asp?menu=UserEdit&UserName=<%=Rs("UserName")%>">�༭</a> | <a onclick="return window.confirm('��ȷ��Ҫɾ������ѡ�û���ȫ������?');" href="Admin_User.asp?menu=UserDel&UserID=<%=Rs("UserID")%>">ɾ��</a></TD>
	</TR>
<%
		Rs.MoveNext
	loop
	Rs.Close
%>
</TABLE>
<table border=0 width=100% align=center><tr><td><%ShowPage()%></tr></td></table>
<%
End Sub


Sub UserEdit
	sql="Select * from [BBSXP_Users] where UserName='"&HTMLEncode(UserName)&"'"
	Set Rs=Execute(sql)
	if Rs.eof then Alert(""&UserName&" ���û����ϲ�����")
	
		XMLDOM.loadxml("<bbsxp>"&Rs("UserInfo")&"</bbsxp>")
		QQ=SelectSingleNode("QQ")
		ICQ=SelectSingleNode("ICQ")
		AIM=SelectSingleNode("AIM")
		MSN=SelectSingleNode("MSN")
		Yahoo=SelectSingleNode("Yahoo")
		Skype=SelectSingleNode("Skype")
		Set XMLDOM= Nothing
		
		UserSign=replace(""&Rs("UserSign")&"","<br>", vbCrlf)
		UserBio=replace(""&Rs("UserBio")&"","<br>",vbCrlf)
		UserNote=replace(""&Rs("UserNote")&"","<br>",vbCrlf)
%>
<form method="POST" name=form action="?menu=Userok">
<input type=hidden name=UserName value="<%=Rs("UserName")%>">
<table cellSpacing="1" cellpadding="5" border="0" width="70%" id=CommonListArea align=center>
	<tr id=CommonListTitle>
		<td width="600" colspan="4" align="center"><font color="000000"><a target="_blank" href="Profile.asp?UserName=<%=Rs("UserName")%>">�鿴��<%=Rs("UserName")%>������ϸ����</a></font></td>
	</tr>
	<tr id=CommonListCell>
		<td colspan="2">&nbsp;�û����ƣ�<%=Rs("UserName")%></td>
		<td width="600" colspan="2">&nbsp;�û����룺<a href="javascript:BBSXP_Modal.Open('?menu=ChangePassword&UserName=<%=Rs("UserName")%>',500,160);">�޸�����</a></td>
	</tr>
	<tr id=CommonListCell>
		<td colspan="2">&nbsp;�û���ɫ��<select name="UserRoleID">
<%
	RoleGetRow = FetchEmploymentStatusList("Select RoleID,Name from [BBSXP_Roles] where RoleID > 0 order by RoleID")
	For i=0 To Ubound(RoleGetRow,2)
	%><option value="<%=RoleGetRow(0,i)%>" <%if Rs("UserRoleID")=RoleGetRow(0,i) then%>selected<%end if%>><%=RoleGetRow(1,i)%></option><%
	Next
%>
			</select>		</td>
		<td width="600" colspan="2">&nbsp;�ʺ�״̬��<select name="UserAccountStatus" size="1">
				<option value="0" <%if Rs("UserAccountStatus")=0 then%>selected<%end if%>>���ȴ����</option>
				<option value="1" <%if Rs("UserAccountStatus")=1 then%>selected<%end if%>>��ͨ�����</option>
				<option value="2" <%if Rs("UserAccountStatus")=2 then%>selected<%end if%>>�ѽ���</option>
				<option value="3" <%if Rs("UserAccountStatus")=3 then%>selected<%end if%>>δͨ�����</option>
			</select>		</td>
	</tr>
	<tr id=CommonListCell>
		<td colspan="2">&nbsp;�û�ͷ�Σ�<input size="10" name="UserTitle" value="<%=Rs("UserTitle")%>"></td>
		<td width="600" colspan="2">&nbsp;���εȼ���<select name="ModerationLevel" size="1">
			<option value="1" <%if Rs("ModerationLevel")=True then%>selected<%end if%>>�����û�</option>
			<option value="0" <%if Rs("ModerationLevel")=False then%>selected<%end if%>>�������û�</option>
		</select></td>
	</tr>
	<tr id=CommonListCell>
		<td width="600" colspan="2">&nbsp;�� �� ����<input size="10" name="TotalPosts" value="<%=Rs("TotalPosts")%>"></td>
		<td colspan="2">&nbsp;�û�������<input size="10" name="Reputation" value="<%=Rs("Reputation")%>"></td>
	</tr>
	<tr id=CommonListCell>
		<td colspan="2">&nbsp;�𡡡�Ǯ��<input size="10" name="UserMoney" value="<%=Rs("UserMoney")%>" /></td>
		<td width="600" colspan="2">&nbsp;�� �� �ˣ�<input size="20" name="ReferrerName" value="<%=Rs("ReferrerName")%>" /></td>
	</tr>
	<tr id=CommonListCell>
		<td colspan="2">&nbsp;�� �� ֵ��<input size="10" name="experience" value="<%=Rs("experience")%>" /></td>
		<td colspan="2">&nbsp;�û�ͷ��<input size="20" name="UserFaceUrl" value="<%=Rs("UserFaceUrl")%>"></td>
	</tr>
	<tr id=CommonListCell>
		<td width="1200" colspan="4">&nbsp;ע�����ڣ�<%=Rs("UserRegisterTime")%> ���ɣУ�<%=Rs("UserRegisterIP")%>��</td>
	</tr>
	<tr id=CommonListCell>
		<td width="1200" colspan="4">&nbsp;����ڣ�<%=Rs("UserActivityTime")%> ���ɣУ�<%=Rs("UserActivityIP")%>��</td>
	</tr>
	<tr id=CommonListTitle>
		<td colspan="4" align="center">��������</td>
	</tr>
	<tr id=CommonListCell>
	  <td width="600" colspan="2">&nbsp;���֣� <input type="text" name="RealName" size="20" value="<%=Rs("RealName")%>" /></td>
		<td width="600" height="3" colspan="2">&nbsp;�Ա� <select size=1 name=UserSex>
				<option value=0 selected>[��ѡ��]</option>
				<option value=1 <%if Rs("UserSex")=1 then%>selected<%end if%>>��</option>
				<option value=2 <%if Rs("UserSex")=2 then%>selected<%end if%>>Ů</option>
	  </select></td>
	</tr>
	<tr id=CommonListCell>
		<td width="600" colspan="2">&nbsp;���գ� <input type="text" name="birthday" size="20" value="<%=Rs("birthday")%>"></td>
		<td width="600" colspan="2">&nbsp;��ַ�� <input type="text" name="Address" size="20" value="<%=Rs("Address")%>"></td>
	</tr>
	<tr id=CommonListCell>
	  <td colspan="2">&nbsp;ְҵ�� <input type="text" name="Occupation" size="20" value="<%=Rs("Occupation")%>"></td>
	  <td colspan="2">&nbsp;��Ȥ�� <input type="text" name="Interests" size="20" value="<%=Rs("Interests")%>"></td>
    </tr>
	<tr id=CommonListCell>
	  <td colspan="2">&nbsp;���䣺 <input type="text" name="UserEmail" size="20" value="<%=Rs("UserEmail")%>"></td>
	  <td colspan="2">&nbsp;��ҳ�� <input type="text" name="WebAddress" size="20" value="<%=Rs("WebAddress")%>"></td>
    </tr>
	<tr id=CommonListCell>
	  <td colspan="2">&nbsp;���ͣ� <input type="text" name="WebLog" size="20" value="<%=Rs("WebLog")%>"></td>
	  <td colspan="2">&nbsp;��᣺ <input type="text" name="WebGallery" size="20" value="<%=Rs("WebGallery")%>"></td>
    </tr>
    
	<tr id=CommonListTitle>
		<td colspan="4" align="center">��ʱͨ��</td>
	</tr>
    
	<tr id=CommonListCell>
	  <td colspan="2">&nbsp;QQ ����<input type="text" name="QQ" size="20" onkeyup=if(isNaN(this.value))this.value='' value="<%=QQ%>"></td>
	  <td colspan="2">&nbsp;ICQ����<input type="text" name="ICQ" size="20" onkeyup=if(isNaN(this.value))this.value='' value="<%=ICQ%>"></td>
    </tr>
	<tr id=CommonListCell>
	  <td colspan="2">&nbsp;AIM����<input type="text" name="AIM" size="20" value="<%=AIM%>"></td>
	  <td colspan="2">&nbsp;MSN����<input type="text" name="MSN" size="20" value="<%=MSN%>"></b></td>
    </tr>
	<tr id=CommonListCell>
	  <td colspan="2">&nbsp;Yahoo��<input type="text" name="Yahoo" size="20" value="<%=Yahoo%>"></td>
	  <td colspan="2">&nbsp;Skype��<input type="text" name="Skype" size="20" value="<%=Skype%>"></b></td>
    </tr>
    
	<tr id=CommonListTitle>
		<td colspan="4" align="center">ǩ������飦��ע</td>
	</tr>
    
    
	<tr id=CommonListCell>
		<td width="600" colspan="4">&nbsp;ǩ����<textarea name="UserSign" rows="4" cols="60"><%=UserSign%></textarea></td>
	</tr>
	<tr id=CommonListCell>
		<td width="600" colspan="4">&nbsp;��飺<textarea name="UserBio" rows="4" cols="60"><%=UserBio%></textarea></td>
	</tr>
	
	<tr id=CommonListCell>
		<td width="600" colspan="4">&nbsp;��ע��<textarea name="UserNote" rows="4" cols="60"><%=UserNote%></textarea></td>
	</tr>
	
	
	<tr id=CommonListTitle>
		<td width="600" align="center" ><a onclick="return window.confirm('��ȷ��Ҫɾ�����û����з����������?');" href="?menu=UserDelTopic&UserName=<%=Rs("UserName")%>">ɾ�����û�����������</a></td>
		<td width="600" colspan="2" align="center" ><input type="submit" value=" �� �� "></td>
		<td width="600" align="center" ><a onclick="return window.confirm('��ȷ��Ҫɾ�����û�����������?');" href="?menu=UserDel&UserID=<%=Rs("UserID")%>">ɾ�����û�����������</a></td>
	</tr>
</table>
</form>
<%
End Sub

Sub UserDelTopic
	Execute("Delete from [BBSXP_Threads] where PostAuthor='"&UserName&"'")
	Response.Write("�Ѿ��� "&UserName&" ���з����������ȫ��ɾ��")
End Sub

Sub UserDel
	for each ho in Request("UserID")
		ho=int(ho)
		if ho=CookieUserID then Alert("�����Լ�ɾ���Լ�")
		Execute("Delete from [BBSXP_Users] where UserID="&ho&"")
	next
	Response.Write("�Ѿ��ɹ�ɾ���û�IDΪ��"&Request("UserID")&"������������")
End Sub

Sub Userok
	birthday=HTMLEncode(Request.Form("birthday"))
	if Not IsDate(birthday) then birthday=null
	
	
	sql="Select * from [BBSXP_Users] where UserName='"&UserName&"'"
	Rs.Open sql,Conn,1,3
		Rs("UserFaceUrl")=Request("UserFaceUrl")
		Rs("UserRoleID")=Request("UserRoleID")
		Rs("UserEmail")=Request("UserEmail")
		Rs("TotalPosts")=Request("TotalPosts")
		Rs("experience")=Request("experience")
		Rs("UserMoney")=Request("UserMoney")
		Rs("ReferrerName")=Request("ReferrerName")
		Rs("TotalPosts")=Request("TotalPosts")
		Rs("UserTitle")=Request("UserTitle")
		Rs("Reputation")=RequestInt("Reputation")
		Rs("UserSign")=HTMLEncode(Request.Form("UserSign"))
		Rs("Interests")=HTMLEncode(Request.Form("Interests"))
		Rs("UserBio")=HTMLEncode(Request.Form("UserBio"))
		Rs("UserNote")=HTMLEncode(Request.Form("UserNote"))
		
		Rs("UserSex")=RequestInt("UserSex")
		Rs("UserAccountStatus")=Request("UserAccountStatus")
		Rs("ModerationLevel")=Request("ModerationLevel")
		Rs("birthday")=birthday
		XMLDOM.loadxml("<bbsxp>"&Rs("UserInfo")&"</bbsxp>")
		Set objRoot = XMLDOM.documentElement
		objRoot.SelectSingleNode("QQ").text = ""&server.HTMLEncode(Request("QQ"))&""
		objRoot.SelectSingleNode("ICQ").text = ""&server.HTMLEncode(Request("ICQ"))&""
		objRoot.SelectSingleNode("AIM").text = ""&server.HTMLEncode(Request("AIM"))&""
		objRoot.SelectSingleNode("MSN").text = ""&server.HTMLEncode(Request("MSN"))&""
		objRoot.SelectSingleNode("Yahoo").text = ""&server.HTMLEncode(Request("Yahoo"))&""
		objRoot.SelectSingleNode("Skype").text = ""&server.HTMLEncode(Request("Skype"))&""
		Set objNodes=XMLDOM.documentElement.ChildNodes
		for each element in objNodes
			UserInfoList=UserInfoList&"<"&element.nodename&">"&element.text&"</"&element.nodename&">"&vbCrlf
		next
		Rs("UserInfo")=UserInfoList
		Rs("RealName")=Request("RealName")
		Rs("Occupation")=Request("Occupation")
		Rs("Address")=Request("Address")
		Rs("WebAddress")=Request("WebAddress")
		Rs("WebLog")=Request("WebLog")
		Rs("WebGallery")=Request("WebGallery")
	Rs.update
	Rs.close
	Response.Write("���³ɹ�")
End Sub



Sub UserRank
%>
<form method="POST" action=?menu=UserRankUp>
<table border="0" cellpadding="5" cellspacing="1" id=CommonListArea width=100%>
	<tr id=CommonListTitle>
		<td width="50" align="center">ID</td>
		<td width="120">����</td>
		<td width="120">��;�����</td>
		<td>ͼ��·��</td>
		<td width="50" align="center">����</td>
	</tr>
<%
	sql="Select * from [BBSXP_Ranks] order by PostingCountMin"
	Set Rs=Execute(sql)
	do while not Rs.eof
%>
	<tr id=CommonListCell>
		<td align="center"><%=Rs("RankID")%><input type=hidden name=RankID value=<%=Rs("RankID")%>></td>
		<td><input size="10" name="RankName<%=Rs("RankID")%>" value="<%=Rs("RankName")%>"></td>
		<td><input size="10" name="PostingCountMin<%=Rs("RankID")%>" value="<%=Rs("PostingCountMin")%>"></td>
		<td><input size="30" name="RankIconUrl<%=Rs("RankID")%>" value="<%=Rs("RankIconUrl")%>"> <img src="<%=Rs("RankIconUrl")%>"></td>
		<td align="center"><a onclick="return window.confirm('��ȷ��Ҫִ�иò���?');" href="?menu=UserRankDel&RankID=<%=Rs("RankID")%>">ɾ��</a></td>
	</tr>
<%
		Rs.Movenext
	loop
	Set Rs = Nothing
%>
	<tr id=CommonListCell>
		<td align="center"><font color="#FF0000">����</font></td>
		<td><input size="10" name="RankName" value=""></td>
		<td><input size="10" name="PostingCountMin" value=""></td>
		<td colspan="2"><input size="30" name="RankIconUrl" value=""></td>
	</tr>
</table>
<input type="submit" value=" �� �� ">
</form>
<%
End Sub

Sub AllRoles
%><b>��ɫ����</b><br>����/�༭��ɫ����������һ���û����ƶ�����Ȩ�ޡ�<br>
<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
	<tr id=CommonListTitle>
		<td align="center">��ɫ����</td>
	</tr>
<%
	sql="Select * from [BBSXP_Roles] order by RoleID"
	Set Rs=Execute(sql)
		Do While Not Rs.EOF 
%>
	<tr id=CommonListCell>
		<td><%if Rs("RoleID") > 3 then%><a href="?menu=ViewRole&RoleId=<%=Rs("RoleID")%>"><%end if%><b><%=Rs("Name")%></b></a><br><%=Rs("Description")%></td>
	</tr>
<%
			Rs.MoveNext
		loop
	Rs.Close
%>
	<tr id=CommonListCell>
		<td>
		<form name="form" method="POST" action="?menu=CreateRole">
			<input name="RoleName" onkeyup="ValidateTextboxAdd(this, 'RoleName1')" onpropertychange="ValidateTextboxAdd(this, 'RoleName1')" size="50"><input type="submit" value="����" id="RoleName1" disabled></form>
		</td>
	</tr>
</table>
<%
End Sub

Sub ViewRole
	if  RoleId<4 then PostDisabled="disabled"
	Rs.Open "Select * from [BBSXP_Roles] where RoleID="&RoleId&"",Conn,1
%><form name="form" method="POST" action="?menu=UpRole&RoleID=<%=RoleID%>">
	<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
		<tr id=CommonListTitle>
			<td align="center" colspan="2">��ɫ����</td>
		</tr>
		<tr id=CommonListCell>
			<td>RoleID</td>
			<td width="50%"><%=Rs("RoleID")%></td>
		</tr>
		<tr id=CommonListCell>
			<td>����</td>
			<td width="50%"><input name="RoleName" size="50" value="<%=Rs("Name")%>"></td>
		</tr>
		<tr id=CommonListCell>
			<td>����</td>
			<td width="50%"><input name="Description" size="50" value="<%=Rs("Description")%>"></td>
		</tr>
		<tr id=CommonListCell>
			<td colspan="2" align="right"><input <%=PostDisabled%> type="button" value="ɾ��" onclick="document.location.href='?menu=DelRole&amp;RoleID=<%=RoleID%>'"><input <%=PostDisabled%> type="submit" value="����"></td>
		</tr>
	</table>
</form>
<%
	Rs.close
End Sub


Set XMLDOM=Nothing
AdminFooter
%>