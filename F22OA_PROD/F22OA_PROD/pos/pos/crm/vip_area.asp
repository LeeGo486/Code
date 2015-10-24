<!--#include file="../f22/inc/function.asp"-->
<%
response.CacheControl = "no-cache"
response.Charset = "gb2312"
id=trim(request.Form("id"))
msg = "<option selected></option>"
success = "false"

set rs=server.CreateObject("adodb.recordset")
rs.open " select ID,replace(name,' ','') Name from J_ChinaArea where ParentID= "&id&"  order by Sequence ",cn,1,1
do while not rs.eof
    msg=msg+"<option pid="&rs("ID")&" value="&rs("Name")&" >"&rs("Name")&"</option>"
    success = "true"
rs.movenext
loop

rs.close
set rs= nothing

response.write "{'msg':'"&msg&"','success':'"&success&"'}"
%>