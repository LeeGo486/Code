<%Response.cachecontrol = "no-cache"
Response.Expires=-1000%>
<HTML>
  <HEAD><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <title>打印小票</title>
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

'营业员
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
<tr align=center height=40><td colspan=2><b><font class=f1>纳纹销售小票</font></b></td></tr>
<tr height="20" align="center"><td colspan="2"><font class='f2'><%=retailid%></font></td></tr>
<tr height=20><td><font class='f2'>销售店柜:<%=depotname%></font></td><td><font class='f2'>营业员:<%=xname%></font></td></tr>
<tr height=20><td><font class='f2'>电话:<%=tel%></font></td><td><font class='f2'>VIP卡号:<%=vipcode%></font></td></tr>
</table>
<%dim ds,cn,tmp,i
sum=0
%><table style='width:58mm' border="0" align="center" cellpadding="0" cellspacing="0"  class='f12' id="t">
  <tr align=center>
    <td width="30%">款号</td>
    <td width="10%">数量</td>
    <td width="15%">单价</td>
	<td width="10%">折扣</td>
    <td width="15%">结算价</td>
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
    <td colspan=2>付款合计:</td>
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
   <tr><td width=100><font class=f2>收款方式:</font></td><td width=250><font class=f2><%response.write(retype&" : "&ds("sums"))%></font></td></tr>
   <%else%>
   <tr><td></tr><td><font class=f2><%response.write(retype&" : "&ds("sums"))%></font></td></tr>
   <%end if
   j=j+1
ds.movenext
wend
ds.close
set ds=nothing%>
</table>
<table style='width:58mm' border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td><hr size="1" noshade></td></tr>
<tr><td><font class=f2>备注：<%=comment%></font></td></tr>
<tr><td><font class=f2>1、请妥善保管好购物凭证，以便我们为您提供售后服务。</font></td></tr>
<tr><td><font class=f2>2、您购买的商品需要调换，在三天内不影响第二次销售的情况下，凭您的购物凭证来我店调换价格相同或以上的货品。</font></td></tr>
<tr height="30"><td align="center"><font class=f2>成交时间：<%=time%></font></td></tr>
<tr align="center"><td><font class=f2>谢谢惠顾，欢迎再次光临!</font></td></tr>
</table>
<center class="Noprint" >
<input  type="button"  value="打印(P)" onClick="printTable('t');" accesskey="p">
<!--<input  type="button"  value="直接打印"  onclick="b2();">
<input  type="button"  value="页面设置"  onclick="b3();">
<input  type="button"  value="打印预览"  onclick="b4();">-->
<input  type="button"  value="关闭(C)"  onclick="pageClose();" accesskey="c">
</center>
</form>
<script language="javascript">
var wh=300+20*<%=i%>;
window.dialogWidth="400px";
window.dialogHeight=wh+"px";
</script>
 </body>
</HTML>

