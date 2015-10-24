<%
Response.cachecontrol = "no-cache"
Response.Expires=-1000
Dim width,fontsize

width=100			'小票宽度，单位：毫米(mm)
fontsize=10

%>
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
body,td,th {
	font-size: <%=fontsize%>pt;
}
-->
</style></HEAD>
 <body>
    <style media='print'>
   .Noprint { DISPLAY: none }
   .PageNext { PAGE-BREAK-AFTER: always }
  </style>
<%dim dname,depotid,retailid,sname,xname,suredate,suretime,add,vipcode,centum,tel,nums,sums,ssums,zsums
retailid=trim(request.querystring("id"))
cn=session("cn")
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.source = "select a.depotid,a.s_sums,a.z_sums,a.s_name,b.d_name,convert(char(10),a.sure_date,126) as suredate,convert(char(8),a.sure_date,114) as suretime,b.address,"&_
            "b.tel,isnull(a.vipcode,'') as vipcode from d_retail a,j_depot b "&_
			"where a.retailid='"&retailid&"' and a.depotid=b.depotid "
'response.Write "<textarea>"& ds.Source&"</textarea>"
'response.end
ds.open
depotid=ds("depotid")
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
'营业员
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
<table style="width:<%=width%>mm" border="0" align="center" cellpadding="0" cellspacing="0">
<form>
<tr>
<center>
<td>
<table width='100%' border="0" align="center" cellpadding="3" cellspacing="0">
<tr><td colspan=4 align=center>
<strong style="font-size:14px;">[<%=depotid%>] <%=dname%></strong>
</td></tr>
<tr>
  <td colspan="4"><%=now()%></td>
  </tr>
<tr>
  <td>单号：</td><td colspan="3"><%=retailid%></td>
  </tr>
<tr>
  <td>VIP卡号：</td>
  <td colspan="3"><%=vipcode%></td>
  </tr>
<tr>
  <td width="20%">收银员：</td>
  <td width="30%"><%=sname%></td>
  <td width="20%">营业员：</td>
  <td width="30%"><%=xname%></td></tr>
</table><br>
<%ds.Source =" select a.s_name,b.clothingid,b.x_price,b.discount,b.s_price,b.nums,b.nums*b.s_price as sums"& _
  			"  from j_style a,d_retailsub b where a.styleid=b.styleid and b.retailid='"&retailid&"'"
  ds.Open
%>
<%dim ds,cn,tmp,i,j,retype
nums=0
sums=0
i=0
%><table width='100%' border="0" align="center" cellpadding="0" cellspacing="0" id="t">
  <tr><td colspan=5><hr size=1></td></tr>
  <tr align="center">
    <td width="40%" height="30">款式编号</td>
	<td width="15%">数量</td>
    <td width="15%">单价</td>
	<td width="15%">折扣</td>
    <td width="15%">金额</td>
  </tr>
  <%
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td><%=ds("clothingid")%></td>
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
  <tr><td colspan=5><hr size=1></td></tr>
</table>
<table width='100%' border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td width="20%">总件数：</td><td width="30%"><%=nums%></td>
  <td width="20%">总金额：</td><td width="30%"><%=sums%></td></tr>
<tr>
  <td>实收：</td><td><%=ssums%></td>
<td>找赎：</td><td><%=zsums%></td></tr>
</table>
<table width='100%' border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
     <td width="20%">付款方式：</td>
     <td width="80%">
     <ul style="list-style:none;margin:0;padding:0;">
				<%ds.source = "select retype,sums from pos_skfs where retailid='"&retailid&"' and isnull(sums,0)<>0"
        ds.open
        while not ds.eof
           retype=ds("retype")
           %>
           <li style="float:left;width:50%;text-align:left;"><%response.write(retype&"："&ds("sums"))%></li>
           <%
           j=j+1
        ds.movenext
        wend
        ds.close
        set ds=nothing%>
        </ul>
      </td>
  </tr>
</table>
<table width='100%' border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td colspan="2" align="center" height="30">谢谢惠顾！请保留小票做为开票凭证。</td>
</tr>
<tr>
  <td align="right" width="60%">电话：</td>
  <td align="left"><%=tel%></td>
</tr>
</table>
</center> 
<center class="Noprint" ><hr width="100%" size=1>
<input  type="button"  value="打印(P)" onClick="printTable('t');" accesskey="p">
<!--<input  type="button"  value="直接打印"  onclick="b2();">
<input  type="button"  value="页面设置"  onclick="b3();">
<input  type="button"  value="打印预览"  onclick="b4();">-->
<input  type="button"  value="关闭(C)"  onclick="pageClose();" accesskey="c">
</center>
</td>
</tr>
</form>
</table>
<script language="javascript">
var wh=300+20*<%=i%>;
window.dialogWidth="400px";
window.dialogHeight=wh+"px";
</script>
 </body>
</HTML>

