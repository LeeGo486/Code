<!-- #include file="Setup.asp" --><%


ThreadID=RequestInt("ThreadID")

Set rs=Execute("Select * From [BBSXP_Threads] where ThreadID="&ThreadID)
if Rs.Eof then error("ϵͳ�����ڴ�����")
ForumID=Rs("ForumID")
Topic=Rs("Topic")
PostAuthor=Rs("PostAuthor")
TotalReplies=Rs("TotalReplies")
Rs.close

sql="Select * from [BBSXP_Forums] where ForumID="&ForumID&""
Set Rs=Execute(sql)
	ForumName=Rs("ForumName")
	ParentID=Rs("ParentID")
	GroupID=Rs("GroupID")
	Moderated=Rs("Moderated")
Rs.close
%>
<!-- #include file="Utility/ForumPermissions.asp" -->
<%
if PermissionManage=0 then error("����<a href=ShowForumPermissions.asp?ForumID="&ForumID&">Ȩ��</a>����")

HtmlTop


%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� <%=ForumTree(ParentID)%><a href="ShowForum.asp?ForumID=<%=ForumID%>"><%=ForumName%></a> �� <a href="ShowPost.asp?ThreadID=<%=ThreadID%>"><%=Topic%></a> �� �ƶ�����</div>

<form name=form method="POST" action="Manage.asp" onsubmit="return VerifyInput();">
	<input type="hidden" value="Move" name="menu">
	<input type="hidden" value="<%=ThreadID%>" name="ThreadID">
	<table cellspacing="1" cellpadding="5" width=100% id=CommonListArea>
		<tr id=CommonListTitle>
			<td align="center" colspan=2>�ƶ�����</td>
		</tr>
		<tr id=CommonListCell>
			<td align="right" width=30%>�����⣺</td>
			<td><%=Topic%></td>
		</tr>
		<tr id=CommonListCell>
			<td align="right">�����ߣ�</td>
			<td><%=PostAuthor%></td>
		</tr>
		<tr id=CommonListCell>
			<td align="right">�ظ�����</td>
			<td><%=TotalReplies%></td>
		</tr>
		<tr id=CommonListCell>
			<td align="right">�ƶ�����</td>
			<td>
			<select name="AimForumID" size=10 style="width:300px"><%=GroupList(0)%></select>
			</td>
		</tr>
		<tr id=CommonListCell>
			<td colspan=2 align=center><input type="submit" value=" ȷ �� ">����<input onclick="history.back()" type="button" value=" �� �� "></td>
		</tr>
	</table>
</form>

<script language="JavaScript">
function VerifyInput()
{
	if (document.form.AimForumID.value == "")
	{
		alert("��ѡ����Ҫ�ƶ����ĸ���̳");
		document.form.AimForumID.focus();
		return false;
	}
}
</SCRIPT>
<%
HtmlBottom
%>