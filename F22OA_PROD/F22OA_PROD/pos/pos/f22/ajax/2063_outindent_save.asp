<!--#include file="../inc/function.asp"-->
<%
dim s_price,dtype
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


CheckBrand()

set rs=server.CreateObject("adodb.recordset")
set rs1=server.CreateObject("adodb.recordset")

call GetPriceType(id,"outindentPRO")
 
 '2014-03-24 xhp �жϵ����Ƿ�2�����˵���
    dim dep_parentid
    set dttype = Server.CreateObject("ADODB.RECORDSET")
    sql="select b.parentid from d_outindentpro a inner join j_depot b on a.depotid=b.depotid where a.outindentid='"&id&"'"
    dttype.open sql,cn,1,1
    If not dttype.eof then
    dep_parentid = dttype("parentid")
    end if
    dttype.close()
    set dttype = nothing
    '�˻�3
    if trim(dep_parentid)=session("dm").System_Parentid then
  	dtype=3
    else
    dtype=2
    end if
    set dttype=nothing
'sql="t18tj_GetClothingPrice 3,'"&depotid&"','"&clothingid&"','',"&request.Cookies("GetPriceType")("T2")
sql="t18tj_GetClothingPrice "&dtype&",'"&depotid&"','"&clothingid&"','',3"
rs.open sql,cn
if rs.eof then
   response.write("false")
   response.End()
else  
   CheckFlow(0)  
   
   sql = "select * from d_outindentprosub where outindentid='"&id&"' and clothingid='"&rs("clothingid")&"'"
   rs1.open sql,cn,1,3
   if rs1.eof then
      rs1.addnew
      rs1("outindentid")=id
      rs1("boxid")="000000"
      rs1("clothingid")=rs("clothingid")
      rs1("styleid")=rs("styleid")
      rs1("colorid")=rs("colorid")
      rs1("sizeid")=rs("sizeid")
      rs1("cost")=rs("j_cost")
      rs1("x_price")=rs("x_price")
	  rs1("j_price")=rs("j_price")
      
	  rs1("s_price")=getFormatNumber(rs("s_price"))
	  rs1("discount")=rs("discount")
	  
	 ' if session("roundcnt")>0 then
	 '    rs1("s_price")=cdbl(rs1("s_price"))/session("roundcnt")
	 '    rs1("s_price")=round(rs1("s_price"),2)
	 '    rs1("s_price")=cdbl(rs1("s_price"))*session("roundcnt")
	 '    if IsNull(rs1("x_price")) or cdbl(rs1("x_price"))=0 then
	 '       rs1("discount")=0
	 '    else
	 '       rs1("discount")=cdbl(rs1("s_price"))/cdbl(rs1("x_price"))
	 '    end if
	 ' end if
	  
      rs1("nums")=cdbl(typ)*nums
      rs1("crdate")=now()
      rs1.update
   else
      rs1("nums")=rs1("nums")+cdbl(typ)*nums
      rs1("crdate")=now()
	  rs1.update
   end if
   rs1.close
   
   if session("iftmlist")=1 then
      savetmlist id,oldclothingid,clothingid,0
   end if
   
   response.write("true")
end if

rs.close
set rs=nothing
set rs1=nothing
%>