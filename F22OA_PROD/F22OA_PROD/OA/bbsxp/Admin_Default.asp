<!-- #include file="Setup.asp" -->
<%
if CookieUserName=empty then error("您还未<a href=Login.asp?ReturnUrl="&ReturnUrl&">登录</a>论坛")
if CookieUserRoleID <> 1 then Alert("您没有权限进入后台")
if Request("menu")="out" then
	session.Abandon()
	Log("退出后台管理")
	response.redirect ""&Request.ServerVariables("script_name")&"/../"
end if


select case Request("menu")
	case "AdminLeft"
		AdminLeft
	case "pass"
		pass
	case "Header"
		AdminHeader
	case "Login"
		Login
	case "main"
		main
	case else
		if session("pass")="" then response.redirect("?menu=Login")
		Default
end select

Sub pass
	if Request("pass")="" then Alert("请输入管理员密码！")

	if Len(CookieUserPass)=32 then
		session("pass")=MD5(""&Request("pass")&"")
	else
		session("pass")=SHA1(""&Request("pass")&"")
	end if

	if CookieUserPass <> session("pass") then Alert("管理员密码错误，请返回重新登录！")
	Response.Write("<script language='JavaScript'>top.location.href='?';</script>")
End Sub

Sub main
	AdminTop
%>
<table cellpadding="5" cellspacing="1" border="0" width="95%" align="center" id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="2" align="center">系统信息</td>
	</tr>
	<tr id=CommonListCell>
		<td width="50%">服务器域名：<%=Request.ServerVariables("server_name")%> / <%=Request.ServerVariables("LOCAL_ADDR")%></td>
		<td width="50%">脚本解释引擎：<%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
	</tr>
	<tr id=CommonListCell>
		<td width="50%">服务器软件名：<%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
		<td width="50%">服务器操作系统：<%=Request.ServerVariables("OS")%></td>
	</tr>
	<tr id=CommonListCell>
		<td width="50%">FSO 组件支持：<%If Not IsObjInstalled("Scripting.FileSystemObject") Then%><font color="red"><b>×</b></font><%else%><b>√</b><%end if%></td>
		<td width="50%">SA-FileUp 组件支持：<%If Not IsObjInstalled("SoftArtisans.FileUp") Then%><font color="red"><b>×</b></font><%else%><b>√</b><%end if%></td>
	</tr>
	<tr id=CommonListCell>
		<td width="50%">CDO.Message 组件支持：<%If Not IsObjInstalled("CDO.Message") Then%><font color="red"><b>×</b></font><%else%><b>√</b><%end if%></td>
		<td width="50%">JMail.Message 组件支持：<%If Not IsObjInstalled("JMail.Message") Then%><font color="red"><b>×</b></font><%else%><b>√</b><%end if%></td>
	</tr>
</table>


<br>
<form method="POST" action="Admin_Setup.asp?menu=SiteSettingsUp">
<table cellpadding="5" cellspacing="1" border="0" width="95%" align="center" id=CommonListArea>
	<tr id=CommonListTitle>
		<td align="center">管理员便笺</td>
	</tr>
	<tr id=CommonListCell>
		<td align="center">
			<textarea name="AdminNotes" rows="9" style="width:95%"><%=AdminNotes%></textarea>
		</td>
	</tr>
	<tr id=CommonListCell>
		<td align="center"><input type="submit" value=" 保 存 "></td>
	</tr>
</table>
</form>





<br>
<table cellpadding="5" cellspacing="1" border="0" width="95%" align="center" id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="3" align="center">管理快捷方式</td>
	</tr>
	<tr id=CommonListCell>
		<td width="20%">用户管理</td>
		<td width="60%">当前有 <b><font color=red><%=Execute("Select count(UserID) from [BBSXP_Users] where UserAccountStatus=0")(0)%></font></b> 位新注册用户等待审核</td>
		<td width="20%"><a href="Admin_User.asp?menu=SearchUser">搜索用户</a></td>
	</tr>
	<tr id=CommonListCell>
		<td width="20%">论坛管理</td>
		<td width="60%">当前有 <b><font color=red><%=Execute("Select count(ForumID) from [BBSXP_Forums]")(0)%></font></b> 论坛及 <b><font color=red><%=Execute("Select count(ThreadID) from [BBSXP_Threads] where IsDel=0")(0)%></font></b> 个讨论主题</td>
		<td width="20%"><a href="Admin_Forum.asp?menu=ForumAdd">添加新论坛</a></td>
	</tr>
</table>
<br>
<table cellpadding="5" cellspacing="1" border="0" width="95%" align="center" id=CommonListArea>
	<tr id=CommonListTitle>
		<td colspan="2" align="center">关于BBSXP论坛</td>
	</tr>
	<tr id=CommonListCell>
		<td width="20%">产品开发</td>
		<td width="80%">BBSXP Studio</td>
	</tr>
	<tr id=CommonListCell>
		<td width="20%">产品运营</td>
		<td width="80%">Yuzi Corporation</td>
	</tr>
	<tr id=CommonListCell>
		<td width="20%" valign="top">联系方法</td>
		<td width="80%">TEL 0595-22205408<br>
		FAX 0595-22205409<br>
		<a target="_blank" href="http://www.bbsxp.com">http://www.bbsxp.com</a>
	</tr>
