<!--#include file="../inc/function.asp"-->
<!--#include file="JSON.asp"-->
<%
id = trim(request("id"))
clothingid=trim(request("clothingid"))
oldclothingid=clothingid
typ=request("typ")
tmln=request("tmln")
userid=trim(session("dm").System_UserId)
nums=request("nums")
depotid=trim(session("dm").system_depotid)

if round(tmln)>0 then
   clothingid=left(clothingid,len(clothingid)-round(tmln))
end if

set rs=server.CreateObject("adodb.recordset")
set rs1=server.CreateObject("adodb.recordset")

sql="t18tj_GetClothingPrice 3,'"&depotid&"','"&clothingid&"'"
rs.open sql,cn
if rs.eof then
   response.write("false")
   response.End()
else
   sql = "select * from d_inventorysub where inventoryid='"&id&"' and clothingid='"&rs("clothingid")&"'"
   rs1.open sql,cn,1,3
   if rs1.eof and rs1.bof then
      rs1.addnew
      rs1("inventoryid")=id
      rs1("boxid")="000000"
      rs1("clothingid")=rs("clothingid")
      rs1("styleid")=rs("styleid")
      rs1("colorid")=rs("colorid")
      rs1("sizeid")=rs("sizeid")
      rs1("j_cost")=rs("j_cost")
      rs1("x_price")=rs("x_price")
      rs1("s_price")=rs("s_price")
      rs1("d_nums")=cdbl(typ)*nums
      rs1("discount")=rs("discount")
      rs1("j_price")=rs("j_price")
      rs1("crdate")=now()
      rs1.update
   else
      rs1("d_nums")=rs1("d_nums")+cdbl(typ)*nums
      rs1("crdate")=now()
	  rs1.update
   end if
   rs1.close
			response.write("true")
end if
rs.close
set rs=nothing
set rs1=nothing
%>