<!-- #include file="Setup.asp" -->
<%
HtmlTop
if SiteConfig("RequireAuthenticationForProfileViewing")=1 and CookieUserName=empty then error("您必须<a href=Login.asp?ReturnUrl="&ReturnUrl&">登录</a>后才能浏览个人资料")

UserName=HTMLEncode(Request("UserName"))
sql="Select * from [BBSXP_Users] where UserName='"&UserName&"'"
Set Rs=Execute(sql)
	if Rs.eof then error("用户“"&UserName&"”的资料不存在")
	ShowRank(Rs("experience"))

	
	XMLDOM.loadxml("<bbsxp>"&Rs("UserInfo")&"</bbsxp>")
		QQ=SelectSingleNode("QQ")
		ICQ=SelectSingleNode("ICQ")
		AIM=SelectSingleNode("AIM")
		MSN=SelectSingleNode("MSN")
		Yahoo=SelectSingleNode("Yahoo")
		Skype=SelectSingleNode("Skype")
	Set XMLDOM=Nothing


%>
<title>查看<%=Rs("UserName")%>的资料 - <%=SiteConfig("SiteName")%> - Powered By BBSXP</title>
<div id="CommonBreadCrumbArea"><%ClubTree%> → 查看用户“<%=Rs("UserName")%>”资料</div>

