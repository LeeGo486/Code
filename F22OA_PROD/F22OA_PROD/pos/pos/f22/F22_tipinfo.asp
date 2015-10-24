<%option explicit
Dim id,typ,tbname,tbnums,tbid,tbgetdepot,sql,chkkc
id=trim(request.QueryString("id"))
typ=1
 
   select case session("tablename")
   
     case "d_outindentset"
       chkkc="true"
	   tbname="d_outindentsetsub"
	   tbid="outindentid"
	   tbnums="nums"
	   tbgetdepot="depotid"
     case "d_move"	
	   chkkc="true"
	   tbname="d_movesub"
	   tbid="moveid"
	   tbnums="set_nums"
	   tbgetdepot="get_depotid"
	 case "d_msell"	
	   chkkc="true"
	   tbname="d_msellsub"
	   tbid="msellid"
	   tbnums="set_nums"
	   tbgetdepot="get_depotid"
   end select 
   
  
   
%>
<!--#include file="inc/function.asp" -->
<%if cint(typ)<>2 then%>
<html>
<link href="css/report.css" rel="stylesheet" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>库存不足</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<script language="javascript">
	function btnClick(s){
	
	    //s=-1; 库存不足
	 	//s=0;库存OK,库存不足审核通过
		window.returnValue=s;
	    window.close();
		return;
	}
</script>
</head>

<body>

<%end if%>

<%

 if chkkc<>"true" then

     response.write("<script>btnClick(0);</script>")
	 response.End()
 end if 
  

if typ<>"" then
	
	
	dim rs
	set rs =server.CreateObject("adodb.recordset")
        sql = "select a.clothingid as '货品条码',isnull(a."&tbnums&",0)    as  '发货数',isnull(c.k_num,0)   as   '可配库存',isnull(isnull(c.k_num,0)-isnull(a."&tbnums&",0),0) as '差额'"&_
			" from  "&tbname&" a "&_
			" inner join  "&session("tablename")&" b on a."&tbid&"=b."&tbid&_
			" left join j_stock c  on  a.clothingid=c.clothingid "&_
			" and c.depotid='"&session("dm").System_depotid&"' where a."&tbid&"='"&id&"'"&_
			" and b."&tbgetdepot&"<>'"&session("dm").System_depotid&"'"&_
			" and isnull(isnull(c.k_num,0)-isnull(a."&tbnums&",0),0)<0  "&_
                        " and isnull(a."&tbnums&",0)>0 "&_
			" order by  a.clothingid "
		rs.open sql,cn,1,1
		if rs.eof and rs.bof then
		  rs.close
	      set rs=nothing
		  cn.close
          set cn=nothing
		  response.write("<script>btnClick(0);</script>")
		  response.End()
		end if
		
		dim n,arr,width
		'抬头
		%>
    <div  style="width:100%;height:90%; margin-top:2px; padding-top::8px; padding-left:10px">
    <table border="0" cellpadding="0" cellspacing="0" align="center">
    <thead>
		<%
		
		arr = array("120","90","90","90")
		
		response.write "<tr>"
		for n=0 to rs.fields.count-1
		
			if n < ubound(arr) then width = arr(n) else width="90" end if
				response.write "<td  style='border:#ddd 1px solid;background-color:#e9f6f5;' width="""&width&""">"&rs.fields(n).name&"</td>"
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

<%if cint(typ)<>2 then%>
<table width="100%"  border="0" class="bar" align="center">
  <tr>
    <td align="center"><form name="form1" method="get" action="F22_tipinfoExcel.asp">
	<input type="button" name="but" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
	<input type="button" name="btncheck" value="继续审核" 	onclick="btnClick(0);"  style="<% if session("setkcyj")=2 then response.Write("display:none;") else response.Write("display:'';") end if %>" > 
	<input type="button" name="btnclose" value="关   闭" onClick="btnClick(-1);" >
    <input type="hidden" name="typ" value="1">

	<input name="id" type="hidden" id="id" value="<%=id%>" />  
	<input name="tbname" type="hidden" id="tbname" value="<%=tbname%>" />  
	<input name="tbnums" type="hidden" id="tbnums" value="<%=tbnums%>" />  
	<input name="tbid" type="hidden" id="tbid" value="<%=tbid%>" />  
	<input name="tbgetdepot" type="hidden" id="tbgetdepot" value="<%=tbid%>" /> 
	</form>
	</td>
  </tr>
</table>
<% end if %>

<%if cint(typ)=20 then%>
<script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){ alert(ex);}
</script>
<%end if%>


</body>
</html>
