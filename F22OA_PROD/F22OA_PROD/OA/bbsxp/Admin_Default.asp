<!-- #include file="Setup.asp" -->
<%
if CookieUserName=empty then error("����δ<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>��̳")
if CookieUserRoleID <> 1 then Alert("��û��Ȩ�޽����̨")
if Request("menu")="out" then
	session.Abandon()
	Log("�˳���̨����")
	response.redirect ""&Request.ServerVariables("script_name")&"/../"
end if


select case Request("menu")
	case "AdminLeft"
		AdminLeft
	case "pass"
		pass
	case "Header"
		AdminHeader
	case "Login"
		Login
	case "main"
		main
	case else
		if session("pass")="" then response.redirect("?menu=Login")
		Default
end select

Sub pass
	if Request("pass")="" then Alert("���������Ա���룡")

	if Len(CookieUserPass)=32 then
		session("pass")=MD5(""&Request("pass")&"")
	else
		session("pass")=SHA1(""&Request("pass")&"")
	end if

	if CookieUserPass <> session("pass") then Alert("����Ա��������뷵�����µ�¼��")
	Response.Write("<script language='JavaScript'>top.location.href='?';</script>")
End Sub

Sub main
	AdminTop
%>
<table cellpadding="5" cellspacing="1" border="0" width="95%" align="center" id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="2" align="center">ϵͳ��Ϣ</td>
	</tr>
	<tr id=CommonListCell>
		<td width="50%">������������<%=Request.ServerVariables("server_name")%> / <%=Request.ServerVariables("LOCAL_ADDR")%></td>
		<td width="50%">�ű��������棺<%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
	</tr>
	<tr id=CommonListCell>
		<td width="50%">�������������<%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
		<td width="50%">����������ϵͳ��<%=Request.ServerVariables("OS")%></td>
	</tr>
	<tr id=CommonListCell>
		<td width="50%">FSO ���֧�֣�<%If Not IsObjInstalled("Scripting.FileSystemObject") Then%><font color="red"><b>��</b></font><%else%><b>��</b><%end if%></td>
		<td width="50%">SA-FileUp ���֧�֣�<%If Not IsObjInstalled("SoftArtisans.FileUp") Then%><font color="red"><b>��</b></font><%else%><b>��</b><%end if%></td>
	</tr>
	<tr id=CommonListCell>
		<td width="50%">CDO.Message ���֧�֣�<%If Not IsObjInstalled("CDO.Message") Then%><font color="red"><b>��</b></font><%else%><b>��</b><%end if%></td>
		<td width="50%">JMail.Message ���֧�֣�<%If Not IsObjInstalled("JMail.Message") Then%><font color="red"><b>��</b></font><%else%><b>��</b><%end if%></td>
	</tr>
</table>


<br>
<form method="POST" action="Admin_Setup.asp?menu=SiteSettingsUp">
<table cellpadding="5" cellspacing="1" border="0" width="95%" align="center" id=CommonListArea>
	<tr id=CommonListTitle>
		<td align="center">����Ա���</td>
	</tr>
	<tr id=CommonListCell>
		<td align="center">
			<textarea name="AdminNotes" rows="9" style="width:95%"><%=AdminNotes%></textarea>
		</td>
	</tr>
	<tr id=CommonListCell>
		<td align="center"><input type="submit" value=" �� �� "></td>
	</tr>
</table>
</form>





<br>
<table cellpadding="5" cellspacing="1" border="0" width="95%" align="center" id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="3" align="center">�����ݷ�ʽ</td>
	</tr>
	<tr id=CommonListCell>
		<td width="20%">�û�����</td>
		<td width="60%">��ǰ�� <b><font color=red><%=Execute("Select count(UserID) from [BBSXP_Users] where UserAccountStatus=0")(0)%></font></b> λ��ע���û��ȴ����</td>
		<td width="20%"><a href="Admin_User.asp?menu=SearchUser">�����û�</a></td>
	</tr>
	<tr id=CommonListCell>
		<td width="20%">��̳����</td>
		<td width="60%">��ǰ�� <b><font color=red><%=Execute("Select count(ForumID) from [BBSXP_Forums]")(0)%></font></b> ��̳�� <b><font color=red><%=Execute("Select count(ThreadID) from [BBSXP_Threads] where IsDel=0")(0)%></font></b> ����������</td>
		<td width="20%"><a href="Admin_Forum.asp?menu=ForumAdd">�������̳</a></td>
	</tr>
</table>
<br>
<table cellpadding="5" cellspacing="1" border="0" width="95%" align="center" id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="2" align="center">����BBSXP��̳</td>
	</tr>
	<tr id=CommonListCell>
		<td width="20%">��Ʒ����</td>
		<td width="80%">BBSXP Studio</td>
	</tr>
	<tr id=CommonListCell>
		<td width="20%">��Ʒ��Ӫ</td>
		<td width="80%">Yuzi Corporation</td>
	</tr>
	<tr id=CommonListCell>
		<td width="20%" valign="top">��ϵ����</td>
		<td width="80%">TEL 0595-22205408<br>
		FAX 0595-22205409<br>
		<a target="_blank" href="http://www.bbsxp.com">http://www.bbsxp.com</a>
	</tr>
