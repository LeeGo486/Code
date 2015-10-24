<!-- #include file="Setup.asp" -->
<%
AdminTop
if RequestCookies("Userpass")="" or RequestCookies("Userpass")<>session("pass") then response.redirect "Admin_Default.asp"
select case Request("menu")
	case "discreteness"
		discreteness
	case "EventLog"
		EventLog
	case "circumstance"
		circumstance
	case "Statistics"
		Statistics
	case "ShowSession"
		ShowSession
	case "ShowApplication"
		ShowApplication
end select

Sub Statistics
%>
<table border="0" cellpadding="5" cellspacing="1" width=90% id=CommonListArea align=center>
	<tr id=CommonListTitle>
		<td width="14%" align="center">日期</td>
		<td width="14%" align="center">今日主题</td>
		<td width="14%" align="center">今日帖子</td>
		<td width="14%" align="center">今日用户</td>
		<td width="14%" align="center">总主题</td>
		<td width="14%" align="center">总帖子</td>
		<td width="14%" align="center">总用户</td>
	</tr>
<%
	TotalCount=Execute("Select count(*) From [BBSXP_Statistics] ")(0) '获取数据数量
	PageSetup=20 '设定每页的显示数量
	TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '总页数
	PageCount = RequestInt("PageIndex") '获取当前页
	if PageCount <1 then PageCount = 1
	if PageCount > TotalPage then PageCount = TotalPage
	sql="[BBSXP_Statistics] order by DateCreated Desc"
	if PageCount<11 then
		Set Rs=Execute(sql)
	else
		rs.Open sql,Conn,1
	end if
	if TotalPage>1 then RS.Move (PageCount-1) * pagesetup
	i=0
	Do While Not Rs.EOF and i<PageSetup
		i=i+1
%>
	<tr id=CommonListCell>
		<td align="center"><%=RS("DateCreated")%></td>
		<td align="center"><%=RS("DaysTopics")%></td>
		<td align="center"><%=RS("DaysPosts")%></td>
		<td align="center"><%=RS("DaysUsers")%></td>
		<td align="center"><%=RS("TotalTopics")%></td>
		<td align="center"><%=RS("TotalPosts")%></td>
		<td align="center"><%=RS("TotalUsers")%></td>
	</tr>
<%
		Rs.MoveNext
	loop
	Set Rs=Nothing
%>
</table>
<table cellspacing=0 cellpadding=0 border=0 width=90% align=center><tr><td><%ShowPage()%></tr></td></table>
<%
End Sub

Sub circumstance
	intCpuNum = Request.ServerVariables("NUMBER_OF_PROCESSORS")
	strOS = Request.ServerVariables("OS")
	If IsObjInstalled("WScript.Shell") Then
		Set wsX = Server.CreateObject("WScript.Shell")
		Set objWshSysEnv = wsX.Environment("SYSTEM")
		intCpuNum = objWshSysEnv("NUMBER_OF_PROCESSORS")
		strOS = objWshSysEnv("OS")
		strCpuInfo = objWshSysEnv("PROCESSOR_IDENTIFIER")
		Set wsX = Nothing
		Set objWshSysEnv = Nothing
	end if

%>
<table border="0" cellpadding="5" cellspacing="1" width=90% id=CommonListArea align=center>
	<tr id=CommonListTitle>
		<td align="center">项目</td>
		<td width="66%" align="center">值</td>
	</tr>
	<tr id=CommonListCell>
		<td>服务器的域名</td>
		<td width="66%"><%=Request.ServerVariables("server_name")%></td>
	</tr>
	<tr id=CommonListCell>
		<td>服务器的IP地址</td>
		<td width="66%"><%=Request.ServerVariables("LOCAL_ADDR")%>
	</tr>
	<tr id=CommonListCell>
		<td>服务端口</td>
		<td width="66%"><%=Request.ServerVariables("SERVER_PORT")%>
	</tr>
	<tr id=CommonListCell>
		<td>服务器软件</td>
		<td width="66%"><%=Request.ServerVariables("SERVER_SOFTWARE")%>
	</tr>
	<tr id=CommonListCell>
		<td>服务器解译引擎</td>
		<td width="66%"><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %>
	</tr>
	<tr id=CommonListCell>
		<td>服务器操作系统</td>
		<td width="66%"><%=strOS%>
	</tr>
	<tr id=CommonListCell>
		<td>服务器CPU数量</td>
		<td width="66%"><%=intCpuNum%></td>
	</tr>
	<tr id=CommonListCell>
		<td>服务器CPU详情</td>
		<td width="66%"><%=strCpuInfo%></td>
	</tr>
	<tr id=CommonListCell>
		<td>服务器当前时间</td>
		<td width="66%"><%=now()%></td>
	</tr>
	<tr id=CommonListCell>
		<td>脚本连接超时时间</td>
		<td width="66%"><%=Server.ScriptTimeout%> 秒</td>
	</tr>
	<tr id=CommonListCell>
		<td>服务器Application数量</td>
		<td width="66%"><%=Application.contents.Count%><%if Application.contents.Count>0 then Response.Write("<a href='?menu=ShowApplication'>[列表]</a>")%></td>
	</tr>
	<tr id=CommonListCell>
		<td>服务器Session数量</td>
		<td width="66%"><%=Session.contents.Count%><%if Session.contents.Count>0 then Response.Write("<a href='?menu=ShowSession'>[列表]</a>")%></td>
	</tr>
	<tr id=CommonListCell>
		<td>本文件请求的物理路径</td>
		<td width="66%"><%=Request.ServerVariables("path_translated")%>
	</tr>
	<tr id=CommonListCell>
		<td>本文件请求的URL</td>
		<td width="66%">http://<%=Request.ServerVariables("server_name")%><%=Request.ServerVariables("script_name")%></td>
	</tr>
