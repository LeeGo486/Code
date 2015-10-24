<%option explicit
session("formid")=2070%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<%dim act,typ,djid,sql,newid
act=trim(request("act"))
typ=request("typ")
djid=trim(request("id"))
select case act
 
  case "edit" if IsNumeric(typ) then
              cn.execute "update d_movenotice set cwpz="&typ&" where noticeid='"&djid&"'"
              end if
			  response.write("<script>window.close();</script>")
		      response.end
  case "jump" if IsNumeric(typ) then
              if cint(typ)=1 then
			     if getcz(djid,1) then
				    response.write("<script>alert('此通知单已经被参照发货！');window.close();</script>")
					response.end
				 end if
			     session("formid")=2065
			     response.Redirect "2065_outindentset_create.asp?action=create&czid="&djid
			  else
			     if chkconkq then
				    response.write("<script>alert('不允许跨区调货！');window.close();</script>")
					response.end
				 end if
			     if getcz(djid,2) then
				    response.write("<script>alert('此通知单已经被参照发货！');window.close();</script>")
					response.end
				 end if
			     session("formid")=2071
				 newid=getid("d_msell","msellid","TD",session("dm").System_UserId)
					sql="insert into d_msell (msellid,msell,noticeid,set_depotid,set_mchid,set_parentid,get_depotid,get_mchid,get_parentid,"&_
							"setchk_sure,set_sure,getchk_sure,get_sure,setdate,getdate,setcr_name,setcr_date,set_comment, crdate,selltype,d_type,"&_
							"fmsaddress, fmsmobtel, fmsrname) "&_
							"select '"&newid&"','"&newid&"','"&djid&"',set_depotid,set_mchid,set_parentid,get_depotid,get_mchid,get_parentid,"&_
							"0,0,0,0,setdate,getdate,'"&session("dm").System_UserName&"',getdate(),comment,getdate(),selltype,d_type, "&_
							"fmsaddress,fmsmobtel,fmsrname "&_
							"from d_movenotice where noticeid='"&djid&"'"
				 cn.execute sql
				 cn.execute "update d_movenotice set cwpz=30 where noticeid='"&djid&"'"
				 response.Redirect "2071_msell_create.asp?action=edit&id="&newid '"&czid=notice&"
			  end if
				end if
end select 

function getcz(idd,t)
dim rs
set rs=server.createobject("adodb.recordset")
if t=1 then
   rs.open "select isnull(count(*),0) as cnt from d_outindentset where quotaid='"&idd&"'",cn
else
   rs.open "select isnull(count(*),0) as cnt from d_msell where noticeid='"&idd&"'",cn
end if
if rs("cnt")>0 then
   getcz=true
else
   getcz=false
end if
rs.close
end function

function chkconkq
dim rs
set rs=server.CreateObject("adodb.recordset")
rs.open "select sysdefvalue from sys_system where systemid=2048",cn,1,1
if rs.eof then
   chkconkq=false
else
   if rs("sysdefvalue")="0" then
      chkconkq=false
   else
      chkconkq=true
   end if
end if
rs.close
set rs=nothing
end function
%>
