<!--#include file="inc/function.asp"-->
<%
	vipcode=request("vipcode")
	xvipcode=request("xvipcode")
	val=request("val")
	ys=request("ys")
	
	schtype=request("schtype")
	vipname=request("vipname")
	mobtel=request("mobtel")
	centum=request("centum")
if val=""  then 
	session("fjfnums")=""
	session("fjfcash")=""
end if

function back(msg,vip,ys)
	response.Redirect("pos_cashjf.asp?vipcode="&vip&"&ys="&ys&"&msg="&server.URLEncode(msg))
end function

set rs=server.CreateObject("adodb.recordset")
if vipcode="" then
	if schtype="mobile" then
	
		if vipname="" and mobtel="" then back "�������������ֻ�����!","",ys
	
	  sql="select vipcode from vip_user where vipname = '"&vipname&"' and mobtel = '"&mobtel&"' and isnull(vipcode,'')<>''"
		rs.open sql,cn,1,1
			if rs.eof and rs.bof then
				back "�Ҳ������ֻ�������ƥ��Ļ�Ա����!","",ys
			else
				back "",xvipcode,ys
			end if
		rs.close
	end if
	
	if xvipcode="" and vipcode="" then back "������VIP��!","",ys
	
	if xvipcode<>"" then
		sql=chkvip(xvipcode,0)
		rs.open sql,cn,1,1
		if rs.eof then
			back "��VIP�������ڻ���ʧЧ!","",ys
		else
			back "",xvipcode,ys
		end if
		rs.close
	end if
end if
if session("cf_VipSet_jfdx")=1 then
    if val="" then
	   back "",vipcode,""
	end if
    sql="select isnull(fjfnums,0) as fjfnums,isnull(fjfcash,0) as fjfcash,fjfcertname from "&session("vipver_db")&"vip_jfcert where fjfcertid="&val
	rs.open sql,cn,1,1
	if not rs.eof then
	  if cdbl(centum)<cdbl(rs("fjfnums")) then
		 back "���ֲ�����������ѡ��",vipcode,""
	  else
	    fjfnums=rs("fjfnums")
	    fjfcash=rs("fjfcash")
	    fjfcertname=rs("fjfcertname")
	  end if
	end if
	rs.close
		session("fjfnums")=fjfnums
		session("fjfcash")=fjfcash
		response.write "<script>javascript:window.returnValue='"&vipcode&"{$}"&fjfcash&"{$}"&fjfnums&"';</script>"
		close "��ȷ�ϴ˵ֿ۷��������������\n\n�������յֿۣ�������Ч��"
elseif session("cf_VipSet_jfdx")=2 then

	fjfcash = request("inputrtp")
	fjfnums = request("inputrtj")
	if fjfcash<>"" and fjfnums<>"" then
		session("fjfcash")=fjfcash
		session("fjfnums")=fjfnums
		response.write "<script>javascript:window.returnValue='"&vipcode&"{$}"&fjfcash&"{$}"&fjfnums&"';</script>"
		close "��ȷ��ʹ�û��֣�"&fjfnums&"\n�ֿ��ֽ�"&fjfcash&"Ԫ\n������������������յֿۣ�������Ч��"
	end if
end if
set rs=nothing
cn.close
set cn=nothing%>
