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
	Rs.close
%>
	<!-- #include file="Utility/ForumPermissions.asp" -->
<%
else
end if


if PermissionManage=0 and BestRole<>1 then error("����<a href=ShowForumPermissions.asp?ForumID="&ForumID&">Ȩ��</a>����")

select case Request("menu")
	case "Fix"
		allarticle=Execute("Select count(ThreadID) from [BBSXP_Threads] where IsDel=0 and ForumID="&ForumID&"")(0)
		if allarticle>0 then
			allrearticle=Execute("Select sum(TotalReplies) from [BBSXP_Threads] where IsDel=0 and ForumID="&ForumID&"")(0)
		else
			allrearticle=0
		end if
		Execute("update [BBSXP_Forums] Set TotalThreads="&allarticle&",TotalPosts="&allarticle+allrearticle&" where ForumID="&ForumID&"")
		UpForumMostRecent(ForumID)
		succeed "�޸���̳ͳ�����ݳɹ�",""
		
	case "ForumDataUp"
		ForumName=HTMLEncode(Request.Form("ForumName"))
		TotalCategorys=HTMLEncode(Request.Form("TotalCategorys"))
		Moderated=HTMLEncode(Request.Form("Moderated"))
		ForumDescription=HTMLEncode(Request.Form("ForumDescription"))
		ForumRules=HTMLEncode(Request.Form("ForumRules"))
		if ForumName="" then error("��������̳����")
		if Len(ForumName)>30 then  error("��̳���Ʋ��ܴ��� 30 ���ַ�")
		if Len(ForumDescription)>255 then  error("��̳��鲻�ܴ��� 255 ���ַ�")
		master=split(""&Moderated&"","|")
		for i = 0 to ubound(master)
			If Execute("Select UserID From [BBSXP_Users] where UserName='"&master(i)&"'" ).eof and master(i)<>"" Then error(""&master(i)&"���û����ϲ�����")
		next
		sql="Select * from [BBSXP_Forums] where ForumID="&ForumID&""
		Rs.Open sql,Conn,1,3
			Rs("ForumName")=ForumName
			if BestRole=1 then Rs("Moderated")=Moderated
			Rs("TotalCategorys")=TotalCategorys
			Rs("ForumDescription")=ForumDescription
			Rs("ForumRules")=ForumRules
		Rs.update
		Rs.close
		Log("������̳��ID:"&ForumID&"������Ϣ��")
		Message="<li>���³ɹ���</li><li><a href=ShowForum.asp?ForumID="&ForumID&">������̳</a></li>"
		succeed Message,"ShowForum.asp?ForumID="&ForumID&""

end select


		sql="Select * from [BBSXP_Forums] where ForumID="&ForumID&""
		Set Rs=Execute(sql)
			ForumDescription=replace(""&Rs("ForumDescription")&"","<br>",vbCrlf)
			ForumRules=replace(""&Rs("ForumRules")&"","<br>",vbCrlf)
%>

<div id="CommonBreadCrumbArea"><%ClubTree%> �� <%=ForumTree(Rs("ParentID"))%> <a href="ShowForum.asp?ForumID=<%=ForumID%>"><%=Rs("ForumName")%></a> �� ������</div>
<table border=0 width=100%>
	<tr>
		<td valign="top" width="20%">
			<table width=100% cellspacing=1 cellpadding=5 border=0 id=CommonListArea>
				<tr id=CommonListTitle>
					<td align="center">��̳��Ϣ </td>
				</tr>
				<tr id=CommonListCell>
					<td>��������<%=Rs("TodayPosts")%></td>
				</tr>
				<tr id=CommonListCell>
					<td>��������<%=Rs("TotalThreads")%> </td>
				</tr>
				<tr id=CommonListCell>
					<td>��������<%=Rs("TotalPosts")%> </td>
				</tr>
				<tr id=CommonListTitle>
					<td align="center">����ѡ��</td>
				</tr>
				<tr id=CommonListCell>
					<td><a href="Moderation.asp?ForumID=<%=ForumID%>&checkbox=1">�������</a></td>
				</tr>
				<tr id=CommonListCell>
					<td><a href="Moderation.asp?ForumID=<%=ForumID%>&checkbox=1&Menu=Censorship">�������</a></td>
				</tr>
				<tr id=CommonListCell>
					<td><a href="Moderation.asp?ForumID=<%=ForumID%>&checkbox=1&Menu=Recycle">�� �� վ</a></td>
				</tr>
				<tr id=CommonListCell>
					<td><a href="ForumManage.asp?menu=Fix&ForumID=<%=ForumID%>">�޸���̳ͳ������</a></td>
				</tr>		
			</table>
		</td>
		<td align="center" valign="top">
		<form name="form2" method="POST" action="?">
		<input type=hidden name=menu value="ForumDataUp">
		<input type=hidden name=ForumID value="<%=ForumID%>">	
			<table width=100% cellspacing=1 cellpadding=5 border=0 id=CommonListArea>
				<tr id=CommonListTitle>
					<td align="center" colspan="2">��̳����</td>
				</tr>
				<tr id=CommonListCell>
					<td align="right" valign="middle" width="20%">��̳���ƣ�</td>
					<td align="Left" valign="middle"><input type="text" name="ForumName" size="30" value="<%=Rs("ForumName")%>"></td>
				</tr>
<%if BestRole=1 then%>
				<tr id=CommonListCell>
					<td align="right" valign="middle" width="20%">��̳������</td>
					<td align="Left" valign="middle"><input size="30" name="Moderated" value="<%=Rs("Moderated")%>">����������á�|���ָ�</td>
				</tr>
<%end if%>
				<tr id=CommonListCell>
					<td align="right" valign="middle" width="20%">�������</td>
					<td align="Left" valign="middle"><input size="30" name="TotalCategorys" value="<%=Rs("TotalCategorys")%>">��������á�|���ָ����磺ԭ��|ת��|��ͼ</td>
				</tr>
				<tr id=CommonListCell>
					<td align="right" width="20%">��̳���ܣ�</td>
					<td align="Left" valign="middle"><textarea name="ForumDescription" rows="4" cols="50"><%=ForumDescription%></textarea>&nbsp;</td>
				</tr>
				<tr id=CommonListCell>
					<td align="right" width="20%">��̳����</td>
<td align="Left" valign="middle"><textarea name="ForumRules" rows="4" cols="50"><%=ForumRules%></textarea>&nbsp;</td>
				</tr>
				<tr id=CommonListCell>
					<td align="right" valign="bottom" width="98%" colspan="2"><input type="submit" value=" �� �� &gt;&gt;�� һ �� "></td>
				</tr>
			</table>
</form>	
		</td>
	</tr>
</table>
<%
	Rs.close

HtmlBottom
%>