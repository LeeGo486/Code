<%option explicit
session("formid")=6101022%>
<!--#include file="inc/function.asp"-->

<%dim ExportExcel

ExportExcel=request("ExportExcel")


if cint(ExportExcel)=1 then
  response.ContentType ="application/vnd.ms-excel"
  response.AddHeader "content-disposition", "attachment; filename=�˿�VIP����.xls" 
end if
%>

<% if cint(ExportExcel)<>1 then %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript">
function sendcard(id){
  var m = showModalDialog('vip_sendcard_sub.asp?id='+id,'example04','dialogWidth:450px;dialogHeight:150px;center: yes;help:no;resizable:yes;status:no');
	if(m)history.go(0);
}

function vip(url){
	if(url){
  	var m=showModalDialog(url,'vipdetail','dialogWidth:600px;dialogHeight:520px;center: yes;help:no;status:no');
	}
}
</script>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">�Ǽ����ϲ�ѯ</td>
  </tr>
</table>

<form name="form1" method="post" action="vip_sendcard.asp">
<input type="hidden" value="1" name="p" id="p" />
<input type="hidden" value="0" name="ExportExcel" id="ExportExcel" />
<table width="100%" border="0" class="f12">
  <tr>
   
	<td align="center">
	

	<input type="submit" name=subm value=" �� ѯ " onClick="document.all.form1.ExportExcel.value=0;this.disabled=true;this.value='���Ե�...';this.form.submit()">
	  <%if pexport then%>
	<input type="submit" name=subm value="����Excel" onClick="document.all.form1.ExportExcel.value=1;this.form.submit()">
	��<% end if %>
        
  
  </td>
  </tr>
</table>
  <table width="100%"  border="1" cellspacing="1" cellpadding="3" bordercolor="#ECD6D2" class="f12" bordercolorlight="#FFFFFF">
  <tr align="center">
    <td width="9%">����</td>
    <td width="5%">�Ա�</td>
    <td width="11%">��������</td>
    <td width="8%">�̶��绰</td>
    <td width="12%">�ƶ��绰</td>
    <td width="20%">��������</td>
    <td width="25%">ͨ�ŵ�ַ</td>
    <td width="9%">&nbsp;</td>
  </tr>
  <%else%>
  <table width="100%"  border="1" cellspacing="1" cellpadding="3" bordercolor="#fff" class="f12" bordercolorlight="#FFFFFF">
  <tr align="center">
    <td width="9%">����</td>
    <td width="5%">�Ա�</td>
    <td width="11%">��������</td>
    <td width="8%">�̶��绰</td>
    <td width="12%">�ƶ��绰</td>
    <td width="20%">��������</td>
    <td width="25%">ͨ�ŵ�ַ</td>
    <td width="9%">&nbsp;</td>
  </tr>
  
<% end if %>


  <%
dim ds,sql,depotid
depotid=trim(session("dm").System_depotid)
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.LockType = 1
'sql= "select vipid,vipname,vipsex,vipbirth,viptel,mobtel,vipemail,vipadd,vipuse "&_
'			" from vip_user where isnull(vipcode,'')='' and isnull(vipuse,0)=1 and depotid="&qts(depotid)
sql= "select vipid,vipname,vipsex,vipbirth,viptel,mobtel,vipemail,vipadd,vipuse=isnull(vipuse,0),vipcode "&_
			" from vip_user where isnull(vipcode,'')=''  and depotid="&qts(depotid)
ds.Source = sql
ds.Open
while not ds.eof%>
  <tr>
    <td><a href="javascript:;" onClick="vip('vip_show.asp?act=view&id=<%=ds("vipid")%>');"><%=ds("vipname")%></a></td>
    <td><%=ds("vipsex")%></td>
    <td><%=ds("vipbirth")%>&nbsp;</td>
    <td><%=ds("viptel")%>&nbsp;</td>
    <td><%=ds("mobtel")%>&nbsp;</td>
    <td><%=ds("vipemail")%>&nbsp;</td>
    <td><%=ds("vipadd")%>&nbsp;</td>
    <td align="center">
	<%if padd then%> 
	     <% if ds("vipuse")=false then  %>
		   δ���  
	     <% else %>
		     <a href="javascript:sendcard('<%=ds("vipid")%>');">��VIP��</a>
		 <% end if %>
		 
	<%end if%>&nbsp;</td>
  </tr>
  <%ds.movenext
  wend
  ds.close
  set ds=Nothing%>
</table>
</body>
</html>
