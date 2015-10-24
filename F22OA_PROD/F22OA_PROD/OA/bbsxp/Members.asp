<!-- #include file="Setup.asp" -->
<%
HtmlTop

if SiteConfig("PublicMemberList")=0 then error("系统已禁止显示成员列表。")

if SiteConfig("MemberListAdvancedSearch")=1 then
	SearchType=HTMLEncode(Request("SearchType"))
	SearchText=HTMLEncode(Request("SearchText"))
	SearchRole=HTMLEncode(Request("SearchRole"))
	CurrentAccountStatus=HTMLEncode(Request("CurrentAccountStatus"))
	JoinedDateComparer=Left(Request("JoinedDateComparer"),1)
	LastPostDateComparer=Left(Request("LastPostDateComparer"),1)
	JoinedDate_picker=HTMLEncode(Request("JoinedDate_picker"))
	LastPostDate_picker=HTMLEncode(Request("LastPostDate_picker"))
	
	if SearchType="all" then SearchType="UserEmail like '%"&SearchText&"%' or UserName"
	if SearchText<>"" then item=item&" and ("&SearchType&" like '%"&SearchText&"%')"
	if JoinedDate_picker<>"" and JoinedDateComparer<>"" then item=item&" and DateDiff("&SqlChar&"d"&SqlChar&",'"&JoinedDate_picker&"',UserRegisterTime) "&JoinedDateComparer&" 0"
	if LastPostDate_picker<>"" and LastPostDateComparer<>"" then item=item&" and DateDiff("&SqlChar&"d"&SqlChar&",'"&LastPostDate_picker&"',UserActivityTime) "&LastPostDateComparer&" 0"
	if SearchRole <> "" then item=item&" and UserRoleID="&SearchRole&""
	if CurrentAccountStatus <> "" then item=item&" and UserAccountStatus="&CurrentAccountStatus&""

	if item<>"" then item=" where "&mid(item,5)
end if

%>
<SCRIPT type="text/javascript" src="Utility/calendar.js"></SCRIPT>


<div id="CommonBreadCrumbArea"><%ClubTree%> → <a href="?">成员列表</a></div>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<TR align=center id=CommonListTitle>
		<TD><a href="?MemberSortDropDown=UserName">用户名</a></TD>
		<TD><a href="?MemberSortDropDown=UserRoleID">角色</a></TD>
		<TD>短讯息</TD>
		<TD><a href="?MemberSortDropDown=UserRegisterTime">注册时间</a></TD>
		<TD><a href="?MemberSortDropDown=Reputation">声望</a></TD>
		<TD><a href="?MemberSortDropDown=TotalPosts">发帖数</a></TD>
		<TD><a href="?MemberSortDropDown=UserMoney">金币</a></TD>
		<TD><a href="?MemberSortDropDown=experience">经验值</a></TD>
		<TD><a href="?MemberSortDropDown=UserActivityTime">最后活动时间</a></TD>
	</TR>
<%
MemberSortDropDown=HTMLEncode(Request("MemberSortDropDown"))
SortOrderDropDown=HTMLEncode(Request("SortOrderDropDown"))
if Len(MemberSortDropDown)>20 then error("非法操作")

if SortOrderDropDown="" then SortOrderDropDown="Desc"
if MemberSortDropDown<>"" then SqlOrder=" order by "&MemberSortDropDown&" "&SortOrderDropDown
if MemberSortDropDown="UserRoleID" then SqlOrder=" order by "&MemberSortDropDown&""

TotalCount=Execute("Select count(UserID) From [BBSXP_Users]"&item)(0) '获取数据数量
PageSetup=SiteConfig("MemberListPageSize") '设定每页的显示数量
TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '总页数
PageCount = RequestInt("PageIndex") '获取当前页
if PageCount <1 then PageCount = 1
if PageCount > TotalPage then PageCount = TotalPage

