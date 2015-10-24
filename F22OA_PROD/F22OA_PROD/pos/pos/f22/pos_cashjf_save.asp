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
	
		if vipname="" and mobtel="" then back "请输入姓名与手机号码!","",ys
	
	  sql="select vipcode from vip_user where vipname = '"&vipname&"' and mobtel = '"&mobtel&"' and isnull(vipcode,'')<>''"
		rs.open sql,cn,1,1
			if rs.eof and rs.bof then
				back "找不到该手机与姓名匹配的会员档案!","",ys
			else
				back "",xvipcode,ys
			end if
		rs.close
	end if
	
	if xvipcode="" and vipcode="" then back "请输入VIP卡!","",ys
	
	if xvipcode<>"" then
		sql=chkvip(xvipcode,0)
		rs.open sql,cn,1,1
		if rs.eof then
			back "此VIP卡不存在或已失效!","",ys
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
		 back "积分不够，请重新选择！",vipcode,""
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
		close "已确认此抵扣方案，请继续收银\n\n进行最终抵扣，否则无效！"
elseif session("cf_VipSet_jfdx")=2 then

	fjfcash = request("inputrtp")
	fjfnums = request("inputrtj")
	if fjfcash<>"" and fjfnums<>"" then
		session("fjfcash")=fjfcash
		session("fjfnums")=fjfnums
		response.write "<script>javascript:window.returnValue='"&vipcode&"{$}"&fjfcash&"{$}"&fjfnums&"';</script>"
		close "已确认使用积分："&fjfnums&"\n抵扣现金："&fjfcash&"元\n请继续收银，进行最终抵扣，否则无效！"
	end if
end if
set rs=nothing
cn.close
set cn=nothing%>
