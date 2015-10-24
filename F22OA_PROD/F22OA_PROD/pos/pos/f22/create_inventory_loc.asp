<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<style media="print" type="text/css">
.hide {
	display:none;
}
</style>
</head>

<body>
<!--#include file="inc/function.asp" -->
<%dim depotid,st_dl, ds,sql,clothingid,colorid,sizeid,k_num,id
dim d_name
id=trim(request.QueryString("id"))
depotid=trim(request.QueryString("depotid"))
clothingid=trim(request.QueryString("clothingid"))
sizeid=trim(request.QueryString("sizeid"))
colorid=trim(request.QueryString("colorid"))
k_num=trim(request.QueryString("k_num"))
act=trim(request.QueryString("act"))%>
  <%
set ds=server.CreateObject("ADODB.Recordset")
    ds.activeconnection = cn
	sql="select a.depotid,b.d_name from d_Inventory a,j_depot b where a.depotid=b.depotid and inventory="&qts(id)
	ds.Source = sql
	ds.Open
	if not ds.eof then
	  depotid=ds(0)
	  d_name=ds(1)
	else
	  ds.close
	  set ds=nothing
	  call mbox("参数错误,请重新生成盘点单!")
	end if
	ds.close
%>
<form name="form1" method="post" action="">
<table width="715" border="0" bgcolor="#FFEFEF">
  <tr>
    <td><h1 align="center"><%=d_name%>(<%=depotid%>)盘点单 <br>时间：<%=date%></h1>
</td>
  </tr>
</table>
<%
sql="select lookcode,lookname from j18_lookupsub where lookupid=2002 order by lookcode"
set ds1=server.CreateObject("ADODB.Recordset")
    ds1.activeconnection = cn
	ds1.Source = sql
	ds1.Open
	while not ds1.eof
	st_dl=ds1(1) %>
	<table width="715" border="0">
      <tr>
        <td><br>
          <h2 align="center">—————— <%=ds1(1)%> ——————</h2></td></tr>
  </table>
  <table  border="0">
    <tr align="center" bgcolor="#FFEFEF">
      <td width="138"><a href="create_inventory_loc.asp?id=<%=id%>">款式编号</a></td>
	  <%if clothingid<>"1" then%>
      <td width="152"><a href="create_inventory_loc.asp?id=<%=id%>&clothingid=1&colorid=<%=colorid%>&sizeid=<%=sizeid%>&k_num=<%=k_num%>">货号</a></td>
	  <%end if%>
	  <%if colorid<>"1" then%>
	  <td width="132"><a href="create_inventory_loc.asp?id=<%=id%>&clothingid=<%=clothingid%>&colorid=1&sizeid=<%=sizeid%>&k_num=<%=k_num%>">颜色</a></td>
	  <%end if%>
	  <%if sizeid<>"1" then%>
	  <td width="82"><a href="create_inventory_loc.asp?id=<%=id%>&clothingid=<%=clothingid%>&colorid=<%=colorid%>&sizeid=1&k_num=<%=k_num%>">规格</a></td>
	  <%end if%>
	  <%if k_num<>"1" then%>
	  <td width="82"><a href="create_inventory_loc.asp?id=<%=id%>&clothingid=<%=clothingid%>&colorid=<%=colorid%>&sizeid=<%=sizeid%>&k_num=1">目前库存</a></td>
	  <%end if%>
	  <td width="103">盘点数量</td>
    </tr>
<%
	select case session("dm").System_UserType
	case 4
	sql=" select a.clothingid,a.styleid,a.colorid,sizeid,c_name,a.k_num "& _
		" from j_stock a,j_color c,j_style j "& _
		" where a.colorid=c.colorid and  a.depotid="&qts(depotid)& _
		" and a.styleid=j.styleid and j.st_dl="&qts(st_dl)& _
		" and clothingid in "& _
		" (select clothingid from d_move dm,d_movesub dms "& _
		" where dm.moveid=dms.moveid and dm.get_depotid="&qts(depotid)& _
		" group by clothingid)"
	case else
	sql=" select j.st_dl,a.clothingid,a.styleid,a.colorid,a.sizeid,c.c_name,a.k_num "& _
		" from j_stock a,j_color c,j_style j "& _
		" where a.colorid=c.colorid and depotid="&qts(depotid)& _
		" and a.styleid=j.styleid and j.st_dl="&qts(st_dl)& _
		" and clothingid in "& _
		" (select clothingid from d_sell ds,d_sellsub dss "& _
		" where ds.sellid=dss.sellid and ds.get_depotid="&qts(depotid)& _
		" group by clothingid) "
	end select
	
	ds.Source = sql
	ds.Open
	styleid=""
	jt=false
	while not ds.eof
	jt=not jt
	%>
    <tr <%if jt then%>bgcolor="#FAF3F2"<%end if%>>
      <td>
	  <%if styleid<>trim(ds("styleid")) then
	      response.Write ds("styleid")
		end if%></td>
	  <%if clothingid<>"1" then%>
      <td><%=ds("clothingid")%></td>
	  <%end if%>
	  <%if colorid<>"1" then%>
      <td><%=ds("colorid")%>(<%=ds("c_name")%>)</td>
	  <%end if%>
	  <%if sizeid<>"1" then%>
      <td><%=ds("sizeid")%></td>
	  <%end if%>
	  <%if k_num<>"1" then%>
      <td><%=ds("k_num")%></td>
	  <%end if%>
      <td><input name="nums" type="text" id="nums" size="5" maxlength="5" class="hide"></td>
    </tr>
	<%styleid=ds("styleid")
	ds.movenext
	wend
	ds.close%>
  </table>
  <%ds1.moveNext
  wend
  ds1.close
  set ds=nothing
  set ds1=nothing%>
</form>
</body>
</html>