</table>
<%



	Execute("Delete from [BBSXP_EventLog] where DateDiff("&SqlChar&"d"&SqlChar&",EventDate,"&SqlNowString&") > 7")
	Execute("Delete from [BBSXP_Statistics] where DateDiff("&SqlChar&"d"&SqlChar&",DateCreated,"&SqlNowString&") > 2000")
	Execute("Delete from [BBSXP_UserActivation] where DateDiff("&SqlChar&"d"&SqlChar&",DateCreated,"&SqlNowString&") > 7")

	AdminFooter
End Sub

Sub Login
%>
<br><br><br><br><br><br><br><br>
<table width="400" border="0" cellspacing="1" cellpadding="5" align="center" id=CommonListArea>
<form action="?" method="POST">
<input type="hidden" value="pass" name="menu">
	<tr id=CommonListTitle>
		<td align="center">��¼��̳����</td>
	</tr>
	<tr id=CommonListCell>
	  <td>
	  
	  
	  <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="50%"><img src="Images/Logo.gif"/></td>
          <td width="50%"><a href="Default.asp" target=_top><%=SiteConfig("SiteName")%></a><br><%=ForumsProgram%><br><%=ForumsBuild%> ����������</td>
        </tr>
      </table>
      
      </td>
    </tr>
	<tr id=CommonListCell>
	  <td align="center">�� �� Ա��<input size="25" name="AdminUserName" type="text" value="<%=CookieUserName%>" Readonly></td>
    </tr>
	<tr id=CommonListCell>
		<td align="center">�������룺<input size="25" name="pass" type="password"></td>
	</tr>
	<tr id=CommonListCell>
		<td align="center"><input type="submit" value=" ��¼ ">��<input type="button" onclick="javascript:history.back()" value=" ȡ�� "></td>
	</tr>
</form>	
</table>

<%
End Sub

Sub AdminLeft
%>
<style>BODY { MARGIN: 0px;}</style>
<table id=CommonListArea cellSpacing="1" cellPadding="5" width="145" align="center" border="0">
		<tr id=CommonListTitle>
			<td align="center">�衡��</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Setup.asp?menu=variable">��������</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Setup.asp?menu=UserAgreement">ע���û�Э��</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Setup.asp?menu=Showbanner">HTML��������</a></td>
		</tr>
		<tr id=CommonListTitle>
			<td align="center">�ɡ�Ա</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_User.asp?menu=SearchUser">�����û�</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_User.asp">��������û�</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_User.asp?menu=AllRoles">�������н�ɫ</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_User.asp?menu=UserRank">�û��ȼ�����</a></td>
		</tr>
		<tr id=CommonListTitle>
			<td align="center">������</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Reputation.asp">������������</a></td>
		</tr>
		<tr id=CommonListTitle>
			<td align="center">�ۡ�̳</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Forum.asp?menu=ForumAdd">�½���̳</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Forum.asp?menu=ManageGroups">�� ̳ ��</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Forum.asp?menu=ApplyManage">�ۡ���̳</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Forum.asp?menu=TreeView">����������̳</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Forum.asp?menu=bbsManage">������̳����</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Forum.asp?menu=upSiteSettings">������̳����</a></td>
		</tr>
		<tr id=CommonListTitle>
			<td align="center">������</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Tool.asp?menu=BatchSendMail">Ⱥ���ʼ�</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Tool.asp?menu=Message">��ѶϢ����</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Tool.asp?menu=Link">�������ӹ���</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Tool.asp?menu=AD">���������</a></td>
		</tr>
		<tr id=CommonListTitle>
			<td align="center">�ˡ���</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Menu.asp">��̳�˵�����</a></td>
		</tr>
		<tr id=CommonListTitle><td align="center">������</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_FSO.asp?menu=bak">ACCESS���ݿ�</a> </td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_FSO.asp?menu=statroom">ͳ��ռ�ÿռ�</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_FSO.asp?menu=PostAttachment">��������</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_FSO.asp?menu=Posts">�������ݱ�</a> </td>
		</tr>
		<tr id=CommonListTitle>
			<td align="center">ϵ��ͳ</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Other.asp?menu=circumstance">������������</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Other.asp?menu=discreteness">���֧�����</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Other.asp?menu=Statistics">��̳ͳ�Ƽ�¼</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Other.asp?menu=EventLog">��̳������¼</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Other.asp?menu=EventLog&ErrNum=1">�쳣�����¼</a></td>
		</tr>
</table><%
End Sub

Sub AdminHeader
	Log("��¼��̨����")
	Response.Write "<body><table border=0 width=100% cellspacing=0 cellpadding=3><tr id=CommonListTitle><td><div style='Padding-left:15px;float:left'><span id='Licence'></span></div><div style='Text-align:right;Padding-right:15px;float:right'><a href='Default.asp' target='_blank'>��̳��ҳ</a>��<a href='?menu=main' target='main'>������ҳ</a>��<a target='_top' href='?menu=out'>�˳�����</a></div></td></tr></table>"
	Response.write("<script type='text/javascript' src='http://Licence.yuzi.net/Licence.asp?Site="&Request.ServerVariables("server_name")&"&Program="&ForumsProgram&"&Build="&ForumsBuild&"'></script>")
End Sub

Sub Default
%>
<title>��̨���� - <%=SiteConfig("SiteName")%> - Powered By BBSXP</title>

<frameset cols="170,*" frameborder="no" >
	<frame src="?menu=AdminLeft" name="leftFrame" scrolling="yes" style="overflow: auto;">
	<frameset rows="20,*" framespacing="0">
		<frame src="?menu=Header" scrolling="no" marginheight="0">
		<frame src="?menu=main" name="main" marginheight="0">
	</frameset>
</frameset>
<%
End Sub

%>