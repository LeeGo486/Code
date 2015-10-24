<%option explicit%>
<%Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>其它店铺库存</title>
</head>

<body>
  <%dim ds,merchantid,sql,clothingid,id,depotid,tj,userid
	
	if session("onlybdkc") then
		close "当前设置不允许查看其它店铺库存"
	end if
  merchantid=trim(session("dm").System_UnitId)
  depotid=trim(session("dm").System_depotid)
  userid=trim(session("dm").system_userid)
  clothingid=trim(request.QueryString("id"))
%>
<table width="100%" border="0" class="bar">
  <tr>
    <td><%=clothingid%> 同区店库存</td>
  </tr>
</table>
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#EFD7CE" class="f12" bordercolorlight="#FFFFFF">
  <tr align="center">
    <td>店铺编号</td>
    <td>店铺名称</td>
    <td>库存数量</td>
  </tr>
<%  set ds=server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
  if session("nozckc") then
     tj=" and b.depotid not in (select depotid from j_depot where m_type in (0,1,80,90)) "
  else
     tj=""
  end if
  'sql="select distinct a.depotid,b.d_name,a.k_num from j_stock a,webp_depot b"& _
  '	" where a.depotid=b.depotid and b.merchantid="&qts(merchantid)& _
  '	" and a.clothingid="&qts(clothingid)& _
  '	" and b.depotid<>"&qts(depotid)&tj
  sql=" select distinct a.depotid,b.d_name,a.k_num from j_stock a,j_depot b "& _
	  " where a.depotid = b.depotid and b.unitid="&qts(merchantid)&" and a.depotid "&session("QryDepotTj")&_
	  " and a.clothingid="&qts(clothingid)&" and isnull(a.k_num,0)<>0 and b.depotid<>"&qts(depotid)&tj
  'de sql
  ds.source = sql
  ds.open
  while not ds.eof%>
  <tr align="center" height="20">
    <td><%=ds(0)%></td>
    <td><%=ds(1)%></td>
    <td><%=ds(2)%></td>
  </tr>
  <%ds.moveNext  
  wend
  ds.close
  set ds=nothing%>
</table>
<br>
<div align="center">
  <input type="button" name="Submit" value="确定(S)" accesskey="s" onClick="window.close();">
  <input type="button" name="Submit" value="取消(X)" accesskey="x" onClick="window.close();">
</div>
</body>
</html>
