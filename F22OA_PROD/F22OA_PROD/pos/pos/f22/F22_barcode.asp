<!--#include file="inc/function.asp"-->
<%dim id,typeid,url,ds,sql,tablename,pkname

id=trim(request.QueryString("id"))
typeid=trim(request.QueryString("typeid"))

select case typeid
    case 2060:
      url="ajax/2060_indent.asp?id="+id
      tablename="d_outindentpro"
	  pkname="outindentid"

    case 2061:
      url="ajax/2061_indent.asp?id="+id
      tablename="d_outindentpro"
	  pkname="outindentid"

	case 2062:
	  '²»¼ì²é
      url="ajax/2062_getsell.asp?id="+id
      response.Write("<script>window.location.href='"+url+"';</script>")	 
	  response.End()
	  
	case 2063:
      url="ajax/2063_outindent.asp?id="+id
	  tablename="d_outindentpro"
      pkname="outindentid"
	case 2163:
      url="2163_outindent_barcode.asp?id="+id
      'tablename="d_outindentsq"
	  'pkname="outindentsqid"
      response.Write("<script>window.location.href='"+url+"';</script>")	 
	  response.End()
	case 2065:
      url="ajax/2065_outindent.asp?id="+id
      tablename="d_outindentset"
	  pkname="outindentid"

	case 2066:
	  url="ajax/2066_inventory.asp?id="+id
	  response.Write("<script>window.location.href='"+url+"';</script>")	 
	  response.End()
	case 2166:
	  url="ajax/2166_inventory.asp?id="+id
      response.Write("<script>window.location.href='"+url+"';</script>")	 
	  response.End()
	case 2067:
      url="ajax/2067_move.asp?id="+id
	  tablename="d_move"
	  pkname="moveid"
	case 2067000:
      url="ajax/2067_moveset.asp?id="+id
	  tablename="d_move"
	  pkname="moveid"  
	case 2068:
      url="ajax/2068_move.asp?id="+id
      tablename="d_move"
	  pkname="moveid"
	case 2069:
      url="ajax/2069_msellget.asp?id="+id
      response.Write("<script>window.location.href='"+url+"';</script>")	 
	  response.End()
	case 2071:
	  url="ajax/2071_msell.asp?id="+id
      tablename="d_msell"
	  pkname="msellid"
	case 2072:
	  url="ajax/2072_inventory.asp?id="+id
	  response.Write("<script>window.location.href='"+url+"';</script>")	 
	  response.End()
	 
end select  
	
sql="select * from "&tablename&" where "&pkname&"='"&id&"'"
set ds=server.createobject("ADODB.Recordset")
ds.ActiveConnection = cn
'de sql
ds.Source = sql
ds.Open
if not ds.eof then
 
  if tablename<>"d_inventory" then
     if tablename="d_outindentpro"  or tablename="d_outindentset" or tablename="d_outindentsq" then
       session("get_depotid")=ds("depotid")
	 else
   	   session("get_depotid")=ds("get_depotid")
	 end if	
	 
	 session("set_depotid")=ds("set_depotid")
	 
	 if tablename="d_msell" then
	    session("noticeid")=ds("noticeid")
	 end if	 
	 
	 if tablename="d_move" then
	    session("noticeid")=ds("indentid")
	 end if
	 	 
	 if tablename="d_outindentset" then
	    session("quotaid")=ds("quotaid")
	 end if
  end if	 
  ds.close  
end if   



response.Write("<script>window.location.href='"+url+"';</script>")	 

%>