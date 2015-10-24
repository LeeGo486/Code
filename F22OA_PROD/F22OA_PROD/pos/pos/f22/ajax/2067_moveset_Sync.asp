<!--#include file="../inc/function.asp"-->
<%
id = trim(request("id"))
sql = " update d_movesub set set_nums=isnull(b.nums,0)  from d_movesub a left join webtmp_barcodeget b "&_
	  " on a.moveid=b.id and a.clothingid=b.clothingid where a.moveid='"&id&"'"	  
cn.execute sql
response.write("true")

%>