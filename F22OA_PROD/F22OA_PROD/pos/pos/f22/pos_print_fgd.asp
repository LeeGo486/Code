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

  </HEAD>
 <body>
  <form>
  <style media='print'>
   .Noprint { DISPLAY: none }
   .PageNext { PAGE-BREAK-AFTER: always }
  </style>
  <style>
  .f1{font-size:15px}
  .f2{font-size:12px}
  .f3{font-size:10px}
  </style>
<%dim depotname,retailid,sum,xname,suredate,tel,vipcode,comment
retailid=trim(request.querystring("id"))
depotname=trim(session("dm").System_depotname)
cn=session("cn")
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
sum=0

ds.Source =" select a.s_name,a.cr_name,b.clothingid,b.x_price,b.discount,b.s_price,b.nums,isnull(b.larg,0) as zs,b.nums*b.s_price as sums,"& _
  			"  b.nums*b.x_price-b.nums*b.s_price as zsums from d_retail a,d_retailsub b "& _
  			 " where a.retailid=b.retailid and a.retailid='"&retailid&"'"& _
			 " order by b.s_price desc"
ds.Open

'ӪҵԱ
set rs=server.CreateObject("adodb.recordset")
rs.ActiveConnection=cn
rs.Source="select names from jk_retailhistory where retailid='"&retailid&"'" 
rs.Open
xname=""
while not rs.EOF
xname=xname&rs("names")&","
rs.MoveNext
wend
rs.Close
rs.source="select a.vipcode,b.tel,convert(char(10),a.sure_date,126) as suredate,a.comment from d_retail a,j_depot b where a.depotid=b.depotid and a.retailid='"&retailid&"'"
rs.open
vipcode=rs("vipcode")
suredate=rs("suredate")&" "&time
tel=rs("tel")
comment=rs("comment")
rs.close
set rs=nothing
if xname<>"" then xname=left(xname,len(xname)-1)%>
<table style='width:58mm' border="0" align="center" cellpadding="0" cellspacing="0">
<tr align=center height=40><td colspan=2><b><font class=f1>FGD���ﵥ</font></b></td></tr>
<tr height="20" align="center"><td colspan="2"><font class='f2'><%=retailid%></font></td></tr>
<tr height=20><td><font class='f2'>���۵��:<%=depotname%></font></td><td><font class='f2'>ӪҵԱ:<%=xname%></font></td></tr>
<tr height=20><td><font class='f2'>�绰:<%=tel%></font></td><td><font class='f2'>VIP����:<%=vipcode%></font></td></tr>
</table>
<%dim ds,cn,tmp,i
sum=0
%><table style='width:58mm' border="0" align="center" cellpadding="0" cellspacing="0"  class='f12' id="t">
  <tr align=center>
    <td width="30%">���</td>
    <td width="10%">����</td>
    <td width="15%">����</td>
	<td width="10%">�ۿ�</td>
    <td width="15%">�����</td>
  </tr>
  <tr><td colspan=5><hr size="1" noshade></td></tr>
  <%
  i=0
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td><%=ds("clothingid")%></td>
    <td><%=ds("nums")%></td>
    <td><%=ds("x_price")%></td>
	<td><%=ds("discount")%></td>
    <td>
	<%sums=cdbl(ds("sums"))
	sum=sum+sums
    response.Write sums%></td>
  </tr>
  <%ds.MoveNext
  wend
  ds.Close%>
    <tr height=20>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan=2>����ϼ�:</td>
    <td><%=sum%></td>
  </tr>
  <tr><td colspan=5><hr size="1" noshade></td></tr>
</table>
<table style='width:58mm' border="0" align="center" cellpadding="0" cellspacing="0">
<%ds.source = "select retype,sums from pos_skfs where retailid='"&retailid&"' and isnull(sums,0)<>0"
ds.open
j=1
while not ds.eof
   retype=ds("retype")
   if j=1 then%>
   <tr><td width=100><font class=f2>�տʽ:</font></td><td width=250><font class=f2><%response.write(retype&" : "&ds("sums"))%></font></td></tr>
   <%else%>
   <tr><td></tr><td><font class=f2><%response.write(retype&" : "&ds("sums"))%></font></td></tr>
   <%end if
   j=j+1
ds.movenext
wend
ds.close
set ds=nothing%>
</table>
<br>
<table style='width:58mm' border="0" align="center" cellpadding="0" cellspacing="0">
<tr height=20><td><font class=f2>�˿�ǩ��:</font></td></tr>
<tr height=20><td><font class=f2>�绰:</font></td></tr>
<tr><td><hr size="1" noshade></td></tr>
<tr><td><font class=f2>��ע��<%=comment%></font></td></tr>
<tr height=50><td align=center><font class=f3>Ϊ������������,�����Ʊ��������ƾ֤.<br>�ɽ�ʱ�䣺<%=time%></font></td></tr>
<tr align="center" height=40><td><font class=f2>лл�ݹˣ���ӭ�ٴι���!</font></td></tr>
</table>
<center class="Noprint" >
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

