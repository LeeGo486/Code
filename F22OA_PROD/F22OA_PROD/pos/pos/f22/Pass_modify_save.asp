<%option explicit%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/function.asp" -->
<%dim ds,sql,rs,a,i,passok
set ds=server.CreateObject("ADODB.Recordset")
ds.activeconnection = cn
dim opass,pass,cfpass,userid,oauserid
userid=trim(Session("dm").System_UserId)
oauserid=trim(request.form("oauserid"))
opass=Trim(request.Form("opass"))
pass=Trim(request.Form("pass"))
cfpass=Trim(request.Form("cf"))
passok=false

if session("expandpass")=1 then
  for i=1 to len(pass)
    a=lcase(mid(pass,i,1))
    if (asc(a)>=asc("a") and asc(a)<=asc("z"))   then
	  passok=true
    end  if 
  next
else
  passok=true    
end if
	
if instr(opass," ")<1 then
  sql="select userid,password,oauserid from j_user where userid="&qts(userid)&" and password="&qts(opass)
  'de sql
  ds.LockType = 3
  ds.Source = sql
  ds.open
  if ds.eof then 
    response.Write "<a href='javascript:window.history.back()'>旧密码错误,请返回重新输入!</a>"
  elseif pass<>cfpass then
    response.Write "<a href='javascript:window.history.back()'>密码和确认密码不一致,请返回重新输入!</a>"
  elseif pass="" then
    response.Write "<a href='javascript:window.history.back()'>密码不能为空,请返回重新输入!</a>"
  elseif session("expandpass")=1 and len(pass)<=session("passlength") then
    response.Write "<a href='javascript:window.history.back()'>密码长度必须大于"&session("passlength")&"位,请返回重新输入!</a>"
  elseif passok=false then
    response.Write "<a href='javascript:window.history.back()'>密码必须包含字母,请返回重新输入!</a>"	
  else
    
	'ds("password")=pass
	'ds("oauserid")=oauserid
	'session("oauserid")=oauserid
	'ds.UPdate
	
    '更新帐套
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select a.dbalia from f18master.dbo.f18books a,master.dbo.sysdatabases b "&_
        	"where a.dbalia=b.name and rtrim(a.dbalia)<>'voa' order by a.f18id",cn
    while not rs.eof
      if chkdb(rs("dbalia")) and chktabname(rs("dbalia"),"j_user") then
        cn.execute "update "&rs("dbalia")&".dbo.j_user set password='"&pass&"' where userid='"&userid&"'"
      end if
      rs.movenext
	wend
	rs.close
	set rs=nothing
  
    '主库
    cn.execute "update f18master.dbo.sys_f22user set password='"&pass&"' where userid='"&userid&"'"
    'OA库
    cn.execute "update voa.dbo.j_user set pwd='"&pass&"' where userid='"&userid&"'"
  	
	response.Write "<a href='Pass_modify.asp'>修改密码成功!</a>"
  end if
  ds.close
end if
set ds=nothing

function chkdb(db)
dim tmp
set tmp=server.CreateObject("adodb.recordset")
tmp.open "select name from  master.dbo.sysdatabases where name='"&db&"'",cn
if not tmp.eof then
   chkdb=true
else
   chkdb=false
end if
end function

function chktabname(db,tab)
dim tmp
set tmp=server.CreateObject("adodb.recordset")
tmp.open "select name from "&db&".dbo.sysobjects where  name ='"&tab&"' and  type = 'U'",cn
if not tmp.eof then
   chktabname=true
else
   chktabname=false
end if
end function
set cn=nothing
%>