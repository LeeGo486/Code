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
					msg = ""&vipcodejm&"��������ԭ�����Ͳ������"
				elseif rs("vipid")<>"" then
					msg = ""&vipcodejm&"�ѱ�ʹ�ã�"
				else
					msg = ""&vipcodejm&"����ʹ�ã�"
					success = "true"
				end if
			else
					msg = ""&vipcodejm&"�����ڣ�"
			end if
		rs.close
	set rs= nothing
else
	msg = "���Ų���Ϊ�գ�"
end if
response.write "{'msg':'"&msg&"','success':'"&success&"'}"

%>