<%option explicit%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript">
function sendcard(id){
  showModalDialog('vip_sendcard_sub.asp?id='+id,'example04','dialogWidth:450px;dialogHeight:150px;center: yes;help:no;resizable:yes;status:no');
}
</script>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">登记资料查询</td>
  </tr>
</table>
<table width="100%"  border="1" cellspacing="0" bordercolor="#ECD6D2" class="f12" bordercolorlight="#FFFFFF">
  <tr align="center">
    <td width="12%">姓名</td>
    <td width="5%">性别</td>
    <td width="9%">出生日期</td>
    <td width="8%">固定电话</td>
    <td width="12%">移动电话</td>
    <td width="20%">电子邮箱</td>
    <td width="25%">通信地址</td>
    <td width="9%">&nbsp;</td>
  </tr>
  <%
dim ds,sql,depotid
depotid=trim(session("dm").System_depotid)
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.LockType = 1
sql= "select vipid,vipname,vipsex,vipbirth,viptel,mobtel,vipemail,vipadd,vipcode from vip_user where isnull(vipcode,'')<>'' and depotid="&qts(depotid)
ds.Source = sql
ds.Open
while not ds.eof%>
  <tr>
    <td><%=ds("vipname")%></td>
    <td><%=ds("vipsex")%></td>
    <td><%=ds("vipbirth")%>&nbsp;</td>
    <td><%=ds("viptel")%>&nbsp;</td>
    <td><%=ds("mobtel")%>&nbsp;</td>
    <td><%=ds("vipemail")%>&nbsp;</td>
    <td><%=ds("vipadd")%>&nbsp;</td>
    <td align="center"><a href="vip_sbrithform.asp?id=<%=ds("vipid")%>&vipcode=<%=ds("vipcode")%>">发生日礼物</a></td>
  </tr>
  <%ds.movenext
  wend
  ds.close
  set ds=Nothing%>
</table>
</body>
</html>
