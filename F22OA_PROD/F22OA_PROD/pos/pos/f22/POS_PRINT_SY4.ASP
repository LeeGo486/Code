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

    <style type="text/css">
<!--
.style2 {font-size: 12px}
-->
    </style>
  </HEAD>
 <body>
  <form>
  <style media='print'>
   .Noprint { DISPLAY: none }
   .PageNext { PAGE-BREAK-AFTER: always }
  </style>
  <style>
body,td,th {
	font-size: 12px;
}
  .f1{font-size:12px}
  .f2{font-size:12px}
  .f3{font-size:10px}
  </style>
<%dim depotname,retailid,sum,xname,suredate,tel,vipcode,comment,depotid,add,sname,centum
retailid=trim(request.querystring("id"))
depotname=trim(session("dm").System_depotname)
depotid=trim(session("dm").System_depotid)
cn=session("cn")
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
sum=0

ds.Source =" select a.s_name,a.cr_name,b.clothingid,c.s_name as styNM,b.x_price,b.discount,b.s_price,b.nums,isnull(b.larg,0) as zs,b.nums*b.s_price as sums,"& _
  			"  b.nums*b.x_price-b.nums*b.s_price as zsums from d_retail a,d_retailsub b, j_style c  "& _
  			 "  where a.retailid=b.retailid and b.styleid=c.styleid and a.retailid='"&retailid&"'"& _
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
rs.source="select a.vipcode,b.tel,convert(char(10),a.sure_date,126) as suredate,a.comment,b.address,a.s_name,a.s_sums,a.z_sums from d_retail a,j_depot b where a.depotid=b.depotid and a.retailid='"&retailid&"'"
rs.open
vipcode=rs("vipcode")
suredate=rs("suredate")
tel=rs("tel")
comment=rs("comment")
add=rs("address")
sname=rs("s_name")
ssums=rs("s_sums")
zsums=rs("z_sums")
rs.close
if vipcode<>"" then
   rs.source = "select isnull(a.centum,0)+isnull(b.starcentum,0) as centum from vip_user a,vip_cardvip b "&_
               "where b.vipcardid='"&vipcode&"' and a.vipid=b.vipid"
   rs.open
   if not rs.eof then 
      centum=rs("centum")
   else
      centum=0
   end if
   rs.close
end if
set rs=nothing
if xname<>"" then xname=left(xname,len(xname)-1)%>
<table style='width:58mm' border="0" align="center" cellpadding="0" cellspacing="0">
<tr align=center height=40><td colspan=2><b><font class=f1>[<%=depotid%>]香港松鹰男装<%=depotname%></font></b></td></tr>
<tr height="20"><td colspan="2"><font class='f2'>地址：<%=add%></font></td></tr>
<tr height=20><td><font class='f2'>电话：<%=tel%></font></td><td><font class='f2'>日期：<%=suredate%></font></td></tr>
<tr height="20"><td colspan="2"><font class='f2'>流水号：<%=retailid%></font></td></tr>
<tr height=20><td><font class='f2'>VIP：<%=vipcode%></font></td><td><font class='f2'>积分：<%=centum%></font></td></tr>
</table>
<%dim ds,cn,tmp,i
sum=0
%><table style='width:58mm' border="0" align="center" cellpadding="0" cellspacing="0"  class='f12' id="t">
  <tr align=center>
    <td width="30%">货品</td>
    <td width="15%">单价</td>	
	<td width="10%">折扣</td>	
    <td width="10%">数量</td>
    <td width="15%">结算价</td>
  </tr>
  <tr><td colspan=5><hr size="1" noshade></td></tr>
  <%
  i=0
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td><%=ds("clothingid")%><br><%=ds("styNM")%></td>
    <td><%=ds("x_price")%></td>
	<td><%=ds("discount")%></td>	
    <td><%nums=nums+cdbl(ds("nums"))
    response.Write cdbl(ds("nums"))%></td>
    <td><%sums=sums+cdbl(ds("sums"))
    response.Write cdbl(ds("sums"))%></td>
  </tr>
  <%ds.MoveNext
  wend
  ds.Close%>
  <tr><td colspan=5><hr size="1" noshade></td></tr>
  <tr align=center><td colspan="2" align=left><font class='f2'>营业员：<%=xname%></font></td><td>合计</td><td><%=nums%></td><td><%=sums%></td></tr>
  <tr><td>客付</td><td><%=ssums%></td><td>找零</td><td></td><td><%=zsums%></td></tr>
</table>
<table style='width:58mm' border="0" align="center" cellpadding="0" cellspacing="0">
<%ds.source = "select retype,sums from pos_skfs where retailid='"&retailid&"' and isnull(sums,0)<>0"
ds.open
j=1
while not ds.eof
   retype=ds("retype")
   if j=1 then%>
   <tr><td width=100><font class=f2>收款方式：</font></td><td width=250><font class=f2><%response.write(retype&" : "&ds("sums"))%></font></td></tr>
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
<tr align="center" height=50>
  <td height="25" align="left" valign="bottom"><font class=f2 style2 style1>营业员:__________ 顾客签名:_________</font></td>
</tr>
<tr align="center" height=20>
  <td height="45" align="left" valign="middle"><p>备注:</p>    </td>
</tr>
<tr height=10><td height="10" align="center" valign="middle"><font class=f2>谢谢惠顾，再次光临<br>
Thank You And Please Come Again</font><br>
  <br></td></tr>
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

