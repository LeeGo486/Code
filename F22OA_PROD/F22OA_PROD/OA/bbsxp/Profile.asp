<!-- #include file="Setup.asp" -->
<%
HtmlTop
if SiteConfig("RequireAuthenticationForProfileViewing")=1 and CookieUserName=empty then error("������<a href=Login.asp?ReturnUrl="&ReturnUrl&">��¼</a>����������������")

UserName=HTMLEncode(Request("UserName"))
sql="Select * from [BBSXP_Users] where UserName='"&UserName&"'"
Set Rs=Execute(sql)
	if Rs.eof then error("�û���"&UserName&"�������ϲ�����")
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
<title>�鿴<%=Rs("UserName")%>������ - <%=SiteConfig("SiteName")%> - Powered By BBSXP</title>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� �鿴�û���<%=Rs("UserName")%>������</div>

<table cellspacing=0 cellpadding=0 border=0 width=100%>
	<TR>
		<TD vAlign=top width="200">
			<TABLE height="100%" width="95%" cellSpacing=1 cellPadding=5 border=0 id=CommonListArea>
				<tr id=CommonListTitle>
					<TD colspan="2"><%=Rs("UserName")%></td>
				</tr>
				<TR id=CommonListCell>
					<TD colspan="2"><%if SiteConfig("EnableAvatars")=1 then%><center><img src="<%=Rs("UserFaceUrl")%>"  style="max-width:<%=SiteConfig("AvatarWidth")%>px;max-height:<%=SiteConfig("AvatarHeight")%>px;" ></center><%end if%>��<table border="0" cellspacing="0">

	<tr><td>�û�״̬��<%=ShowUserAccountStatus(RS("UserAccountStatus"))%></td></tr>
	<tr><td>�ǡ���ɫ��<%=ShowRole(RS("UserRoleID"))%></td></tr>
	<tr><td>�ȡ�������<%=RankName%></td></tr>
	<tr><td>ע�����ڣ�<%=FormatDateTime(Rs("UserRegisterTime"),2)%></td></tr>
	<tr><td>������<%=FormatDateTime(Rs("UserActivityTime"),2)%></td></tr>
	<tr><td>����������<%=Rs("Reputation")%></td></tr>
	<tr><td>�� �� ����<%=Rs("TotalPosts")%></td></tr>
	<tr><td>�𡡡�Ǯ��<%=Rs("UserMoney")%></td></tr>
	<tr><td>�� �� ֵ��<%=Rs("experience")%></td></tr>

						</table>
					</TD>
				</TR>
				<TR id=CommonListTitle>
					<TD colspan="2">ѡ��</td>
				</TR>
				<TR id=CommonListCell>
					<TD>
						<table  border="0">




							
							<%if CookieUserName<>"" then
							
							if CookieUserName=Rs("UserMate") or CookieUserName=Rs("UserName") and Rs("UserMate")<>"" then%>
							<tr>
								<td><img src=images/divorce.gif></td>
								<td><span id="UserMate"><a href="javascript:Ajax_CallBack(false,'UserMate','UserMate.asp?menu=divorce');">�� <%=Rs("UserMate")%> ���</a></span></td>
							</tr>
							<%else%>
							<tr>
								<td><img src=images/Marry.gif></td>
								<td><span id="UserMate"><a href="javascript:Ajax_CallBack(false,'UserMate','UserMate.asp?menu=MarryRequest&TargetUser=<%=Rs("UserName")%>');">�� <%=Rs("UserName")%> ���</a></span></td>
							</tr>
							<%
							end if
							end if
							
							
							if CookieUserName=Rs("UserName") then%>
							<tr>
								<td><img src=images/edit.gif></td>
								<td><a href="EditProfile.asp">�༭�ҵ�����</a></td>
							</tr>
							<%end if%>
							<tr>
								<td><img src=images/favorite.gif></td>
								<td><a href="MyFavorites.asp?menu=FavoriteFriend&FriendUserName=<%=Rs("UserName")%>">�� <%=Rs("UserName")%> ��Ϊ����</a></td>
							</tr>
							<%if CookieUserName<>empty then%>
							<tr>
								<td><img src=images/privatemessage.gif></td>
								<td><a href="javascript:BBSXP_Modal.Open('MyMessage.asp?menu=Post&RecipientUserName=<%=Rs("UserName")%>',600,350);">�� <%=Rs("UserName")%> ����ѶϢ</a></td>
							</tr>
							<tr>
								<td><img src=images/reputation.gif></td>
								<td><a href="javascript:BBSXP_Modal.Open('Reputation.asp?CommentFor=<%=Rs("UserName")%>',550,200);">�� <%=Rs("UserName")%> ��������</a></td>
							</tr>
							<%end if%>
							
							<tr>
								<td><img src=images/email.gif></td>
								<td><a target="_blank" href="mailto:<%=Rs("UserEmail")%>">�� <%=Rs("UserName")%> �����ʼ�</a></td>
							</tr>


							<%if Rs("WebAddress")<>"" then%>
							<tr>
								<td><img src=images/homepage.gif></td>
								<td><a target="_blank" href="<%=Rs("WebAddress")%>">�鿴 <%=Rs("UserName")%> ����ҳ</a></td>
							</tr>
							<%
							end if
							
							if Rs("WebLog")<>"" then%>
							<tr>
								<td><img src=images/weblog.gif></td>
								<td><a target="_blank" href="<%=Rs("WebLog")%>">�鿴 <%=Rs("UserName")%> �Ĳ���</a></td>
							</tr>
							<%
							end if
							
							if Rs("WebGallery")<>"" then%>
							<tr>
								<td><img src=images/webgallery.gif></td>
								<td><a target="_blank" href="<%=Rs("WebGallery")%>">�鿴 <%=Rs("UserName")%> �����</a></td>
							</tr>
							<%end if%>
							<tr>
								<td><img src=images/search.gif></td>
								<td><a href="ShowBBS.asp?menu=MyTopic&UserName=<%=Rs("UserName")%>">���� <%=Rs("UserName")%> ������</a></td>
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
				<TD align=Left>��������</TD>
			</TR>
       		<TR id=CommonListCell>
				<TD>
				<table border="0" width="100%" cellspacing="0">
	<tr><td>�� �֣�<%=Rs("RealName")%></td></tr>
	<tr><td>ͷ �Σ�<%=Rs("UserTitle")%></td></tr>
	<tr><td>�� ��<%=ShowUserSex(Rs("UserSex"))%></td></tr>
	<tr><td>�� �գ�<%=Rs("birthday")%></td></tr>
	<tr><td>�� Ф��<%=Zodiac(Rs("birthday"))%></td></tr>
	<tr><td>�� ����<%=Horoscope(Rs("birthday"))%></td></tr>
	<tr><td>�� ż��<a href="Profile.asp?UserName=<%=Rs("UserMate")%>"><%=Rs("UserMate")%></a></td></tr>
	<tr><td>ְ ҵ��<%=Rs("Occupation")%></td></tr>
	<tr><td>�� Ȥ��<%=Rs("Interests")%></td></tr>	
	<tr><td>�� ַ��<%=Rs("Address")%></td></tr>	
				</table>
				</TD>
			</TR>
				</TD>
			</TR>
		</TABLE>
		



		<%if Rs("UserBio")<>"" then%>
		<TABLE WIDTH=100% cellSpacing=1 cellPadding=5 align=center border=0 id=CommonListArea>
			<TR id=CommonListTitle>
				<TD align=Left>���</TD>
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
				<TD align=Left>ǩ��</TD>
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
					<td class=PannelOn id=PannelHeader1 onclick='LoadComment("PannelHeader1","CommentFor=<%=Rs("UserName")%>")'>���˶� <%=Rs("UserName")%> ������</td>
					<td class=PannelOff id=PannelHeader2 onclick='LoadComment("PannelHeader2","CommentBy=<%=Rs("UserName")%>")'><%=Rs("UserName")%> �����˵�����</td>
					<td width=40% class='TableRight'>��</td>
				</tr>
			</table>
			<span id=CommentArea>
				<script language="javascript">Ajax_CallBack(false,'CommentArea','Loading.asp?menu=Reputation&CommentFor=<%=Rs("UserName")%>');</script>
			</span>
		<%if Rs("UserNote")<>"" and BestRole=1 then%>
		<TABLE WIDTH=100% cellSpacing=1 cellPadding=5 align=center border=0 id=CommonListArea>
			<TR id=CommonListTitle>
				<TD align=Left>��ע�����������������Ա�ɼ���</TD>
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

<center><br><input onclick="history.back()" type="button" value=" &lt;&lt; �� �� "> <br></center>
<%
Set Rs = Nothing
HtmlBottom
%>