<!--#include file="../F22/inc/function.asp"-->
<%dim ds,id,action
response.Expires = 0 
response.Buffer = True 
response.Clear 
cn=session("cn")
id=trim(request.QueryString("vipid"))
     
 
    set ds=server.CreateObject("ADODB.Recordset")
	
    if Left(id,3)="tmp" then
      sql="select img from vip_images where vipid='"&id&"'"
	else
	  sql="select userpicture from vip_user where vipid='"&id&"'"
	end if 	
	ds.open sql,cn,1,1
	if not ds.eof and not ds.bof then 
	  response.contenttype="image/*"
	  Response.BinaryWrite ds(0)
	else
	  response.Write("no_pic.gif")  
	end if
	ds.close
	set ds=nothing
%>