sql="Select * from [BBSXP_Users] "&item&" "&SqlOrder&""

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
	<TR align=center id=CommonListCell>
		<TD><a href=Profile.asp?UserName=<%=Rs("UserName")%>><%=Rs("UserName")%></a></TD>
		<TD><%=ShowRole(RS("UserRoleID"))%></TD>
		<TD><%if CookieUserName<>empty then%><a href="javascript:BBSXP_Modal.Open('MyMessage.asp?menu=Post&RecipientUserName=<%=Rs("UserName")%>',600, 350);"><img border="0" src="images/message.gif"></a><%end if%></TD>
		<TD><%=Rs("UserRegisterTime")%></TD>
		<TD><%=Rs("Reputation")%></TD>
		<TD><%=Rs("TotalPosts")%></TD>
		<TD><%=Rs("UserMoney")%></TD>
		<TD><%=Rs("experience")%></TD>
		<TD><%=Rs("UserActivityTime")%></TD>
		</TR>
<%
Rs.MoveNext
loop
Set Rs=Nothing
%>
</TABLE>
<table cellspacing=0 cellpadding=0 border=0 width=100%>
<tr>
	<td><%ShowPage()%></td>
<%if SiteConfig("MemberListAdvancedSearch")=1 then%>	
	<td align="right">
		<a onmousedown="ToggleMenuOnOff('ForumOption')" class="CommonImageTextButton" style="BACKGROUND-IMAGE: url(images/ForumSettings.gif)">
		高级搜索</a>
	</td>
<%end if%>
</tr>
</table>

<div id="ForumOption" style="display:none;">
<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
	<form method="POST" action="Members.asp" method=post>
	<tr id=CommonListTitle>
		<td align=center colspan=2>用户搜索</td>
	</tr>
	<tr id=CommonListCell>
		<td colspan=2><br>
			<div style="text-align:center"><input size="45" name="SearchText"> <input type="submit" value=" 搜  索 "></div>
		<br><br>
		<fieldset>
			<legend>根据排序</legend>
			<select name=MemberSortDropDown>
				<option value=UserName>用户名</option>
				<option value=UserEmail>电子邮件</option>
				<option value=TotalPosts>发帖数</option>
				<option value=UserRegisterTime>注册日期</option>
				<option value=UserActivityTime>最后活动日期</option>
			</select> 
			<select name=SortOrderDropDown><option value=desc>倒序</option><option value=asc>顺序</option></select>
		</fieldset><br>
		<fieldset>
			<legend>日期过滤</legend>
			　　注册时间：<select name="JoinedDateComparer" onchange="javascript:if(this.options[this.selectedIndex].value != ''){document.getElementById('UserRegisterTime').style.display='';}else{document.getElementById('UserRegisterTime').style.display='none';}">
					<option value="">----</option>
					<option value="<">在此之前</option>
					<option value="=">在此之时</option>
					<option value=">">在此之后</option>
				</select> <span id=UserRegisterTime style="display:none">
			<input size="24" name="JoinedDate_picker" onclick="showcalendar(event, this)" value="<%=date()%>"></span><br>
			最后活动时间：<select name="LastPostDateComparer" onchange="javascript:if(this.options[this.selectedIndex].value != ''){document.getElementById('UserActivityTime').style.display='';}else{document.getElementById('UserActivityTime').style.display='none';}">
					<option value="">----</option>
					<option value="<">在此之前</option>
					<option value="=">在此之时</option>
					<option value=">">在此之后</option>
				</select> <span id="UserActivityTime" style="display:none">
			<input size="24" name="LastPostDate_picker" onclick="showcalendar(event, this)" value="<%=date()%>"></span>
		</fieldset><br>
		<fieldset>
			<legend>过 滤</legend>
			　　角色：<select name="SearchRole">
				<option value="">所有用户</option>
<%
	sql="Select * from [BBSXP_Roles] where RoleID > 0 order by RoleID"
	Set Rs=Execute(sql)
		Do While Not Rs.EOF
				Response.Write("<option value='"&Rs("RoleID")&"'>"&Rs("Name")&"</option>")
			Rs.MoveNext
		loop
	Rs.Close
%>
			</select><br>
			搜索范围：<select name="SearchType">
				<option value="UserName">用户名包含有</option>
				<option value="UserEmail">邮箱包含有</option>
				<option value="all">用户名或邮箱包含有</option>
			</select><br>
			　　状态：<select name="CurrentAccountStatus" size="1">
				<option value="">所有状态</option>
				<option value="0">正等待审核</option>
				<option value="1">已通过审核</option>
				<option value="2">已禁用</option>
				<option value="3">未通过审核</option>
			</select>
		</fieldset>
		</td>
	</tr>
	</form>
</table>
</div>

<%
HtmlBottom
%>