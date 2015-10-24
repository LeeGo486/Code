<!-- #include file="Setup.asp" -->

<%
HtmlTop


UserEmail=HTMLEncode(Request("UserEmail"))
ActivationKey=HTMLEncode(Request("ActivationKey"))
ReferrerName=HTMLEncode(Request("ReferrerName"))


if SiteConfig("AllowNewUserRegistration")= 0 then error("本论坛暂时不允许新用户注册！")

if SiteConfig("AccountActivation")=2 then

	if ActivationKey=empty then error("本论坛需要邀请码才能注册！")
	if Execute("Select UserName from [BBSXP_UserActivation] where ActivationKey='"&ActivationKey&"' and Email='"&UserEmail&"'").eof then error("邀请码错误！")

end if




if Request.Form("menu")="AddUserName" then

	UserName=HTMLEncode(Request.Form("UserName"))
	password=Trim(Request.Form("password"))
	RetypePassword=Trim(Request.Form("RetypePassword"))


	if UserName="" then Message=Message&"<li>您的用户名没有填写</li>"
	if UserEmail="" then Message=Message&"<li>您的Email没有填写</li>"
	if Len(UserName) < SiteConfig("UserNameMinLength") then Message=Message&"<li>您的用户名长度不能少于 "&SiteConfig("UserNameMinLength")&" 个字节</li>"
	if Len(UserName) > SiteConfig("UserNameMaxLength") then Message=Message&"<li>您的用户名长度不能超过 "&SiteConfig("UserNameMaxLength")&" 个字节</li>"	
	if instr(Request.QueryString("UserName"),UserName)=0 then Message=Message&"<li>用户名中不能含有URL所不能传送的特殊符号</li>"
	if instr(UserEmail,"@")=0 then Message=Message&"<li>您的电子邮箱地址填写错误</li>"

	errorchar=array("　","","","","","","|","`","#","%","&","+")
	for i=0 to ubound(errorchar)
		if instr(username,errorchar(i))>0 then Message=Message&"<li>用户名中不能含有特殊符号</li>"
	next

	if SiteConfig("BannedRegUserName")<>"" then
		filtrate=split(""&SiteConfig("BannedRegUserName")&"","|")
		for i = 0 to ubound(filtrate)
			if filtrate(i)<>"" then
				if instr(UserName,filtrate(i))>0 then Message=Message&"<li>用户名中不能含有系统禁止注册的字符“"&filtrate(i)&"”</li>"
			End if
		next
	end if


	if SiteConfig("EnableAntiSpamTextGenerateForRegister")=1 then
		if Request.Form("VerifyCode")<>Session("VerifyCode") or Session("VerifyCode")="" then Message=Message&"<li>验证码错误！</li>"
	end if

	if SiteConfig("AccountActivation")=1 then 
		Randomize
		password=int(rnd*999999)+1
	else
		if Len(password)<6 then Message=Message&"<li>密码必须至少包含 6 个字符</li>"
		if password<>RetypePassword then Message=Message&"<li>您 2 次输入的密码不相同</li>"
	end if

	if Message<>"" then error(""&Message&"")

	if not Execute("Select UserID From [BBSXP_Users] where UserName='"&UserName&"'" ).eof Then Message=Message&"<li>"&UserName&" 已经被别人注册了"
	If not Execute("Select UserID From [BBSXP_Users] where UserEmail='"&UserEmail&"'" ).eof Then Message=Message&"<li>"&UserEmail&" 已经被别人注册了"





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

	Message=Message&"<li>注册新用户资料成功</li><li><a href=Default.asp><a href=EditProfile.asp>填写个人详细资料</a></a></li>"
	succeed Message,"Default.asp"
end if






if Request("menu")="" and CreateUserAgreement<>"" then
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> → 注册协议</div>
<br><center>
<textarea name="textarea" rows="18" readOnly style="width:100%"><%=CreateUserAgreement%></textarea><br><br>
<input type="submit" value=" 同 意 " onclick="window.location.href='CreateUser.asp?menu=WriteProfile';">
<input type="submit" value=" 不同意 " onclick="history.back()"></center>
<%
else
%>
<SCRIPT type="text/javascript" src="Utility/pswdplc.js"></SCRIPT>
<div id="CommonBreadCrumbArea"><%ClubTree%> → 填写注册资料</div>
<form method="post" name="form" action="?UserName=" onsubmit="this.action=this.action+this.UserName.value">
<input type="hidden" name="menu" value="AddUserName">
<input type="hidden" name="ReferrerName" value="<%=ReferrerName%>">
<input type="hidden" name="ActivationKey" value="<%=ActivationKey%>">
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="2" valign="middle" align="Left">&nbsp;注册用户资料</td>
	</tr>
	<tr id=CommonListCell>
		<td align="right" width="23%"><b>用户名：</b></td>
	  <td align="Left" width="77%"><input type="text" name="UserName" size="40" onblur="CheckUserName(this.value)"> <span id="CheckUserName" style="color:#FF0000"></span></td>
	</tr>
