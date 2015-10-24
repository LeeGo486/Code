<!-- #include file="Setup.asp" -->

<%
if RequestCookies("Userpass")="" or RequestCookies("Userpass")<>session("pass") then response.redirect "Admin_Default.asp"

UserName=HTMLEncode(Request("UserName"))
RoleID=HTMLEncode(Request("RoleID"))
RoleName=HTMLEncode(Request("RoleName"))
Description=HTMLEncode(Request("Description"))

if Request("menu")="ChangePassword" then ChangePassword


AdminTop
Log("")

select case Request("menu")
	case "UserEdit"
		UserEdit
	case "SearchUser"
		SearchUser
	case "UserDelTopic"
		UserDelTopic
	case "UserDel"
		UserDel
	case "Userok"
		Userok
		
	case "ChangePassword"
		ChangePassword
		
	case "UserRank"
		UserRank
	case "UserRankUp"
		if Request.Form("RankName")<>"" then
			Execute("insert into [BBSXP_Ranks] (RankName,PostingCountMin,RankIconUrl) values ('"&Request.Form("RankName")&"','"&Request.Form("PostingCountMin")&"','"&Request.Form("RankIconUrl")&"')")
		end if
		for each ho in Request.Form("RankID")
			Execute("update [BBSXP_Ranks] Set RankName='"&Request.Form("RankName"&ho)&"',PostingCountMin='"&Request.Form("PostingCountMin"&ho)&"',RankIconUrl='"&Request.Form("RankIconUrl"&ho)&"' where RankID="&ho&"")
		next
		response.write "更新成功"
	case "UserRankDel"
		Execute("Delete from [BBSXP_Ranks] where RankID="&Request("RankID")&"")
		response.write "删除成功"
	case "AllRoles"
		AllRoles
	case "CreateRole"
		if RoleName=empty then Alert("您没有输入角色名称")
		Execute("insert into [BBSXP_Roles] (Name) values ('"&RoleName&"')")
		AllRoles
	case "ViewRole"
		ViewRole
	case "UpRole"
		if RoleName=empty then Alert("您没有输入角色名称")
		Execute("update [BBSXP_Roles] Set Name='"&RoleName&"',Description='"&Description&"' where RoleID="&RoleID&"")
		Response.Write("编辑成功")
	case "DelRole"
		if Roleid<4 then Alert("该角色为系统内置角色，无法删除")
		if Not Execute("Select UserID From [BBSXP_Users] where UserRoleID="&RoleID&"" ).eof then Alert("只能删除没有成员的角色组！")
		Execute("Delete from [BBSXP_Roles] where RoleID="&RoleID&"")
		Response.Write("删除成功")
	case else
		SearchUserok
end select


Sub ChangePassword
Response.clear
if Request.ServerVariables("Request_method") = "POST" then
	NewPassword1=Trim(Request("NewPassword1"))
	NewPassword2=Trim(Request("NewPassword2"))
	if NewPassword1<>NewPassword2 then  Alert("您2次输入的密码不同")
	if Len(NewPassword1)<6 then  Alert("密码不能小于6位数")
	Execute("update [BBSXP_Users] Set Userpass='"&DefaultPasswordFormat(NewPassword1)&"' where UserName='"&UserName&"'")
	%><script language="JavaScript">parent.BBSXP_Modal.Close();</script><%
end if
%>
<title>修改密码</title>
<style>body,table{FONT-SIZE:9pt;}</style>
<form name=form action="Admin_User.asp?menu=ChangePassword" method="POST">
<input type=hidden name="UserName" value="<%=UserName%>">
修改密码 - (<%=UserName%>) <br><br>
<table border="0" width="100%">
	<tr>
		<td>新密码：　</td>
		<td><input name="NewPassword1" type="password" maxlength="15" size="40" /></td>
	</tr>
	<tr>
		<td>重新输入新密码：　</td>
		<td><input name="NewPassword2" type="password" maxlength="15" size="40" /></td>
	</tr>
</table>
<br>
<input type="submit" value=" 修改密码 ">
</form>
<%
Response.End
End Sub


