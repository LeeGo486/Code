<!--#include file="../f22/inc/function.asp"-->
<%
response.CacheControl = "no-cache"
response.Charset = "gb2312"

vipcode=trim(request.Form("vipcode"))
typeid=trim(request.Form("typeid"))
msg = ""
success = "false"

if  session("pos_vipshow")=true  then
  vipcodejm="*****"
else
  vipcodejm=vipcode
end if 


if vipcode<>"" then
vipcode = ucase(vipcode)
	set rs=server.CreateObject("adodb.recordset")
		sql="select vipcardid,isnull(vipid,'') as vipid,isnull(viptypeid,0) as viptypeid from vip_cardvip where vipcardid="&qts(vipcode)
		rs.open sql,cn,1,1
			if not(rs.eof and rs.bof) then
				if rs("viptypeid")<>typeid then
					msg = ""&vipcodejm&"卡类型与原卡类型不相符！"
				elseif rs("vipid")<>"" then
					msg = ""&vipcodejm&"已被使用！"
				else
					msg = ""&vipcodejm&"可以使用！"
					success = "true"
				end if
			else
					msg = ""&vipcodejm&"不存在！"
			end if
		rs.close
	set rs= nothing
else
	msg = "卡号不能为空！"
end if
response.write "{'msg':'"&msg&"','success':'"&success&"'}"

%>