<%Response.cachecontrol = "no-cache"
Response.Expires=-1000%>
<HTML>
  <HEAD><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <title>��ӡСƱ</title>
  <link href="css/f22.css" rel="stylesheet" type="text/css">
    <script language="javascript">
	function printTable(id){
	  window.print();
//	  if(parent.winid!=undefined){
//	    parent.close();
//	  }
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

.t1{font-size:12px}
.t2{font-size:15px}
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
ds.source = "select a.sellnametel,a.sellname,a.s_sums,a.z_sums,a.s_name,b.d_name,convert(char(10),a.sure_date,126) as suredate,convert(char(8),a.sure_date,114) as suretime,b.address,"&_
            "b.tel,isnull(a.vipcode,'') as vipcode from d_retail a,j_depot b "&_
			"where a.retailid='"&retailid&"' and a.depotid=b.depotid "
'response.Write "<textarea>"& ds.Source&"</textarea>"
'response.end
ds.open
dname=ds("d_name") '��������
sname=ds("s_name") '����Ա
suredate=ds("suredate") '��������
suretime=ds("suretime") '����ʱ��
add=ds("address") '���̵�ַ
tel=ds("tel") '���̵绰
vipcode=ds("vipcode") 'VIP����
ssums=ds("s_sums") 'ʵ��
zsums=ds("z_sums") '�һ�
sellname=ds("sellname") '�˿�����
sellnametel=ds("sellnametel")'�˿͵绰
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
if xname<>"" then xname=left(xname,len(xname)-1) 'ӪҵԱ
%>
<center>
<table width='350' border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td>���̣�</td><td><%=dname%></td><td>���ڣ�</td><td><%=suredate%></td></tr>
<tr><td width=50>���ţ�</td><td colspan="3"><%=retailid%></td></tr>
<tr><td>�绰��</td><td><%=tel%></td><td>VIP���ţ�</td><td><%=vipcode%></td></tr>
<tr><td>����Ա��</td><td colspan="3"><%=xname%></td></tr>
</table>
<%ds.Source =" select a.s_name,b.clothingid,b.sizeid,b.x_price,b.discount,b.s_price,b.nums,b.nums*b.s_price as sums"& _
  			"  from j_style a,d_retailsub b where a.styleid=b.styleid and b.retailid='"&retailid&"'"
  ds.Open
%>
<%dim ds,cn,tmp,i,j,retype
nums=0
sums=0
i=0
%><table width='350' border="0" align="center" cellpadding="0" cellspacing="0" id="t">
  <tr><td colspan=6><hr size=1></td></tr>
  <tr align='center'>
    <td width="25%">���</td>
	<td width="10%">����</td>
    <td width="10%">����</td>
    <td width="10%">����</td>
    <td width="10%">�ۿ�</td>
    <td width="10%">�����</td>
  </tr>
  <%
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td><%=ds("clothingid")%></td>
	<td><%=ds("sizeid")%></td>
	<td><%=ds("nums")%></td>
	<td><%=ds("s_price")%></td>
	<td><%=ds("discount")%></td>
    <td><%=ds("sums")%></td>
  </tr>
  <%nums=nums+cdbl(ds("nums"))
	sums=sums+cdbl(ds("sums"))
  ds.MoveNext
  wend
  ds.Close%>
  <tr><td colspan=6><hr size=1></td></tr>
  <tr height="30"><td colspan="5" align="right"><font class="t2">����ϼƣ�</font></td><td><font class="t2"><%=sums%></font></td></tr>
</table>
<table width='350' border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td>Ӧ�գ�</td><td><%=sums%></td><td>ʵ�գ�</td><td><%=ssums%></td><td>�һؽ�</td><td><%=zsums%></td></tr>
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
<table width='350' border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td>�˿�������<%=sellname%></td>
  <td>&nbsp;</td>
</tr>
<tr><td colspan="2">��&nbsp;&nbsp;&nbsp;&nbsp;����<%=sellnametel%></td>
</tr>
<tr><td><br></td>
  <td>&nbsp;</td>
</tr>
<tr height="50">
  <td align="left"> &nbsp;&nbsp;&nbsp;&nbsp;���ڹ�������ƶ�����ƾ�����������ĵ��ƻر������������������ˡ�����ܻ�����������Ϊ�𻵣��������Ը�ṩ�г����񣬾�������������Ʒ�޲��á�<br>
�ɽ�ʱ�䣺<%=suretime%><br></td>
  <td align="center">&nbsp;</td>
</tr>
<tr><td>�ؼۻ�Ʒ����ϴˮ��Խ���һ�ǣ������˻���</td>
  <td>&nbsp;</td>
</tr>
<tr><td><br></td>
  <td>&nbsp;</td>
</tr>
<tr><td>��˿�ȷ��ǩ��______________</td>
  <td>&nbsp;</td>
</tr>
<tr height="30"><td align="center">��Ʒ��ͳһ���ۼ۾��ۡ���л�ݹˣ���ӭ�ٴι���</td>
  <td align="center">&nbsp;</td>
</tr>
</table>
</center> 
<center class="Noprint" ><hr width="350" size=1>
<input  type="button"  value="��ӡ(P)" onClick="printTable('t');" accesskey="p" id="btnPrint">
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