Sub SearchUser
%>
<SCRIPT type="text/javascript" src="Utility/calendar.js"></SCRIPT>
用户资料：<b><font color=red><%=Execute("Select count(UserID) from [BBSXP_Users]")(0)%></font></b> 条
<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
	<form method="POST" action="?menu=SearchUserok">
	<tr id=CommonListTitle>
		<td align=center>用户搜索</td>
	</tr>
	<tr id=CommonListCell>
		<td><br>
			<div style="text-align:center"><input size="45" name="SearchText"> <input type="submit" value=" 搜  索 "></div>
		<br><br>
		<fieldset>
			<legend>根据排序</legend>
			<select name=MemberSortDropDown>
				<option value=UserName>用户名</option>
				<option value=UserEmail>电子邮件</option>
				<option value=TotalPosts>帖子数</option>
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
				</select> <span id=UserRegisterTime style="display:none"><input size="24" name="JoinedDate_picker" onclick="showcalendar(event, this)" value="<%=date()%>"></span><br>
			最后活动时间：<select name="LastPostDateComparer" onchange="javascript:if(this.options[this.selectedIndex].value != ''){document.getElementById('UserActivityTime').style.display='';}else{document.getElementById('UserActivityTime').style.display='none';}">
					<option value="">----</option>
					<option value="<">在此之前</option>
					<option value="=">在此之时</option>
					<option value=">">在此之后</option>
				</select> <span id="UserActivityTime" style="display:none"><input size="24" name="LastPostDate_picker" onclick="showcalendar(event, this)" value="<%=date()%>"></span>
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
<hr noshade="noshade" size="1" color=#999999 />
		<fieldset>
			<legend>快捷方式</legend>
			<li><a href="?MemberSortDropDown=TotalPosts&SortOrderDropDown=desc">发帖排行</li></a>
			<li><a href="?LastPostDateComparer==&LastPostDate_picker=<%=date()%>">过去 24 小时内活动的用户</li></a>
			<li><a href="?JoinedDateComparer==&JoinedDate_picker=<%=date()%>">过去 24 小时内注册的用户</li></a>
			<li><a href="?CurrentAccountStatus=0">等待审核的用户</a></li>
		</fieldset>
	</form>
		</td>
	</tr>
</table><br>



<%
End Sub

Sub SearchUserok
%>
<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
	<TR align=center id=CommonListTitle>
		<TD>用户名</TD>
		<TD>Email</TD>
		<TD>发帖数</TD>
		<TD>注册时间</TD>
		<TD>最后活动时间</TD>
		<TD>动作</TD>
	</TR>
<%
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

	sql="[BBSXP_Users]"&item&""

	TotalCount=Execute("Select count(UserID) From "&sql&"")(0) '获取数据数量
	PageSetup=20 '设定每页的显示数量
	TotalPage=Abs(Int(TotalCount/PageSetup*(-1))) '总页数
	PageCount = RequestInt("PageIndex") '获取当前页
	if PageCount <1 then PageCount = 1
	if PageCount > TotalPage then PageCount = TotalPage
	
	if Request("MemberSortDropDown")<>"" then item=item&" order by "&Request("MemberSortDropDown")&" "&Request("SortOrderDropDown")&""
	sql="[BBSXP_Users]"&item&""
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
		<TD><a href="Admin_User.asp?menu=UserEdit&UserName=<%=Rs("UserName")%>"><%=Rs("UserName")%></a></TD>
		<TD><a href="mailto:<%=Rs("UserEmail")%>"><%=Rs("UserEmail")%></a></TD>
		<TD><%=Rs("TotalPosts")%></TD>
		<TD><%=Rs("UserRegisterTime")%></TD>
		<TD><%=Rs("UserActivityTime")%></TD>
		<TD><a href="Admin_User.asp?menu=UserEdit&UserName=<%=Rs("UserName")%>">编辑</a> | <a onclick="return window.confirm('您确定要删除您所选用户的全部资料?');" href="Admin_User.asp?menu=UserDel&UserID=<%=Rs("UserID")%>">删除</a></TD>
	</TR>
<%
		Rs.MoveNext
	loop
	Rs.Close
%>
</TABLE>
<table border=0 width=100% align=center><tr><td><%ShowPage()%></tr></td></table>
<%
End Sub


