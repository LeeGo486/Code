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
body,td,th {
	font-size: 12px;
}
  .f0{font-size:7px}
  .f1{font-size:14px}
  .f2{font-size:12px}
  .f3{font-size:10px}
  </style>
<%dim depotname,retailid,sum,xname,suredate,tel,vipcode,comment,depotid,add,sname,centum,company,currdate,EmployeeName
retailid=trim(request.querystring("id"))
depotname=trim(session("dm").System_depotname)
depotid=trim(session("dm").System_depotid)
cn=session("cn")
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
sum=0

ds.Source =" select a.s_name,a.cr_name,b.clothingid,b.styleid,b.colorid,b.sizeid,b.x_price,b.discount,b.s_price,b.nums,isnull(b.larg,0) as zs,b.nums*b.s_price as sums,"& _
  			"  b.nums*b.x_price as xsums,b.nums*b.x_price-b.nums*b.s_price as zsums from d_retail a,d_retailsub b "& _
  			 " where a.retailid=b.retailid and a.retailid='"&retailid&"'"& _
			 " order by b.s_price desc"
ds.Open

'营业员
set rs=server.CreateObject("adodb.recordset")
rs.ActiveConnection=cn
rs.open "select sysdefvalue from sys_system where systemid=1001",cn
company=rs("sysdefvalue")
rs.close
rs.Source="select names from jk_retailhistory where retailid='"&retailid&"'" 
rs.Open
xname=""
while not rs.EOF
xname=xname&rs("names")&","
rs.MoveNext
wend
rs.Close
rs.source="select currdate=getdate(),a.vipcode,b.tel,convert(char(10),a.sure_date,126) as suredate,a.comment,b.address,a.s_name,a.s_sums,a.z_sums from d_retail a,j_depot b where a.depotid=b.depotid and a.retailid='"&retailid&"'"
rs.open
vipcode=rs("vipcode")
suredate=rs("suredate")
tel=rs("tel")
comment=rs("comment")
add=rs("address")
sname=rs("s_name")
ssums=rs("s_sums")
zsums=rs("z_sums")
currdate=rs("currdate")
rs.close

rs.source = " select EmployeeName=dbo.FUN_GetEmployeeName('LS0001-2009-11-10-0001') from jk_retailhistory(nolock) where  retailid='"&retailid&"'" 
   rs.open
   if not rs.eof then 
      EmployeeName=rs("EmployeeName")
   else
      EmployeeName=0
   end if
rs.close
   

if vipcode<>"" then
   'rs.source = "select isnull(a.centum,0)+isnull(b.starcentum,0) as centum from vip_user a,vip_cardvip b "&_
    '           "where b.vipcardid='"&vipcode&"' and a.vipid=b.vipid"
	rs.source = " select centum=sum(vipcentum) from d_retailsub(nolock) where  retailid='"&retailid&"'" 
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
<table style='width:63mm' border="0" align="center" cellpadding="0" cellspacing="0">
<tr align=center height=40><td colspan=2 valign="middle"><font class=f1><%=company%></font></td></tr>
<tr><td colspan="2"><hr size="1"></td></tr>
<tr><td colspan="2"><font class='f2'>单号：<%=retailid%></font></td></tr>
<tr><td colspan="2"><font class='f2'>店铺：<%=depotname%></font></td></tr>
<tr><td colspan="2"><font class='f2'>地址：<%=add%></font></td></tr>
<tr><td><font class='f2'>打单日期：<%=suredate%></font></td><td><font class='f2'>联系电话：<%=tel%></font></td></tr>
<tr><td colspan="2"><font class='f2'>打印时间：<%=currdate%></font></td></tr>
<tr><td colspan="2"><hr size="1"></td></tr>
</table>
<%dim ds,cn,tmp,i
sum=0
%><table style='width:63mm' border="0" align="center" cellpadding="0" cellspacing="0" class='f12' id="t">
  <tr align=center>
    <td width="30%">款号</td>
    <td width="10%">数量</td>
	<td width="15%">单价</td>
	<td width="10%">折扣</td>
    <td width="15%">结算价</td>
  </tr>
  <%
  i=0
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td><%=ds("clothingid")%></td>
    <td><%nums=nums+cdbl(ds("nums"))
    response.Write cdbl(ds("nums"))%></td>
	<td><%=ds("x_price")%></td>
	<td><%=ds("discount")%></td>
    <td><%sums=sums+cdbl(ds("sums"))
    response.Write cdbl(ds("sums"))%></td>
  </tr>
  <%ds.MoveNext
  wend
  ds.Close%>
<tr><td colspan="5"><hr size="1"></td></tr>
</table> 
<table style='width:63mm' border="0" align="center" cellpadding="0" cellspacing="0"> 
  <tr><td>总件数</td><td colspan="2"><%=nums%></td><td>总金额</td><td><%=sums%></td></tr>
  <tr><td>VIP卡号</td><td colspan="2"><%=vipcode%></td><td>VIP积分</td><td colspan="2"><%=centum%></td></tr>
  <tr><td>营业员</td><td colspan="5"><%=EmployeeName%></td></tr>
</table>
<br>
<table style='width:63mm' border="0" align="center" cellpadding="0" cellspacing="0">
<tr align="center" height=40><td><font class=f2>谢谢惠顾，请保留小票作为开发票凭证！<br>七天内凭小票换货！</font></td></tr>
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

