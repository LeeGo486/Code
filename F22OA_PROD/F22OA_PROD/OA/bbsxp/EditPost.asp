<!-- #include file="Setup.asp" -->
<%

HtmlTop
if CookieUserName=empty then error("����δ<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>��̳")
ThreadID=RequestInt("ThreadID")
PostID=RequestInt("PostID")
Category=HTMLEncode(Request("Category"))

sql="Select * From [BBSXP_Threads] where ThreadID="&ThreadID&""
Rs.Open sql,Conn,1
	if Rs.eof or Rs.bof then error"<li>ϵͳ�����ڸ����ӵ�����"
	ForumID=Rs("ForumID")
	PostsTableName=Rs("PostsTableName")
	ThreadStyle=Rs("ThreadStyle")
	Topic=Rs("Topic")
	Category=Rs("Category")
	Tags=Rs("Tags")
	ThreadEmoticonID=Rs("ThreadEmoticonID")
Rs.close

sql="Select * from [BBSXP_Forums] where ForumID="&ForumID&""
Set Rs=Execute(sql)
	ForumName=Rs("ForumName")
	Moderated=Rs("Moderated")
	ParentID=Rs("ParentID")
	GroupID=Rs("GroupID")
	TotalCategorys=Rs("TotalCategorys")
Rs.close
%>

<!-- #include file="Utility/ForumPermissions.asp" -->

<%
if PermissionEdit=0 then error("����<a href=ShowForumPermissions.asp?ForumID="&ForumID&">Ȩ��</a>����")
sql="Select * from [BBSXP_Posts"&PostsTableName&"] where PostID="&PostID&""
Set Rs=Execute(sql)
	if Rs.eof or Rs.bof then error"<li>ϵͳ�����ڸ����ӵ�����"
	if Rs("PostAuthor")<>CookieUserName and PermissionManage=0 then error("�Բ�������Ȩ�޲�����")	
	if SiteConfig("PostEditBodyAgeInMinutes")>0 and DateDiff("n", Rs("PostDate"), now())> SiteConfig("PostEditBodyAgeInMinutes") then error"<li>���ӷ��� "&SiteConfig("PostEditBodyAgeInMinutes")&" ����֮�������ٴα��༭"
	Subject=ReplaceText(""&Rs("Subject")&"","<[^>]*>","")
	Body=Rs("Body")
	PostParentID=Rs("ParentID")
Rs.close



'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
if Request.ServerVariables("Request_method") = "POST" then
	Subject=HTMLEncode(Request.Form("PostSubject"))
	Body=BodyEncode(Request.Form("Body"))
	Category=HTMLEncode(Request.Form("Category"))
	Tags=HTMLEncode(Request.Form("Tags"))
	ThreadEmoticonID=RequestInt("ThreadEmoticonID")
	if PermissionManage=1 then ThreadStyle=BodyEncode(Request.Form("ThreadStyle"))
	


	if Request.Form("DisableYBBCode")<>1 then Body=YbbEncode(Body)
	if PostParentID=0 then
		if Len(Subject)<2 then Message=Message&"<li>�������ⲻ��С�� 2 �ַ�"
	end if
	if Len(Body)<2 then Message=Message&"<li>�������ݲ���С�� 2 �ַ�"
	if len(Tags)>255 then Message=Message&"<li>��ǩ���ܴ���255�ַ�"

	if SiteConfig("DisplayEditNotes")=1 then Body=""&Body&"<p>�۴������ѱ� "&CookieUserName&" �� "&now()&" �༭����"
	if Message<>"" then error(""&Message&"")
	sql="Select * from [BBSXP_Posts"&PostsTableName&"] where PostID="&PostID&""
	Rs.Open sql,Conn,1,3
		if Rs("ParentID")=0 then Execute("update [BBSXP_Threads] Set ThreadStyle='"&ThreadStyle&"',Topic='"&Subject&"',Category='"&Category&"',ThreadEmoticonID="&ThreadEmoticonID&",Tags='"&Tags&"' where ThreadID="&Rs("ThreadID")&"")
		Rs("Subject")=Subject
		Rs("Body")=Body
	Rs.update
	Rs.close
	if Request.Form("UpFileID")<>"" then
		UpFileID=split(Request.Form("UpFileID"),",")
		for i = 0 to ubound(UpFileID)-1
			Execute("update [BBSXP_PostAttachments] Set Description='"&Subject&"' where UpFileID="&int(UpFileID(i))&" and UserName='"&CookieUserName&"'")
		next
	end if
	Log("�޸����ӳɹ������⣺"&Subject&"������ID��"&ThreadID&"������ID��"&PostID&"")
	Message="<li>�޸����ӳɹ�<li><a href=ShowPost.asp?ThreadID="&ThreadID&">��������</a><li><a href=ShowForum.asp?ForumID="&	ForumID&">������̳</a>"
	succeed Message,"ShowForum.asp?ForumID="&ForumID&""
