<!-- #include file="inc/const.asp" -->
<%cn=session("cn")%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href='skin/<%=session("skindir")%>/default.css' rel='stylesheet' type='text/css'>
<meta http-equiv="refresh" content="100">
<title>ZHX_OAMAIN</title>
<script language="javascript">
function openurl(url){
  top.mainFrame.main.location.href=url;
}
function tframe(){
  window.parent.topFrame.oa_tool();
}
function qq(){
  window.open("qq/qq.asp","","width=165,height=500,status=no,menubar=no,toolbar=no,scrollbars=yes,resizable=yes");
}
function com(str){
  var s=str.split("-");
  var h="index.asp?stype=2&com="+s[1]+"&action=search&ext="+s[0];
  //alert(h);
 
  //parent.main.location.href="f22/index.asp?stype=2&com="+s[1]+"&action=search&ext="+s[0];
}
</script>
</head>
<body background="skin/<%=session("skindir")%>/image/index_15.gif" topmargin="0" leftmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="index_head">
  <tr>
    <td width=80><a href="javascript:tframe();">在线</a>：<font color="#FF0000">10</font> </td>
    <td background="skin/<%=session("skindir")%>/image/index_152.gif" width="8"></td>	
    <td width=20 align=center valign=middle><img src="skin/<%=session("skindir")%>/image/RTX_on_line.gif"></td>
	<td width=100><a href="javascript:qq();"><%=session("dm").System_username%></a>(<%=session("dm").System_userid%>)</td>
    <td background="skin/<%=session("skindir")%>/image/index_152.gif" width="8">&nbsp;</td>
	<td width=110><a href="javascript:void(null);" onclick="openurl('f22/f22_index1.asp')" onFocus=this.blur()>共<font color="#FF0000"><span id=nums></span></font>条信息</a></td>
	<td background="skin/<%=session("skindir")%>/image/index_152.gif" width="8">&nbsp;</td>
    <td valign="middle">&nbsp;<marquee direction=left height=15 scrollamount=2 scrolldelay=20 width="100%" onMouseOver="this.stop();" onMouseOut="this.start();">
	<%showtask%></marquee></td>
    <td background="skin/<%=session("skindir")%>/image/index_152.gif" width="8">&nbsp;</td>
    <td width=300>
	<table width="300" height="25" border="0" cellspacing="0" cellpadding="0" class="index_head">
	<tr valign=middle>
	<td><img src="skin/<%=session("skindir")%>/image/index_head1.jpg" border=0></td><td><a href="javascript:void(null);" onclick="openurl('')" onFocus=this.blur()>工作安排</a></td>
	<td><img src="skin/<%=session("skindir")%>/image/index_head2.jpg" border=0></td><td><a href="javascript:void(null);" onclick="openurl('')" onFocus=this.blur()>便笺</a></td>
	<td><img src="skin/<%=session("skindir")%>/image/index_head3.jpg" border=0 ></td><td><a href="javascript:void(null);" onclick="openurl('f22/f22_index1.asp')" onFocus=this.blur()>任务</a></td>
	<td><img src="skin/<%=session("skindir")%>/image/index_head4.jpg" border=0></td><td><a href="mailto: " onFocus=this.blur()>E-mail</a></td>
	<td><img src="skin/<%=session("skindir")%>/image/index_head5.jpg" border=0></td><td><a href="javascript:void(null);" onclick="showModalDialog('f22/messagesend.asp','send','dialogWidth:500px;dialogHeight:370px;center:yes;help:no;resizable:no;status:no');" onFocus="this.blur()">短信</a></td></tr>
	</table></td>
  </tr>
</table>
<%session("session")=""%>
</body>
</html>
<%sub showtask
dim title,rs,i
set rs=server.createobject("adodb.recordset")
rs.open "f22qry_jmautouser '"&session("dm").System_userid&"','"&session("dm").System_ParentId&"',0",cn
i=0
while not rs.eof 
   if trim(rs("worktype"))="提示" then
   title=title&"&nbsp;&nbsp;&nbsp;"
  title=title&"<font color=#FF0000>["&rs("worktype")&"]</font><a target='iFrmRef' href='javascript:void(null);' onclick=""javascript:com('"&rs("worktype")&"-"&rs("powerbillid")&"')"" onFocus=this.blur()>"&left(rs("title"),instr(rs("title")&"-","-"))&"</a>"
   'title=title&"<font color=#FF0000>["&rs("worktype")&"]</font><a target='iFrmRef' href=""javascript:com('"&rs("worktype")&"-"&rs("powerbillid")&"')"" onFocus=this.blur()>"&left(rs("title"),instr(rs("title")&"-","-"))&"</a>"
	i=i+1
	end if
	rs.movenext
	
wend
response.write("<script>document.all.nums.innerHTML='"&i&"'</script>")
response.write(title)
rs.close
set rs=nothing
end sub%>
