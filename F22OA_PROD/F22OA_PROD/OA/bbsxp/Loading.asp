<!-- #include file="conn.asp" -->
<%
if Request.ServerVariables("Request_method") <> "POST" then Response.End

select case Request("menu")

	case "CloseMsg"
		RemoveApplication("Message_"&CookieUserName)
		Response.write("临时讯息（已阅读）")

	case "Reputation"
		CommentFor=HTMLEncode(Request.QueryString("CommentFor"))
		CommentBy=HTMLEncode(Request.QueryString("CommentBy"))
		if CommentFor<>empty then
			Set Rs=Execute("select top "&SiteConfig("ShowUserRates")&" * from [BBSXP_Reputation] where CommentFor='"&CommentFor&"' order by DateCreated desc")
			TitleStr="评价人"
		elseif CommentBy<>empty then
			Set Rs=Execute("select top "&SiteConfig("ShowUserRates")&" * from [BBSXP_Reputation] where CommentBy='"&CommentBy&"' order by DateCreated desc")
			TitleStr="被评价人"
		end if
		if Rs.eof then
		
			CommentAreaStr="<table cellspacing=0 cellpadding=0 width=100% class='PannelBody'><tr><td>暂时没有相关评价</td></tr></table>"

		else
		
			CommentAreaStr="<table cellspacing=0 cellpadding=0 width=100% class='PannelBody'><tr align=center><td colspan=2>评价内容</td><td>"&TitleStr&"</td></tr>"
			do while not Rs.eof
				if Rs("Reputation")>0 then
					ReputationTitle="好评"
					ImgUrl="Reputation_Excellent.gif"
					FontColor="#FF0000"
					ReputationValue="+"&Rs("Reputation")&""
					
				elseif Rs("Reputation")=0 then
					ReputationTitle="中评"
					ImgUrl="Reputation_Average.gif"
					FontColor="#007700"
					ReputationValue="不计分"
				else
					ReputationTitle="差评"
					ImgUrl="Reputation_Poor.gif"
					FontColor=""
					ReputationValue=Rs("Reputation")
				end if

				CommentAreaStr=CommentAreaStr&"<TR>"
				CommentAreaStr=CommentAreaStr&"<TD width=60 align=center><img src='images/"&ImgUrl&"'> <font color='"&FontColor&"'>"&ReputationTitle&"</font><br>( "&ReputationValue&" )</TD>"
				CommentAreaStr=CommentAreaStr&"<TD>"&Rs("Comment")&"　<em><font color=#C0C0C0>"&Rs("DateCreated")&"</em></font></TD>"
			if CommentFor<>empty then
				CommentAreaStr=CommentAreaStr&"<TD width=25% align=center><a href='?UserName="&Rs("CommentBy")&"'>"&Rs("CommentBy")&"</a></TD>"
			else
				CommentAreaStr=CommentAreaStr&"<TD width=25% align=center><a href='?UserName="&Rs("CommentFor")&"'>"&Rs("CommentFor")&"</a></TD>"
			end if
				CommentAreaStr=CommentAreaStr&"</TR>"
				Rs.movenext
			loop
			CommentAreaStr=CommentAreaStr&"</table>"
		end if
		Rs.close
		Set Rs = Nothing
		response.Write(CommentAreaStr)
		
	case "ForumTree"
		GroupID=RequestInt("GroupID")
		ParentID=RequestInt("ParentID")
		QueryStr="ParentID="&ParentID&""
		if GroupID>0 then QueryStr="GroupID="&GroupID&" and ParentID=0"
		sql="Select * From [BBSXP_Forums] where "&QueryStr&" and IsActive=1 and  SortOrder>0 order by SortOrder"
		Set Rs=Execute(sql)
		do while not rs.eof
			alltree=""&alltree&"<div class=menuitems><a href=ShowForum.asp?ForumID="&rs("ForumID")&">"&rs("ForumName")&"</a></div>"
			rs.Movenext
		loop
		Set Rs = Nothing
		if GroupID>0 then
