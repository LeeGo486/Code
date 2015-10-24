<!-- #include file="Setup.asp" -->
<%
HtmlTop

if SiteConfig("SelectMailMode")="" then error("系统未开启 邮件 功能！")



UserName=HTMLEncode(Request("UserName"))
UserEmail=HTMLEncode(Request("UserEmail"))
ActivationKey=HTMLEncode(Request("ActivationKey"))

select case Request("menu")
	case ""
		default
		
		
	case "MailRecover"
		if Request("VerifyCode")<>Session("VerifyCode") or Session("VerifyCode")="" then error("验证码错误！")
		if UserEmail="" then error("请输入Email地址！")
		if UserName<>"" then UserNameSql="and UserName='"&UserName&"'"
		sql="Select * from [BBSXP_Users] where UserEmail='"&UserEmail&"' "&UserNameSql&""
		Rs.Open sql,Conn,1
		if Rs.eof then error("论坛中找不到相关的资料")
		UserEmail=Rs("UserEmail")
		UserName=Rs("UserName")
		Rs.close

		Randomize
		ActivationKey=int(rnd*9999999999)+1
		
		LoadingEmailXml("RecoverPassword")
		MailBody=Replace(MailBody,"[UserName]",UserName)
		MailBody=Replace(MailBody,"[RecoverPasswordURL]","<a target=_blank href="&SiteConfig("SiteUrl")&"/RecoverPassword.asp?menu=MailRecoverok&username="&UserName&"&ActivationKey="&ActivationKey&">"&SiteConfig("SiteUrl")&"/RecoverPassword.asp?menu=MailRecoverok&username="&UserName&"&ActivationKey="&ActivationKey&"</a>")
		MailBody=Replace(MailBody,"[IPAddress]",REMOTE_ADDR)
		SendMail UserEmail,MailSubject,MailBody
		
		Execute("insert into [BBSXP_UserActivation] (ActivationKey,UserName) values ('"&ActivationKey&"','"&UserName&"')")
		Session("VerifyCode")=""
		log(""&UserName&"申请找回密码，Email:"&UserEmail&"")
		succeed "请到邮箱中取回密码","Login.asp"
		
	case "setNewPassword"
		Userpass=Trim(Request("Userpass"))
		Userpass2=Trim(Request("Userpass2"))
		if Userpass<>Userpass2 then error"<li>您的新密码和确认新密码不同"
		if Len(Userpass)<6 then error"<li>新密码必须至少包含 6 个字符"

		if Execute("Select UserName from [BBSXP_UserActivation] where ActivationKey='"&ActivationKey&"' and UserName='"&UserName&"'").eof then error("找回密码的信息已过期！请重新提交找回！")
		
		Execute("update [BBSXP_Users] Set UserPass='"&DefaultPasswordFormat(Userpass)&"' where UserName='"&UserName&"'")
		Execute("Delete from [BBSXP_UserActivation] where UserName='"&UserName&"'")


		Message=Message&"<li>新密码设置成功</li><li><a href=Login.asp?ReturnUrl="&ReturnUrl&">请返回登录</a></li>"
		succeed Message,"Login.asp"
		
		
	case "MailRecoverok"
	if UserName="" then error "URL不完整，没有用户名！"
	if Execute("Select UserName from [BBSXP_UserActivation] where ActivationKey='"&ActivationKey&"' and UserName='"&UserName&"'").eof then error("找回密码的信息已过期！请重新提交找回！")

%>
<div id="CommonBreadCrumbArea"><%ClubTree%> → 找回密码</div>
<SCRIPT type="text/javascript" src="Utility/pswdplc.js"></SCRIPT>
<form method="POST" name="form" action="?Menu=setNewPassword" onsubmit="return VerifyInput();">
<input type=hidden name=UserName value="<%=UserName%>">
<input type=hidden name=ActivationKey value="<%=ActivationKey%>">
<table width="100%" border="0" cellspacing="1" cellpadding="5" align="center" id=CommonListArea>
	<tr id=CommonListTitle>
		<td width="100%" align="center" colspan=2>设置 <%=UserName%> 的新密码</td>
	</tr>
	<tr id=CommonListCell>
	    <td align="right" width="45%"><b> 新密码：</b></td>
		<td align="Left" width="55%"> <input type="password" name="Userpass" size="40" maxLength="16" onkeyup=EvalPwd(this.value); onchange=EvalPwd(this.value);></td>
	</tr>
	<tr id=CommonListCell>
	    <td align="right" width="45%"><b>密码强度：</b></td>
	    <td align="Left" width="55%">
			<table border="0" width="250" cellspacing="1" cellpadding="2">
				<tr bgcolor="#f1f1f1">
					<td id=iWeak align="center">弱</td>
					<td id=iMedium align="center">中</td>
					<td id=iStrong align="center">强</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr id=CommonListCell>
		<td align="right" width="45%"><b>重新键入新密码：</b><br>请与您的新密码保持一致</td>
		<td align="Left" valign="middle" width="55%"> <input type="password" name="Userpass2" size="40" maxlength="16"></td>
	</tr>
	<tr id=CommonListCell>
		<td align="center" width="100%" colspan="2"> <input type="submit" value=" 确 定 "></td>
	</tr>
</table>
</form>
<script language="JavaScript">
function VerifyInput()
{
	if (document.form.Userpass.value.length < 6)
	{
		alert("您的新密码长度必须大于5！");
		document.form.Userpass.focus();
		return false;
	}
	if (document.form.Userpass.value != document.form.Userpass2.value)
	{
		alert("您二次键入的新密码不同！");
		document.form.Userpass.focus();
		return false;
	}
	return true;
}
</SCRIPT>
<%
end select

Sub default
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> → 找回密码</div>

<table cellspacing=1 cellpadding=5 width=80% id=CommonListArea>
<form action="RecoverPassword.asp?menu=MailRecover" method="POST">
	<tr id=CommonListTitle>
		<td align="center" colspan="2">取回用户密码</td>
	</tr>
		<tr id=CommonListCell>
			<td width="30%" align="right">验证码：</td>
			<td>
				<input type="text" name="VerifyCode" MaxLength="4" size="10" onblur="CheckVerifyCode(this.value)" onKeyUp="if (this.value.length == 4)CheckVerifyCode(this.value)"> <img src="VerifyCode.asp" title="验证码,看不清楚?请点击刷新验证码" style="cursor:pointer" onclick="this.src='VerifyCode.asp?'+Math.random()"> <span id="CheckVerifyCode" style="color:red"></span>
			</td>
		</tr>
	<tr id=CommonListCell>
		<td align="right"> 
		用户名：</td>
		<td> 
		<input name="UserName" size="30"></td>
	</tr>
	<tr id=CommonListCell>
		<td align="right"> 
		电子邮件地址：</td>
		<td> 
		<input name="UserEmail" size="30"></td>
	</tr>
	<tr id=CommonListCell>
		<td align="center" colspan="2"> 
		<input type="submit" value=" 确定 ">　<input type="button" onclick="javascript:history.back()" value=" 取消 "> </td>
	</tr>
</form>
</table>
<br><center><a href="javascript:history.back()">BACK </a><br>
<%
End Sub
HtmlBottom
%>