<!-- #include file="Setup.asp" -->
<%
HtmlTop
if CookieUserName=empty then error("您还未<a href=Login.asp?ReturnUrl="&ReturnUrl&">登录</a>论坛")
ForumID=RequestInt("ForumID")


if ForumID>0 then
	sql="Select * from [BBSXP_Forums] where ForumID="&ForumID&""
	Set Rs=Execute(sql)
		ParentID=Rs("ParentID")
		GroupID=Rs("GroupID")
		ForumName=Rs("ForumName")
		Moderated=Rs("Moderated")
		TotalCategorys=Rs("TotalCategorys")
	Rs.close
	
	ForumSql=" and ForumID="&ForumID
	ForumListStr=" → "&ForumTreeList&" <a href='ShowForum.asp?ForumID="&ForumID&"'>"&ForumName&"</a>"
	
	
	filtrate=split(""&TotalCategorys&"","|")
	for i = 0 to ubound(filtrate)
		TotalCategorysOptionList=TotalCategorysOptionList&"<option value="&filtrate(i)&">"&filtrate(i)&"</option>"
	next

%><!-- #include file="Utility/ForumPermissions.asp" --><%
	if PermissionManage=0 then error("您的<a href=ShowForumPermissions.asp?ForumID="&ForumID&">权限</a>不够")
elseif BestRole=1 then
	ForumSql=""
	ForumListStr=""
else
	error("你的权限不够！")
end if

if Request.ServerVariables("Request_method") = "POST" then

select case Request.Form("Item")
	case "BatchDel"
		IsDel=RequestInt("IsDel")
		for each ho in Request.Form("ThreadID")
			ho=int(ho)
			Execute("update [BBSXP_Threads] Set IsDel="&IsDel&",lasttime="&SqlNowString&",lastname='"&CookieUserName&"' where ThreadID="&ho&ForumSql&"")
		next
		
		succtitle="批量删除，主题ID："&Request.Form("ThreadID")&""


	case "BatchApproved"
		IsApproved=RequestInt("IsApproved")
		for each ho in Request.Form("ThreadID")
			ho=int(ho)
			Execute("update [BBSXP_Threads] Set IsApproved="&IsApproved&",lasttime="&SqlNowString&",lastname='"&CookieUserName&"' where ThreadID="&ho&ForumSql&"")
		next
		
		succtitle="批量审核，主题ID："&Request.Form("ThreadID")&""


	case "BatchGOOD"
		IsGooD=RequestInt("IsGooD")
		for each ho in Request.Form("ThreadID")
			ho=int(ho)
			Execute("update [BBSXP_Threads] Set IsGooD="&IsGooD&",lasttime="&SqlNowString&" where ThreadID="&ho&ForumSql&"")
		next
		
		succtitle="批量精华，主题ID："&Request.Form("ThreadID")&""


	case "BatchLocked"
		IsLocked=RequestInt("IsLocked")
		for each ho in Request.Form("ThreadID")
			ho=int(ho)
			Execute("update [BBSXP_Threads] Set IsLocked="&IsLocked&",lasttime="&SqlNowString&" where ThreadID="&ho&ForumSql&"")
		next
		
		succtitle="批量锁定，主题ID："&Request.Form("ThreadID")&""

		
	case "BatchCategory"
		Category=HTMLEncode(Request.Form("Category"))
		for each ho in Request.Form("ThreadID")
			ho=int(ho)
			Execute("update [BBSXP_Threads] Set Category='"&Category&"',lasttime="&SqlNowString&" where ThreadID="&ho&ForumSql&"")
		next

		succtitle="批量类别，主题ID："&Request.Form("ThreadID")&""


	case "BatchMoveTopic"
		AimForumID=RequestInt("AimForumID")
		if AimForumID=0 then error("您没有选择要将主题移动到哪个论坛")
		for each ho in Request.Form("ThreadID")
			ho=int(ho)
			Execute("update [BBSXP_Threads] Set ForumID="&AimForumID&",ThreadTop=0,IsGood=0,IsLocked=0 where ThreadID="&ho&ForumSql&"")
		next
		
		succtitle="批量移动，主题ID："&Request.Form("ThreadID")&""
		
	case "ClearRecycle"
		if BestRole <> 1 then error("您的权限不够")
		TimeLimit=RequestInt("TimeLimit")
		if TimeLimit < 1 then error("只能清空24小时之前的文章")
		
		Execute("Delete from [BBSXP_Threads] where IsDel=1 and DateDiff("&SqlChar&"d"&SqlChar&",lasttime,"&SqlNowString&") > "&TimeLimit&"")
		
		succtitle="清空回收站内 "&TimeLimit&" 天以前的主题！"

end select


if succtitle="" then error("无效指令")

if ForumID>0 then UpForumMostRecent(ForumID)

