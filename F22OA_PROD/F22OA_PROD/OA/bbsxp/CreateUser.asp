<!-- #include file="Setup.asp" -->

<%
HtmlTop


UserEmail=HTMLEncode(Request("UserEmail"))
ActivationKey=HTMLEncode(Request("ActivationKey"))
ReferrerName=HTMLEncode(Request("ReferrerName"))


if SiteConfig("AllowNewUserRegistration")= 0 then error("����̳��ʱ���������û�ע�ᣡ")

if SiteConfig("AccountActivation")=2 then

	if ActivationKey=empty then error("����̳��Ҫ���������ע�ᣡ")
	if Execute("Select UserName from [BBSXP_UserActivation] where ActivationKey='"&ActivationKey&"' and Email='"&UserEmail&"'").eof then error("���������")

end if




if Request.Form("menu")="AddUserName" then

	UserName=HTMLEncode(Request.Form("UserName"))
	password=Trim(Request.Form("password"))
	RetypePassword=Trim(Request.Form("RetypePassword"))


	if UserName="" then Message=Message&"<li>�����û���û����д</li>"
	if UserEmail="" then Message=Message&"<li>����Emailû����д</li>"
	if Len(UserName) < SiteConfig("UserNameMinLength") then Message=Message&"<li>�����û������Ȳ������� "&SiteConfig("UserNameMinLength")&" ���ֽ�</li>"
	if Len(UserName) > SiteConfig("UserNameMaxLength") then Message=Message&"<li>�����û������Ȳ��ܳ��� "&SiteConfig("UserNameMaxLength")&" ���ֽ�</li>"	
	if instr(Request.QueryString("UserName"),UserName)=0 then Message=Message&"<li>�û����в��ܺ���URL�����ܴ��͵��������</li>"
	if instr(UserEmail,"@")=0 then Message=Message&"<li>���ĵ��������ַ��д����</li>"

	errorchar=array("��","��","��","��","","","|","`","#","%","&","+")
	for i=0 to ubound(errorchar)
		if instr(username,errorchar(i))>0 then Message=Message&"<li>�û����в��ܺ����������</li>"
	next

	if SiteConfig("BannedRegUserName")<>"" then
		filtrate=split(""&SiteConfig("BannedRegUserName")&"","|")
		for i = 0 to ubound(filtrate)
			if filtrate(i)<>"" then
				if instr(UserName,filtrate(i))>0 then Message=Message&"<li>�û����в��ܺ���ϵͳ��ֹע����ַ���"&filtrate(i)&"��</li>"
			End if
		next
	end if


	if SiteConfig("EnableAntiSpamTextGenerateForRegister")=1 then
		if Request.Form("VerifyCode")<>Session("VerifyCode") or Session("VerifyCode")="" then Message=Message&"<li>��֤�����</li>"
	end if

	if SiteConfig("AccountActivation")=1 then 
		Randomize
		password=int(rnd*999999)+1
	else
		if Len(password)<6 then Message=Message&"<li>����������ٰ��� 6 ���ַ�</li>"
		if password<>RetypePassword then Message=Message&"<li>�� 2 ����������벻��ͬ</li>"
	end if

	if Message<>"" then error(""&Message&"")

	if not Execute("Select UserID From [BBSXP_Users] where UserName='"&UserName&"'" ).eof Then Message=Message&"<li>"&UserName&" �Ѿ�������ע����"
	If not Execute("Select UserID From [BBSXP_Users] where UserEmail='"&UserEmail&"'" ).eof Then Message=Message&"<li>"&UserEmail&" �Ѿ�������ע����"





	if Message<>"" then error(""&Message&"")


	UserInfoList=UserInfoList&"<QQ></QQ>"&vbCrlf
	UserInfoList=UserInfoList&"<ICQ></ICQ>"&vbCrlf
	UserInfoList=UserInfoList&"<AIM></AIM>"&vbCrlf
	UserInfoList=UserInfoList&"<MSN></MSN>"&vbCrlf
	UserInfoList=UserInfoList&"<Yahoo></Yahoo>"&vbCrlf
	UserInfoList=UserInfoList&"<Skype></Skype>"&vbCrlf
	Rs.Open "Select top 1 * from [BBSXP_Users]",Conn,1,3
	Rs.addNew
		Rs("UserName")=UserName
		Rs("Userpass")=DefaultPasswordFormat(""&password&"")
		Rs("UserEmail")=UserEmail

		Rs("UserInfo")=UserInfoList
		Rs("UserFaceUrl")="images/face/Default.gif"
		Rs("ReferrerName")=ReferrerName

		Rs("ModerationLevel")=SiteConfig("NewUserModerationLevel")
		if SiteConfig("AccountActivation")=3 then Rs("UserAccountStatus")=0

		Rs("UserRegisterTime")=""&now()&""
		Rs("UserRegisterIP")=REMOTE_ADDR
		Rs("UserActivityTime")=""&now()&""
		Rs("UserActivityIP")=REMOTE_ADDR
	Rs.update
	UserID=Rs("UserID")
	UserPass=Rs("UserPass")
	Rs.close
	
	Session("VerifyCode")=""
	UpdateStatistics 1,0,0
	NowDate=date()
	Execute("update [BBSXP_Statistics] Set NewestUserName='"&UserName&"' where DateDiff("&SqlChar&"d"&SqlChar&",DateCreated,"&SqlNowString&")=0")


	if SiteConfig("AccountActivation")=0 or SiteConfig("AccountActivation")=2 then
		ResponseCookies "UserID",UserID,"9999"
		ResponseCookies "Userpass",UserPass,"9999"
	end if

	if SiteConfig("AccountActivation")=2 then Execute("Delete from [BBSXP_UserActivation] where Email='"&UserEmail&"'")

	LoadingEmailXml("NewUserAccountCreated")
	MailBody=Replace(MailBody,"[UserName]",UserName)
	MailBody=Replace(MailBody,"[password]",password)
	SendMail UserEmail,MailSubject,MailBody

	Message=Message&"<li>ע�����û����ϳɹ�</li><li><a href=Default.asp><a href=EditProfile.asp>��д������ϸ����</a></a></li>"
	succeed Message,"Default.asp"
