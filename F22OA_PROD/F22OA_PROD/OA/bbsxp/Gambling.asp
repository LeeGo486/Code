<!-- #include file="Setup.asp" -->
<%

HtmlTop

if CookieUserName=empty then error("����δ<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>��̳")

PlayMoney=RequestInt("PlayMoney")


%>
<title>������</title>
<div id="CommonBreadCrumbArea">	<%ClubTree%> �� <a href="?">�����ĳ�</a></div>
<center>
<%
Randomize

select case Request("menu")
	case ""
		index
		
	case "VsBigSmall"
		VsBigSmall
		
	case "VsBigSmallResult"
		VsBigSmallResult
		
	case "GuessNumber"
		GuessNumber
		
	case "GuessNumberResult"
		GuessNumberResult
		
	case "GuessNumber3"
		GuessNumber3
		
	case "GuessNumber3Result"
		GuessNumber3Result
		
	case "GuessNumber50"
		GuessNumber50
		
	case "GuessNumber50Result"
		GuessNumber50Result
		
		end select

sub CheckMoney
	if Request.ServerVariables("Request_method") <> "POST" then Alert("�Ƿ�����")
	if PlayMoney <10 or PlayMoney>100 then Alert("��ע��������10��һ򳬹�100���")
	if PlayMoney > CookieUserMoney then Alert("��Ľ�Ҳ�����")
end sub

sub index
%>
<table border="0" width="100%" cellspacing="0" cellpadding="6">
	<tr>
		<td width="40%" align="center">
		<p>
		<img src="images/plus/Gambling.gif" width="303" height="237" border="0"></p>
		</td>
		<td width="60%">
		<ul>
			<li><b><a href="?menu=VsBigSmall">�ȴ�С</a></b> (���ʣ���������ע��Χ���������������)<p>ׯ�������һ�����ӣ����Ҳ�����һ�����ӣ� 
			�����������ׯ�Ҳ���Ӯ��</p>
			</li>
		</ul>
		<p align="right">��</p>
		<ul>
			<li><b><a href="?menu=GuessNumber">�µ���</a></b> (���ʣ���������ע��Χ���������������)<p>���������һ�����ӣ���ѡ�����ӵĵ�����������ӵĵ�������ѡ�ĵ���һ��������Ӯ�ˡ�</p>
			</li>
		</ul>
		<p align="right">��</p>
		<ul>
			<li><b><a href="?menu=GuessNumber3">�ĵ���</a></b> (���ʣ���
			����������ע��Χ���������������)<p>����������������ӣ�������һ��ѹ�������ӣ�������Գ����κ�һ�����ӵĵ�������ѹ�ĵ���һ��������Ӯ�ˡ�</p>
			</li>
			
		</ul>
		<p align="right">��</p>
		<ul>
			
			<li><b><a href="?menu=GuessNumber50">������</a></b> (���ʣ�������
			����ע��Χ�����������������)<p>���������һ�����֣�������һ��ѹ�������֣�������Գ��ĵ����ֺ���ѹ������һ��������Ӯ�ˡ�</p>
			</li>
		</ul>
		</td>
	</tr>
</table>
<%
end sub







sub VsBigSmall
%>
<form method="POST" action="?">
	<input type="hidden" name="menu" value="VsBigSmallResult">
	<table border="0" cellspacing="1" cellpadding="5" width="500" id="CommonListArea" height="115">
		<tr id="CommonListTitle">
			<td height="9" align="center">�� �� С</b></td>
		</tr>
		<tr id="CommonListCell">
			<td align="center" height="12">�����ע�� <b><font color="CC0000">100</font> 
			���</b></td>
		</tr>
		<tr id="CommonListCell">
			<td align="center" height="20">��Ҫ��ע��<input type="text" name="PlayMoney" size="10" value="10">
			<b>���</b></td>
		</tr>
		<tr id="CommonListCell">
			<td align="center"><input type="submit" value="ȷ ��"></td>
		</tr>
	</table>