</table>
<%



	Execute("Delete from [BBSXP_EventLog] where DateDiff("&SqlChar&"d"&SqlChar&",EventDate,"&SqlNowString&") > 7")
	Execute("Delete from [BBSXP_Statistics] where DateDiff("&SqlChar&"d"&SqlChar&",DateCreated,"&SqlNowString&") > 2000")
	Execute("Delete from [BBSXP_UserActivation] where DateDiff("&SqlChar&"d"&SqlChar&",DateCreated,"&SqlNowString&") > 7")

	AdminFooter
End Sub

Sub Login
%>
<br><br><br><br><br><br><br><br>
<table width="400" border="0" cellspacing="1" cellpadding="5" align="center" id=CommonListArea>
<form action="?" method="POST">
<input type="hidden" value="pass" name="menu">
	<tr id=CommonListTitle>
		<td align="center">登录论坛管理</td>
	</tr>
	<tr id=CommonListCell>
	  <td>
	  
	  
	  <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="50%"><img src="Images/Logo.gif"/></td>
          <td width="50%"><a href="Default.asp" target=_top><%=SiteConfig("SiteName")%></a><br><%=ForumsProgram%><br><%=ForumsBuild%> 管理控制面版</td>
        </tr>
      </table>
      
      </td>
    </tr>
	<tr id=CommonListCell>
	  <td align="center">管 理 员：<input size="25" name="AdminUserName" type="text" value="<%=CookieUserName%>" Readonly></td>
    </tr>
	<tr id=CommonListCell>
		<td align="center">管理密码：<input size="25" name="pass" type="password"></td>
	</tr>
	<tr id=CommonListCell>
		<td align="center"><input type="submit" value=" 登录 ">　<input type="button" onclick="javascript:history.back()" value=" 取消 "></td>
	</tr>
</form>	
</table>

<%
End Sub

Sub AdminLeft
%>
<style>BODY { MARGIN: 0px;}</style>
<table id=CommonListArea cellSpacing="1" cellPadding="5" width="145" align="center" border="0">
		<tr id=CommonListTitle>
			<td align="center">设　置</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Setup.asp?menu=variable">基本设置</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Setup.asp?menu=UserAgreement">注册用户协议</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Setup.asp?menu=Showbanner">HTML代码设置</a></td>
		</tr>
		<tr id=CommonListTitle>
			<td align="center">成　员</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_User.asp?menu=SearchUser">搜索用户</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_User.asp">浏览所有用户</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_User.asp?menu=AllRoles">管理所有角色</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_User.asp?menu=UserRank">用户等级名称</a></td>
		</tr>
		<tr id=CommonListTitle>
			<td align="center">声　望</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Reputation.asp">管理声望评论</a></td>
		</tr>
		<tr id=CommonListTitle>
			<td align="center">论　坛</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Forum.asp?menu=ForumAdd">新建论坛</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Forum.asp?menu=ManageGroups">论 坛 组</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Forum.asp?menu=ApplyManage">论　　坛</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Forum.asp?menu=TreeView">管理所有论坛</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Forum.asp?menu=bbsManage">管理论坛资料</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Forum.asp?menu=upSiteSettings">更新论坛资料</a></td>
		</tr>
		<tr id=CommonListTitle>
			<td align="center">工　具</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Tool.asp?menu=BatchSendMail">群发邮件</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Tool.asp?menu=Message">短讯息管理</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Tool.asp?menu=Link">友情链接管理</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Tool.asp?menu=AD">帖间广告管理</a></td>
		</tr>
		<tr id=CommonListTitle>
			<td align="center">菜　单</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Menu.asp">论坛菜单管理</a></td>
		</tr>
		<tr id=CommonListTitle><td align="center">数　据</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_FSO.asp?menu=bak">ACCESS数据库</a> </td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_FSO.asp?menu=statroom">统计占用空间</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_FSO.asp?menu=PostAttachment">附件管理</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_FSO.asp?menu=Posts">帖子数据表</a> </td>
		</tr>
		<tr id=CommonListTitle>
			<td align="center">系　统</td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Other.asp?menu=circumstance">主机环境变量</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Other.asp?menu=discreteness">组件支持情况</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Other.asp?menu=Statistics">论坛统计记录</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Other.asp?menu=EventLog">论坛操作记录</a></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center"><a target="main" href="Admin_Other.asp?menu=EventLog&ErrNum=1">异常出错记录</a></td>
		</tr>
</table><%
End Sub

Sub AdminHeader
	Log("登录后台管理")
	Response.Write "<body><table border=0 width=100% cellspacing=0 cellpadding=3><tr id=CommonListTitle><td><div style='Padding-left:15px;float:left'><span id='Licence'></span></div><div style='Text-align:right;Padding-right:15px;float:right'><a href='Default.asp' target='_blank'>论坛首页</a>　<a href='?menu=main' target='main'>管理首页</a>　<a target='_top' href='?menu=out'>退出管理</a></div></td></tr></table>"
	Response.write("<script type='text/javascript' src='http://Licence.yuzi.net/Licence.asp?Site="&Request.ServerVariables("server_name")&"&Program="&ForumsProgram&"&Build="&ForumsBuild&"'></script>")
End Sub

Sub Default
%>
<title>后台管理 - <%=SiteConfig("SiteName")%> - Powered By BBSXP</title>

<frameset cols="170,*" frameborder="no" >
	<frame src="?menu=AdminLeft" name="leftFrame" scrolling="yes" style="overflow: auto;">
	<frameset rows="20,*" framespacing="0">
		<frame src="?menu=Header" scrolling="no" marginheight="0">
		<frame src="?menu=main" name="main" marginheight="0">
	</frameset>
</frameset>
<%
End Sub

%>