end if






if Request("menu")="" and CreateUserAgreement<>"" then
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� ע��Э��</div>
<br><center>
<textarea name="textarea" rows="18" readOnly style="width:100%"><%=CreateUserAgreement%></textarea><br><br>
<input type="submit" value=" ͬ �� " onclick="window.location.href='CreateUser.asp?menu=WriteProfile';">
<input type="submit" value=" ��ͬ�� " onclick="history.back()"></center>
<%
else
%>
<SCRIPT type="text/javascript" src="Utility/pswdplc.js"></SCRIPT>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� ��дע������</div>
<form method="post" name="form" action="?UserName=" onsubmit="this.action=this.action+this.UserName.value">
<input type="hidden" name="menu" value="AddUserName">
<input type="hidden" name="ReferrerName" value="<%=ReferrerName%>">
<input type="hidden" name="ActivationKey" value="<%=ActivationKey%>">
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="2" valign="middle" align="Left">&nbsp;ע���û�����</td>
	</tr>
	<tr id=CommonListCell>
		<td align="right" width="23%"><b>�û�����</b></td>
	  <td align="Left" width="77%"><input type="text" name="UserName" size="40" onblur="CheckUserName(this.value)"> <span id="CheckUserName" style="color:#FF0000"></span></td>
	</tr>