</form>
<%
end sub

sub VsBigSmallResult
	CheckMoney

	
	Computer=fix(rnd*6)+1
	player=fix(rnd*6)+1
%> <br>
<table border="0" cellspacing="1" cellpadding="5" width="500" id="CommonListArea">
	<tr align="center" id="CommonListTitle">
		<td colspan="3" height="15">�� �� С</font></td>
	</tr>
	<tr align="center" id="CommonListCell">
		<td height="8" width="192"><font color="CC0000">��������</font></td>
		<td height="15" width="86" rowspan="2"><font size="6"><b>VS</b></font></td>
		<td height="8" width="190"><font color="0000CC">ׯ������</font></td>
	</tr>
	<tr align="center" id="CommonListCell">
		<td height="7" width="192"><img src="images/plus/dice<%=player%>.gif"></td>
		<td height="7" width="190"><img src="images/plus/dice<%=Computer%>.gif"></td>
	</tr>
	<tr id="CommonListCell">
		<td align="center" height="50" colspan="3"><%
if Computer < player then
	%><font size="3"> ��ϲ����Ӯ�� <b><font color="CC0000"><%=PlayMoney%></font> ���</b></font><%
	PlayMoney=PlayMoney
else
	%><font size="3"> ���ź��������� <b><font color="CC0000"><%=PlayMoney%></font> ���</b></font><%
	PlayMoney=-PlayMoney
end if


Execute("update [BBSXP_Users] Set UserMoney=UserMoney+"&PlayMoney&" where UserID="&CookieUserID&"")

%> </td>
	</tr>
</table>
<%
end sub



sub GuessNumber
%> <br>
<form method="POST" action="?">
	<input type="hidden" name="menu" value="GuessNumberResult">
	<table border="0" cellspacing="1" cellpadding="5" width="500" id="CommonListArea">
		<tr align="center" id="CommonListTitle">
			<td width="33%">�� �� ��</td>
		</tr>
		<tr align="center" id="CommonListCell">
			<td width="33%"><img src="images/plus/random.gif"></td>
		</tr>
		<tr id="CommonListTitle">
			<td width="960" align="center">�� ѡ ��</td>
		</tr>
		<tr id="CommonListCell">
			<td align="center">
			<table border="0" cellspacing="0" cellpadding="0" align="center">
				<tr align="center">
					<td width="17%"><img src="images/plus/dice1.gif"></td>
					<td width="17%"><img src="images/plus/dice2.gif"></td>
					<td width="16%"><img src="images/plus/dice3.gif"></td>
					<td width="17%"><img src="images/plus/dice4.gif"></td>
					<td width="17%"><img src="images/plus/dice5.gif"></td>
					<td width="16%"><img src="images/plus/dice6.gif"></td>
				</tr>
				<tr align="center">
					<td width="17%">
					<input type="radio" name="dddimg" value="1" checked></td>
					<td width="17%"><input type="radio" name="dddimg" value="2"></td>
					<td width="16%"><input type="radio" name="dddimg" value="3"></td>
					<td width="17%"><input type="radio" name="dddimg" value="4"></td>
					<td width="17%"><input type="radio" name="dddimg" value="5"></td>
					<td width="16%"><input type="radio" name="dddimg" value="6"></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr id="CommonListCell">
			<td align="center">��Ҫ��ע��<input type="text" name="PlayMoney" size="10" value="10">
			<b>���</b></td>
		</tr>
		<tr id="CommonListCell">
			<td align="center"><input type="submit" value="ȷ ��"></td>
		</tr>
	</table>
</form>
<%
end sub




sub GuessNumberResult
	CheckMoney
	Player=cint(request("dddimg"))
	Computer=fix(rnd*6)+1
