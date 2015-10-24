<!--#include file="../inc/function.asp"-->
<%dim ds,id,action
response.Expires = 0 
response.Buffer = True 
response.Clear 
cn=session("cn")
id=trim(request.QueryString("styleid"))
action=trim(request.QueryString("action"))
action="style"
'id="100222B"
'session("cnp")="Driver={SQL Server};Server="&conn_server&";Uid="&conn_name&";Pwd="&conn_pass&";dataBase=f117picture"

	select case action
	case "style"
	  sql="select st_picture from j_style where styleid='"&id&"'"
	  set ds=server.CreateObject("ADODB.Recordset")
		ds.open "select sysdefvalue from sys_system where systemid=2003 ",cn,1,1	'取得默认设置
		if not(ds.eof and ds.bof) then
			if ds(0)=1 then
				sql="select picture1 from f117picture.dbo.j_style where styleid='"&id&"' and dbname='"&session("dbname")&"'"
			end if
		end if
		ds.close
		
		ds.open sql,cn,1,1
			response.contenttype="image/*"
			Response.BinaryWrite ds(0)
	  ds.close
	  set ds=nothing
	case "product"
	  sql="select takepic from j_productmaintain where productid='"&id&"'"
	  set ds=server.CreateObject("ADODB.Recordset")
	  ds.Activeconnection=cn
	  ds.source = sql
      ds.open
	  response.contenttype="image/*"
      Response.BinaryWrite ds(0)
	  ds.close
	  set ds=nothing
	end select%>