<!-- #include file="Setup.asp" -->
<%
AdminTop
if RequestCookies("Userpass")="" or RequestCookies("Userpass")<>session("pass") then response.redirect "Admin_Default.asp"
Log("")
PostsTableNameDefault=conn.OpenSchema(4,Array(Empty,Empty,"BBSXP_Threads","PostsTableName"))("Column_Default")
if not IsNumeric(PostsTableNameDefault) then PostsTableNameDefault=ReplaceText(PostsTableNameDefault,"\(\((.*)\)\)","$1") '针对SQL 2005数据库读取会出现(())

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
		Alert("删除成功！")
	case "changeobjectowner"
	
	if TableNameNO < 1 then Alert("输入范围[1-9]！")
		SQL="sp_changeobjectowner '[BBSXP_Posts"&TableNameNO&"]','dbo'"
		Execute(SQL)
		Alert("已经成功将该表的所有者更改为dbo")
		
	case "CreatTable"			'建立数据库
	if TableNameNO < 1 then Alert("输入范围[1-9]！")
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
	'建立关联
		Sql="ALTER TABLE [BBSXP_Posts"&TableNameNO&"] ADD CONSTRAINT [FK_BBSXP_Posts"&TableNameNO&"_BBSXP_Threads] FOREIGN KEY ([ThreadID]) REFERENCES [BBSXP_Threads] ([ThreadID]) ON DELETE CASCADE  ON UPDATE CASCADE"
		Execute(sql)

		Alert("建立成功！")
	case "update"
		if TableNameNO < 1 then TableNameNO=null

		If IsSqlDataBase=0 Then
			Execute("alter table [BBSXP_Threads] alter PostsTableName int default "&TableNameNO&"")
		else
			if PostsTableNameDefault<>"" then Execute("ALTER TABLE [BBSXP_Threads] DROP CONSTRAINT [DF_BBSXP_Threads_PostsTableName]")
			if TableNameNO > 0 then Execute("ALTER TABLE [BBSXP_Threads] ADD CONSTRAINT [DF_BBSXP_Threads_PostsTableName] DEFAULT "&TableNameNO&" FOR [PostsTableName]")
		end if
		Alert("设置成功！") 
	case "Del"
		if TableNameNO=0 then Alert("系统默认的表不能删除！")
		If not Execute("Select PostsTableName From [BBSXP_Threads] where PostsTableName="&TableNameNO&"" ).eof Then Alert("该表中有对应的主题，不能删除！")
		if ""&PostsTableNameDefault&""=""&TableNameNO&"" then Alert("当前正在使用中的数据表不能删除！")
		Execute("drop table [BBSXP_Posts"&TableNameNO&"]")
		Alert("删除成功！")
	case "bak"
		bak
	case "bakbf"
		Set MyFileObject=Server.CreateOBject("Scripting.FileSystemObject")
		MyFileObject.CopyFile ""&Server.MapPath(SqlDataBase)&"",""&Server.MapPath(Request.Form("BakDbPath"))&""
		Alert("备份成功！")
	case "bakhf"
		Set MyFileObject=Server.CreateOBject("Scripting.FileSystemObject")
		MyFileObject.CopyFile ""&Server.MapPath(Request.Form("BakDbPath"))&"",""&Server.MapPath(SqlDataBase)&""
		Alert("恢复成功！")
	case "statroom"
		statroom
end select

Sub bak
	If IsSqlDataBase<>0 Then Alert("SQL版本无法进行ACCESS数据库管理")
%>

<table cellspacing="1" cellpadding="5" width="70%" border="0" id=CommonListArea align="center">
	<tr id=CommonListTitle>
		<td align=center colspan=2>备份数据库</td>
	</tr>
	<tr id=CommonListCell>
		<td align=center colspan=2>
		<form method="POST" action="?menu=bakbf">
			<table cellpadding="0" cellspacing="0" width="90%">
				<tr>
					<td width="30%">数据库路径： </td>
					<td width="70%"><%=SqlDataBase%></td>
				</tr>
				<tr>
					<td width="30%">备份的数据库路径：</td>
						<td width="70%"><input size="30" value="<%=replace(""&SqlDataBase&"",".mdb","("&Date()&").mdb")%>" name="BakDbPath"></td>
				</tr>
				<tr>
						<td width="100%" align="center" colspan="2"><input type="submit" value=" 备 份 "><br></td>
				</tr>
			</table>
		</form>
		</td>
	</tr>
</table>
<table cellspacing="1" cellpadding="5" width="70%" border="0" id=CommonListArea align="center">
	<tr id=CommonListTitle>
		<td align=center colspan=2>恢复数据库</td>
	</tr>
	<tr id=CommonListCell>
		<td align=center colspan=2>
		<form method="POST" action="?menu=bakhf">
			<table cellpadding="0" cellspacing="0" width="90%">
				<tr>
					<td width="30%">备份的数据库路径： </td>
					<td width="70%"><input size="30" value="<%=replace(""&SqlDataBase&"",".mdb","("&Date()&").mdb")%>" name="BakDbPath"></td>
				</tr>
				<tr>
					<td width="30%">数据库路径：</td>
					<td width="70%"><%=SqlDataBase%></td>
				</tr>
				<tr>
					<td width="100%" align="center" colspan="2"><input type="submit" value=" 恢 复 "><br></td>
				</tr>
			</table>
		</form>
		</td>
	</tr>