%> <br>
<table border="0" cellpadding="3" width="500" cellspacing="1" id="CommonListArea">
	<tr id="CommonListTitle">
		<td align="center" width="50%">�����ע</td>
		<td align="center">�� ��</td>
	</tr>
	<tr>
		<td align="center" id="CommonListCell">
		<img src="images/plus/dice<%=Player%>.gif"></td>
		<td align="center" id="CommonListCell">
		<img src="images/plus/dice<%=Computer%>.gif"></td>
	</tr>
	<tr id="CommonListCell">
		<td colspan="2" align="center" height="50"><%
if Computer=Player then
	PlayMoney=PlayMoney*5
	%><font size="3">��ϲ����Ӯ��  <b><font color="CC0000"><%=PlayMoney%></font> ���</b></font><%
else
	%><font size="3">���ź���������  <b><font color="CC0000"><%=PlayMoney%> </font>���</b></font><%	
	PlayMoney=-PlayMoney
end if

Execute("update [BBSXP_Users] Set UserMoney=UserMoney+"&PlayMoney&" where UserID="&CookieUserID&"")

%> </td>
	</tr>
</table>
<%
end sub






sub GuessNumber3
%> <br>
<form method="POST" action="?">
	<input type="hidden" name="menu" value="GuessNumber3Result">
	<table border="0" cellspacing="1" cellpadding="5" width="600" id="CommonListArea">
		<tr align="center" id="CommonListTitle">
			<td width="33%">�� �� ��</td>
		</tr>
		<tr align="center" id="CommonListCell">
			<td width="33%"><img src="images/plus/random.gif">
			<img src="images/plus/random.gif"> <img src="images/plus/random.gif"></td>
		</tr>
		<tr id="CommonListTitle">
			<td width="960" align="center">�� �� ע</td>
		</tr>
		<tr id="CommonListCell">
			<td align="center">
			<div align="center">
				<table border="0" cellspacing="0" cellpadding="5" width="100%">
					<tr align="center">
						<td>����</td>
						<td><img src="images/plus/dice1.gif"></td>
						<td><img src="images/plus/dice2.gif"></td>
						<td><img src="images/plus/dice3.gif"></td>
						<td><img src="images/plus/dice4.gif"></td>
						<td><img src="images/plus/dice5.gif"></td>
						<td><img src="images/plus/dice6.gif"></td>
					</tr>
					<tr align="center">
						<td>
						���</td>
						<td>
						<input type="text" name="PlayMoney1" size="5" value="0"></td>
						<td>
						<input type="text" name="PlayMoney2" size="5" value="0"></td>
						<td>
						<input type="text" name="PlayMoney3" size="5" value="0"></td>
						<td>
						<input type="text" name="PlayMoney4" size="5" value="0"></td>
						<td>
						<input type="text" name="PlayMoney5" size="5" value="0"></td>
						<td>
						<input type="text" name="PlayMoney6" size="5" value="0"></td>
					</tr>
				</table>
			</div>
			</td>
		</tr>
		<tr id="CommonListCell">
			<td align="center"><input type="submit" value="ȷ ��"></td>
		</tr>
	</table>
</form>
<%
end sub



sub GuessNumber3Result
	Computer1=fix(rnd*6)+1
	Computer2=fix(rnd*6)+1
	Computer3=fix(rnd*6)+1
	
			
	PlayMoney=0
	i=0
	Do While i < 6
		i=i+1
		TempMoney=RequestInt("PlayMoney"&i)
		if TempMoney>0 then
			TotlePlayMoney=TotlePlayMoney+TempMoney
			PlaySelectList=PlaySelectList&"<Img src=images/plus/dice"&i&".gif title='"&TempMoney&" ���' > "
			
			StartMoney=PlayMoney
			if i=Computer1 then PlayMoney=PlayMoney+TempMoney
			if i=Computer2 then PlayMoney=PlayMoney+TempMoney
			if i=Computer3 then PlayMoney=PlayMoney+TempMoney
			if StartMoney=PlayMoney then PlayMoney=PlayMoney-TempMoney '���û�оͿ�Ǯ
			
		end if
	loop
	
	
	if Request.ServerVariables("Request_method") <> "POST" then Alert("�Ƿ�����")
	if TotlePlayMoney < 10 then Alert("���ٶ�ע��������10���")
	if TotlePlayMoney > 500 then Alert("����ע���ܳ���500���")
	if TotlePlayMoney > CookieUserMoney then Alert("��Ľ�Ҳ�����")

