<%option explicit%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<style type="text/css">
#m {
	height:60%;
	width:100%;
	overflow:auto;
	border:1px solid #F5E8E6;
}
</style>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">VIP消费查询</td>
  </tr>
</table>
<div id="m">
<table width="100%"  border="1" cellspacing="0" bordercolor="#ECD6D2" class="f12" bordercolorlight="#FFFFFF">
  <tr align="center">
    <td width="21%">VIP卡号</td>
    <td width="20%">登记日期</td>
    <td width="13%">姓名</td>
    <td width="5%">性别</td>
    <td width="10%">总消费额</td>
    <td width="7%">储值</td>
    <td width="8%">积分</td>
    <td width="8%">&nbsp;</td>
    <td width="8%">&nbsp;</td>
  </tr>
  <%
dim ds,sql,depotid
depotid=trim(session("dm").System_depotid)
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.LockType = 1
sql= "select vipid,vipcode,vipname,vipsex,crdate,isnull(sums,0) sums,isnull(centum,0) centum from vip_user where depotid="&qts(depotid)
ds.Source = sql
ds.Open
while not ds.eof%>
  <tr>
    <td align="center"><a href="vip_xf.asp?id=<%=ds("vipcode")%>" target="is"><%=ds("vipcode")%></a>&nbsp;</td>
    <td><%=ds("crdate")%></td>
    <td><%=ds("vipname")%></td>
    <td><%=ds("vipsex")%></td>
    <td><%=ds("vipname")%></td>
    <td align="center"><%=ds("sums")%></td>
    <td align="center"><%=ds("centum")%></td>
    <td align="center"><a href="vip_show.asp?id=<%=ds("vipid")%>">查看资料</a></td>
    <td align="center">修改 <a href="vip_save.asp?act=del&id=<%=ds("vipid")%>">删除</a></td>
  </tr>
  <%ds.movenext
  wend
  ds.close
  set ds=Nothing%>
</table>
</div>
<iframe name="is" width="100%" height="30%" frameborder="0" src="vip_xf.asp" marginwidth="0px"></iframe>
</body>
</html>