Sub UserEdit
	sql="Select * from [BBSXP_Users] where UserName='"&HTMLEncode(UserName)&"'"
	Set Rs=Execute(sql)
	if Rs.eof then Alert(""&UserName&" 的用户资料不存在")
	
		XMLDOM.loadxml("<bbsxp>"&Rs("UserInfo")&"</bbsxp>")
		QQ=SelectSingleNode("QQ")
		ICQ=SelectSingleNode("ICQ")
		AIM=SelectSingleNode("AIM")
		MSN=SelectSingleNode("MSN")
		Yahoo=SelectSingleNode("Yahoo")
		Skype=SelectSingleNode("Skype")
		Set XMLDOM= Nothing
		
		UserSign=replace(""&Rs("UserSign")&"","<br>", vbCrlf)
		UserBio=replace(""&Rs("UserBio")&"","<br>",vbCrlf)
		UserNote=replace(""&Rs("UserNote")&"","<br>",vbCrlf)
%>
<form method="POST" name=form action="?menu=Userok">
<input type=hidden name=UserName value="<%=Rs("UserName")%>">
<table cellSpacing="1" cellpadding="5" border="0" width="70%" id=CommonListArea align=center>
	<tr id=CommonListTitle>
		<td width="600" colspan="4" align="center"><font color="000000"><a target="_blank" href="Profile.asp?UserName=<%=Rs("UserName")%>">查看“<%=Rs("UserName")%>”的详细资料</a></font></td>
	</tr>
	<tr id=CommonListCell>
		<td colspan="2">&nbsp;用户名称：<%=Rs("UserName")%></td>
		<td width="600" colspan="2">&nbsp;用户密码：<a href="javascript:BBSXP_Modal.Open('?menu=ChangePassword&UserName=<%=Rs("UserName")%>',500,160);">修改密码</a></td>
	</tr>
	<tr id=CommonListCell>
		<td colspan="2">&nbsp;用户角色：<select name="UserRoleID">
<%
	RoleGetRow = FetchEmploymentStatusList("Select RoleID,Name from [BBSXP_Roles] where RoleID > 0 order by RoleID")
	For i=0 To Ubound(RoleGetRow,2)
	%><option value="<%=RoleGetRow(0,i)%>" <%if Rs("UserRoleID")=RoleGetRow(0,i) then%>selected<%end if%>><%=RoleGetRow(1,i)%></option><%
	Next
