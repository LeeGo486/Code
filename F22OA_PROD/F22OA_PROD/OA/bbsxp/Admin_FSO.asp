<!-- #include file="Setup.asp" -->
<%
AdminTop
if RequestCookies("Userpass")="" or RequestCookies("Userpass")<>session("pass") then response.redirect "Admin_Default.asp"
Log("")
PostsTableNameDefault=conn.OpenSchema(4,Array(Empty,Empty,"BBSXP_Threads","PostsTableName"))("Column_Default")
if not IsNumeric(PostsTableNameDefault) then PostsTableNameDefault=ReplaceText(PostsTableNameDefault,"\(\((.*)\)\)","$1") '���SQL 2005���ݿ��ȡ�����(())

TableNameNO=RequestInt("TableNameNO")

select case Request("menu")
	case "Posts"
		Posts
	case "PostAttachment"
		PostAttachment
	case "DelPostAttachment"
		for each ho in Request.Form("UpFileID")
			ho=int(ho)
			sql="Select * from [BBSXP_PostAttachments] where UpFileID="&ho&""
			Rs.Open sql,Conn,1
				if Not Rs.Eof then
					if DelFile(""&RS("FilePath")&"")=True then 	Execute("Delete from [BBSXP_PostAttachments] where UpFileID="&Rs("UpFileID")&"")
				End if
			Rs.close
		next
		Alert("ɾ���ɹ���")
	case "changeobjectowner"
	
	if TableNameNO < 1 then Alert("���뷶Χ[1-9]��")
		SQL="sp_changeobjectowner '[BBSXP_Posts"&TableNameNO&"]','dbo'"
		Execute(SQL)
		Alert("�Ѿ��ɹ����ñ�������߸���Ϊdbo")
		
	case "CreatTable"			'�������ݿ�
	if TableNameNO < 1 then Alert("���뷶Χ[1-9]��")
	Sql="CREATE TABLE [BBSXP_Posts"&TableNameNO&"] ("&_
		"PostID int IDENTITY (1, 1) NOT NULL ,"&_
		"ThreadID int NOT NULL ,"&_
		"ParentID int Default 0 NOT NULL ,"&_
		"Subject nvarchar(255) NULL ,"&_
		"PostAuthor nvarchar(50) NOT NULL ,"&_
		"Body ntext NOT NULL ,"&_
		"PostDate datetime Default "&SqlNowString&" NOT NULL ,"&_
		"IPAddress nvarchar(50) NOT NULL "&_
	")"
		Execute(sql)
	'��������
		Sql="ALTER TABLE [BBSXP_Posts"&TableNameNO&"] ADD CONSTRAINT [FK_BBSXP_Posts"&TableNameNO&"_BBSXP_Threads] FOREIGN KEY ([ThreadID]) REFERENCES [BBSXP_Threads] ([ThreadID]) ON DELETE CASCADE  ON UPDATE CASCADE"
		Execute(sql)

		Alert("�����ɹ���")
	case "update"
		if TableNameNO < 1 then TableNameNO=null

		If IsSqlDataBase=0 Then
			Execute("alter table [BBSXP_Threads] alter PostsTableName int default "&TableNameNO&"")
		else
			if PostsTableNameDefault<>"" then Execute("ALTER TABLE [BBSXP_Threads] DROP CONSTRAINT [DF_BBSXP_Threads_PostsTableName]")
			if TableNameNO > 0 then Execute("ALTER TABLE [BBSXP_Threads] ADD CONSTRAINT [DF_BBSXP_Threads_PostsTableName] DEFAULT "&TableNameNO&" FOR [PostsTableName]")
		end if
		Alert("���óɹ���") 
	case "Del"
		if TableNameNO=0 then Alert("ϵͳĬ�ϵı���ɾ����")
		If not Execute("Select PostsTableName From [BBSXP_Threads] where PostsTableName="&TableNameNO&"" ).eof Then Alert("�ñ����ж�Ӧ�����⣬����ɾ����")
		if ""&PostsTableNameDefault&""=""&TableNameNO&"" then Alert("��ǰ����ʹ���е����ݱ���ɾ����")
		Execute("drop table [BBSXP_Posts"&TableNameNO&"]")
		Alert("ɾ���ɹ���")
	case "bak"
		bak
	case "bakbf"
		Set MyFileObject=Server.CreateOBject("Scripting.FileSystemObject")
		MyFileObject.CopyFile ""&Server.MapPath(SqlDataBase)&"",""&Server.MapPath(Request.Form("BakDbPath"))&""
		Alert("���ݳɹ���")
	case "bakhf"
		Set MyFileObject=Server.CreateOBject("Scripting.FileSystemObject")
		MyFileObject.CopyFile ""&Server.MapPath(Request.Form("BakDbPath"))&"",""&Server.MapPath(SqlDataBase)&""
		Alert("�ָ��ɹ���")
	case "statroom"
		statroom
