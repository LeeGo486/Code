<!-- #include file="conn.asp" -->
<%if instr(""&ReturnUrl&"","http://"&Server_Name&"") = 0 then ReturnURL="Default.asp"%>
<html>
<head>
	<title><%=SiteConfig("SiteName")%> - Powered By BBSXP</title>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<meta name="keywords" content="<%=SiteConfig("MetaKeywords")%>" />
	<meta name="description" content="<%=SiteConfig("MetaDescription")%>" />
	<meta name="GENERATOR" content="<%=ForumsProgram%> (Build: <%=ForumsBuild%>)" />
	<Link href="Themes/<%=RequestCookies("Themes")%>/Common.css" rel=stylesheet />
</head>

<script type="text/javascript" src="Utility/MenuTree.js"></script>
<script language="JavaScript">
	if(self != top){top.location=self.location;}
	function switchSysBar() {
		if (document.getElementById("frmTitle").style.display == ""){
			document.getElementById("frmTitle").style.display = "none";
			document.getElementById("frmImg").src="images/switchOff.gif"
		}
		else {
			document.getElementById("frmTitle").style.display = "";
			document.getElementById("frmImg").src="images/switchOn.gif"
		}
	}
	if(top != self) {top.location = self.location;}
</script>


<body scroll="no" id="FrameLeftMenu" >


<table cellPadding="0" cellSpacing="0" border="0" width="100%" height="100%">
	<tr>
		<td id="frmTitle">
<div style="width: 170px; height: 100%;white-space:nowrap;overflow: auto;">
<br>
��<b><%=SiteConfig("SiteName")%></b><br>
��<a href="Default.asp" target="main">��̳��ҳ</a> | <a href="Help.asp" target="main">ʹ�ð���</a><br>
��<a href="ShowBBS.asp" target="main">��������</a> | <a href="ViewOnline.asp" target="main">�������</a><br><br>

<script language="JavaScript">
var yuzimenu=new menutree('yuzimenu','main');
<%ClubTree%>
yuzimenu.init();
</script>
</div>
		</td>
		<td width="100%" height="100%">
		
		    <table border="0" cellPadding="0" cellSpacing="0" height="100%" style="position: absolute;">
				<tr>
					<td><a href="javascript:switchSysBar()"><img id="frmImg" src="images/switchOn.gif" border="0"></a></td>
				</tr>
			</table>

			<iframe frameborder="0" name="main" src="<%=ReturnURL%>"  width="100%" height="100%"></iframe>
		</td>
	</tr>
</table>
</body>
</html>


<%
Sub ClubTree
	GroupGetRow = FetchEmploymentStatusList("Select GroupID,GroupName From [BBSXP_Groups] where SortOrder>0 order by SortOrder")
	if Not IsArray(GroupGetRow) then Exit Sub

	for i=0 to Ubound(GroupGetRow,2)
		Response.Write "yuzimenu.addFolder('"&GroupGetRow(1,i)&"','default.asp?GroupID="&GroupGetRow(0,i)&"');" & vbCrlf
		ForumListTree GroupGetRow(0,i),0
		Response.Write "yuzimenu.endFolder();" & vbCrlf
	next
End Sub

Sub ForumListTree(GroupID,ParentID)
	if ParentID=0 then
		sql="GroupID="&GroupID&" and ParentID=0"
	else
		sql="ParentID="&GroupID&""
	end if
	
	ForumGetRow = FetchEmploymentStatusList("Select ForumID,ForumName From [BBSXP_Forums] where "&sql&" and SortOrder>0 and IsActive=1 order by SortOrder")
	if Not IsArray(ForumGetRow ) then Exit Sub

	for j=0 to Ubound(ForumGetRow,2)
		if Execute("Select ForumID from [BBSXP_Forums] where ParentID="&ForumGetRow(0,j)&"").eof then
			Response.Write "yuzimenu.addNode('"&ForumGetRow(1,j)&"','ShowForum.asp?ForumID="&ForumGetRow(0,j)&"',false);" & vbCrlf
			ForumListTree ForumGetRow(0,j),1
		else
			Response.Write "yuzimenu.addFolder('"&ForumGetRow(1,j)&"','ShowForum.asp?ForumID="&ForumGetRow(0,j)&"',false);" & vbCrlf
			ForumListTree ForumGetRow(0,j),1
			Response.Write "yuzimenu.endFolder();" & vbCrlf
		end if
	next
End Sub
%>