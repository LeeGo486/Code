<!-- #include file="Setup.asp" -->
<%
HtmlTop

if SiteConfig("SelectMailMode")="" then error("ϵͳδ���� �ʼ� ���ܣ�")



UserName=HTMLEncode(Request("UserName"))
UserEmail=HTMLEncode(Request("UserEmail"))
ActivationKey=HTMLEncode(Request("ActivationKey"))

select case Request("menu")
	case ""
		default
		
		
	case "MailRecover"
		if Request("VerifyCode")<>Session("VerifyCode") or Session("VerifyCode")="" then error("��֤�����")
		if UserEmail="" then error("������Email��ַ��")
		if UserName<>"" then UserNameSql="and UserName='"&UserName&"'"
		sql="Select * from [BBSXP_Users] where UserEmail='"&UserEmail&"' "&UserNameSql&""
		Rs.Open sql,Conn,1
		if Rs.eof then error("��̳���Ҳ�����ص�����")
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
		log(""&UserName&"�����һ����룬Email:"&UserEmail&"")
		succeed "�뵽������ȡ������","Login.asp"
		
	case "setNewPassword"
		Userpass=Trim(Request("Userpass"))
		Userpass2=Trim(Request("Userpass2"))
		if Userpass<>Userpass2 then error"<li>�����������ȷ�������벻ͬ"
		if Len(Userpass)<6 then error"<li>������������ٰ��� 6 ���ַ�"

		if Execute("Select UserName from [BBSXP_UserActivation] where ActivationKey='"&ActivationKey&"' and UserName='"&UserName&"'").eof then error("�һ��������Ϣ�ѹ��ڣ��������ύ�һأ�")
		
		Execute("update [BBSXP_Users] Set UserPass='"&DefaultPasswordFormat(Userpass)&"' where UserName='"&UserName&"'")
		Execute("Delete from [BBSXP_UserActivation] where UserName='"&UserName&"'")


		Message=Message&"<li>���������óɹ�</li><li><a href=Login.asp?ReturnUrl="&ReturnUrl&">�뷵�ص�¼</a></li>"
		succeed Message,"Login.asp"
		
		
	case "MailRecoverok"
	if UserName="" then error "URL��������û���û�����"
	if Execute("Select UserName from [BBSXP_UserActivation] where ActivationKey='"&ActivationKey&"' and UserName='"&UserName&"'").eof then error("�һ��������Ϣ�ѹ��ڣ��������ύ�һأ�")

%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� �һ�����</div>
<SCRIPT type="text/javascript" src="Utility/pswdplc.js"></SCRIPT>
<form method="POST" name="form" action="?Menu=setNewPassword" onsubmit="return VerifyInput();">
<input type=hidden name=UserName value="<%=UserName%>">
<input type=hidden name=ActivationKey value="<%=ActivationKey%>">
<table width="100%" border="0" cellspacing="1" cellpadding="5" align="center" id=CommonListArea>
	<tr id=CommonListTitle>
		<td width="100%" align="center" colspan=2>���� <%=UserName%> ��������</td>
	</tr>
	<tr id=CommonListCell>
	    <td align="right" width="45%"><b> �����룺</b></td>
		<td align="Left" width="55%"> <input type="password" name="Userpass" size="40" maxLength="16" onkeyup=EvalPwd(this.value); onchange=EvalPwd(this.value);></td>
	</tr>
	<tr id=CommonListCell>
	    <td align="right" width="45%"><b>����ǿ�ȣ�</b></td>
	    <td align="Left" width="55%">
			<table border="0" width="250" cellspacing="1" cellpadding="2">
				<tr bgcolor="#f1f1f1">
					<td id=iWeak align="center">��</td>
					<td id=iMedium align="center">��</td>
					<td id=iStrong align="center">ǿ</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr id=CommonListCell>
		<td align="right" width="45%"><b>���¼��������룺</b><br>�������������뱣��һ��</td>
		<td align="Left" valign="middle" width="55%"> <input type="password" name="Userpass2" size="40" maxlength="16"></td>
	</tr>
	<tr id=CommonListCell>
		<td align="center" width="100%" colspan="2"> <input type="submit" value=" ȷ �� "></td>
	</tr>
</table>
</form>
<script language="JavaScript">
function VerifyInput()
{
	if (document.form.Userpass.value.length < 6)
	{
		alert("���������볤�ȱ������5��");
		document.form.Userpass.focus();
		return false;
	}
	if (document.form.Userpass.value != document.form.Userpass2.value)
	{
		alert("�����μ���������벻ͬ��");
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
<div id="CommonBreadCrumbArea"><%ClubTree%> �� �һ�����</div>

<table cellspacing=1 cellpadding=5 width=80% id=CommonListArea>
<form action="RecoverPassword.asp?menu=MailRecover" method="POST">
	<tr id=CommonListTitle>
		<td align="center" colspan="2">ȡ���û�����</td>
	</tr>
		<tr id=CommonListCell>
			<td width="30%" align="right">��֤�룺</td>
			<td>
				<input type="text" name="VerifyCode" MaxLength="4" size="10" onblur="CheckVerifyCode(this.value)" onKeyUp="if (this.value.length == 4)CheckVerifyCode(this.value)"> <img src="VerifyCode.asp" title="��֤��,�������?����ˢ����֤��" style="cursor:pointer" onclick="this.src='VerifyCode.asp?'+Math.random()"> <span id="CheckVerifyCode" style="color:red"></span>
			</td>
		</tr>
	<tr id=CommonListCell>
		<td align="right"> 
		�û�����</td>
		<td> 
		<input name="UserName" size="30"></td>
	</tr>
	<tr id=CommonListCell>
		<td align="right"> 
		�����ʼ���ַ��</td>
		<td> 
		<input name="UserEmail" size="30"></td>
	</tr>
	<tr id=CommonListCell>
		<td align="center" colspan="2"> 
		<input type="submit" value=" ȷ�� ">��<input type="button" onclick="javascript:history.back()" value=" ȡ�� "> </td>
	</tr>
</form>
</table>
<br><center><a href="javascript:history.back()">BACK </a><br>
<%
End Sub
HtmlBottom
%>