end select

Sub bak
	If IsSqlDataBase<>0 Then Alert("SQL�汾�޷�����ACCESS���ݿ����")
%>

<table cellspacing="1" cellpadding="5" width="70%" border="0" id=CommonListArea align="center">
	<tr id=CommonListTitle>
		<td align=center colspan=2>�������ݿ�</td>
	</tr>
	<tr id=CommonListCell>
		<td align=center colspan=2>
		<form method="POST" action="?menu=bakbf">
			<table cellpadding="0" cellspacing="0" width="90%">
				<tr>
					<td width="30%">���ݿ�·���� </td>
					<td width="70%"><%=SqlDataBase%></td>
				</tr>
				<tr>
					<td width="30%">���ݵ����ݿ�·����</td>
						<td width="70%"><input size="30" value="<%=replace(""&SqlDataBase&"",".mdb","("&Date()&").mdb")%>" name="BakDbPath"></td>
				</tr>
				<tr>
						<td width="100%" align="center" colspan="2"><input type="submit" value=" �� �� "><br></td>
				</tr>
			</table>
		</form>
		</td>
	</tr>
</table>
<table cellspacing="1" cellpadding="5" width="70%" border="0" id=CommonListArea align="center">
	<tr id=CommonListTitle>
		<td align=center colspan=2>�ָ����ݿ�</td>
	</tr>
	<tr id=CommonListCell>
		<td align=center colspan=2>
		<form method="POST" action="?menu=bakhf">
			<table cellpadding="0" cellspacing="0" width="90%">
				<tr>
					<td width="30%">���ݵ����ݿ�·���� </td>
					<td width="70%"><input size="30" value="<%=replace(""&SqlDataBase&"",".mdb","("&Date()&").mdb")%>" name="BakDbPath"></td>
				</tr>
				<tr>
					<td width="30%">���ݿ�·����</td>
					<td width="70%"><%=SqlDataBase%></td>
				</tr>
				<tr>
					<td width="100%" align="center" colspan="2"><input type="submit" value=" �� �� "><br></td>
				</tr>
			</table>
		</form>
		</td>
	</tr>
</table>
<table cellspacing="1" cellpadding="5" width="70%" border="0" id=CommonListArea align="center">
	<tr id=CommonListTitle>
		<td align=center colspan=2>ѹ�����ݿ�</td>
	</tr>
	<tr id=CommonListCell>
		<td align=center colspan=2>
		<form action=Compact.asp method=Post>
		<input type=hidden name=sessionid value=<%=session.sessionid%>>
			<table cellpadding="0" cellspacing="0" width="90%">
				<tr>
					<td width="70%">
						<table cellpadding="0" cellspacing="0" width="90%">
							<tr>
								<td width="30%">���ݿ�·���� </td>
								<td width="70%"><input size="30" value="<%=SqlDataBase%>" name="dbpath"></td>
							</tr>
							<tr>
								<td width="30%">���ݿ��ʽ��</td>
								<td width="70%"><input type="radio" value="True" name="boolIs97" id=boolIs97><label for=boolIs97>Access 97</label>��<input type="radio" value="" name="boolIs97" checked id=boolIs97_1><label for=boolIs97_1>Access 2000��2002��2003</label></td>
							</tr>
							<tr>
								<td width="100%" align="center" colspan="2"><input type="submit" value=" ѹ �� "></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		</td>
	</tr>
</table>
<%
End Sub

Sub statroom
	Set fso=server.createobject("Scripting.FileSystemObject")
	UpFacedir=server.mappath("./UpFile/UpFace")
	Set d=fso.getfolder(UpFacedir)
	UpFacesize=d.size
	UpFiledir=server.mappath("./UpFile/UpAttachment")
	Set d=fso.getfolder(UpFiledir)
	UpFilesize=d.size
	toldir=server.mappath(".")
	Set d=fso.getfolder(toldir)
	tolsize=d.size
	totalBytes=UpFacesize+UpPhotosize+UpFilesize+tolsize
