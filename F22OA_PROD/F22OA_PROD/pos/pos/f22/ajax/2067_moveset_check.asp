<!--#include file="../inc/function.asp"-->
<%
id = trim(request("id"))
set rs=server.createobject("adodb.recordset")
 rs.open " select top 1 1 from d_move a "&_
		   " inner join d_movenotice b on a.indentid=b.noticeid "&_
		   " inner join d_movenoticesub c on b.noticeid=c.noticeid "&_
		   " left join webtmp_barcodeget d on a.moveid=d.id  and c.clothingid=d.clothingid "&_
		   " where a.moveid='"&id&"'" &_
		   " and c.nums>isnull(d.nums,0)"&_
		   " and len(set_comment)<3",cn 
 if not rs.eof then
   rs.close
   set rs=nothing
   response.write("false")	 
 else
   rs.close
   set rs=nothing
   response.write("true")
 end if  
%>