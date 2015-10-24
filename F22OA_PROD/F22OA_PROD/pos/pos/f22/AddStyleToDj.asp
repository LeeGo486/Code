<%option explicit
response.AddHeader "Pragma","No-Cache"
response.AddHeader "Cache-Control","No-Cache"
Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>读入款式到单据</title>
</head>

<body>
<br>
<br>
<%
dim id,sql1,sql2,sql3,sql4,rs,formid,djid
id=trim(request.QueryString("id"))
formid=trim(request.QueryString("formid"))
set rs = server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn

select case formid
case 2066
     sql1=" select 1 from d_inventory where inventoryid="&qts(id)&" and chk_sure>0" 
     sql2=" insert into d_inventorysub (inventoryid,boxid,clothingid,styleid,colorid,sizeid,nums) "&_
	      " select "&qts(id)&",'AV9999',a.clothingid,a.styleid,a.colorid,a.sizeid,0 from j_clothing a,sys_stylepower18ql b "&_
		  " where a.styleid=b.styleid and b.userid="&qts(session("dm").system_userid)&" and b.access=1 and b.selection=1 "&_
		  " and b.styleid not in (select styleid from d_inventorysub where inventoryid="&qts(id)&")"
     sql3=" update a set a.j_cost=b.j_cost,a.j_price=b.j_price,a.x_price=b.x_price,a.s_price=b.x_price "&_
          " from d_inventorysub a,j_style b where a.inventoryid='"&id&"' and a.styleid=b.styleid"
     'sql3=" F22_RefreshDj 'd_inventory','"&id&"'"
end select
rs.open sql1,cn
if not rs.eof then
   call close("此单已经审核，不可以读入！")
   rs.close
   set rs=nothing
end if
cn.execute sql2
cn.execute sql3

set rs=nothing
set cn=nothing
call close("读入完成!")
%>
</body>
</html>