%>
<table cellspacing="1" cellpadding="5" width="80%" border="0" id=CommonListArea align="center">
	<tr id=CommonListTitle>
    	<td align=center colspan=3>ͳ��ռ�ÿռ�</td>
	</tr>
	<tr id=CommonListCell>
		<td width="29%">�ϴ�ͷ��ռ�ÿռ�<br></td>
		<td width="60%">
<div class="percent"><div style="width:<%=Int(UpFacesize/totalBytes*100)%>%"></div></div></td>
		<td><%=CheckSize(UpFacesize)%></td></tr>
	<tr id=CommonListCell>
		<td width="29%">�ϴ�����ռ�ÿռ�</td>
		<td width="60%"><div class="percent"><div style="width:<%=Int(UpFilesize/totalBytes*100)%>%"></div></div> </td>
		<td><%=CheckSize(UpFilesize)%></td>
	</tr>
	<tr id=CommonListCell>
		<td width="29%">BBSXPĿ¼�ܹ�ռ�ÿռ�</td>
		<td width="60%"><div class="percent"><div style="width:<%=Int(tolsize/totalBytes*100)%>%"></div></div> </td>
		<td><%=CheckSize(tolsize)%></td>
	</tr>
</table>
<%
End Sub

Sub Posts
	Set Rs=conn.openSchema(20)
%>
<form method=Post name=form action="?menu=update">
<table  cellspacing="1" cellpadding="5" width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td align="center" colspan="8"><%=rs(0)%>�������ݱ����</td>
	</tr>
	<tr id=CommonListCell>
		<td align="center">����</td>
		<td align="center">������</td>
		<td align="center">Ĭ��</td>
		<td align="center">����ʱ��</td>
		<td align="center">�޸�ʱ��</td>
		<td align="center">˵��</td>
		<td align="center">������</td>
		<td align="center">����</td>
	</tr>
<%
	Do Until Rs.EOF
		if instr(Rs("TABLE_NAME"),"BBSXP_Posts")>0 and Rs("TABLE_TYPE")="TABLE" then
			TableNameNO=replace(Rs("TABLE_NAME"),"BBSXP_Posts","")
%>
	<tr id=CommonListCell>
		<td align="center"><%=Rs("TABLE_NAME")%></td>
		<td align="center"><%=Conn.Execute("Select count(PostID)from ["&Rs("TABLE_NAME")&"]")(0)%></td>
		<td align="center"><input type="radio" <%if "BBSXP_Posts"&PostsTableNameDefault&""=""&Rs("TABLE_NAME")&"" then%>CHECKED<%end if%> value="<%=TableNameNO%>" name="TableNameNO"></td>
		<td align="center"><%=Rs(7)%></td>
		<td align="center"><%=Rs(8)%></td>
		<td align="center"><%=Rs(5)%></td>
		<td align="center"><%=Rs(1)%></td>
		<td align="center"><%If IsSqlDataBase=1 Then%><a onclick="return window.confirm('��ȷ������������߸���Ϊdbo?')" href="?menu=changeobjectowner&TableNameNO=<%=TableNameNO%>">����������</a><%end if%> <a href="?menu=Del&TableNameNO=<%=TableNameNO%>">ɾ�����ݱ�</a></td>
	</tr>
<%
		end if
		Rs.movenext
	Loop
%>
	
	<tr id=CommonListCell>
		<td align="center" colspan="8"><input type="submit" value="�� ��"></td>
	</tr>
	<tr id=CommonListCell>
		<td colspan="8">
		<i>ע�ͣ�</i>�������ݱ���ѡ�е�Ϊ��ǰ��̳��ʹ���������������ݵı�һ�������ÿ�����е�����Խ����̳������ʾ�ٶ�Խ�죬�������е������ݱ��е������г�����ʮ�������ʱ��������һ�����ݱ��������������ݣ����ᷢ����̳�ٶȿ�ܶࡣ 
		��Ҳ���Խ���ǰ��ʹ�õ����ݱ������ݱ����л�����ǰ��ʹ�õ��������ݱ���ǰ��̳�û�����ʱĬ�ϱ������ӵ����ݱ�<br><br>
		<i>���飺</i>ACCESS �汾���� <b>200,000</b> �����ݽ����±�<br> MSSQL �汾���� <b>500,000</b> �����ݽ����±�
		</td>
	</tr>
