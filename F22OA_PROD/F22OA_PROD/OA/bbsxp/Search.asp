<!-- #include file="Setup.asp" --><%
HtmlTop


ForumID=RequestInt("ForumID")
DateComparer=RequestInt("DateComparer")

if Request("menu")="Result" then
	Keywords=HTMLEncode(Request("Keywords"))

	SortBy=HTMLEncode(Request("SortBy"))
	Item=HTMLEncode(Request("Item"))

	if Keywords="" then error("��û�������κβ�ѯ������")
	if Request("VerifyCode")<>Session("VerifyCode") or Session("VerifyCode")="" then error("��֤�����")

	SQLSearch="IsApproved=1 and IsDel=0 and "&Item&" like '%"&Keywords&"%' "
		
	
	if DateComparer > 0 then SQLSearch=SQLSearch&" and DateDiff("&SqlChar&"d"&SqlChar&",PostTime,"&SqlNowString&") < "&DateComparer&" "

	if ForumID > 0 then SQLSearch=SQLSearch&" and ForumID="&ForumID&" "


	sql="Select * from [BBSXP_Threads] where "&SQLSearch&" order by ThreadID "&SortBy&""
	Rs.Open sql,Conn,1
		count=Execute("Select count(ThreadID) from [BBSXP_Threads] where "&SQLSearch&"")(0)    '����������
		if Count=0 then error("�Բ���û���ҵ���Ҫ��ѯ������")
		PageSetup=SiteConfig("ThreadsPerPage") '�趨ÿҳ����ʾ����
		Rs.Pagesize=PageSetup
		TotalPage=Rs.Pagecount  '��ҳ��
		PageCount = RequestInt("PageIndex")
		if PageCount <1 then PageCount = 1
		if PageCount > TotalPage then PageCount = TotalPage
		if TotalPage>0 then Rs.absolutePage=PageCount '��ת��ָ��ҳ��
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� �������</div>

<table cellspacing=0 cellpadding=0 border=0 width=100%>
	<tr>
		<td width="100%" align="right">���ҵ��� <b><font color="FF0000"><%=Count%></font></b> ƪ�������</td>
	</tr>
</table>



<table cellspacing="1" cellpadding="5" width="100%" id="CommonListArea">
	<tr id="CommonListTitle">
		<td colspan="5">����</td>
	</tr>
	<tr id="CommonListHeader" align="center">
		<td>����</td>
		<td>����</td>
		<td>�ظ�</td>
		<td>�鿴</td>
		<td>������</td>
	</tr>
<%
i=0
Do While Not RS.EOF and i<pagesetup
i=i+1
ShowThread()
Rs.MoveNext
loop
Rs.Close
%>
</table>


<table cellspacing=0 cellpadding=0 border=0 width=100%>
	<tr>
		<td width="100%"><%ShowPage()%></td>
	</tr>
</table>

<%
	HtmlBottom
end if
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� ��������</div>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<form method="POST" action="Search.asp?menu=Result" name="form">
		<tr id=CommonListTitle>
			<td colspan="2">����ѡ��</td>
		</tr>
		<tr id=CommonListCell>
			<td width="40%" align="right">�ؼ��ʣ�</td>
			<td><input size="40" name="Keywords" onkeyup="ValidateTextboxAdd(this, 'btnadd')" onpropertychange="ValidateTextboxAdd(this, 'btnadd')"></td>
		</tr>
		<tr id=CommonListCell>
			<td width="40%" align="right">�������ݣ�</td>
			<td> 
			<input type="radio" name="Item" value="Topic" id="Topic" checked><label for="Topic">����</label> 
			<input type="radio" name="Item" value="Tags" id="Tags"><label for="Tags">��ǩ</label> 
			<input type="radio" name="Item" value="Category" id="Category"><label for="Category">���</label> 
			<input type="radio" name="Item" value="PostAuthor" id="PostAuthor"><label for="PostAuthor">����</label> 
			<input type="radio" name="Item" value="LastName" id="LastName"><label for="LastName">�����µ��û�</label> 
		</tr>
		<tr id=CommonListCell>
			<td align="right">���ڷ�Χ��</td>
			<td>
			<select size="1" name="DateComparer">
				<option value="1" >��������</option>
				<option value="2" >2 ������</option>
				<option value="7" >1 ������</option>
				<option value="10" >10 ������</option>
				<option value="14" >2 ������</option>
				<option value="30" >1 ��������</option>
				<option value="45" >45 ������</option>
				<option value="60" >2 ��������</option>
				<option value="75" >75 ������</option>
				<option value="100" >100 ������</option>
				<option value="365" selected="selected">1 ������</option>
				<option value="-1">�κ�ʱ��</option>
				</select>
</td>
		</tr>
		<tr id=CommonListCell>
			<td align="right">����ʽ��</td>
			<td>
				<select  name="SortBy">
					<option value="">�Ӿɵ���</option>
					<option value="Desc" selected="">���µ���</option>
				</select>
			</td>
		</tr>
		<tr id=CommonListCell>
			<td align="right">������̳��</td>
			<td>
				<select name="ForumID">
				<option value="0">ȫ����̳</option>
				<%=GroupList(ForumID)%>
				</select>
			</td>
		</tr>
		
	<tr id=CommonListCell>
		<td align="right">��֤�룺</td>
		<td><input type="text" name="VerifyCode" MaxLength="4" size="10" onblur="CheckVerifyCode(this.value)" onKeyUp="if (this.value.length == 4)CheckVerifyCode(this.value)"> <img src="VerifyCode.asp" title="��֤��,�������?����ˢ����֤��" style="cursor:pointer" onclick="this.src='VerifyCode.asp?'+Math.random()"> <span id="CheckVerifyCode" style="color:red"></span></td>
	</tr>
		<tr id=CommonListCell>
			<td colspan="2" align="center"><input type="submit" value="��ʼ����" id="btnadd" disabled></td>
		</tr>
	</form>
</table>
<%
HtmlBottom
%>