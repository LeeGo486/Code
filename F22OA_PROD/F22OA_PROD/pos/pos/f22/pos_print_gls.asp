<%Response.cachecontrol = "no-cache"
Response.Expires=-1000%>
<HTML>
  <HEAD><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <title>��ӡСƱ</title>
  <link href="css/f22.css" rel="stylesheet" type="text/css">
    <script language="javascript">
	function printTable(id){
	  window.print();
	}
	function printTable1(id){
  	var   op   =   window.open(); 
	var a = document.all[id];
	op.document.writeln("<link href=\"css\/f22.css\" rel=\"stylesheet\" type=\"text\/css\">");
  	op.document.writeln(a.outerHTML);
	//alert(a.outerHTML);
  	op.document.writeln("<scr"+"ipt>window.print();<\/scr"+"ipt>");
  	}
  	function pageClose(){
	window.returnValue=1;
 	 window.close();
  	}
  </script>

  <style type="text/css">
<!--
body,td,th {
	font-size: 12px;
}
-->
</style></HEAD>
 <body>
  <form>
    <style media='print'>
   .Noprint { DISPLAY: none }
   .PageNext { PAGE-BREAK-AFTER: always }
  </style>
<%dim dname,retailid,sname,xname,suredate,suretime,add,vipcode,centum,tel,nums,sums,ssums,zsums
retailid=trim(request.querystring("id"))
cn=session("cn")
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.source = "select a.s_sums,a.z_sums,a.s_name,b.d_name,convert(char(10),a.sure_date,126) as suredate,convert(char(8),a.sure_date,114) as suretime,b.address,"&_
            "b.tel,isnull(a.vipcode,'') as vipcode from d_retail a,j_depot b "&_
			"where a.retailid='"&retailid&"' and a.depotid=b.depotid "
'response.Write "<textarea>"& ds.Source&"</textarea>"
'response.end
ds.open
dname=ds("d_name")
sname=ds("s_name")
suredate=ds("suredate")
suretime=ds("suretime")
add=ds("address")
tel=ds("tel")
vipcode=ds("vipcode")
ssums=ds("s_sums")
zsums=ds("z_sums")
centum=0
ds.close
if vipcode<>"" then
   ds.source = "select isnull(a.centum,0)+isnull(b.starcentum,0) as centum from vip_user a,vip_cardvip b "&_
               "where b.vipcardid='"&vipcode&"' and a.vipid=b.vipid"
   ds.open
   if not ds.eof then 
      centum=ds("centum")
   else
      centum=0
   end if
   ds.close
end if
'ӪҵԱ
ds.Source="select names from jk_retailhistory where retailid='"&retailid&"'" 
ds.Open
xname=""
while not ds.EOF
xname=xname&ds("names")&","
ds.MoveNext
wend
ds.Close
if xname<>"" then xname=left(xname,len(xname)-1)
%>
<center>
<table width='350' border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td colspan=4 align=center><b>����˼��˾����СƱ</b><br><br></td></tr>
<tr><td width=50>��&nbsp;&nbsp;&nbsp;�ţ�</td><td width=150><%=retailid%></td><td width=60>�� �� Ա��</td><td width=90><%=sname%></td></tr>
<tr><td>��&nbsp;&nbsp;&nbsp;Ա��</td><td><%=xname%></td><td>��&nbsp;&nbsp;&nbsp;&nbsp;�ڣ�</td><td><%=suredate%></td></tr>
<tr><td>��&nbsp;&nbsp;&nbsp;����</td><td><%=dname%></td><td>ʱ&nbsp;&nbsp;&nbsp;&nbsp;�䣺</td><td><%=suretime%></td></tr>
<tr><td>��&nbsp;&nbsp;&nbsp;ַ��</td><td><%=add%></td><td>��ϵ�绰��</td><td><%=tel%></td></tr>
<tr><td>VIP���ţ�</td><td><%=vipcode%></td><td>�ۼƻ��֣�</td><td><%=centum%></td></tr>
</table><br>
<%ds.Source =" select a.s_name,b.clothingid,b.x_price,b.discount,b.s_price,b.nums,b.nums*b.s_price as sums"& _
  			"  from j_style a,d_retailsub b where a.styleid=b.styleid and b.retailid='"&retailid&"'"
  ds.Open
%>
<%dim ds,cn,tmp,i,j,retype
nums=0
sums=0
i=0
%><table width='350' border="0" align="center" cellpadding="0" cellspacing="0" id="t">
  <tr align='center'>
    <td width="25%">����</td>
	<td width="25%">����</td>
    <td width="10%">�ּ�</td>
    <td width="10%">�ۿ�</td>
    <td width="10%">����</td>
	<td width="10%">����</td>
    <td width="10%">���</td>
  </tr>
  <tr><td colspan=7><hr size=1></td></tr>
  <%
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td><%=ds("clothingid")%></td>
	<td><%=ds("s_name")%></td>
	<td><%=ds("x_price")%></td>
	<td><%=ds("discount")%></td>
	<td><%=ds("s_price")%></td>
    <td><%=ds("nums")%></td>
    <td><%=ds("sums")%></td>
  </tr>
  <%nums=nums+cdbl(ds("nums"))
	sums=sums+cdbl(ds("sums"))
  ds.MoveNext
  wend
  ds.Close%>
  <tr><td colspan=7><hr size=1></td></tr>
</table>
<table width='350' border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td width=100>�� �� ����</td><td width=75><%=nums%></td><td width=100>�� �� �</td><td width=75><%=sums%></td></tr>
<tr><td>�տ��ܶ</td><td><%=ssums%></td><td>�һؽ�</td><td><%=zsums%></td></tr>
</table>
<table width='350' border="0" align="center" cellpadding="0" cellspacing="0">
<%ds.source = "select retype,sums from pos_skfs where retailid='"&retailid&"' and isnull(sums,0)<>0"
ds.open
j=1
while not ds.eof
   retype=ds("retype")
   if j=1 then%>
   <tr><td width=100>�տʽ��</td><td width=250><%response.write(retype&" : "&ds("sums"))%></td></tr>
   <%else%>
   <tr><td></tr><td><%response.write(retype&" : "&ds("sums"))%></td></tr>
   <%end if
   j=j+1
ds.movenext
wend
ds.close
set ds=nothing%>
</table><br>
<b>лл�ݹ� ���ٹ���<br>
Thank You And Please Come Again<br>
www.ellassay.com</b>
</center> 
<center class="Noprint" ><hr width="350" size=1>
<input  type="button"  value="��ӡ(P)" onClick="printTable('t');" accesskey="p">
<!--<input  type="button"  value="ֱ�Ӵ�ӡ"  onclick="b2();">
<input  type="button"  value="ҳ������"  onclick="b3();">
<input  type="button"  value="��ӡԤ��"  onclick="b4();">-->
<input  type="button"  value="�ر�(C)"  onclick="pageClose();" accesskey="c">
</center>
</form>
<script language="javascript">
var wh=300+20*<%=i%>;
window.dialogWidth="400px";
window.dialogHeight=wh+"px";
</script>
 </body>
</HTML>