%>
			</select>		</td>
		<td width="600" colspan="2">&nbsp;帐号状态：<select name="UserAccountStatus" size="1">
				<option value="0" <%if Rs("UserAccountStatus")=0 then%>selected<%end if%>>正等待审核</option>
				<option value="1" <%if Rs("UserAccountStatus")=1 then%>selected<%end if%>>已通过审核</option>
				<option value="2" <%if Rs("UserAccountStatus")=2 then%>selected<%end if%>>已禁用</option>
				<option value="3" <%if Rs("UserAccountStatus")=3 then%>selected<%end if%>>未通过审核</option>
			</select>		</td>
	</tr>
	<tr id=CommonListCell>
		<td colspan="2">&nbsp;用户头衔：<input size="10" name="UserTitle" value="<%=Rs("UserTitle")%>"></td>
		<td width="600" colspan="2">&nbsp;信任等级：<select name="ModerationLevel" size="1">
			<option value="1" <%if Rs("ModerationLevel")=True then%>selected<%end if%>>信任用户</option>
			<option value="0" <%if Rs("ModerationLevel")=False then%>selected<%end if%>>非信任用户</option>
		</select></td>
	</tr>
	<tr id=CommonListCell>
		<td width="600" colspan="2">&nbsp;发 帖 数：<input size="10" name="TotalPosts" value="<%=Rs("TotalPosts")%>"></td>
		<td colspan="2">&nbsp;用户声望：<input size="10" name="Reputation" value="<%=Rs("Reputation")%>"></td>
	</tr>
	<tr id=CommonListCell>
		<td colspan="2">&nbsp;金　　钱：<input size="10" name="UserMoney" value="<%=Rs("UserMoney")%>" /></td>
		<td width="600" colspan="2">&nbsp;邀 请 人：<input size="20" name="ReferrerName" value="<%=Rs("ReferrerName")%>" /></td>
	</tr>
	<tr id=CommonListCell>
		<td colspan="2">&nbsp;经 验 值：<input size="10" name="experience" value="<%=Rs("experience")%>" /></td>
		<td colspan="2">&nbsp;用户头像：<input size="20" name="UserFaceUrl" value="<%=Rs("UserFaceUrl")%>"></td>
	</tr>
	<tr id=CommonListCell>
		<td width="1200" colspan="4">&nbsp;注册日期：<%=Rs("UserRegisterTime")%> （ＩＰ：<%=Rs("UserRegisterIP")%>）</td>
	</tr>
	<tr id=CommonListCell>
		<td width="1200" colspan="4">&nbsp;活动日期：<%=Rs("UserActivityTime")%> （ＩＰ：<%=Rs("UserActivityIP")%>）</td>
	</tr>
	<tr id=CommonListTitle>
		<td colspan="4" align="center">基本资料</td>
	</tr>
	<tr id=CommonListCell>
	  <td width="600" colspan="2">&nbsp;名字： <input type="text" name="RealName" size="20" value="<%=Rs("RealName")%>" /></td>
		<td width="600" height="3" colspan="2">&nbsp;性别： <select size=1 name=UserSex>
				<option value=0 selected>[请选择]</option>
				<option value=1 <%if Rs("UserSex")=1 then%>selected<%end if%>>男</option>
				<option value=2 <%if Rs("UserSex")=2 then%>selected<%end if%>>女</option>
	  </select></td>
	</tr>
	<tr id=CommonListCell>
		<td width="600" colspan="2">&nbsp;生日： <input type="text" name="birthday" size="20" value="<%=Rs("birthday")%>"></td>
		<td width="600" colspan="2">&nbsp;地址： <input type="text" name="Address" size="20" value="<%=Rs("Address")%>"></td>
	</tr>
	<tr id=CommonListCell>
	  <td colspan="2">&nbsp;职业： <input type="text" name="Occupation" size="20" value="<%=Rs("Occupation")%>"></td>
	  <td colspan="2">&nbsp;兴趣： <input type="text" name="Interests" size="20" value="<%=Rs("Interests")%>"></td>
    </tr>
	<tr id=CommonListCell>
	  <td colspan="2">&nbsp;邮箱： <input type="text" name="UserEmail" size="20" value="<%=Rs("UserEmail")%>"></td>
	  <td colspan="2">&nbsp;主页： <input type="text" name="WebAddress" size="20" value="<%=Rs("WebAddress")%>"></td>
    </tr>
	<tr id=CommonListCell>
	  <td colspan="2">&nbsp;博客： <input type="text" name="WebLog" size="20" value="<%=Rs("WebLog")%>"></td>
	  <td colspan="2">&nbsp;相册： <input type="text" name="WebGallery" size="20" value="<%=Rs("WebGallery")%>"></td>
    </tr>
    
	<tr id=CommonListTitle>
		<td colspan="4" align="center">即时通信</td>
	</tr>
    
	<tr id=CommonListCell>
	  <td colspan="2">&nbsp;QQ ：　<input type="text" name="QQ" size="20" onkeyup=if(isNaN(this.value))this.value='' value="<%=QQ%>"></td>
	  <td colspan="2">&nbsp;ICQ：　<input type="text" name="ICQ" size="20" onkeyup=if(isNaN(this.value))this.value='' value="<%=ICQ%>"></td>
    </tr>
	<tr id=CommonListCell>
	  <td colspan="2">&nbsp;AIM：　<input type="text" name="AIM" size="20" value="<%=AIM%>"></td>
	  <td colspan="2">&nbsp;MSN：　<input type="text" name="MSN" size="20" value="<%=MSN%>"></b></td>
    </tr>
	<tr id=CommonListCell>
	  <td colspan="2">&nbsp;Yahoo：<input type="text" name="Yahoo" size="20" value="<%=Yahoo%>"></td>
	  <td colspan="2">&nbsp;Skype：<input type="text" name="Skype" size="20" value="<%=Skype%>"></b></td>
    </tr>
    
	<tr id=CommonListTitle>
		<td colspan="4" align="center">签名＆简介＆备注</td>
	</tr>
    
    
	<tr id=CommonListCell>
		<td width="600" colspan="4">&nbsp;签名：<textarea name="UserSign" rows="4" cols="60"><%=UserSign%></textarea></td>
	</tr>
	<tr id=CommonListCell>
		<td width="600" colspan="4">&nbsp;简介：<textarea name="UserBio" rows="4" cols="60"><%=UserBio%></textarea></td>
	</tr>
	
	<tr id=CommonListCell>
		<td width="600" colspan="4">&nbsp;备注：<textarea name="UserNote" rows="4" cols="60"><%=UserNote%></textarea></td>
	</tr>
	
	
	<tr id=CommonListTitle>
		<td width="600" align="center" ><a onclick="return window.confirm('您确定要删除该用户所有发表过的帖子?');" href="?menu=UserDelTopic&UserName=<%=Rs("UserName")%>">删除该用户的所有主题</a></td>
		<td width="600" colspan="2" align="center" ><input type="submit" value=" 更 新 "></td>
		<td width="600" align="center" ><a onclick="return window.confirm('您确定要删除该用户的所有资料?');" href="?menu=UserDel&UserID=<%=Rs("UserID")%>">删除该用户的所有资料</a></td>
	</tr>
