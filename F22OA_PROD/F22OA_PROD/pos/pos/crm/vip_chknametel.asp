<!--#include file="../f22/inc/function.asp"-->
<%
response.CacheControl = "no-cache"
response.Charset = "gb2312"
vipname=trim(request.Form("vipname"))
Server.URLEncode(vipname)
mobtel=trim(request.Form("mobtel"))
msg = ""
success = "true"

if  mobtel<>"" and session("cf_vip_same")=false then
	set rs=server.CreateObject("adodb.recordset")
		
	rs.open " select top 1 a.vipname,b.d_name from vip_user a inner join j_depot b  on a.depotid=b.depotid where a.mobtel='"&mobtel&"'",cn,1,1
	if not rs.eof and not rs.bof then
	   msg = " Vip手机号重复, 顾客姓名为:"&rs(0)&", 店铺:"&rs(1)&"!"
	   success = "false"
	else
       success = "true"
  	end if
	rs.close
		
	set rs= nothing
end if
response.write "{'msg':'"&msg&"','success':'"&success&"'}"

%>