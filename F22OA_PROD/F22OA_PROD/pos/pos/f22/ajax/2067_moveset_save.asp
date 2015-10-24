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

CheckBrand()

call GetPriceType(id,"move")
 
set rs=server.CreateObject("adodb.recordset")
set rs1=server.CreateObject("adodb.recordset")

sql="t18tj_GetClothingPrice 3,'"&depotid&"','"&clothingid&"','',"&request.Cookies("GetPriceType")("T2")
rs.open sql,cn
if rs.eof then
   response.write("false")
   response.End()
else
   clothingid=rs("clothingid")
   '扫描正数检查审批单
   if cdbl(typ)=1 then
     CheckTZ()
   end if   
  
   CheckFlow(0)  
    
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
      savetmlist id,oldclothingid,clothingid,0
   end if
   
   response.write("true")
end if
rs.close
set rs=nothing
set rs1=nothing

'货品是否在通知单内检查
sub CheckTZ()
if session("noticeid")<>"" and session("noticeid")<>"null" then
  dim ds,sql
  set ds=Server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn

  sql = "select top 1 * from d_movenoticesub a  where noticeid='"&session("noticeid")&"' and clothingid='"&clothingid&"'"
  ds.source =sql
  ds.open
  if  ds.eof and  ds.Eof then
     ds.close
     set ds=nothing
	 response.Write("no")
	 response.End()
  else
    ds.close
	
    sql=" select top 1 a.clothingid"&_
        " from  webtmp_barcodeget a  "&_
        " inner join d_move b on a.id=b.moveid" &_
        " left join  d_movenoticesub c on b.indentid=c.noticeid and a.clothingid=c.clothingid "&_
        " where b.moveid='"&id&"' and a.nums>=isnull(c.nums,0)  and a.clothingid='"&clothingid&"'"
     
	ds.source =sql
	ds.open
    if  not ds.eof or not  ds.Eof then
      ds.close
      set ds=nothing
	  response.Write("nums")
	  response.End()
    else	
      ds.close
	  set ds=nothing
	end if  
  end if

end if
'货品是否在通知单内检查END
end sub
%>