end if
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� <%=ForumTree(ParentID)%> <a href=ShowForum.asp?ForumID=<%=ForumID%>><%=ForumName%></a> �� <a href="ShowPost.asp?ThreadID=<%=ThreadID%>"><%=Topic%></a> �� �༭����</div>

<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
<form name="form" method="post" onSubmit="return CheckForm(this);">
<input name="Body" type="hidden" value='<%=server.htmlencode(Body)%>'>
<input name="UpFileID" type="hidden">
<input name="ThreadStyle" id="ThreadStyle" type="hidden" value='<%=ThreadStyle%>'>

	<TR id=CommonListTitle>
		<TD colSpan=2>�༭����</TD>
	</TR>
	<TR id=CommonListCell>
		<TD width="180"><B>����</B><%if PermissionManage=1 and PostParentID=0 then%>��<a href="javascript:BBSXP_Modal.Open('Utility/SelectStyle.htm',500,420);">����</a>��<%end if%></TD>
		<TD><INPUT type="text" maxLength="50" size="60" name="PostSubject" value='<%=Subject%>' <%if PostParentID=0 then%>id="Subject" style="<%=ThreadStyle%>"<%end if%>></TD>
	</TR>

<%	if PostParentID=0 then%>
	<tr id=CommonListCell>
		<td><B>���</B></td>
		<td>
		<SELECT name=Category size=1>
		<OPTION value="" selected>��</OPTION>
		<OPTION value="<%=Category%>" selected><%=Category%></OPTION>
<%
		if TotalCategorys<>empty then
			filtrate=split(TotalCategorys,"|")
			for i = 0 to ubound(filtrate)
				response.write "<OPTION value='"&filtrate(i)&"'>"&filtrate(i)&"</OPTION>"
			next
		end if
%>
		</SELECT> <a href="javascript:BBSXP_Modal.Open('Utility/AddCategory.htm', 500, 100);">������</a>
		</TD>
	</TR>

	<TR id=CommonListCell>
		<TD vAlign=top align=Left><B>����</B></TD>
		<TD><INPUT type=radio value=0 name=ThreadEmoticonID checked>��<br>
		<script language="JavaScript">
		for(i=1;i<=30;i++) {
			if (i ==<%=ThreadEmoticonID%>){IsChecked="checked"}else{IsChecked=""}
			document.write("<INPUT type=radio value="+i+" name=ThreadEmoticonID "+IsChecked+"><IMG src=images/Emoticons/"+i+".gif >��")
			if (i ==10 || i ==20){document.write("<br>")}
		}
		</script></TD>
	</TR>
		
<%	end if%>

	<TR id=CommonListCell>
		<TD vAlign=top>
			<br><B>����</B><BR>��<a href="javascript:CheckLength();">�鿴���ݳ���</a>��<BR><BR><INPUT id=DisableYBBCode name=DisableYBBCode type=checkbox value=1><label for=DisableYBBCode> ����YBB����</label>
			<%if SiteConfig("UpFileOption")<>empty and PermissionAttachment=1 then%>
						<BR><BR><span id=UpFile></span><a href="javascript:BBSXP_Modal.Open('UploadAttachment.asp',500,150);" class="CommonTextButton">�ϴ�����</a>
			<%end if%>
		</TD>
		<TD height=250><SCRIPT type="text/javascript" src="Editor/Post.js"></SCRIPT></TD>
	</TR>
<%if SiteConfig("DisplayPostTags")=1 and PostParentID=0 then%>
	<TR id=CommonListCell>
		<TD><b>��ǩ<br></b>�Զ��š�,���ָ�</TD>
		<TD><input type="text" name="Tags" size="80" value="<%=Tags%>" /></TD>
	</TR>
<%end if%>
	<TR id=CommonListCell>
		<TD align=center colSpan=2><INPUT type=submit value=" ���� " name=EditSubmit>��<input type="Button" value=" Ԥ�� " onclick="Preview()">��<INPUT onclick="history.back()" type="button" value=" ȡ�� "></TD>
	</TR>
</FORM>
</TABLE>
<div name="Preview" id="Preview"></div>
<%
HtmlBottom
%>