</table>
<%
End Sub

Sub EventLog
	ErrNum=RequestInt("ErrNum")

%>
本记录只保留一个星期

<div style="float:right">
<select onchange="window.location='?menu=EventLog&ErrNum='+this.options[this.selectedIndex].value" size="1">
<option>错误代码索引</option>
<%
	sql="Select DISTINCT ErrNumber from [BBSXP_EventLog] where ErrNumber<>0"
	Set Rs=Execute(sql)
	Do While Not RS.EOF
		SelectedHtml=""
		if Rs("ErrNumber")=ErrNum then	SelectedHtml="selected"
		response.write "<option value="&Rs("ErrNumber")&" "&SelectedHtml&">"&Rs("ErrNumber")&"</option>"
		Rs.MoveNext
	loop
	Rs.close


%></select>
</div>
<table cellspacing=1 width=100% cellpadding=5 id=CommonListArea align=center>
	<tr id=CommonListTitle>
		<td align="center" width="150">操作人</td>
		<td align="center">详细资料</td>
	</tr>
<%
	
	if ErrNum="1" then
		QueryStr="ErrNumber<>0"
	else
		QueryStr="ErrNumber="&ErrNum&""
	end if
	
	Key=Request("Key")
	if Key<>"" then SearchList=" and UserName like '%"&Key&"%' or MessageXML like '%"&Key&"%'"
	TopSql="[BBSXP_EventLog] where "&QueryStr&""&SearchList&""
	TotalCount=Execute("Select count(UserName) From "&TopSql&" ")(0) '获取数据数量
	PageSetup=20 '设定每页的显示数量
	TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '总页数
	PageCount = RequestInt("PageIndex") '获取当前页
	if PageCount <1 then PageCount = 1
	if PageCount > TotalPage then PageCount = TotalPage
	sql=""&TopSql&" order by EventDate Desc"
	if PageCount<11 then
		Set Rs=Execute(sql)
	else
		rs.Open sql,Conn,1
	end if
	if TotalPage>1 then RS.Move (PageCount-1) * pagesetup
	i=0
	Do While Not Rs.EOF and i<PageSetup
		i=i+1
%>
	<tr id=CommonListCell>
		<td valign=top align="center"><br><b><a target="_blank" href="Profile.asp?UserName=<%=Rs("UserName")%>"><%=Rs("UserName")%></a></b><br><br><%=Rs("EventDate")%></td>
		<td>
			<ul>
<%
	
	XMLDOM.loadxml("<bbsxp>"&Rs("MessageXML")&"</bbsxp>")
	Set objnodes=XMLDOM.documentElement.ChildNodes
	for each element in objnodes
		if element.text<>"" then  response.write "<p><li>"&element.nodename&"：<br>"&Replace(UnEscape(element.text),CHR(10),"<br>")&"</li></p>"
	next
%></ul>
		</td>
	</tr>
<%
		Rs.MoveNext
	loop
	Rs.close
%>
</table>
<table cellspacing=1 width=100% align=center>
	<tr>
		<td><%ShowPage()%></td>
		<td align="right"><form action="Admin_Other.asp?menu=EventLog&ErrNum=<%=ErrNum%>" method="POST">
			搜索记录：<input size="15" name="Key" onkeyup="ValidateTextboxAdd(this, 'btnadd')" onpropertychange="ValidateTextboxAdd(this, 'btnadd')" value="<%=Key%>"> <input type="submit" value=" 搜索 " id="btnadd" disabled></form>
		</td>
	</tr>
