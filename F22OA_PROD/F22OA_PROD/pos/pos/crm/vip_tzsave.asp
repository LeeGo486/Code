<!--#include file="../f22/inc/function.asp"-->
<%
response.CacheControl = "no-cache"
response.Charset = "gb2312"
vipid=trim(request.Form("vipid"))
tzname=trim(request.Form("tzname"))
Server.URLEncode(tzname)
tzid=trim(request.Form("tzid"))
msg = ""
success = "flase"

	set rs=server.CreateObject("adodb.recordset")
	rs.ActiveConnection = cn
	rs.LockType = 3
	sql= "select top 1 * from vip_user where vipid='"&vipid&"'"
	rs.Source = sql
	rs.open
	rs("tz_name")=tzname
    rs("employeeid")=tzid
    rs.Update
	rs.close
	set rs= nothing
success = "true"

response.write "{'msg':'"&msg&"','success':'"&success&"'}"

%>