<%	if SiteConfig("AccountActivation")<>1 then%>
	<tr id=CommonListCell>
		<td align="right" valign="middle" width="23%"><b>���룺</b><br>
	  ����������ٰ��� 6 ���ַ�</td>
	  <td align="Left" valign="middle" width="77%"><input type="password" name="password" size="40" maxLength="16" onkeyup=EvalPwd(this.value); onchange=EvalPwd(this.value); onblur="CheckUserPass(this.value)"> <span id="CheckUserPass" style="color:#FF0000"></span></td>
	</tr>
	<tr id=CommonListCell>
		<td align="right"><b>����ǿ�ȣ�</b></td>
		<td align="Left" valign="middle" width="77%">
			<table border="0" width="250" cellspacing="1" cellpadding="2">
				<tr bgcolor="#f1f1f1">
					<td id=iWeak align="center">��</td>
					<td id=iMedium align="center">��</td>
					<td id=iStrong align="center">ǿ</td>
				</tr>
			</table>		</td>
	</tr>
	<tr id=CommonListCell>
		<td align="right" valign="middle" width="23%"><b>���¼������룺</b><br>�����������뱣��һ��</td>
		<td align="Left" valign="middle" width="77%"><input type="password" name="RetypePassword" size="40" onblur="CheckRetypePassword(this.value)"> <span id="CheckRetypePassword" style="color:#FF0000"></span></td>
	</tr>
<%	end if%>
	<tr id=CommonListCell>
		<td align="right" valign="middle" width="23%"><b>����Email��ַ��</b><br><%if SiteConfig("AccountActivation")=1 then%><font color="FF0000">���뽫ͨ��Email����</font><%end if%></td>
	 	<td align="Left" valign="middle" width="77%">
		<input type="text" name="UserEmail" size="40" onblur="CheckMail(this.value)" <%if SiteConfig("AccountActivation")=2 then%> value="<%=UserEmail%>" readonly<%end if%>> <span id="CheckMail" style="color:#FF0000"></span></td>
	</tr>



<%	if SiteConfig("EnableAntiSpamTextGenerateForRegister")=1 then%>
	<tr id=CommonListCell>
		<td align="right"><b>��֤�룺</b></td>
		<td><input type="text" name="VerifyCode" MaxLength="4" size="10" onblur="CheckVerifyCode(this.value)" onKeyUp="if (this.value.length == 4)CheckVerifyCode(this.value)"> <img src="VerifyCode.asp" title="��֤��,�������?����ˢ����֤��" style="cursor:pointer" onclick="this.src='VerifyCode.asp?'+Math.random()"> <span id="CheckVerifyCode" style="color:red"></span></td>
	</tr>
<%	end if%>
	<tr align="center" id=CommonListCell>
		<td valign="middle" colspan="2"><input type="submit" value=" ע �� "></td>
	</tr>
</table>
</form>
<script language="JavaScript">
function CheckUserName(UserName) {
	if(UserName.length > <%=SiteConfig("UserNameMaxLength")%> || UserName.length <<%=SiteConfig("UserNameMinLength")%>) {
		ShowCheckResult("CheckUserName","��������û�������Ӧ���� <%=SiteConfig("UserNameMinLength")%>-<%=SiteConfig("UserNameMaxLength")%> ��Χ��","error");
		return;
	}
	

	Ajax_CallBack(false,"CheckUserName","Loading.asp?menu=CheckUserName&UserNameLength="+UserName.length+"&UserName=" + escape(UserName));
}

function CheckUserPass(UserPass) {
	if (UserPass.length < 6){
		ShowCheckResult("CheckUserPass", "����������ٰ��� 6 ���ַ�","error");
		return;
	}

	ShowCheckResult("CheckUserPass", "","right");

}
function CheckRetypePassword(RetypePassword) {
	if (RetypePassword != document.form.password.value){
		ShowCheckResult("CheckRetypePassword", "�� 2 ����������벻��ͬ","error");
		return;
	}
	
	if (RetypePassword != ''){
		ShowCheckResult("CheckRetypePassword", "","right");
	}
}
function CheckMail(Mail) {
	if(Mail.indexOf("@") == -1 || Mail.indexOf(".") == -1) {
		ShowCheckResult("CheckMail", "��û������Email����������","error");
		return;
	}
	
	Ajax_CallBack(false,"CheckMail","Loading.asp?menu=CheckMail&Mail=" + Mail);
}
</script>
<%
end if

HtmlBottom
%>