<!-- #include file="Setup.asp" -->
<%
if CookieUserName=empty then AlertForModal("����δ��¼��̳")
CommentFor=HTMLEncode(Request("CommentFor"))
if CommentFor="" then AlertForModal("û�����۶���")
if Lcase(CommentFor)=Lcase(CookieUserName) then AlertForModal("���ܶ��Լ���������")


if CookieTotalPosts < SiteConfig("MinReputationPost") then AlertForModal("���������� "&SiteConfig("MinReputationPost")&" ���޷������˽�������")
if CookieReputation < SiteConfig("MinReputationCount") then AlertForModal("�������� "&SiteConfig("MinReputationCount")&"���޷������˽�������")

if not Execute("select * from [BBSXP_Reputation] where CommentFor='"&CommentFor&"' and IPAddress='"&REMOTE_ADDR&"' and DateDiff("&SqlChar&"d"&SqlChar&",DateCreated,"&SqlNowString&")=0").eof then AlertForModal("��IP�����Ѷ� "&CommentFor&" ���۹���")


if BestRole<>1 then

	ReputationToday=Execute("Select count(ReputationID) from [BBSXP_Reputation] where DateDiff("&SqlChar&"d"&SqlChar&",DateCreated,"&SqlNowString&")=0 and CommentBy='"&CookieUserName&"'")(0)
	if ReputationToday>SiteConfig("MaxReputationPerDay") then AlertForModal("ÿ���û�ÿ������˵����۲��ܳ��� "&SiteConfig("MaxReputationPerDay")&" ��")

	CommentByGetRows=FetchEmploymentStatusList("Select top "&SiteConfig("ReputationRepeat")&" CommentFor from [BBSXP_Reputation] where CommentBy='"&CookieUserName&"' order by DateCreated DESC")
	if IsArray(CommentByGetRows) then
		For i=0 To Ubound(CommentByGetRows,2)
			if CommentByGetRows(0,i)=CommentFor then  AlertForModal("�ٴζ� "&CommentFor&" ������������֮ǰ�������������20���û������������ۣ�")
		Next
	End if
	
end if


if Request.ServerVariables("Request_method") = "POST" then
	Reputation=RequestInt("Reputation")
	Comment=HTMLEncode(Request("Comment"))
	
	if BestRole=1 then Reputation=SiteConfig("AdminReputationPower")*Reputation
	Rs.open "Select * from [BBSXP_Reputation]",Conn,1,3
	Rs.addnew
		Rs("Reputation")=Reputation
		Rs("Comment")=Comment
		Rs("CommentFor")=CommentFor
		Rs("CommentBy")=CookieUserName
		Rs("IPAddress")=REMOTE_ADDR
	Rs.update
	Rs.close
	
	Execute("Update [BBSXP_Users] set Reputation=Reputation+"&Reputation&" where UserName='"&CommentFor&"'")
	
	AddApplication "Message_"&CommentFor,"��ϵͳѶϢ��<a target=_blank href=Profile.asp?UserName="&CommentFor&">"&CookieUserName&" ������������������</a>"

	
%>
<script language="JavaScript">
	parent.BBSXP_Modal.Close();
</script>
<%
else
	Response.clear
%>
<title>�� <%=CommentFor%> ��������</title>
<style>body,table{FONT-SIZE:9pt;}</style>
<script language="JavaScript">
	function CheckComment(){
		if (document.form.elements["Reputation"][0].checked != true && document.form.elements["Reputation"][1].checked != true && document.form.elements["Reputation"][2].checked != true){
			alert("��ѡ���������ۣ�");
			return false;
		}
		if (document.form.Comment.value == ""){
			alert("�������������ۣ�");
			return false;
		}
		
		if (document.form.Comment.value.length > 500){
			alert("�������ݲ��ܳ���500���ַ���");
			return false;
		}			
		return true;
	}
</script>
<table width="100%" border=0 align="center">
<form name=form method=Post action=? onsubmit="return CheckComment()">
<input name="CommentFor" type="hidden" value="<%=CommentFor%>" />
  <tr>
    <td height=30>�� �ۣ�</td>
    <td>
		<input name="Reputation" type="radio" value="1" id="IsGood" /><label for="IsGood"><img src="images/Reputation_Excellent.gif" align="absmiddle" title="����">����</label>��
		<input name="Reputation" type="radio" value="0" id="IsMid" /><label for="IsMid"><img src="images/Reputation_Average.gif" align="absmiddle" title="����">����</label>��
		<input name="Reputation" type="radio" value="-1" id="IsBad" /><label for="IsBad"><img src="images/Reputation_Poor.gif" align="absmiddle" title="����">����</label>	</td>
  </tr>
  <tr>
    <td valign=top>�� �ۣ�</td>
    <td><textarea name="Comment" cols="55" rows="5"></textarea></td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <input type="submit" name="Submit" value=" ȷ �� " />��
      <input type="button" onclick="javascript:parent.BBSXP_Modal.Close()" value=" ȡ �� ">
    </td>
    </tr>
</form>
</table>
<%
end if



Sub AlertForModal(Message)
%>
	<script language="JavaScript">
	alert('<%=Message%>');
	parent.BBSXP_Modal.Close();
	</script>
<%
	Response.End
End Sub
%>