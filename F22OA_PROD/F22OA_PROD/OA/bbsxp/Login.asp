<!-- #include file="Setup.asp" -->


<%



HtmlTop

if Request("menu")="OUT" then
		if Request.ServerVariables("Request_method") <> "POST" then error("�ύ��ʽ����")
		Execute("Delete from [BBSXP_UserOnline] where sessionid='"&session.sessionid&"'")
		CleanCookies()
		succeed "�Ѿ��ɹ��˳�","Default.asp"
		
elseif Request.ServerVariables("Request_method") = "POST" then
	ReturnUrl=Request.Form("ReturnUrl")

	if SiteConfig("EnableAntiSpamTextGenerateForLogin")=1 then
		if Request.Form("VerifyCode")<>Session("VerifyCode") or Session("VerifyCode")="" then error("��֤�����")
	end if

	UserName=HTMLEncode(Request.Form("UserName"))
	
	UserPass=Trim(Request.Form("UserPass"))





	if UserName=empty then error("�û���û������")
	sql="Select * from [BBSXP_Users] where UserName='"&UserName&"'"
	rs.Open sql,Conn,1,3
		if Rs.eof then error("���û�����δע��")
		if Rs("UserAccountStatus")=0 then error("�����ʺ����ڵȴ����")
		if Rs("UserAccountStatus")=2 then error("�����ʺ��ѱ����ã�")
		if Rs("UserAccountStatus")=3 then error("�����ʺ���δͨ�����")
		
		if SiteConfig("AllowLogin")=0 and Rs("UserRoleID")<>1 then error("������Ա���κ��˶��������¼��")
		
		
		if Len(Rs("Userpass"))=16 then
			if LCASE(mid(md5(UserPass),9,16))<>Rs("UserPass") then error("��������������")
		elseif Len(Rs("Userpass"))=32 then
			if md5(UserPass)<>Rs("UserPass") then error("��������������")
		elseif Len(Rs("Userpass"))=40 then
			if SHA1(UserPass)<>Rs("UserPass") then error("��������������")
		else
			if UserPass<>Rs("UserPass") then error("��������������")
		end if

		Rs("Userpass")=DefaultPasswordFormat(UserPass)
		Rs("UserActivityTime")=""&now()&""
		Rs("UserActivityIP")="'"&REMOTE_ADDR&"'"
		Rs.update

		if Request("Invisible")="1" then
			Invisible="1"
		else
			Invisible="0"
		end if
		if Request("IsSave")="1" then
			Expires=9999
		else
			Expires=0
		end if
		ResponseCookies "UserID",Rs("UserID"),Expires
		ResponseCookies "UserPass",Rs("UserPass"),Expires
		ResponseCookies "Invisible",Invisible,Expires
	rs.close
	
	Session("VerifyCode")=""
	
	if ""&ReturnUrl&""<>"" and instr(ReturnUrl,"login.asp")=0 then
		response.redirect ReturnUrl
	else
		response.redirect ""&SiteConfig("SiteUrl")&"/Default.asp"
	end if
	
end if

%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� ��¼��̳</div>
<form action="Login.asp" method="POST" name=form>
	<input type="hidden" value="<%=ReturnUrl%>" name="ReturnUrl">
	<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
		<tr id=CommonListTitle>
			<td align="center" colspan="2">��¼��̳</td>
		</tr>
		<tr id=CommonListCell>
			<td width="40%" align="right">�û����ƣ�</td>
			<td>
				<input type="text" name="UserName" value="<%=CookieUserName%>" style="WIDTH:150">&nbsp; <a href="CreateUser.asp">û��ע��?</a>
			</td>
		</tr>
		<tr id=CommonListCell>
			<td width="40%" align="right">�û����룺</td>
			<td>
				<input type="password" name="Userpass" style="WIDTH:150">&nbsp; <a href="RecoverPassword.asp">�һ�����?</a>
			</td>
		</tr>
		<%if SiteConfig("EnableAntiSpamTextGenerateForLogin")=1 then%>
		<tr id=CommonListCell>
			<td width="40%" align="right">�� ֤ �룺</td>
			<td>
				<input type="text" name="VerifyCode" MaxLength="4" size="10" onblur="CheckVerifyCode(this.value)" onKeyUp="if (this.value.length == 4)CheckVerifyCode(this.value)"> <img src="VerifyCode.asp" title="��֤��,�������?����ˢ����֤��" style="cursor:pointer" onclick="this.src='VerifyCode.asp?'+Math.random()"> <span id="CheckVerifyCode" style="color:red"></span>
			</td>
		</tr>
		<%end if%>
		<tr id=CommonListCell>
			<td align="right" width="40%">��¼��ʽ��</td>
			<td>
				<input type="checkbox" value="1" name="IsSave" id="IsSave"><label for="IsSave">�Զ���¼</label>
				<input type="checkbox" value="1" name="Invisible" id="Invisible"><label for="Invisible">�����¼</label>
			</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center" colspan="2">
				<input type="submit" value=" ��¼ ">��<input type="reset" value=" ȡ�� ">
			</td>
		</tr>
	</table>
</form>

<a href=javascript:history.back()>BACK </a><br>
<%

HtmlBottom
%>