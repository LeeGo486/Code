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

'�ж�ˢ�½�ȡ
if request.cookies("vipflash")("cut")=1 then
   id=mid(id,request.cookies("vipflash")("beg"),request.cookies("vipflash")("cnt"))
end if

depotid=trim(session("dm").System_depotid)
if id="" then
 	' call close("VIP���Ų���Ϊ��!")
		CheckAlert "VIP���Ų���Ϊ��!",false
else
  id=ucase(id)
end if
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn

select case act
case "check"
  c=check()
  if c<>false then 
		'call close("���ɹ�,�˿�������:"+c)
		CheckAlert "���ɹ�!�˿�������:"+c,false
	end if
case "add"
  vipid=trim(request.QueryString("vipid"))
  if vipid="" then
    'call close("�û�ID����!��ˢ�º�����!")
		CheckAlert "�û�ID����!��ˢ�º�����!",false
  end if
  c=check()
  s=checksend() 
  typ = getposset()

  if typ=true and viptypename <> c and  viptypename <>"" then
    CheckAlert  "��ǰ��������["&c&"]�����뿨����["&viptypename&"]��һ��,���ܷ���!",false
  end if
 
  if c<>false then
    cn.execute "update vip_user set vipcode="&qts(id)&" where vipid="&qts(vipid)
    cn.execute "update vip_cardvip set vipid="&qts(vipid)&",vipemit=getdate(),vipemitadd="&qts(depotid)&" where vipcardid="&qts(id)
  end if
  ' call close("����VIP���ɹ�!")
		CheckAlert "����VIP���ɹ�!!",true
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
		'call close("û�д�VIP�����ѹ���,��˶Ժ���������!")
		CheckAlert "û�д�VIP�����ѹ���!��˶Ժ���������!",false
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
	  'call close("��VIP�����ѷ��͸�����!��˶Ժ���������!")
			CheckAlert "��VIP�����ѷ��͸�����!��˶Ժ���������!",false
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
		CheckAlert "��ǰ�û��ѷ�VIP���������ظ�������",false
	checksend=false
  else 
    ds.close
	set ds=nothing	  
	checksend=true	
  end if
end function

'�Ƿ�����VIP�������Ƿ�������������ͬ
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
