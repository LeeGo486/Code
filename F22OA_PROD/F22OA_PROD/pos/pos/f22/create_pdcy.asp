<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td>建立盘点差异</td>
  </tr>
</table>
<%
  Set cn = server.CreateObject("ADODB.Connection")
  cn.ConnectionString = Session("cn")
  cn.Open
  Set cd = server.CreateObject("ADODB.Command")
  cd.ActiveConnection = cn
  Set ds = server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
  
  	 sql="SELECT TOP 100 PERCENT d_inventory.inventoryid,"& _
		 "MAX(d_inventory.inventory) AS inventory,"& _
		 "MAX(d_inventory.depotid) AS depotid, "& _
		 "MAX(j_depot.d_name) AS dptname,"& _
		 "MAX(d_inventory.setdate) AS setdate, "& _
		 "MAX(d_inventory.d_type) AS d_type,"& _
		 "MAX(d_inventory.sure_name) AS sure_name,"& _
		 "MAX(d_inventory.ov_date) AS ov_date, "& _
		 "MAX(d_inventory.ov_sure) AS ov_sure,"& _
		 "MAX(d_inventory.ov_name) AS ov_name, "& _
		 "MAX(d_inventory.sure) AS sure, "& _
		 "MAX(d_inventory.chk_sure) AS chk_sure, "& _
		 "MAX(d_inventory.cr_date) AS cr_date, "& _
		 "MAX(d_inventory.cr_name) AS cr_name,"& _
		 "MAX(d_inventory.chk_name) AS chk_name, "& _
		 "MAX(d_inventory.chk_date) AS chk_date, "& _
		 "MAX(d_inventory.sure_date) AS sure_date,"& _
		 "MAX(d_inventory.comment) AS comment, MAX(d_inventory.crdate) AS crdate,"& _
		 "SUM(d_inventorysub.nums) AS nums,"& _
		 "SUM(ISNULL(d_inventorysub.s_price,0) * ISNULL(d_inventorysub.nums, 0)) AS sums,"& _
		 "SUM(ISNULL(d_inventorysub.d_nums,0)) AS cynums,"& _
		 "SUM(ISNULL(d_inventorysub.s_price,0) * ISNULL(d_inventorysub.d_nums, 0)) AS cysums,"& _
		 "MIN(d_inventory.diff) AS diff "& _
		 " FROM d_inventory JOIN"& _
		 " j_depot ON d_inventory.depotid = j_depot.depotid and d_inventory.depotid="&qts(session("dm").System_depotid)&" and isnull(d_inventory.diff,0)=0 JOIN"& _
		 " d_inventorysub ON"& _
		 " d_inventory.inventoryid = d_inventorysub.inventoryid "& _
		 " JOIN j_style ON d_inventorysub.styleid=j_style.styleid "& _
		 " GROUP BY d_inventory.inventoryid "
ds.source = sql
'de sql
ds.open
%>
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr align="center">
    <td width="32%">盘点单号</td>
    <td width="10%">数量</td>
    <td width="11%">金额</td>
    <td width="13%">盘点类型</td>
    <td width="19%">盘点日期</td>
    <td width="15%">&nbsp;</td>
  </tr>
  <%while not ds.eof%>
  <tr>
    <td><%=ds("inventoryid")%></td>
    <td><%=ds("nums")%></td>
    <td><%=ds("sums")%></td>
    <td><%=ds("d_type")%></td>
    <td><%=ds("cr_date")%></td>
    <td><a href="create_pdcy_save.asp?id=<%=ds("inventoryid")%>&lx=<%=ds("d_type")%>&pdrq=<%=ds("cr_date")%>">建立差异</a></td>
  </tr>
  <%ds.movenext
  wend%>
</table>
<%
  ds.Close
  cn.Close
  Set ds = Nothing
  Set cd = Nothing
  Set cn = Nothing

%>
</body>
</html>
