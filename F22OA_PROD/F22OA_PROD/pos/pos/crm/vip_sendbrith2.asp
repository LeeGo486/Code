<%option explicit%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
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
    <td align="center">�Ǽ����ϲ�ѯ</td>
  </tr>
</table>
<table width="100%"  border="1" cellspacing="0" bordercolor="#ECD6D2" class="f12" bordercolorlight="#FFFFFF">
  <tr align="center">
    <td width="12%">����</td>
    <td width="5%">�Ա�</td>
    <td width="9%">��������</td>
    <td width="8%">�̶��绰</td>
    <td width="12%">�ƶ��绰</td>
    <td width="20%">��������</td>
    <td width="25%">ͨ�ŵ�ַ</td>
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
    <td align="center"><a href="vip_sbrithform.asp?id=<%=ds("vipid")%>&vipcode=<%=ds("vipcode")%>">����������</a></td>
  </tr>
  <%ds.movenext
  wend
  ds.close
  set ds=Nothing%>
</table>
</body>
</html>
