<!--#include file="inc/function.asp"-->
<%dim ds,id,action
response.Expires = 0 
response.Buffer = True 
response.Clear 
cn=session("cn")
id=trim(request.QueryString("id"))
action=trim(request.QueryString("action"))
'action="style"
'id="100222B"
'session("cnp")="Driver={SQL Server};Server="&conn_server&";Uid="&conn_name&";Pwd="&conn_pass&";dataBase=f117picture"
  set ds=server.CreateObject("ADODB.Recordset")
	if action="style" then
		ds.open "select isnull(sysdefvalue,0) from sys_system where systemid=2003 ",cn,1,1	'取得默认设置
		if not(ds.eof and ds.bof) then
			if cint(ds(0))=1 then
				sql="select picture1 from f117picture.dbo.j_style where styleid='"&id&"' and dbname='"&session("dbname")&"'"
			else
				sql="select st_picture from j_style where styleid='"&id&"'"
			end if
		end if
		ds.close
		
		ds.open sql,cn,1,1
		if not (ds.eof and ds.bof) then
			response.contenttype="image/*"
			Response.BinaryWrite ds(0)
		end if
	    ds.close
	elseif action="product" then
	  sql="select takepic from j_productmaintain where productid='"&id&"'"
      ds.open sql,cn,1,1
	  if not ds.eof and not ds.bof then
	  response.contenttype="image/*"
      Response.BinaryWrite ds(0)
	  end if
	  ds.close
	end if
  set ds=nothing
%>