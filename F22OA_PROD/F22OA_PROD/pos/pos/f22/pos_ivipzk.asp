<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�鿴VIP�ۿ�</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<base target="_self">
<script language="javascript">
function vip(vipcode){
  if(vipcode!=''){
  	showModalDialog('vip_user.asp?vipcode='+vipcode,'vipmx','dialogWidth:500px;dialogHeight:390px;center: yes;help:no;status:no');
  }else{
    alert('VIP����Ϊ�գ�');
  }
}

function searchvip(vipcode){
  if(vipcode!=''){
  	showModalDialog('../crm/vip_xf.asp?id='+vipcode,'vipmx','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;status:no');
  }else{
    alert('VIP����Ϊ�գ�');
  }
}

</script>
</head>
<%dim ds,sql,zjf,act,key
act=trim(request.QueryString("act"))
key=trim(request.QueryString("key"))
if not isnumeric(act) then
  act=1
else
  act=cint(act)
end if
key=replace(key,"'","")%>
<body onLoad="document.form1.key.focus();">
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">�鿴VIP�ۿ�</td>
  </tr>
</table>
<form name="form1" method="get" action="pos_ivipzk.asp">
  <table width="100%"  border="0" class="tcontent">
    <tr>
      <td>��ʽ��<input name="act" type="radio" value="1" <%if act=1 then response.Write " checked" end if%> >
        VIP���� <input type="radio" name="act" value="2" <%if act=2 then response.Write " checked" end if%>>
�ֻ����� <input type="radio" name="act" value="3" <%if act=3 then response.Write " checked" end if%>>
����
&nbsp;&nbsp;&nbsp;�ؼ��� <input name="key" type="text" id="key" size="15" maxlength="20">
      <input type="submit" name="Submit" value="��ѯ"></td>
    </tr>
  </table>
</form>
<%
  '�ж�ˢ�½�ȡ
  if request.cookies("vipflash")("cut")=1 and act=1 then
		 oldkey = key
     key=mid(key,request.cookies("vipflash")("beg"),request.cookies("vipflash")("cnt"))
  end if
  
  select case act
  case 1 tj=" and c.vipcardid in ('"&key&"','"&oldkey&"')"
  case 2 tj=" and e.mobtel='"&key&"'"
  case 3 tj=" and e.vipname like '%"&key&"%'"
  end select
  
if key<>"" then
  set ds=Server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
	
  sql="select a.viptypename,a.begcentum,a.endcentum,b.begrate,b.endrate,b.rate "&_
      "from vip_rate a,vip_ratesub b,vip_cardvip c,vip_typevip d,vip_user e "&_
      "where a.rateid=b.rateid and a.viptypename=d.viptypename and c.viptypeid=d.viptypeid and c.vipcardid=e.vipcode "&tj&_
			" and convert(char(10),c.vipemit+isnull(c.limitday,0),126)>=convert(char(10),getdate(),126) "&_
			" and convert(char(10),isnull(c.viplastdate,getdate())+isnull(c.maxday,0),126)>=convert(char(10),getdate(),126)"
			
  ds.Source = sql
  ds.Open
  if ds.eof then
     call mbox("��VIP���Ų����ڣ�����δ��Ч��������ʧЧ,����δ���ô�����VIP����ʽ�ۿ۷�Χ��")
  else%>
<table width='100%' border=1 cellspacing=0 bordercolorlight='#ACA899' bordercolordark='#FFFFFF' class='f12'>
  <tr bgcolor='#FFEFEF' align='center'>
    <td width="20%">VIP����</td>
    <td width="20%">����</td>
	<td width="12%">�ܻ���</td>
    <td width="12%">����</td>
    <td width="13%">�ֻ���</td>
	<td width="13%">&nbsp;</td>
  </tr>
<%set rs=server.CreateObject("adodb.recordset")
sql = "select c.vipcardid,e.depotid,e.vipname,e.vipbirth,e.mobtel,isnull(e.centum,0)+isnull(c.starcentum,0) as centum "&_
        "from vip_cardvip c,vip_user e where c.vipid=e.vipid "&tj
rs.open sql,cn,1,1

'de sql

if not rs.eof and not rs.bof then
zjf=cdbl(rs("centum"))
	while not rs.eof%>
		<tr>
			<td><a href="javascript:searchvip('<%=rs("vipcardid")%>');"><%=rs("vipcardid")%></a></td>
			<td><%if trim(rs("depotid"))=session("dm").system_depotid then%><a href="javascript:vip('<%=rs("vipcardid")%>');"><%=rs("vipname")%></a><%else response.write rs("vipname") end if%></td>
		<td><%=rs("centum")%></td>
			<td><%=rs("vipbirth")%></td>
			<td>&nbsp;<%if trim(rs("depotid"))=session("dm").system_depotid then response.write rs("mobtel") end if%></td>
		<td>&nbsp;<%if act=3 then%><a href="?act=1&key=<%=getvip(rs("vipcardid"))%>">�鿴�ۿ�</a><%end if%></td>
		</tr>
	<%rs.movenext
	wend
end if
%>
</table><br>
<%rs.close
set rs=nothing
if act<>3 then%>
<table width='100%' border=1 cellspacing=0 bordercolorlight='#ACA899' bordercolordark='#FFFFFF' class='f12'>
  <tr>
    <td rowspan="2">������</td>
    <td colspan="2">����</td>
    <td colspan="2">��ʽ�ۿ�</td>
    <td rowspan="2">VIP�ۿ�</td>
  </tr>
  <tr>
    <td>��ʼ��</td>
    <td>������</td>
    <td>��ʼ��</td>
    <td>������</td>
  </tr>
<%while not ds.eof%>
  <tr <%if cdbl(ds("begcentum"))<=zjf and zjf<cdbl(ds("endcentum")) then response.write("bgcolor='yellow'") end if%>>
    <td><%=ds("viptypename")%></td>
    <td><%=ds("begcentum")%></td>
    <td><%=ds("endcentum")%></td>
    <td><%=ds("begrate")%></td>
    <td><%=ds("endrate")%></td>
    <td><%=ds("rate")%></td>
  </tr>
<%ds.movenext
wend
response.Write("<tr><td colspan=6>ע����ɫ�����Ǵ�VIP�������ܵ��ۿ۶�</td></tr>")
ds.close
set ds=nothing
end if%>
</table><br>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" bgcolor="#FFEFEF" class="bk">
  <tr>
    <td align="center"><input type="button" name="Submit" value=" �� �� (X)" accesskey="x" onClick="window.close();"></td>
  </tr>
</table>
<%end if
cn.close
set cn=nothing
end if%>
</body>
</html>
<%function getvip(vipid)
dim str,i,j
if request.cookies("vipflash")("cut")=1 then 
   i=cdbl(request.cookies("vipflash")("beg"))-1
   for j=1 to i
     str=str&"*"
   next
   getvip=str&vipid
else 
   getvip=vipid end if
end function%>