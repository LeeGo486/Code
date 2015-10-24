<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<!--#include file="inc/function.asp"-->
</head>

<body>
<%dim depotid,vipcode
depotid=trim(session("dm").System_Depotid)
vipcode=trim(request.QueryString("vipcode"))%>
<table width="100%"  border="0" class="bar">
  <tr>
    <td>登记资料查询</td>
  </tr>
</table>
<div class="broad">
<table width="100%" border="1" cellspacing="0" bordercolorlight="#ECD6D2" bordercolordark="#FFFFFF" class="f14">
  <tr>
    <td width="15%">名称</td>
    <td width="21%">款号</td>
    <td width="19%">款式编号</td>
    <td width="15%">颜色</td>
    <td width="9%">尺码</td>
    <td width="7%">库存</td>
    <td width="14%">&nbsp;</td>
  </tr>
<%dim ds,sql,i
sql=" select c.clothingid,a.styleid,b.s_name,c.colorid,c.sizeid,d.k_num "& _
	" from vip_birthstyle a,j_style b,j_clothing c,j_stock d "& _
	" where a.styleid=b.styleid and a.styleid=c.styleid and a.styleid*=d.styleid and a.sel=1"
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.Source= sql
ds.Open
while not ds.eof%>
  <tr>
    <td><%=ds("s_name")%></td>
    <td><%=ds("styleid")%></td>
    <td><%=ds("clothingid")%></td>
    <td><%=ds("s_name")%></td>
    <td><%=ds("sizeid")%></td>
    <td><%=ds("k_num")%>&nbsp;</td>
    <td><a href="vip_sbrithform_sub.asp?clothingid=<%=ds("clothingid")%>&vipcode=<%=vipcode%>" target="is">加入赠送列表</a></td>
  </tr>
<%ds.movenext
wend
ds.close
set ds=nothing%>
</table>
</div>
<iframe name="is" width="100%" height="25%" frameborder="0" src="vip_sbrithform_sub.asp"></iframe>
</body>
</html>