%> <br>
<table border="0" cellpadding="3" width="500" cellspacing="1" id="CommonListArea">
	<tr id="CommonListTitle">
		<td align="center">�����ע</td>
	</tr>
	<tr>
		<td align="center" id="CommonListCell"><%=PlaySelectList%> </td>
	</tr>
	<tr id="CommonListTitle">
		<td align="center">���</td>
	</tr>
	<tr>
		<td align="center" id="CommonListCell">
		<img src="images/plus/dice<%=Computer1%>.gif">
		<img src="images/plus/dice<%=Computer2%>.gif">
		<img src="images/plus/dice<%=Computer3%>.gif"> <br>
		</td>
	</tr>
	<tr id="CommonListCell">
		<td align="center" height="50"><%
	if PlayMoney=0 then
		%><font size="3">���ֳ�ƽ</font><%
	elseif PlayMoney>0 then

		%><font size="3">��ϲ����Ӯ�� <b><font color="CC0000"><%=PlayMoney%></font> ���</b></font><%	
	else
		%><font size="3">���ź��������� <b><font color="CC0000"><%=Abs(PlayMoney)%> </font> ���</b></font><%	
end if

Execute("update [BBSXP_Users] Set UserMoney=UserMoney+"&PlayMoney&" where UserID="&CookieUserID&"")

%> </td>
	</tr>
</table>
<%
end sub




sub GuessNumber50
%> <br>
<form method="POST" action="?" name="form" >
	<input type="hidden" name="menu" value="GuessNumber50Result">
	<table border="0" cellspacing="1" cellpadding="5" width="600" id="CommonListArea">
		<tr align="center" id="CommonListTitle">
			<td width="33%">�� �� ��</td>
		</tr>
		<tr align="center" id="CommonListCell">
			<td width="33%"><div style="float:left">����ѡ��<input type="radio" value="Big" id="FastSelectType"  name="FastSelectType">��<input type="radio" value="Small" id="FastSelectType" name="FastSelectType">С��<input type="radio" value="One" id="FastSelectType" name="FastSelectType">����<input type="radio" id="FastSelectType" value="Two" name="FastSelectType">˫</div>
			
			<div style="float:right"><input type=text id=PlayMoney name=PlayMoney size=5 value=500> 
				<input type="button" value="����ѹע" onclick="FastSelect()"></div></td>
		</tr>
		<tr id="CommonListTitle">
			<td width="960" align="center">�� �� ע</td>
		</tr>
		<tr id="CommonListCell">
			<td align="center">
			<div align="center">
				<table border="0" cellspacing="0" cellpadding="5" width="100%">
<%
	i=0
	Do While i < 50

		if i mod 10 = 0 then response.write "<tr align=center>"
		i=i+1
response.write "<td><b>"&i&"</b><br><input type=text id=PlayMoney"&i&" name=PlayMoney"&i&" size=5 value=0></td>"

		if i mod 10 = 0 then response.write "</tr>"
			loop
%>


				</table>
			</div>
			</td>
		</tr>
		<tr id="CommonListCell">
			<td align="center"><input type="submit" value="ȷ ��"></td>
		</tr>
	</table>
</form>