Log(""&succtitle&"")
succeed succtitle,""

end if



	if Request("menu")="Censorship" then
		sql="[BBSXP_Threads] where IsApproved=0 and IsDel=0"&ForumSql&""
		ForumTitle="主题审核"
	elseif Request("menu")="Recycle" then
		sql="[BBSXP_Threads] where IsDel=1"&ForumSql&""
		ForumTitle="回收站"
	else
		sql="[BBSXP_Threads] where IsApproved=1 and IsDel=0"&ForumSql&""
		ForumTitle="主题管理"
	end if


%>
<div id="CommonBreadCrumbArea"><%ClubTree%><%=ForumListStr%> → <a href="?menu=<%=Request("menu")%>&ForumID=<%=ForumID%>&checkbox=1"><%=ForumTitle%></a></div>

<table cellspacing="1" cellpadding="5" width="100%" id="CommonListArea">
<form method="POST" action="Moderation.asp" onsubmit="return VerifyRadio('Item');">
<input type="hidden" name="ForumID" value="<%=ForumID%>">
	<tr id="CommonListTitle">
		<td colspan="5">主题</td>
	</tr>
	<tr id="CommonListHeader" align="center">
		<td>标题</td>
		<td>作者</td>
		<td>回复</td>
		<td>查看</td>
		<td>最后更新</td>
	</tr>
<%

	TotalCount=Execute("Select count(ThreadID) From "&sql&" ")(0) '获取数据数量
	PageSetup=SiteConfig("ThreadsPerPage") '设定每页的显示数量
	TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '总页数
	PageCount = RequestInt("PageIndex") '获取当前页
	if PageCount <1 then PageCount = 1
	if PageCount > TotalPage then PageCount = TotalPage

	sql="Select * from "&sql&" order by lasttime Desc"
	if PageCount<11 then
		Set Rs=Execute(sql)
	else
		rs.Open sql,Conn,1
	end if
	if TotalPage>1 then RS.Move (PageCount-1) * pagesetup
	i=0
	Do While Not RS.EOF and i<PageSetup
		i=i+1
		ShowThread()
		Rs.MoveNext
	loop
	Rs.Close
%>
	<tr id="CommonListCell">
		<td colspan="5">
		<input type="checkbox" name="chkall" onclick="CheckAll(this.form)" value="ON">全选
		<input type="radio" value="BatchDel" name="Item"><select name="IsDel">
		<option value="1">删除帖子</option>
		<option value="0">还原帖子</option>
		</select>
		
		
		<input type="radio" value="BatchApproved" name="Item"><select name="IsApproved">
		<option value="1">审核通过</option>
		<option value="0">审核失败</option>
		</select>
		
		<input type="radio" value="BatchGOOD" name="Item"><select name="IsGOOD">
		<option value="1">加入精华</option>
		<option value="0">取消精华</option>
		</select>
		
		<input type="radio" value="BatchLocked" name="Item"><select name="IsLocked">
		<option value="1">主题锁定</option>
		<option value="0">主题解锁</option>
		</select>

		
		<input type="radio" value="BatchCategory" name="Item"><select name="Category">
		<option value="">更改类别</option>
		<%=TotalCategorysOptionList%>
		<option value="">取消类别</option>
		</select>
		
		<input type="radio" value="BatchMoveTopic" name="Item"><select name="AimForumID">
		<option value="0">移动到以下论坛</option>
		<%=GroupList(0)%></select>&nbsp;
		<input onclick="return window.confirm('您确定执行本次操作?');" type="submit" value=" 执 行 ">
		</td>
	</tr>
</form>
</table>
<table border="0" width="100%" align="center">
	<tr>
		<td valign="top"><%ShowPage()%></td>
		
		<%if Request("menu")="Recycle" and BestRole = 1 then%>
		<form name="form" method="POST" action="Moderation.asp"><input type="hidden" name="Item" value="ClearRecycle">
		<td align="right">
			清空 <input size="1" value="7" name="TimeLimit"> 天以前删除的主题 <input type="submit" onclick="return window.confirm('执行本操作将清空回收站的主题?');" value="确定">
		</td>
		</form>
		<%end if%>
	</tr>
</table>
<script language="JavaScript">
function VerifyRadio() {
	objYN=false;

	for (i=0;i<document.getElementsByName("ThreadID").length;i++) {
	if (document.getElementsByName("ThreadID")[i].checked) {objYN= true;}
	}
	
	if (objYN==false) {alert ('请选择您要操作的主题！');return false;}




	objYN=false;

	for (i=0;i<document.getElementsByName("Item").length;i++) {
	if (document.getElementsByName("Item")[i].checked) {objYN= true;}
	}
	
	if (objYN==false) {alert ('请选择您要操作的项目！');return false;}


}
</SCRIPT>

<%
HtmlBottom
%>