<table cellspacing=0 cellpadding=0 border=0 width=100%>
	<TR>
		<TD vAlign=top width="200">
			<TABLE height="100%" width="95%" cellSpacing=1 cellPadding=5 border=0 id=CommonListArea>
				<tr id=CommonListTitle>
					<TD colspan="2"><%=Rs("UserName")%></td>
				</tr>
				<TR id=CommonListCell>
					<TD colspan="2"><%if SiteConfig("EnableAvatars")=1 then%><center><img src="<%=Rs("UserFaceUrl")%>"  style="max-width:<%=SiteConfig("AvatarWidth")%>px;max-height:<%=SiteConfig("AvatarHeight")%>px;" ></center><%end if%>　<table border="0" cellspacing="0">

	<tr><td>用户状态：<%=ShowUserAccountStatus(RS("UserAccountStatus"))%></td></tr>
	<tr><td>角　　色：<%=ShowRole(RS("UserRoleID"))%></td></tr>
	<tr><td>等　　级：<%=RankName%></td></tr>
	<tr><td>注册日期：<%=FormatDateTime(Rs("UserRegisterTime"),2)%></td></tr>
	<tr><td>最近活动：<%=FormatDateTime(Rs("UserActivityTime"),2)%></td></tr>
	<tr><td>声　　望：<%=Rs("Reputation")%></td></tr>
	<tr><td>发 帖 数：<%=Rs("TotalPosts")%></td></tr>
	<tr><td>金　　钱：<%=Rs("UserMoney")%></td></tr>
	<tr><td>经 验 值：<%=Rs("experience")%></td></tr>

						</table>
					</TD>
				</TR>
				<TR id=CommonListTitle>
					<TD colspan="2">选项</td>
				</TR>
				<TR id=CommonListCell>
					<TD>
						<table  border="0">




							
							<%if CookieUserName<>"" then
							
							if CookieUserName=Rs("UserMate") or CookieUserName=Rs("UserName") and Rs("UserMate")<>"" then%>
							<tr>
								<td><img src=images/divorce.gif></td>
								<td><span id="UserMate"><a href="javascript:Ajax_CallBack(false,'UserMate','UserMate.asp?menu=divorce');">与 <%=Rs("UserMate")%> 离婚</a></span></td>
							</tr>
							<%else%>
							<tr>
								<td><img src=images/Marry.gif></td>
								<td><span id="UserMate"><a href="javascript:Ajax_CallBack(false,'UserMate','UserMate.asp?menu=MarryRequest&TargetUser=<%=Rs("UserName")%>');">向 <%=Rs("UserName")%> 求婚</a></span></td>
							</tr>
							<%
							end if
							end if
							
							
							if CookieUserName=Rs("UserName") then%>
							<tr>
								<td><img src=images/edit.gif></td>
								<td><a href="EditProfile.asp">编辑我的资料</a></td>
							</tr>
							<%end if%>
							<tr>
								<td><img src=images/favorite.gif></td>
								<td><a href="MyFavorites.asp?menu=FavoriteFriend&FriendUserName=<%=Rs("UserName")%>">将 <%=Rs("UserName")%> 加为好友</a></td>
							</tr>
							<%if CookieUserName<>empty then%>
							<tr>
								<td><img src=images/privatemessage.gif></td>
								<td><a href="javascript:BBSXP_Modal.Open('MyMessage.asp?menu=Post&RecipientUserName=<%=Rs("UserName")%>',600,350);">给 <%=Rs("UserName")%> 发送讯息</a></td>
							</tr>
							<tr>
								<td><img src=images/reputation.gif></td>
								<td><a href="javascript:BBSXP_Modal.Open('Reputation.asp?CommentFor=<%=Rs("UserName")%>',550,200);">对 <%=Rs("UserName")%> 进行评价</a></td>
							</tr>
							<%end if%>
							
							<tr>
								<td><img src=images/email.gif></td>
								<td><a target="_blank" href="mailto:<%=Rs("UserEmail")%>">给 <%=Rs("UserName")%> 发送邮件</a></td>
							</tr>


							<%if Rs("WebAddress")<>"" then%>
							<tr>
								<td><img src=images/homepage.gif></td>
								<td><a target="_blank" href="<%=Rs("WebAddress")%>">查看 <%=Rs("UserName")%> 的主页</a></td>
							</tr>
							<%
							end if
							
							if Rs("WebLog")<>"" then%>
							<tr>
								<td><img src=images/weblog.gif></td>
								<td><a target="_blank" href="<%=Rs("WebLog")%>">查看 <%=Rs("UserName")%> 的博客</a></td>
							</tr>
							<%
							end if
							
							if Rs("WebGallery")<>"" then%>
							<tr>
								<td><img src=images/webgallery.gif></td>
								<td><a target="_blank" href="<%=Rs("WebGallery")%>">查看 <%=Rs("UserName")%> 的相册</a></td>
							</tr>
							<%end if%>
							<tr>
								<td><img src=images/search.gif></td>
								<td><a href="ShowBBS.asp?menu=MyTopic&UserName=<%=Rs("UserName")%>">搜索 <%=Rs("UserName")%> 的主题</a></td>
							</tr>
							
							
							<%if QQ<>"" then%>
							<tr>
								<td><img src=images/im_qq.gif></td>
								<td><a target="blank" href="http://wpa.qq.com/msgrd?V=1&Uin=<%=QQ%>&menu=yes&Site=<%=SiteConfig("SiteName")%>"><%=QQ%></a></td>
							</tr>
							<%
							end if
							
							if MSN<>"" then%>
							<tr>
								<td><img src=images/im_msn.gif></td>
								<td><a target="blank" href="http://members.msn.com/?mem=<%=MSN%>"><%=MSN%></a></td>
							</tr>
							<%
							end if
							
							if AIM<>"" then%>
							<tr>
								<td><img src=images/im_aim.gif></td>
								<td><%=AIM%></td>
							</tr>
							<%
							end if
							
							if Yahoo<>"" then%>
							<tr>
								<td><img src=images/im_yahoo.gif></td>
								<td><%=Yahoo%></td>
							</tr>
							<%
							end if
							if ICQ<>"" then%>
							<tr>
								<td><img src=images/im_icq.gif></td>
								<td><%=ICQ%></td>
							</tr>
							<%
							end if
							if Skype<>"" then%>
							<tr>
								<td><img src=images/im_skype.gif></td>
								<td><%=Skype%></td>
							</tr>
							<%end if%>
						</table>
					</TD>
				</TR>
			</TABLE>
		</TD>
		<TD vAlign=top>

		<TABLE  WIDTH=100% cellSpacing=1 cellPadding=5 align=center border=0 id=CommonListArea>
			<TR id=CommonListTitle>
				<TD align=Left>个人资料</TD>
			</TR>
       		<TR id=CommonListCell>
				<TD>
				<table border="0" width="100%" cellspacing="0">
	<tr><td>名 字：<%=Rs("RealName")%></td></tr>
	<tr><td>头 衔：<%=Rs("UserTitle")%></td></tr>
	<tr><td>性 别：<%=ShowUserSex(Rs("UserSex"))%></td></tr>
	<tr><td>生 日：<%=Rs("birthday")%></td></tr>
	<tr><td>生 肖：<%=Zodiac(Rs("birthday"))%></td></tr>
	<tr><td>星 座：<%=Horoscope(Rs("birthday"))%></td></tr>
	<tr><td>配 偶：<a href="Profile.asp?UserName=<%=Rs("UserMate")%>"><%=Rs("UserMate")%></a></td></tr>
	<tr><td>职 业：<%=Rs("Occupation")%></td></tr>
	<tr><td>兴 趣：<%=Rs("Interests")%></td></tr>	
	<tr><td>地 址：<%=Rs("Address")%></td></tr>	
				</table>
				</TD>
			</TR>
				</TD>
			</TR>
		</TABLE>
		



		<%if Rs("UserBio")<>"" then%>
		<TABLE WIDTH=100% cellSpacing=1 cellPadding=5 align=center border=0 id=CommonListArea>
			<TR id=CommonListTitle>
				<TD align=Left>简介</TD>
			</TR>
			<TR id=CommonListCell>
				<TD><%=Rs("UserBio")%></TD>
			</TR>
		</TABLE>
		<BR>
		<%
		end if
		
		
		if SiteConfig("EnableSignatures")=1 and Rs("UserSign")<>"" then
		%>
		<TABLE WIDTH=100% cellSpacing=1 cellPadding=5 align=center border=0 id=CommonListArea>
			<TR id=CommonListTitle>
				<TD align=Left>签名</TD>
			</TR>
			<TR id=CommonListCell>
				<TD><%=YbbEncode(Rs("UserSign"))%></TD>
			</TR>
		</TABLE>
		<%
		end if%>
		
			<br>
			<table width=100% cellspacing=0 cellpadding=0>		
				<tr height=22 style='text-align:center'>
					<td class=PannelOn id=PannelHeader1 onclick='LoadComment("PannelHeader1","CommentFor=<%=Rs("UserName")%>")'>他人对 <%=Rs("UserName")%> 的评价</td>
					<td class=PannelOff id=PannelHeader2 onclick='LoadComment("PannelHeader2","CommentBy=<%=Rs("UserName")%>")'><%=Rs("UserName")%> 对他人的评价</td>
					<td width=40% class='TableRight'>　</td>
				</tr>
			</table>
			<span id=CommentArea>
				<script language="javascript">Ajax_CallBack(false,'CommentArea','Loading.asp?menu=Reputation&CommentFor=<%=Rs("UserName")%>');</script>
			</span>
		<%if Rs("UserNote")<>"" and BestRole=1 then%>
		<TABLE WIDTH=100% cellSpacing=1 cellPadding=5 align=center border=0 id=CommonListArea>
			<TR id=CommonListTitle>
				<TD align=Left>备注（仅超级版主与管理员可见）</TD>
			</TR>
			<TR id=CommonListCell>
				<TD><%=Rs("UserNote")%></TD>
			</TR>
		</TABLE>
		<%end if%>
		</TD>
	</TR>
</TABLE>
<script language="javascript">
	function LoadComment(ID,menu){
		document.getElementById("PannelHeader1").className = document.getElementById("PannelHeader2").className = 'PannelOff';
		document.getElementById(ID).className = 'PannelOn';
		Ajax_CallBack(false,'CommentArea','Loading.asp?menu=Reputation&'+menu+'');
	}
</script>

<center><br><input onclick="history.back()" type="button" value=" &lt;&lt; 返 回 "> <br></center>
<%
Set Rs = Nothing
HtmlBottom
%>