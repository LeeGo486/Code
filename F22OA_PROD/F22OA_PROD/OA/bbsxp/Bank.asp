<!-- #include file="Setup.asp" -->
<%
HtmlTop
if CookieUserName=empty then error("����δ<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>��̳")

sql="select * from [BBSXP_Users] where UserID="&CookieUserID&""
Rs.Open sql,Conn,1,3

SaveBankDay=int(now-Rs("BankDate"))

accrual=fix(Rs("BankMoney")*0.001)*SaveBankDay

select case Request.Form("menu")
	case "save"
		save
	case "draw"
		draw
	case "virement"
		virement
end select
%>

<div id="CommonBreadCrumbArea"><%ClubTree%> �� <a href="Bank.asp">��������</a></div>
<br>
<table border=0 width=100%>
	<tr>
		<td width="50%" align="center" valign="top"><img src="images/Plus/Bank.gif"><br><br><br>
		<table border="0" cellpadding="5" cellspacing="1" width="377" id=CommonListArea>
			<tr id=CommonListTitle>
				<td width="50%" colspan="4" align="center"><%=CookieUserName%>�������ʺ�</td>
			</tr>
			<tr id=CommonListCell>
				<td width="16%" align="center">�ֽ�</td>
				<td width="28%"><b><font color="aa0000">��<%=Rs("UserMoney")%> </font></b></td>
				<td width="16%" align="center">��</td>
				<td width="31%"><b><font color="aa0000">��<%=Rs("BankMoney")%></font></b></td>
			</tr>
			<tr id=CommonListCell>
				<td width="16%" align="center">��Ϣ��</td>
				<td width="28%"><b><font color="aa0000">��<%=accrual%></font></b> ��<%=SaveBankDay%>�죩</td>
				<td width="16%" align="center">�ܹ���</td>
				<td width="31%"><b><font color="aa0000">��<%=Rs("BankMoney")+Rs("UserMoney")+accrual%></font></b></td>
			</tr>
			<tr id=CommonListCell>
				<td width="23%" align="center">���ʱ�䣺</td>
				<td width="68%" colspan="3"><%=Rs("BankDate")%></td>
			</tr>
			<tr id=CommonListCell>
				<td width="91%" colspan="4">�����е���ϢΪÿ�� <font color="#FF0000"><b>0.001%</b></font>��ÿ�δ�ȡ���Զ�������Ϣ��</td>
			</tr>
		</table>
		</td>
		<td align="center">
		<form action="Bank.asp" method="POST">
		<table cellSpacing="1" cellpadding="5" border="0" width="377" height="47" id=CommonListArea>
			<tr id=CommonListTitle>
				<td width="60%">&nbsp; <b>���</b></td>
				<td align="center">�ֽ� <b>��<%=Rs("UserMoney")%></b></td>
			</tr>
			<tr id=CommonListCell>
				<td align="center"><input type=hidden name=menu value="save">&nbsp; ��Ҫ�� ��<input size="10" value="<%=Rs("UserMoney")%>" name="qmoney" MAXSIZE="32"></td>
				<td align="center"><input type="submit" value=" �� �� " name="B2"></td>
			</tr>
		</table>
		</form>
		<form action="Bank.asp" method="POST">
		<table cellSpacing="1" cellpadding="5" border="0" width="377" height="47" id=CommonListArea>
			<tr id=CommonListTitle>
				<td width="60%">&nbsp; <b>ȡ��</b></td>
				<td align="center">��� <b>��<%=Rs("BankMoney")%></b></td>
			</tr>
			<tr id=CommonListCell>
				<td align="center"><input type=hidden name=menu value="draw">&nbsp; ��Ҫȡ ��<input size="10" value="<%=Rs("BankMoney")%>" name="qmoney" MAXSIZE="32"></td>
				<td align="center"><input type="submit" value=" ȡ �� " name="B2"></td>
			</tr>
		</table>
		</form>
		<form action="Bank.asp" method="POST">
		<table cellSpacing="1" cellpadding="5" border="0" width="377"  id=CommonListArea>
			<tr id=CommonListTitle>
				<td width="60%">&nbsp; <b>�ֽ�ת��</b>�������� 10 %��</td>
				<td align="center">�ֽ� <b>��<%=Rs("UserMoney")%></b></td>
			</tr>
			<tr id=CommonListCell>
				<td align="center" colspan="2">
				<input type=hidden name=menu value="virement">&nbsp; ��Ҫ�� ��<input size="5" value="1000" name="qmoney" MAXSIZE="32"> ת�� <input size="10" name="dxname" MAXSIZE="32"> ���ʻ�<br><input type="submit" value=" ȷ �� " name="B2">
				</td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
</table>
<%
Rs.close
HtmlBottom

sub save
	qmoney=RequestInt("qmoney")
	if qmoney > Rs("UserMoney") then error("<li>�����ֽ𲻹���")
	if qmoney<1 then error("<li>����Ϊ�㣡")

	Rs("BankMoney")=Rs("BankMoney")+qmoney+accrual
	Rs("UserMoney")=Rs("UserMoney")-qmoney
	Rs("BankDate")=now()
	Rs.update
	Rs.close
	Message="<li>���ɹ�<li><a href=Bank.asp>��������</a>"
	succeed Message,"Bank.asp"
end sub


sub draw
	qmoney=RequestInt("qmoney")
	if qmoney>Rs("BankMoney") then error("<li>���Ĵ�����")
	if qmoney<1 then error("<li>ȡ���Ϊ�㣡")

	Rs("BankMoney")=Rs("BankMoney")-qmoney+accrual
	Rs("UserMoney")=Rs("UserMoney")+qmoney
	Rs("BankDate")=now()
	Rs.update
	Rs.close
	Message="<li>ȡ��ɹ�<li><a href=Bank.asp>��������</a>"
	succeed Message,"Bank.asp"
end sub

sub virement
	dxname=HTMLEncode(Request.form("dxname"))
	if dxname=CookieUserName then error("<li>����������Լ����ʺţ�")
	If Conn.Execute("Select UserID From [BBSXP_Users] where UserName='"&dxname&"'" ).eof Then error("<li>ϵͳ������"&dxname&"���ʺ�")

	qmoney=RequestInt("qmoney")
	if qmoney<10 then error"<li>ת�ʲ��ܵ���10��"

	if qmoney*1.1>Rs("UserMoney") then error"<li>�����ֽ𲻹���Ŀǰ�ֽ� ��"&Rs("UserMoney")&"<li>���λ�� ��"&qmoney&"�������� ��"&qmoney*0.1&"������Ҫ ��"&qmoney*1.1&""

	Rs("UserMoney")=Rs("UserMoney")-qmoney*1.1
	Rs("BankDate")=now()
	Rs.update
	Rs.close

	Conn.execute("update [BBSXP_Users] Set UserMoney=UserMoney+"&qmoney&" where UserName='"&dxname&"'")

	AddApplication "Message_"&dxname,"��ϵͳѶϢ��"&CookieUserName&" �Ѿ�ͨ������ת�� ��"&qmoney&" �������ֽ��ʻ��У�"


	Log(""&CookieUserName&" ͨ������ת�� ��"&qmoney&" �� "&dxname&"")

	Message="<li>ת�ʳɹ�<li><a href=Bank.asp>��������</a>"
	succeed Message,"Bank.asp"
end sub
%>