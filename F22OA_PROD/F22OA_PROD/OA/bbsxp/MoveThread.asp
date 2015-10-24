<!-- #include file="Setup.asp" --><%


ThreadID=RequestInt("ThreadID")

Set rs=Execute("Select * From [BBSXP_Threads] where ThreadID="&ThreadID)
if Rs.Eof then error("系统不存在此主题")
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
if PermissionManage=0 then error("您的<a href=ShowForumPermissions.asp?ForumID="&ForumID&">权限</a>不够")

HtmlTop


%>
<div id="CommonBreadCrumbArea"><%ClubTree%> → <%=ForumTree(ParentID)%><a href="ShowForum.asp?ForumID=<%=ForumID%>"><%=ForumName%></a> → <a href="ShowPost.asp?ThreadID=<%=ThreadID%>"><%=Topic%></a> → 移动主题</div>

<form name=form method="POST" action="Manage.asp" onsubmit="return VerifyInput();">
	<input type="hidden" value="Move" name="menu">
	<input type="hidden" value="<%=ThreadID%>" name="ThreadID">
	<table cellspacing="1" cellpadding="5" width=100% id=CommonListArea>
		<tr id=CommonListTitle>
			<td align="center" colspan=2>移动帖子</td>
		</tr>
		<tr id=CommonListCell>
			<td align="right" width=30%>主　题：</td>
			<td><%=Topic%></td>
		</tr>
		<tr id=CommonListCell>
			<td align="right">作　者：</td>
			<td><%=PostAuthor%></td>
		</tr>
		<tr id=CommonListCell>
			<td align="right">回复数：</td>
			<td><%=TotalReplies%></td>
		</tr>
		<tr id=CommonListCell>
			<td align="right">移动到：</td>
			<td>
			<select name="AimForumID" size=10 style="width:300px"><%=GroupList(0)%></select>
			</td>
		</tr>
		<tr id=CommonListCell>
			<td colspan=2 align=center><input type="submit" value=" 确 定 ">　　<input onclick="history.back()" type="button" value=" 返 回 "></td>
		</tr>
	</table>
</form>

<script language="JavaScript">
function VerifyInput()
{
	if (document.form.AimForumID.value == "")
	{
		alert("请选择您要移动到哪个论坛");
		document.form.AimForumID.focus();
		return false;
	}
}
</SCRIPT>
<%
HtmlBottom
%>