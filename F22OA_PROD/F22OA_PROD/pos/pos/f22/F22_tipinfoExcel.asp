<%option explicit
Dim id,typ,tbname,tbnums,tbid,tbgetdepot,sql

response.ContentType ="application/vnd.ms-excel"
response.AddHeader "content-disposition", "attachment; filename=库存不足.xls" 

id=trim(request.QueryString("id"))
typ=2

   select case session("tablename")
   
     case "d_outindentset"

	   tbname="d_outindentsetsub"
	   tbid="outindentid"
	   tbnums="nums"
	   tbgetdepot="depotid"
     case "d_move"	

	   tbname="d_movesub"
	   tbid="moveid"
	   tbnums="set_nums"
	   tbgetdepot="get_depotid"
	 case "d_msell"	

	   tbname="d_msellsub"
	   tbid="msellid"
	   tbnums="set_nums"
	   tbgetdepot="get_depotid"
   end select 


%>
<!--#include file="inc/function.asp" -->



<%

if typ<>"" then
	
	
	dim rs
	set rs =server.CreateObject("adodb.recordset")
        sql = "select a.clothingid as '货品条码',isnull(a."&tbnums&",0)    as  '发货数',isnull(c.k_num,0)   as   '可配库存',isnull(isnull(c.k_num,0)-isnull(a."&tbnums&",0),0) as '差额'"&_
			" from  "&tbname&" a "&_
			" inner join  "&session("tablename")&" b on a."&tbid&"=b."&tbid&_
			" left join j_stock c  on  a.clothingid=c.clothingid "&_
			" and c.depotid='"&session("dm").System_depotid&"' where a."&tbid&"='"&id&"'"&_
			" and b."&tbgetdepot&"<>'"&session("dm").System_depotid&"'"&_
			" and isnull(isnull(c.k_num,0)-isnull(a."&tbnums&",0),0)<0 "&_
			" and isnull(a."&tbnums&",0)>0 "&_
			" order by  a.clothingid "
			'de sql
		rs.open sql,cn,1,1
		dim n,arr,width
		'抬头
		%>
    <div id="gt1" style="width:100%;height:90%;">
    <table border="0">
    <thead>
		<%
		
		arr = array("110","70","70","70")
		
		response.write "<tr>"
		for n=0 to rs.fields.count-1
		
			if n < ubound(arr) then width = arr(n) else width="70" end if
				response.write "<td  style='border:#ddd 1px solid' width="""&width&""">"&rs.fields(n).name&"</td>"
		next
		response.write "</tr>"
		%>
</thead>
 <tbody>
		<%
		'数据
		do while not rs.eof
			response.write "<tr>"
				for n=0 to rs.fields.count-1
						response.write "<td style='border:#ddd 1px solid'>"&rs.fields(n)&"</td>"
				next
			response.write "</tr>"
		rs.movenext
		loop
%>
 </tbody>
</table>
</div>
<%
	rs.close
	set rs=nothing
end if

cn.close
set cn=nothing

%>

