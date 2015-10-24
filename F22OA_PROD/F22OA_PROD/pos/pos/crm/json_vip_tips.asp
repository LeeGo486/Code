<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="inc/function.asp"-->
<%
response.Charset="gb2312"
Response.Buffer=True

set rs=server.CreateObject("adodb.recordset")

if session("cf_VipSet_showTips") then
	dim rs,depotid,sql
	dim VipSet_Tipsjf, VipSet_Tipssr, VipSet_Tipsgq, VipSet_Tipsxf, VipSet_Tipssh
	
	if 	session("cf_VipSet_Tipsjf")<>"" then VipSet_Tipsjf=session("cf_VipSet_Tipsjf") else VipSet_Tipsjf =1000	 end if
	if 	session("cf_VipSet_Tipssr")<>"" then VipSet_Tipssr=session("cf_VipSet_Tipssr") else VipSet_Tipssr =30	 end if
	if 	session("cf_VipSet_Tipsgq")<>"" then VipSet_Tipsgq=session("cf_VipSet_Tipsgq") else VipSet_Tipsgq =30	 end if
	if 	session("cf_VipSet_Tipsxf")<>"" then VipSet_Tipsxf=session("cf_VipSet_Tipsxf") else VipSet_Tipsxf =30	 end if
	if 	session("cf_VipSet_Tipssh")<>"" then VipSet_Tipssh=session("cf_VipSet_Tipssh") else VipSet_Tipssh =30	 end if
	
	set rs=server.CreateObject("adodb.recordset")
	depotid = session("dm").System_DepotID
	sql="oa_getviptips '"&depotid&"',"&VipSet_Tipsjf&","&VipSet_Tipssr&","&VipSet_Tipsgq&","&VipSet_Tipsxf&","&VipSet_Tipssh
	rs.open sql,cn,1,1
	response.write "<div id=""topic_div""><ul>"
		do while not rs.eof
			response.write "<li><a href=""../pos/pos/crm/vip_tips.asp?val="&rs(2)&"&typ="&rs(3)&""" "
			'if rs(1)>0 then response.write "style=""color:red"""
			response.write " title=""VIP信息提示"">"&rs(0)&"："&rs(1)&"位</a></li>"
		rs.movenext
		loop
	rs.close
	set rs=nothing
	response.write "</ul></div>"
end if
%>