<%	if SiteConfig("AccountActivation")<>1 then%>
	<tr id=CommonListCell>
		<td align="right" valign="middle" width="23%"><b>密码：</b><br>
	  密码必须至少包含 6 个字符</td>
	  <td align="Left" valign="middle" width="77%"><input type="password" name="password" size="40" maxLength="16" onkeyup=EvalPwd(this.value); onchange=EvalPwd(this.value); onblur="CheckUserPass(this.value)"> <span id="CheckUserPass" style="color:#FF0000"></span></td>
	</tr>
	<tr id=CommonListCell>
		<td align="right"><b>密码强度：</b></td>
		<td align="Left" valign="middle" width="77%">
			<table border="0" width="250" cellspacing="1" cellpadding="2">
				<tr bgcolor="#f1f1f1">
					<td id=iWeak align="center">弱</td>
					<td id=iMedium align="center">中</td>
					<td id=iStrong align="center">强</td>
				</tr>
			</table>		</td>
	</tr>
	<tr id=CommonListCell>
		<td align="right" valign="middle" width="23%"><b>重新键入密码：</b><br>请与您的密码保持一致</td>
		<td align="Left" valign="middle" width="77%"><input type="password" name="RetypePassword" size="40" onblur="CheckRetypePassword(this.value)"> <span id="CheckRetypePassword" style="color:#FF0000"></span></td>
	</tr>
<%	end if%>
	<tr id=CommonListCell>
		<td align="right" valign="middle" width="23%"><b>您的Email地址：</b><br><%if SiteConfig("AccountActivation")=1 then%><font color="FF0000">密码将通过Email发送</font><%end if%></td>
	 	<td align="Left" valign="middle" width="77%">
		<input type="text" name="UserEmail" size="40" onblur="CheckMail(this.value)" <%if SiteConfig("AccountActivation")=2 then%> value="<%=UserEmail%>" readonly<%end if%>> <span id="CheckMail" style="color:#FF0000"></span></td>
	</tr>



<%	if SiteConfig("EnableAntiSpamTextGenerateForRegister")=1 then%>
	<tr id=CommonListCell>
		<td align="right"><b>验证码：</b></td>
		<td><input type="text" name="VerifyCode" MaxLength="4" size="10" onblur="CheckVerifyCode(this.value)" onKeyUp="if (this.value.length == 4)CheckVerifyCode(this.value)"> <img src="VerifyCode.asp" title="验证码,看不清楚?请点击刷新验证码" style="cursor:pointer" onclick="this.src='VerifyCode.asp?'+Math.random()"> <span id="CheckVerifyCode" style="color:red"></span></td>
	</tr>
<%	end if%>
	<tr align="center" id=CommonListCell>
		<td valign="middle" colspan="2"><input type="submit" value=" 注 册 "></td>
	</tr>
</table>
</form>
<script language="JavaScript">
function CheckUserName(UserName) {
	if(UserName.length > <%=SiteConfig("UserNameMaxLength")%> || UserName.length <<%=SiteConfig("UserNameMinLength")%>) {
		ShowCheckResult("CheckUserName","您输入的用户名长度应该在 <%=SiteConfig("UserNameMinLength")%>-<%=SiteConfig("UserNameMaxLength")%> 范围内","error");
		return;
	}
	

	Ajax_CallBack(false,"CheckUserName","Loading.asp?menu=CheckUserName&UserNameLength="+UserName.length+"&UserName=" + escape(UserName));
}

function CheckUserPass(UserPass) {
	if (UserPass.length < 6){
		ShowCheckResult("CheckUserPass", "密码必须至少包含 6 个字符","error");
		return;
	}

	ShowCheckResult("CheckUserPass", "","right");

}
function CheckRetypePassword(RetypePassword) {
	if (RetypePassword != document.form.password.value){
		ShowCheckResult("CheckRetypePassword", "您 2 次输入的密码不相同","error");
		return;
	}
	
	if (RetypePassword != ''){
		ShowCheckResult("CheckRetypePassword", "","right");
	}
}
function CheckMail(Mail) {
	if(Mail.indexOf("@") == -1 || Mail.indexOf(".") == -1) {
		ShowCheckResult("CheckMail", "您没有输入Email或输入有误","error");
		return;
	}
	
	Ajax_CallBack(false,"CheckMail","Loading.asp?menu=CheckMail&Mail=" + Mail);
}
</script>
<%
end if

HtmlBottom
%>