</table>
</form>
<br>
<form method=Post name=form action="?menu=CreatTable">
<table  cellspacing="1" cellpadding="5" width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td align="center" colspan="2">������ݱ�</td>
	</tr>
	<tr id=CommonListCell>
		<td align="center" width="70%">��ӵı���:<input value="1" name="TableNameNO" size="2" maxLength=1>&nbsp;&nbsp; ֻ��Ҫ��д����( 1 - 9 )����</td>
		<td align="center" width="30%"><input type="submit" value="�� ��"></td>
	</tr>
</table>
</form>
<%
End Sub

Sub PostAttachment

	Search=HTMLEncode(Request("Search"))
	Key=HTMLEncode(Request("Key"))
	order=HTMLEncode(Request("order"))

	if Search<>"" then SearchSql="where "&Search&" like '%"&Key&"%'"
	if order="" then order="UpFileID"
	sql="[BBSXP_PostAttachments] "&SearchSql&""
	rs.Open ""&sql&" order by "&order&" Desc",Conn,1
		TotalCount=Execute("Select count(UpFileID) From "&sql&"")(0) '��ȡ��������
		PageSetup=20 '�趨ÿҳ����ʾ����
		TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '��ҳ��
		PageCount = RequestInt("PageIndex") '��ȡ��ǰҳ
		if PageCount <1 then PageCount = 1
		if PageCount > TotalPage then PageCount = TotalPage
		if TotalPage>1 then RS.Move (PageCount-1) * pagesetup
%>
�������� <font color="#FF0000"><b><%=TotalCount%></b></font> ���ļ�
<table cellspacing="1" cellpadding="2" border="0"  width=100% id=CommonListArea>
<form method=Post name=form action="?menu=DelPostAttachment">
	<tr id=CommonListTitle>
		<td width=50 align="center"><input type=checkbox name=chkall onclick=CheckAll(this.form) value="ON"></td>
		<td align=center width="15%"><a href="?menu=PostAttachment&order=FileName">�ļ�����</a></td>
		<td align=center width="80"><a href="?menu=PostAttachment&order=ContentSize">��С</a></td>
		<td align="center"><a href="?menu=PostAttachment&order=ContentType">����</a></td>
		<td align="center"><a href="?menu=PostAttachment&order=Created">�ϴ�ʱ��</a></td>
		<td align="center"><a href="?menu=PostAttachment&order=UserName">�ϴ��û�</a></td>
		<td align="center" width="13%"><a href="?menu=PostAttachment&order=Description">����</a></td>
	</tr>
<%
		i=0
		Do While Not Rs.EOF and i<PageSetup
			i=i+1
%>
	<tr id=CommonListCell>
		<td align="center"><input type=checkbox name=UpFileID value="<%=RS("UpFileID")%>"></td>
		<td align=center><a target="_blank" href="<%=RS("FilePath")%>"><%=RS("FileName")%></a></td>
		<td align=center><%=CheckSize(RS("ContentSize"))%></td>
		<td align=center><%=RS("ContentType")%></td>
		<td align=center><%=RS("Created")%></td>
		<td align=center><a target="_blank" href="Profile.asp?UserName=<%=RS("UserName")%>"><%=RS("UserName")%></a></td>
		<td align=center><%if Rs("ThreadID")>0 then response.Write("<a href=ShowPost.asp?ThreadID="&Rs("ThreadID")&" target=_blank>"&RS("Description")&"</a>") else response.Write(RS("Description")) end if%></td>
	</tr>
<%
			Rs.MoveNext
		loop
	Rs.Close
%>

</table>
<table border="0" width="100%">
	<tr>
		<td><input type="submit" value="ɾ ��"></form></td>
		<td>
			<form name="form" method="post" action="?menu=PostAttachment">
			���� <select size="1" name="Search">
<option value="FileName" selected>�ļ�����</option>
<option value="ContentType">�ļ�����</option>
<option value="UserName">�ϴ��û�</option>
<option value="Description">��������</option>
</select> ����
				<input onkeyup="ValidateTextboxAdd(this, 'btnadd')" onpropertychange="ValidateTextboxAdd(this, 'btnadd')" name="Key">
				<input id="btnadd" disabled type="submit" value="����"> 
			</form>		
		</td>
		<td align="right" valign="top"><%ShowPage()%></td>
	</tr>
</table>
<%
End Sub
AdminFooter
%>