</table>
<%
End Sub

Sub discreteness
%>
<table border=0 width="90%" cellspacing=1 cellpadding=5 id=CommonListArea align=center>
	<tr id=CommonListTitle>
		<td width="57%">&nbsp;组件名称</td><td width="41%">支持及版本</td>
	</tr>
<%
	Dim theInstalledObjects(17)
	theInstalledObjects(0) = "MSWC.AdRotator"
	theInstalledObjects(1) = "MSWC.BrowserType"
	theInstalledObjects(2) = "MSWC.NextLink"
	theInstalledObjects(3) = "MSWC.Tools"
	theInstalledObjects(4) = "MSWC.Status"
	theInstalledObjects(5) = "MSWC.Counters"
	theInstalledObjects(6) = "MSWC.PermissionChecker"
	theInstalledObjects(7) = "WScript.Shell"
	theInstalledObjects(8) = "Adodb.Connection"	
	theInstalledObjects(9) = "Adodb.Recordset"
	theInstalledObjects(10) = "Adodb.Stream"
	theInstalledObjects(11) = "Microsoft.XMLDOM"	
	theInstalledObjects(12) = "Scripting.Dictionary"
	theInstalledObjects(13) = "Scripting.FileSystemObject"
	theInstalledObjects(14) = "CDO.Message"
	theInstalledObjects(15) = "SoftArtisans.FileUp"
	theInstalledObjects(16) = "JMail.Message"
	theInstalledObjects(17) = "Persits.Jpeg"



	For i=0 to 17
		Response.Write "<TR id=CommonListCell><TD>&nbsp;" & theInstalledObjects(i) & "<font color=888888>&nbsp;"
		select case i
			case 13
				Response.Write "(FSO 文本文件读写)"
			case 14
				Response.Write "(微软 SMTP 服务器)"
			case 15
				Response.Write "(SA-FileUp 文件上传)"
			case 16
				Response.Write "(JMail 邮件发送)"
			case 17
				Response.Write "(ASPJPEG 图像处理)"

		end select
		Response.Write "</font></td><td>"
		If Not IsObjInstalled(theInstalledObjects(i)) Then
			Response.Write "<font color=red><b>×</b></font>"
		Else
			Response.Write "<b>√</b> " & getver(theInstalledObjects(i)) & ""
		End If
		Response.Write "</td></TR>" & vbCrLf
	Next
%>
</table>
<%
End Sub

''''''''''''''''''''''''''''''
Function getver(Classstr)
On Error Resume Next
Set xTestObj = Server.CreateObject(Classstr)
If 0 = Err Then getver=xtestobj.version
Set xTestObj = Nothing
On Error GoTo 0
End Function
''''''''''''''''''''''''''''''
Sub ShowSession
%>
<table border=0 width="90%" cellspacing=1 cellpadding=5 id=CommonListArea align=center>
	<tr id=CommonListTitle>
		<td width="30%">名称</td><td width="70%">值</td>
	</tr>
<%for each sens in Session.Contents%>
	<tr id=CommonListCell>
		<td width="30%"><%=sens%></td>
		<td width="70%">
<%
		if isobject(Session.Contents(sens)) then
			Response.Write "[对象]"
		elseif isarray(Session.Contents(sens)) then
			Response.Write "[数组]"
		else
			Response.Write replace(server.HTMLEncode(Session.Contents(sens)),chr(10),"<br>")
		end if
%>
		</td>
	</tr>
<%next%>
</table>
<%
End Sub


Sub ShowApplication
%>
<table border=0 width="90%" cellspacing=1 cellpadding=5 id=CommonListArea align=center>
	<tr id=CommonListTitle>
		<td width="30%">名称</td><td width="70%">值</td>
	</tr>
<%for each apps in Application.Contents%>
	<tr id=CommonListCell>
		<td width="30%"><%=apps%></td>
		<td width="70%">
<%
		if isobject(Application.Contents(apps)) then
			Response.Write "[对象]"
		elseif isarray(Application.Contents(apps)) then
			Response.Write "[数组]"
		else
			Response.Write replace(server.HTMLEncode(Application.Contents(apps)),chr(10),"<br>")
		end if
%>
		</td>
	</tr>
<%next%>
</table>
<%
End Sub

AdminFooter
%>