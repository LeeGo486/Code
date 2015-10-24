<%
Response.Expires = 0 
Response.Expiresabsolute = Now() - 1 
Response.AddHeader "pragma","no-cache" 
Response.AddHeader "cache-control","private" 
Response.CacheControl = "no-cache" 
%>
<!--#include file="inc/function.asp"-->
<%dim ds,sql,id,act,c,vipid,depotid,viptypename
act=trim(request("act"))
id=trim(request("id"))
viptypename = trim(request("viptypename"))

'判断刷新截取
if request.cookies("vipflash")("cut")=1 then
   id=mid(id,request.cookies("vipflash")("beg"),request.cookies("vipflash")("cnt"))
end if

depotid=trim(session("dm").System_depotid)
if id="" then
 	' call close("VIP卡号不能为空!")
		CheckAlert "VIP卡号不能为空!",false
else
  id=ucase(id)
end if
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn

select case act
case "check"
  c=check()
  if c<>false then 
		'call close("检测成功,此卡号属于:"+c)
		CheckAlert "检测成功!此卡号属于:"+c,false
	end if
case "add"
  vipid=trim(request.QueryString("vipid"))
  if vipid="" then
    'call close("用户ID出错!请刷新后重试!")
		CheckAlert "用户ID出错!请刷新后重试!",false
  end if
  c=check()
  s=checksend() 
  typ = getposset()

  if typ=true and viptypename <> c and  viptypename <>"" then
    CheckAlert  "当前卡类型是["&c&"]与申请卡类型["&viptypename&"]不一致,不能发卡!",false
  end if
 
  if c<>false then
    cn.execute "update vip_user set vipcode="&qts(id)&" where vipid="&qts(vipid)
    cn.execute "update vip_cardvip set vipid="&qts(vipid)&",vipemit=getdate(),vipemitadd="&qts(depotid)&" where vipcardid="&qts(id)
  end if
  ' call close("发送VIP卡成功!")
		CheckAlert "发送VIP卡成功!!",true
end select

function check()
  dim vtn
  sql=" select viptypename from vip_cardvip a,vip_typevip b "&_
      " where a.viptypeid=b.viptypeid and isnull(a.vipid,'')='' and vipcardid="&qts(id)&" and vipemitadd="&qts(depotid)
  ds.Source = sql
  ds.Open
  if ds.eof then
    ds.close
	set ds=nothing
		'call close("没有此VIP卡或已过期,请核对后重新输入!")
		CheckAlert "没有此VIP卡或已过期!请核对后重新输入!",false
	check=false
  else
    vtn=ds(0)
    ds.close
	sql="select vipname from vip_user where vipcode="&qts(id)
	ds.Source = sql
	ds.Open
	if ds.eof then
	  ds.close
	  check=vtn
	else
      ds.close
	  set ds=nothing
	  'call close("此VIP卡号已发送给别人!请核对后重新输入!")
			CheckAlert "此VIP卡号已发送给别人!请核对后重新输入!",false
	  check=false
	end if
  end if
end function

function checksend() 
  sql=" select vipid from vip_user where vipid="&qts(vipid)&" and isnull(vipcode,'')<>''"
  ds.Source = sql
  ds.Open
  if not ds.eof then
    ds.close
	set ds=nothing		
		CheckAlert "当前用户已发VIP卡，不能重复发卡！",false
	checksend=false
  else 
    ds.close
	set ds=nothing	  
	checksend=true	
  end if
end function

'是否允许发VIP卡类型是否与申请资料相同
function getposset()
     sql="   select 1 from sys_possetup where setid='SendVipCardChk' and value2=1 "
     set rs=server.CreateObject("ADODB.Recordset")
     rs.ActiveConnection = cn
     rs.Source = sql
     rs.Open
     
     if not rs.eof then
        getposset = true
     else
        getposset = false
     end if

     rs.close
     set rs = nothing
end function

function CheckAlert(msg,cls)
  response.Write "<script language='javascript'>"
  response.Write "alert('"& msg &"');"
	if cls then response.write "window.returnValue=true;window.close();"
  response.Write "</script>"
  response.End()
end function


%>
