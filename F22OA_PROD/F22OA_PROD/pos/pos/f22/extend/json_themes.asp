<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../inc/function.asp" -->

<%
dim userid,depotid,rs
response.Charset="utf-8"
Response.Buffer=True

userid=trim(session("dm").System_UserId)
depotid=trim(session("dm").System_Depotid)
cn.execute("update i_topics set istate=10 where (getdate()-1)>eddate and istate=2")
set rs=server.CreateObject("adodb.recordset")
response.write "<div id=""topic_div""><ul>"

rs.open "select * from sysobjects where name='F22_getdcTheme'",cn,1,1
if rs.eof and rs.bof then
	response.End()
end if
rs.close()

rs.open "F22_getdcTheme '"&depotid&"'",cn,1,1
if error then response.End() end if
	do while not rs.eof
		response.write "<li>"
			response.write "<a href='../pos/pos/f22/extend/dc_showtheme.asp?dcid="&rs(0)&"' title='"&rs(1)&"'>["&rs(1)&"] "&rs(2)&"</a>"
		response.write "</li>"
	rs.movenext
	loop
rs.close
set rs=nothing
cn.close
set cn=nothing
response.write "</ul></div><div class=""x-clear"" />"
%>