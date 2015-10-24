<!--#include file="../inc/function.asp"-->
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
'sql="t18tj_GetClothingPrice 2,'"&depotid&"','"&clothingid&"'"
sql="t18tj_GetClothingPrice 3,'"&depotid&"','"&clothingid&"'"
rs.open sql,cn
if rs.eof then
   response.write("false")
   response.End()
else
   sql = "select 1 from d_sellsub where sellid='"&id&"' and clothingid='"&rs("clothingid")&"'"
   rs1.open sql,cn
   if rs1.eof then
      response.write("false")
	  response.End()
   end if
   rs1.close
  
   CheckFlow(1)
  
   
   sql = "select id,userid,clothingid,nums from webtmp_barcodeget where id='"&id&"' and clothingid='"&rs("clothingid")&"'"
   rs1.open sql,cn,1,3
   if rs1.eof then
      rs1.addnew
      rs1("id")=id
	  rs1("userid")=userid
      rs1("clothingid")=rs("clothingid")
      rs1("nums")=cdbl(typ)*nums
      rs1.update
   else
      rs1("nums")=rs1("nums")+cdbl(typ)*nums
	  rs1.update
   end if
   rs1.close
   
   if session("iftmlist")=1 then
     savetmlist id,oldclothingid,clothingid,1
   end if
   
   response.write("true")
end if
rs.close
set rs=nothing
set rs1=nothing
%>