%>
<a onmouseover="showmenu(event,'<%=alltree%>')" href=Default.asp?GroupID=<%=GroupID%>><%=Execute("Select GroupName From [BBSXP_Groups] where GroupID="&GroupID&"")(0)%></a><%else%>
<a onmouseover="showmenu(event,'<%=alltree%>')" href=ShowForum.asp?ForumID=<%=ParentID%>><%=Execute("Select ForumName From [BBSXP_Forums] where ForumID="&ParentID&"")(0)%></a><%
		end if

	case "ForumList"
		ii=0
		ForumsList="<select name='ParentID'><option value='0'>--</option>"
		GroupID=RequestInt("GroupID")
		ForumListLoad GroupID,0
		ForumsList=ForumsList&"</select>"
		response.write(ForumsList)

	case "UsersOnline"
		ForumID=RequestInt("ForumID")
		if ForumID=0 then
			sql="Select * from [BBSXP_UserOnline] where UserName<>'' and IsInvisible<>1"
		else
			sql="Select * from [BBSXP_UserOnline] where UserName<>'' and IsInvisible<>1 and ForumID="&ForumID&""
		end if
		Set Rs=Execute(sql)
		do while not Rs.eof
			content=""&content&"<a href=Profile.asp?UserName="&Rs("UserName")&">"&Rs("UserName")&"</a>　"
			Rs.Movenext
		loop
		Rs.close
		response.write content
		
		
	case "ThreadStatus"
		ThreadID=RequestInt("ThreadID")
		ThreadStatus=RequestInt("ThreadStatus")
		Execute("update [BBSXP_Threads] Set ThreadStatus="&ThreadStatus&" where ThreadID="&ThreadID&"")
	case "Subscription"
		ThreadID=RequestInt("ThreadID")
		sql="Select * from [BBSXP_Subscriptions] where UserName='"&CookieUserName&"' and ThreadID="&ThreadID&""
		Rs.open sql,conn,1,3
		if Rs.eof then
			Rs.addnew
			Rs("UserName")=CookieUserName
			Rs("ThreadID")=ThreadID
			Rs("Email")=CookieUserEmail
			Rs.update
			BgImage="tracktopic-on.gif"
			ButtonText="取消订阅"
		else
			Execute("Delete from [BBSXP_Subscriptions] where UserName='"&CookieUserName&"' and ThreadID="&ThreadID&"")
			BgImage="tracktopic.gif"
			ButtonText="订阅主题"
		end if
		Rs.close
		%><a class="CommonImageTextButton" style="BACKGROUND-IMAGE: url(images/<%=BgImage%>)" href="javascript:Ajax_CallBack(false,'ThreadSubscription','Loading.asp?Menu=Subscription&amp;ThreadID=<%=ThreadID%>')"><%=ButtonText%></a><%
	case "Threadstar"

		ThreadID=RequestInt("ThreadID")
		VoteValue=RequestInt("Rate")
		
			sql="Select * From [BBSXP_PostRating] where UserName='"&CookieUserName&"' and ThreadID="&ThreadID&""
			Rs.Open SQL,Conn,1,3
			if Rs.eof then Rs.addNew
				Rs("ThreadID")=ThreadID
				Rs("Rating")=VoteValue
				Rs("UserName")=CookieUserName
				Rs("DateCreated")=Now()
			Rs.update
			Rs.close
			
		RatingSum=Execute("Select sum(Rating) from [BBSXP_PostRating] where ThreadID="&ThreadID&"")(0)
		TotalRatings=Execute("Select count(Rating) from [BBSXP_PostRating] where ThreadID="&ThreadID&"")(0)

		sql="Select * from [BBSXP_Threads] where ThreadID="&ThreadID&""
		Rs.Open SQL,Conn,1,3
			Rs("RatingSum")=RatingSum
			Rs("TotalRatings")=TotalRatings
		Rs.update
			RatingSum=Rs("RatingSum")
			TotalRatings=Rs("TotalRatings")
		Rs.close

		Threadstar=RatingSum/TotalRatings

		Response.write(Threadstar)

	case "CheckUserName"
		UserName=HTMLEncode(Request.QueryString("UserName"))
		UserNameLength=RequestInt("UserNameLength")
		if len(UserName)<>UserNameLength then
			Response.write("<img src='images/check_error.gif' />&nbsp;您输入的用户名“"&UserName&"”含有URL所不能传送的字符")
			Response.end
		end if
		if Execute("Select UserID From [BBSXP_Users] where UserName='"&UserName&"'" ).eof Then
			Response.write("<img src='images/check_right.gif' />")
		else
			Response.write("<img src='images/check_error.gif' align=absmiddle />&nbsp;"&UserName&" 已经有人使用，请另选一个!")
		end if
	case "CheckMail"
		UserEmail=HTMLEncode(Request.QueryString("Mail"))
		If Execute("Select UserID From [BBSXP_Users] where UserEmail='"&UserEmail&"'" ).eof Then
			Response.write("<img src='images/check_right.gif' />")
		else
			Response.write("<img src='images/check_error.gif' />&nbsp;"&UserEmail&" 已经有人使用，请另选一个。")
		end if
	case "CheckVerifyCode"
		VerifyCode=Request.QueryString("VerifyCode")
		If VerifyCode=Session("VerifyCode") Then
			Response.write("<img src='images/check_right.gif' />")
		else
			Response.write("<img src='images/check_error.gif' />&nbsp;您的验证码输入错误，请重新输入或点击刷新验证码图片")
		end if
	case "IsObjInstalled"
		strClassString=Request.QueryString("Object")
		On Error Resume Next
		IsInstalled = "<img src='images/check_error.gif' /> 您的服务器不支持 "&Request.QueryString("Object")&" 组件"
		Set xTestObj = Server.CreateObject(strClassString)
		If 0 = Err Then IsInstalled = "<img src='images/check_right.gif' />"
		Set xTestObj = Nothing
		On Error GoTo 0
		Response.write(IsInstalled)
	case "Preview"
		Subject=unescape(Request.Form("Subject")&Request.Form("PostSubject"))
		Body=unescape(Request.Form("Body"))
%>
<table id=CommonListArea cellspacing="1" cellpadding="5" width="100%" align="center" border="0">
	<tr id=CommonListTitle><td><div style="float:left">预览</div><div style="float:right"><a href="javascript:ToggleMenuOnOff('Preview')">关闭</a></div></td></tr>
	<tr id="CommonListHeader"><td><div style="float:left"><b><%=HTMLEncode(Subject)%></b></div><div style="float:right"><%=now()%></div></td></tr>
	<tr id=CommonListCell><td><%=YbbEncode(BodyEncode(Body))%></td></tr>
	<tr id="CommonListCell"><td align="right"><input type="Button" value=" 发表 " onclick="javascript:document.form.EditSubmit.click()"></td></tr>
</table>
<%
end select

Sub ForumListLoad(GroupID,ParentID)
	sql="Select * From [BBSXP_Forums] where GroupID="&GroupID&" and ParentID="&ParentID&" and IsActive=1 order by SortOrder"
	Set Rs1=Execute(sql)
	do while not rs1.eof
		ForumsList=ForumsList&"<option value='"&rs1("ForumID")&"'>"&string(ii,"　")&"&gt; "&rs1("ForumName")&"</option>"
		ii=ii+1
		ForumListLoad GroupID,rs1("ForumID")
		ii=ii-1
		rs1.Movenext
	loop
	Set Rs1 = Nothing
End Sub
%>