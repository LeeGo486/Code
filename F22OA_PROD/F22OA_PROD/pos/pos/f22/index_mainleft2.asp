<!--#include file="inc/function.asp"-->
<html><head>
<meta http-equiv='Content-Type' content='text/html; charset=gb2312'>
<link href='../skin/<%=session("skindir")%>/default.css' rel='stylesheet' type='text/css'>
<link rel="StyleSheet" href="css/dtree.css" type="text/css" />
<script type="text/javascript" src="css/dtree.js"></script>
<style type="text/css">
.tbhide{display:none;}
.tbshow{display:block;}
</style>
</head>

<body topmargin=1 leftmargin="0">
<%
userid=session("dm").System_Userid
oahttp=session("oahttp")
if userid="" then response.write "<script>top.location.href='../../../relogin.aspx';</script>"
sql="A380web_getUserMenu '"&userid&"'"
set rs=server.CreateObject("ADODB.Recordset")
rs.open sql,cn,1,1
if not(rs.eof and rs.bof) then
	response.write "<script type=""text/javascript"">"&vbcr&_
					"d = new dTree('d');"&vbcr&_
					"d.add(0,-1,'<a href=# onclick=d.closeAll()><img src=img/folder.gif align=asbmiddle border=0> 全部关闭</a> / <a href=# onclick=d.openAll()><img src=img/folderopen.gif align=asbmiddle border=0> 全部展开</a>');"&vbcr
	oLen=0
	bID=0
	do while not rs.eof
		aspname=trim(rs("aspname"))
		loadid=trim(rs("loadid"))
		aspxid=trim(rs("aspxid"))
		readme=trim(rs("readme"))
	if aspname<>"F22" then
	id=id+1
		if len(loadid)=3 then
			PID=0
		elseif len(loadid)>oLen then
			bID=PID
			PID=oID
		elseif len(loadid)<oLen then
			PID=bID
		end if
		oLen=len(loadid)
		oID=id
		if left(aspxid,3)="POS" then
			if aspname<>"" then
				target="main"
				aspname=oahttp&"/pos/"&aspname
			else
				target=""
				aspname="javascript: d.o("&id&");"
			end if
		else
			if aspname<>"" then
				target="main"
				aspname=oahttp&"/"&aspname&"?aspxid="&aspxid&"&aspxname="&readme
			else
				target=""
				aspname="javascript: d.o("&id&");"
			end if
		end if
		response.write "d.add("&id&","&PID&",'"&readme&"','"&aspname&"','"&readme&"','"&target&"');"&vbcr
	end if
	rs.movenext
	loop
	response.write "document.write(d);"&vbcr&_
					"d.openAll();"&vbcr&_
					"</script >"&vbcr
end if
rs.close
%>
</body>
</html>