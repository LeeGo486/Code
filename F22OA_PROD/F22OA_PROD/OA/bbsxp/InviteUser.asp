<!-- #include file="Setup.asp" -->
<%
HtmlTop
if CookieUserName=empty then error("����δ<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>��̳")
if SiteConfig("AccountActivation")<>2 then error("ϵͳδ���� ������ע�� ѡ�")
if SiteConfig("SelectMailMode")="" then error("ϵͳδ���� �ʼ����� ���ܣ�")

if Request("menu")="InvitingOk" then
	if Request("VerifyCode")<>Session("VerifyCode") or Session("VerifyCode")="" then error("��֤�����")
	UserEmail=HTMLEncode(Request("UserEmail"))
	if UserEmail="" then error("�����������˵�Email��ַ��")
	if instr(UserEmail,"@")=0 then error("�����˵�Email��ַ��д����")
	
	If not Execute("Select UserID From [BBSXP_Users] where UserEmail='"&UserEmail&"'" ).eof Then Error("<li>"&UserEmail&" �Ѿ��ڱ���̳ע����")

	
	Randomize
	ActivationKey=int(rnd*9999999999)+1

	LoadingEmailXml("InviteNewUser")
	MailBody=Replace(MailBody,"[UserName]",CookieUserName)
	MailBody=Replace(MailBody,"[SiteName]",SiteConfig("SiteName"))
	MailBody=Replace(MailBody,"[InviteURL]","<a target=_blank href="&SiteConfig("SiteUrl")&"/CreateUser.asp?menu=WriteProfile&ActivationKey="&ActivationKey&"&ReferrerName="&CookieUserName&"&UserEmail="&UserEmail&">"&SiteConfig("SiteUrl")&"/CreateUser.asp?menu=WriteProfile&ActivationKey="&ActivationKey&"&ReferrerName="&CookieUserName&"&UserEmail="&UserEmail&"</a>")
	SendMail UserEmail,MailSubject,MailBody
	
	Execute("insert into [BBSXP_UserActivation] (ActivationKey,Email) values ('"&ActivationKey&"','"&UserEmail&"')")
	Session("VerifyCode")=""
	succeed "�����뷢�ͳɹ���","Default.asp"
else
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� ����������</div>
<table cellspacing=1 cellpadding=5 width=80% id=CommonListArea>
	<form action="?menu=InvitingOk" method="POST" name=form>
		<tr id=CommonListTitle>
			<td align="center" colspan="2">����������</td>
		</tr>
		<tr id=CommonListCell>
			<td width="30%" align="right">��֤�룺</td>
			<td>
				<input type="text" name="VerifyCode" MaxLength="4" size="10" onblur="CheckVerifyCode(this.value)" onKeyUp="if (this.value.length == 4)CheckVerifyCode(this.value)"> <img src="VerifyCode.asp" title="��֤��,�������?����ˢ����֤��" style="cursor:pointer" onclick="this.src='VerifyCode.asp?'+Math.random()"> <span id="CheckVerifyCode" style="color:red"></span>
			</td>
		</tr>
		<tr id=CommonListCell>
			<td align="right">�����˵������䣺</td>
			<td>
				<input type="text" name="UserEmail" size=30>
			</td>
		</tr>
		<tr id=CommonListCell>
			<td valign="top" align="center" colspan="2">
				<input type="submit" value=" ���� "> <input type="button" onclick="javascript:history.back()" value=" ȡ�� ">
			</td>
		</tr>
	</form>
	</table>
<%
end if
HtmlBottom
%>