<!--#include file="Conn.asp"-->
<%
	if SiteConfig("SiteDisabled")=1 Then ConciseMsg("ά���У�ϵͳ��ʱ�رգ����Ժ���ʣ�")
	ForumID=RequestInt("ForumID")
	ThreadID=RequestInt("ThreadID")
	dim ForumNavList
	
	If ForumID>0 Then
		set Rs=Execute("Select ForumName,ForumUrl,IsActive From [BBSXP_Forums] where ForumID="&ForumID&"")
			if Rs.eof then ConciseMsg"�Ҳ����ð�������"
			ForumName=Rs("ForumName")
			IsActive=Rs("IsActive")
			ForumUrl=Rs("ForumUrl")
		Rs.close
		FroumNameTitle=ForumName&"_"
		FroumNameBottom="<a href=ShowForum.asp?ForumID="&ForumID&">"&ForumName&"</a>"
		ForumNav 0,ForumID
	ElseIf ThreadID>0 Then
		Set Rs=Execute("Select * from [BBSXP_Threads] where ThreadID="&ThreadID&" and IsApproved=1 and IsDel=0")
			if Rs.eof then ConciseMsg"�Ҳ��������������"
			Topic=Rs("Topic")
			ForumID=Rs("ForumID")
			PostTableName=Rs("PostsTableName")
		Rs.close
		set Rs=Execute("Select ForumName,ForumUrl,IsActive From [BBSXP_Forums] where ForumID="&ForumID&"")
			ForumName=Rs("ForumName")
			IsActive=Rs("IsActive")
			ForumUrl=Rs("ForumUrl")
		Rs.close
		FroumNameTitle=ForumName&"_"
		FroumNameBottom="<a href=ShowPost.asp?ThreadID="&ThreadID&">"&Topic&"</a>"
		TopicTitle=Topic&"_"
		TopicNav=" �� "&Topic
		ForumNav 0,ForumID
	End If
	if ForumUrl<>"" then response.redirect ForumUrl
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=TopicTitle&FroumNameTitle&SiteConfig("SiteName")%></title>
<style type="text/css">
	body{FONT-SIZE:9pt;word-break:break-all;}	/* �����С */
	h3 { margin:5px; padding:0px; font-size:1em}
	BLOCKQUOTE {BORDER: #cccccc 1px dotted; PADDING: 4px; MARGIN: 16px;}
	
	.WAP { margin: 0px auto 0px; width: 100%;}
	.ForumList { padding: 0 1em 0 1em; line-height: 1.6em;}
	.ForumList ul { padding-left: 1em; }
	
	.ThreadList { line-height: 1.6em;}
	.ThreadList li { padding-left: 5px; }
	.ThreadList li em { color: #999; font-style:normal}

	.PostList { border: 1px solid silver; padding: 1px;margin: 0px auto 10px;  line-height: 1.6em;}
	.PostTop { padding: 4px; background: #EEEEEE; line-height: 1.6em;}
	.PostAuthor { font-weight: bold; width: auto; float: left;}
	.PostTime { width: auto; text-align:right;}
	.PostBody { padding: 4px; background: #F9F9F9;}
</style>
</head>

<body>
<div class="WAP">
	<div style="padding:10px; border: 1px solid silver;">
		<a href="?"><%=SiteConfig("SiteName")%></a><%=ForumNavList&TopicNav%>
	</div>
	<div style="padding:10px;">
		<b>�鿴�����汾��<%If FroumNameBottom<>empty then Response.Write(FroumNameBottom) Else Response.Write("<a href='default.asp'>"&SiteConfig("SiteName")&"</a>") End If%></b>
	</div>
	<%
	if RequestInt("ForumID")>0 then
			ShowThread
	elseif RequestInt("ThreadID")>0 then
			ShowPost
	else
			Default
	end if
	%>
</div>

<div style="padding:10px; text-align:center">
	Powered by <a target="_blank" href="http://www.bbsxp.com/"><%=ForumsProgram%></a> &copy; 1998-<%=year(now)%>
	<%
	ProcessTime=FormatNumber((timer()-startime))
	if ProcessTime<1 then ProcessTime="0"&ProcessTime
	response.write("<br>Processed in "&ProcessTime&" second(s)")
	%>
</div>
</body>
</html>

<%
Sub ShowThread
	%><!-- #include file="Utility/ForumPermissions.asp" --><%
	if IsActive=0 and PermissionManage=0 then ConciseMsg"<li>�ð���Ѿ��رգ�"
	if PermissionView=0 then ConciseMsg("����Ȩ�޲���")
	
	TotalCount=Execute("Select count(ThreadID) From [BBSXP_Threads] where ForumID="&ForumID&" and IsApproved=1 and IsDel=0")(0) '��ȡ��������
	PageSetup=250									'�趨ÿҳ����ʾ����
	TotalPage=Abs(Int(TotalCount/PageSetup*(-1)))	'��ҳ��
	PageCount = RequestInt("PageIndex")				'��ȡ��ǰҳ
	if PageCount <1 then PageCount = 1
	if PageCount > TotalPage then PageCount = TotalPage
	
	Sql="Select ThreadID,Topic,TotalReplies From [BBSXP_Threads] where ForumID="&ForumID&" and IsApproved=1 and IsDel=0 order by ThreadID desc"

	Set Rs=Execute(sql)

	if TotalPage>1 then RS.Move (PageCount-1) * PageSetup

	If Rs.Eof Then Rs.close:Exit Sub
	ThreadGetRow=Rs.GetRows(PageSetup)
	StartNum=PageSetup*(PageCount-1)+1

	Rs.Close
	
	Response.write("<div style='padding:10px; border: 1px solid silver;'>")
	
	Response.Write("<ul class='ThreadList'><ol start='"&StartNum&"'>"&vbcrlf)
	For i=0 to Ubound(ThreadGetRow,2)
		Response.Write("<li><a href='?ThreadID="&ThreadGetRow(0,i)&"'>"&ThreadGetRow(1,i)&"</a> <em>("&ThreadGetRow(2,i)&"ƪ�ظ�)</em></li>"&vbcrlf)
	Next
	Response.Write("</ol></ul></div>"&vbcrlf)
	
	if TotalPage>1 then
		PageStr=ShowPage("?ForumID="&ForumID,TotalPage,PageCount)
		Response.Write("<div style='padding:10px; line-height:1.2; text-align:center'>"&PageStr&"</div>")
	end if
End Sub

Sub ShowPost
	%><!-- #include file="Utility/ForumPermissions.asp" --><%
	if IsActive=0 and PermissionManage=0 then ConciseMsg"<li>�ð���Ѿ��رգ�"
	if PermissionRead=0 then ConciseMsg"<li>��û��Ȩ���Ķ�����"
	
	Sql="Select PostAuthor,PostDate,Body From [BBSXP_Posts"&PostTableName&"] where ThreadID="&ThreadID&" order by PostID"

	Rs.Open sql,Conn,1
	If Rs.Eof Then Rs.close:Exit Sub
	PostGetRow=Rs.GetRows()
	Rs.Close
	For i=0 to Ubound(PostGetRow,2)
		Response.Write("<div class=PostList>" & vbCrlf)
		Response.Write("<div class=PostTop><div class=PostAuthor>"&PostGetRow(0,i)&"</div><div class=PostTime>"&PostGetRow(1,i)&"</div></div>" & vbCrlf)
		Response.Write("<div class=PostBody>"&PostGetRow(2,i)&"</div>" & vbCrlf)
		Response.Write("" & vbCrlf)
		Response.Write("</div>" & vbCrlf)

	Next
End Sub

Sub Default
	Response.write("<div style='border: 1px solid silver;'>")
	Response.Write("<ul class='ForumList'>")
	sql="Select GroupID,GroupName From [BBSXP_Groups] where SortOrder>0 order by SortOrder"
	Set Rs=Execute(sql)
	if Rs.eof then Rs.close:exit sub
	GroupGetRow=Rs.GetRows()
	Rs.close
	for i=0 to Ubound(GroupGetRow,2)
		Response.Write("<li><h3>"&GroupGetRow(1,i)&"</h3><ul>" & vbCrlf)
		ForumListTree GroupGetRow(0,i),0
		Response.Write "</ul></li>" & vbCrlf
	next
	Response.Write("</ul>")
	Response.Write("</div>" & vbCrlf)
End Sub

Sub ForumListTree(GroupID,ParentID)
	if ParentID=0 then
		sql="GroupID="&GroupID&" and ParentID=0"
	else
		sql="ParentID="&GroupID&""
	end if
	sql="Select ForumID,ForumName From [BBSXP_Forums] where "&sql&" and SortOrder>0 and IsActive=1 order by SortOrder"

	Set Rs=Execute(sql)
	
	if Rs.eof then Rs.close:exit sub
	ForumGetRow=Rs.getRows()
	Rs.close
	for j=0 to Ubound(ForumGetRow,2)
		if Execute("Select ForumID from [BBSXP_Forums] where ParentID="&ForumGetRow(0,j)&"").eof then
			Response.Write("<li><a href=?ForumID="&ForumGetRow(0,j)&">"&ForumGetRow(1,j)&"</a></li>" & vbCrlf)
			ForumListTree ForumGetRow(0,j),1
		else
			Response.Write("<li><a href=?ForumID="&ForumGetRow(0,j)&">"&ForumGetRow(1,j)&"</a>" & vbCrlf)
			Response.write("<ul>" & vbCrlf)
			ForumListTree ForumGetRow(0,j),1
			Response.Write "</ul>" & vbCrlf
			Response.Write "</li>" & vbCrlf
		end if
	next
End Sub

Function ShowPage(URL,TotalPage,CurrentPage)
	ShowPage=""
	if CurrentPage>TotalPage then Exit Function
	
	for i=1 to TotalPage
		if i<1 or i>TotalPage then exit for
		if i=CurrentPage then
			ShowPage=ShowPage&"["&i&"]"&vbcrlf
		else
			ShowPage=ShowPage&"<a href='"&URL&"&PageIndex="&i&"'>"&i&"</a>"&vbcrlf
		end if
	next
End Function
	
Sub ForumNav(GroupID,ForumID)
	If GroupID>0 then
		ForumNavList=" �� "&ForumNavList
		Exit Sub
	ElseIf ForumID>0 then
		Set Rs1=Execute("Select * From [BBSXP_Forums] where ForumID="&ForumID&"")
		If ""&ForumNavList&""="" then
			ForumNavList="<a href='?ForumID="&ForumID&"'>"&Rs1("ForumName")&"</a>"
		Else
			ForumNavList="<a href='?ForumID="&ForumID&"'>"&Rs1("ForumName")&"</a> �� "&ForumNavList
		End If
		If Rs1("ParentID")>0 then
			ForumNav 0,Rs1("ParentID")
		Else
			ForumNav Rs1("GroupID"),0
		End If
		Rs1.Close
	End If
End Sub

%>