</table>
</form>
<%
End Sub

Sub UserDelTopic
	Execute("Delete from [BBSXP_Threads] where PostAuthor='"&UserName&"'")
	Response.Write("已经将 "&UserName&" 所有发表过的主题全部删除")
End Sub

Sub UserDel
	for each ho in Request("UserID")
		ho=int(ho)
		if ho=CookieUserID then Alert("不能自己删除自己")
		Execute("Delete from [BBSXP_Users] where UserID="&ho&"")
	next
	Response.Write("已经成功删除用户ID为（"&Request("UserID")&"）的所有资料")
End Sub

Sub Userok
	birthday=HTMLEncode(Request.Form("birthday"))
	if Not IsDate(birthday) then birthday=null
	
	
	sql="Select * from [BBSXP_Users] where UserName='"&UserName&"'"
	Rs.Open sql,Conn,1,3
		Rs("UserFaceUrl")=Request("UserFaceUrl")
		Rs("UserRoleID")=Request("UserRoleID")
		Rs("UserEmail")=Request("UserEmail")
		Rs("TotalPosts")=Request("TotalPosts")
		Rs("experience")=Request("experience")
		Rs("UserMoney")=Request("UserMoney")
		Rs("ReferrerName")=Request("ReferrerName")
		Rs("TotalPosts")=Request("TotalPosts")
		Rs("UserTitle")=Request("UserTitle")
		Rs("Reputation")=RequestInt("Reputation")
		Rs("UserSign")=HTMLEncode(Request.Form("UserSign"))
		Rs("Interests")=HTMLEncode(Request.Form("Interests"))
		Rs("UserBio")=HTMLEncode(Request.Form("UserBio"))
		Rs("UserNote")=HTMLEncode(Request.Form("UserNote"))
		
		Rs("UserSex")=RequestInt("UserSex")
		Rs("UserAccountStatus")=Request("UserAccountStatus")
		Rs("ModerationLevel")=Request("ModerationLevel")
		Rs("birthday")=birthday
		XMLDOM.loadxml("<bbsxp>"&Rs("UserInfo")&"</bbsxp>")
		Set objRoot = XMLDOM.documentElement
		objRoot.SelectSingleNode("QQ").text = ""&server.HTMLEncode(Request("QQ"))&""
		objRoot.SelectSingleNode("ICQ").text = ""&server.HTMLEncode(Request("ICQ"))&""
		objRoot.SelectSingleNode("AIM").text = ""&server.HTMLEncode(Request("AIM"))&""
		objRoot.SelectSingleNode("MSN").text = ""&server.HTMLEncode(Request("MSN"))&""
		objRoot.SelectSingleNode("Yahoo").text = ""&server.HTMLEncode(Request("Yahoo"))&""
		objRoot.SelectSingleNode("Skype").text = ""&server.HTMLEncode(Request("Skype"))&""
		Set objNodes=XMLDOM.documentElement.ChildNodes
		for each element in objNodes
			UserInfoList=UserInfoList&"<"&element.nodename&">"&element.text&"</"&element.nodename&">"&vbCrlf
		next
		Rs("UserInfo")=UserInfoList
		Rs("RealName")=Request("RealName")
		Rs("Occupation")=Request("Occupation")
		Rs("Address")=Request("Address")
		Rs("WebAddress")=Request("WebAddress")
		Rs("WebLog")=Request("WebLog")
		Rs("WebGallery")=Request("WebGallery")
	Rs.update
	Rs.close
	Response.Write("更新成功")
End Sub