</table>
<table cellspacing="1" cellpadding="5" width="70%" border="0" id=CommonListArea align="center">
	<tr id=CommonListTitle>
		<td align=center colspan=2>压缩数据库</td>
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
								<td width="30%">数据库路径： </td>
								<td width="70%"><input size="30" value="<%=SqlDataBase%>" name="dbpath"></td>
							</tr>
							<tr>
								<td width="30%">数据库格式：</td>
								<td width="70%"><input type="radio" value="True" name="boolIs97" id=boolIs97><label for=boolIs97>Access 97</label>　<input type="radio" value="" name="boolIs97" checked id=boolIs97_1><label for=boolIs97_1>Access 2000、2002、2003</label></td>
							</tr>
							<tr>
								<td width="100%" align="center" colspan="2"><input type="submit" value=" 压 缩 "></td>
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
    	<td align=center colspan=3>统计占用空间</td>
	</tr>
	<tr id=CommonListCell>
		<td width="29%">上传头像占用空间<br></td>
		<td width="60%">
<div class="percent"><div style="width:<%=Int(UpFacesize/totalBytes*100)%>%"></div></div></td>
		<td><%=CheckSize(UpFacesize)%></td></tr>
	<tr id=CommonListCell>
		<td width="29%">上传附件占用空间</td>
		<td width="60%"><div class="percent"><div style="width:<%=Int(UpFilesize/totalBytes*100)%>%"></div></div> </td>
		<td><%=CheckSize(UpFilesize)%></td>
	</tr>
	<tr id=CommonListCell>
		<td width="29%">BBSXP目录总共占用空间</td>
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
		<td align="center" colspan="8"><%=rs(0)%>帖子数据表管理</td>
	</tr>
	<tr id=CommonListCell>
		<td align="center">表名</td>
		<td align="center">帖子数</td>
		<td align="center">默认</td>
		<td align="center">创建时间</td>
		<td align="center">修改时间</td>
		<td align="center">说明</td>
		<td align="center">所有者</td>
		<td align="center">管理</td>
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
		<td align="center"><%If IsSqlDataBase=1 Then%><a onclick="return window.confirm('您确定将表的所有者更改为dbo?')" href="?menu=changeobjectowner&TableNameNO=<%=TableNameNO%>">更改所有者</a><%end if%> <a href="?menu=Del&TableNameNO=<%=TableNameNO%>">删除数据表</a></td>
	</tr>
<%
		end if
		Rs.movenext
	Loop
%>
	
	<tr id=CommonListCell>
		<td align="center" colspan="8"><input type="submit" value="提 交"></td>
	</tr>
	<tr id=CommonListCell>
		<td colspan="8">
		<i>注释：</i>上面数据表中选中的为当前论坛所使用来保存帖子数据的表，一般情况下每个表中的数据越少论坛帖子显示速度越快，当您下列单个数据表中的数据有超过几十万的帖子时不妨新添一个数据表来保存帖子数据，您会发现论坛速度快很多。 
		您也可以将当前所使用的数据表在数据表中切换，当前所使用的帖子数据表即当前论坛用户发帖时默认保存帖子的数据表。<br><br>
		<i>建议：</i>ACCESS 版本超过 <b>200,000</b> 条数据建立新表<br> MSSQL 版本超过 <b>500,000</b> 条数据建立新表
		</td>
	</tr>
</table>
</form>
<br>
<form method=Post name=form action="?menu=CreatTable">
<table  cellspacing="1" cellpadding="5" width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td align="center" colspan="2">添加数据表</td>
	</tr>
	<tr id=CommonListCell>
		<td align="center" width="70%">添加的表名:<input value="1" name="TableNameNO" size="2" maxLength=1>&nbsp;&nbsp; 只需要填写数字( 1 - 9 )即可</td>
		<td align="center" width="30%"><input type="submit" value="提 交"></td>
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
		TotalCount=Execute("Select count(UpFileID) From "&sql&"")(0) '获取数据数量
		PageSetup=20 '设定每页的显示数量
		TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '总页数
		PageCount = RequestInt("PageIndex") '获取当前页
		if PageCount <1 then PageCount = 1
		if PageCount > TotalPage then PageCount = TotalPage
		if TotalPage>1 then RS.Move (PageCount-1) * pagesetup
%>
共搜索到 <font color="#FF0000"><b><%=TotalCount%></b></font> 个文件
<table cellspacing="1" cellpadding="2" border="0"  width=100% id=CommonListArea>
<form method=Post name=form action="?menu=DelPostAttachment">
	<tr id=CommonListTitle>
		<td width=50 align="center"><input type=checkbox name=chkall onclick=CheckAll(this.form) value="ON"></td>
		<td align=center width="15%"><a href="?menu=PostAttachment&order=FileName">文件名称</a></td>
		<td align=center width="80"><a href="?menu=PostAttachment&order=ContentSize">大小</a></td>
		<td align="center"><a href="?menu=PostAttachment&order=ContentType">类型</a></td>
		<td align="center"><a href="?menu=PostAttachment&order=Created">上传时间</a></td>
		<td align="center"><a href="?menu=PostAttachment&order=UserName">上传用户</a></td>
		<td align="center" width="13%"><a href="?menu=PostAttachment&order=Description">描述</a></td>
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
		<td><input type="submit" value="删 除"></form></td>
		<td>
			<form name="form" method="post" action="?menu=PostAttachment">
			搜索 <select size="1" name="Search">
<option value="FileName" selected>文件名称</option>
<option value="ContentType">文件类型</option>
<option value="UserName">上传用户</option>
<option value="Description">关联帖子</option>
</select> 包含
				<input onkeyup="ValidateTextboxAdd(this, 'btnadd')" onpropertychange="ValidateTextboxAdd(this, 'btnadd')" name="Key">
				<input id="btnadd" disabled type="submit" value="搜索"> 
			</form>		
		</td>
		<td align="right" valign="top"><%ShowPage()%></td>
	</tr>
</table>
<%
End Sub
AdminFooter
%>