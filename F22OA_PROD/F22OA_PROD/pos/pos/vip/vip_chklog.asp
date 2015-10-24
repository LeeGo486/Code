<!--#include file="../f22/inc/function.asp"-->
<%
dim vipid
vipid=trim(request.QueryString("vipid"))
%>
<html>
<style type="text/css">
<!--
div {
	padding: 5px;
}
-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=vipid%> - 升级审核日志</title>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
<base target="_self"></head>
</head>
<body>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="bar">
  <tr>
    <td align="center"><%=vipid%> - 升级审核日志</td>
  </tr>
</table>
<div style="padding:10px;">
<%
	set rs=server.CreateObject("adodb.recordset")
		sql="select dtype,comment,crdate,crusername,orderid from vip_comment where vipid='"&vipid&"' order by orderid asc"
		rs.open sql,cn,1,1
			do while not rs.eof 
				if i mod 2=0 then
					color="#f4f4f4"
				else
					color="#FFFFFF"
				end if
				response.write "<div style='background:"&color&";'>"
				response.write rs("orderid")&".<strong>"&rs("dtype")&"：</strong>"
				response.write rs("comment")
				response.write "<div align=right>"&rs("crdate")&" by "&rs("crusername")&"</div>"
				response.write "</div>"
				i=i+1
			rs.movenext
			loop
		rs.close
	set rs=nothing
%>
</div>

<div align="center">
  <input type="button" name="button" onClick="window.close()" value="关 闭">
</div>
</body>
</html>