Sub UserRank
%>
<form method="POST" action=?menu=UserRankUp>
<table border="0" cellpadding="5" cellspacing="1" id=CommonListArea width=100%>
	<tr id=CommonListTitle>
		<td width="50" align="center">ID</td>
		<td width="120">名称</td>
		<td width="120">最低经验数</td>
		<td>图标路径</td>
		<td width="50" align="center">管理</td>
	</tr>
<%
	sql="Select * from [BBSXP_Ranks] order by PostingCountMin"
	Set Rs=Execute(sql)
	do while not Rs.eof
%>
	<tr id=CommonListCell>
		<td align="center"><%=Rs("RankID")%><input type=hidden name=RankID value=<%=Rs("RankID")%>></td>
		<td><input size="10" name="RankName<%=Rs("RankID")%>" value="<%=Rs("RankName")%>"></td>
		<td><input size="10" name="PostingCountMin<%=Rs("RankID")%>" value="<%=Rs("PostingCountMin")%>"></td>
		<td><input size="30" name="RankIconUrl<%=Rs("RankID")%>" value="<%=Rs("RankIconUrl")%>"> <img src="<%=Rs("RankIconUrl")%>"></td>
		<td align="center"><a onclick="return window.confirm('您确定要执行该操作?');" href="?menu=UserRankDel&RankID=<%=Rs("RankID")%>">删除</a></td>
	</tr>
<%
		Rs.Movenext
	loop
	Set Rs = Nothing
%>
	<tr id=CommonListCell>
		<td align="center"><font color="#FF0000">增加</font></td>
		<td><input size="10" name="RankName" value=""></td>
		<td><input size="10" name="PostingCountMin" value=""></td>
		<td colspan="2"><input size="30" name="RankIconUrl" value=""></td>
	</tr>
</table>
<input type="submit" value=" 更 新 ">
</form>
<%
End Sub

Sub AllRoles
%><b>角色管理</b><br>创建/编辑角色，用来控制一个用户在制定版块的权限。<br>
<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
	<tr id=CommonListTitle>
		<td align="center">角色管理</td>
	</tr>
<%
	sql="Select * from [BBSXP_Roles] order by RoleID"
	Set Rs=Execute(sql)
		Do While Not Rs.EOF 
%>
	<tr id=CommonListCell>
		<td><%if Rs("RoleID") > 3 then%><a href="?menu=ViewRole&RoleId=<%=Rs("RoleID")%>"><%end if%><b><%=Rs("Name")%></b></a><br><%=Rs("Description")%></td>
	</tr>
<%
			Rs.MoveNext
		loop
	Rs.Close
%>
	<tr id=CommonListCell>
		<td>
		<form name="form" method="POST" action="?menu=CreateRole">
			<input name="RoleName" onkeyup="ValidateTextboxAdd(this, 'RoleName1')" onpropertychange="ValidateTextboxAdd(this, 'RoleName1')" size="50"><input type="submit" value="创建" id="RoleName1" disabled></form>
		</td>
	</tr>
</table>
<%
End Sub

Sub ViewRole
	if  RoleId<4 then PostDisabled="disabled"
	Rs.Open "Select * from [BBSXP_Roles] where RoleID="&RoleId&"",Conn,1
%><form name="form" method="POST" action="?menu=UpRole&RoleID=<%=RoleID%>">
	<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
		<tr id=CommonListTitle>
			<td align="center" colspan="2">角色管理</td>
		</tr>
		<tr id=CommonListCell>
			<td>RoleID</td>
			<td width="50%"><%=Rs("RoleID")%></td>
		</tr>
		<tr id=CommonListCell>
			<td>名称</td>
			<td width="50%"><input name="RoleName" size="50" value="<%=Rs("Name")%>"></td>
		</tr>
		<tr id=CommonListCell>
			<td>描述</td>
			<td width="50%"><input name="Description" size="50" value="<%=Rs("Description")%>"></td>
		</tr>
		<tr id=CommonListCell>
			<td colspan="2" align="right"><input <%=PostDisabled%> type="button" value="删除" onclick="document.location.href='?menu=DelRole&amp;RoleID=<%=RoleID%>'"><input <%=PostDisabled%> type="submit" value="保存"></td>
		</tr>
	</table>
</form>
<%
	Rs.close
End Sub


Set XMLDOM=Nothing
AdminFooter
%>