<script language="JavaScript">
function FastSelect(){

PlayMoney=document.getElementById("PlayMoney").value

var FastSelectType;
var FormObject = document.forms["form"];
for (var i=0;i<FormObject.elements["FastSelectType"].length;i++) {
	if(FormObject.elements["FastSelectType"][i].checked){   
		FastSelectType=FormObject.elements["FastSelectType"][i].value;
		break;
	}
}

if (!FastSelectType){alert("��û��ѡ�����ѹע������")}

if (FastSelectType=="One"){
	for (var i=1; i <= 50; i++) {
	if(i % 2  == 1){
			document.getElementById("PlayMoney"+i).value= PlayMoney/25;
		}else{
			document.getElementById("PlayMoney"+i).value= 0;
		}
	}
}

if (FastSelectType=="Two"){
	for (var i=1; i <= 50; i++) {
	if(i % 2  == 0){
			document.getElementById("PlayMoney"+i).value= PlayMoney/25;
		}else{
			document.getElementById("PlayMoney"+i).value= 0;
		}
	}
}


if (FastSelectType=="Big"){

	for (var i=1; i <= 25; i++) {
	document.getElementById("PlayMoney"+i).value= 0;
	}
	
	for (var i=26; i <= 50; i++) {
	document.getElementById("PlayMoney"+i).value= PlayMoney/25;
	}

}



if (FastSelectType=="Small"){
	for (var i=1; i <= 25; i++) {
	document.getElementById("PlayMoney"+i).value= PlayMoney/25;
	}
	for (var i=26; i <= 50; i++) {
	document.getElementById("PlayMoney"+i).value= 0;
	}
}

}
</script>

<%
end sub



sub GuessNumber50Result
	Computer=fix(rnd*50)+1

	PlayMoney=0
	i=0
	Do While i < 50
		i=i+1
		TempMoney=RequestInt("PlayMoney"&i)
		if TempMoney>0 then

			TotlePlayMoney=TotlePlayMoney+TempMoney
			PlaySelectList=PlaySelectList&"<b><font size=5 title='"&TempMoney&" ���'>"&i&"</font></b>��"
			
			StartMoney=PlayMoney
			if i=Computer then PlayMoney=PlayMoney+TempMoney*40
			if StartMoney=PlayMoney then PlayMoney=PlayMoney-TempMoney '���û�оͿ�Ǯ
			
		end if
	loop
	
	
	if Request.ServerVariables("Request_method") <> "POST" then Alert("�Ƿ�����")
	if TotlePlayMoney<10 then Alert("���ٶ�ע��������10���")
	if TotlePlayMoney>5000 then Alert("����ע���ܳ���5000���")
	if TotlePlayMoney > CookieUserMoney then Alert("��Ľ�Ҳ�����")

%> <br>
<table border="0" cellpadding="3" width="500" cellspacing="1" id="CommonListArea">
	<tr id="CommonListTitle">
		<td align="center">�����ע</td>
	</tr>
	<tr>
		<td align="center" id="CommonListCell"><%=PlaySelectList%> </td>
	</tr>
	<tr id="CommonListTitle">
		<td align="center">���</td>
	</tr>
	<tr>
		<td align="center" id="CommonListCell"><b><font size=7><%=Computer%></font></b>
		</td>
	</tr>
	<tr id="CommonListCell">
		<td align="center" height="50"><%
	if PlayMoney=0 then
		%><font size="3">���ֳ�ƽ</font><%
	elseif PlayMoney>0 then

		%><font size="3">��ϲ����Ӯ�� <b><font color="CC0000"><%=PlayMoney%></font> ���</b></font><%	
	else
		%><font size="3">���ź��������� <b><font color="CC0000"><%=Abs(PlayMoney)%> </font> ���</b></font><%	
end if

Execute("update [BBSXP_Users] Set UserMoney=UserMoney+"&PlayMoney&" where UserID="&CookieUserID&"")

%> </td>
	</tr>
</table>
<%
end sub


%> 

<hr width="250" size="1">���������Ϲ��� <b><font color="CC0000"><%=Execute("Select UserMoney from [BBSXP_Users] where UserName='"&CookieUserName&"'")(0)%></font> 
���</b><br>
<hr width="250" size="1"><br>
<input onclick="history.back()" type="button" value=" &lt;&lt; �� �� "> <br>
</center>
<%
HtmlBottom
%>