<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%cn=session("cn")%>
<%'response.ContentType="application/rtf"
response.ContentType="text/html"
set rs=server.createobject("adodb.recordset")
rs.open "select isnull(b.jobsheet,'') from j_user a,j_powergrp b where a.powergroup=b.powergrpid and a.userid='"&session("dm").System_userid&"'",cn
if not rs.eof then
  response.Write replace(rs(0),vbcrlf,"<br>")
end if
rs.close
set rs=nothing
set cn=nothing%>
