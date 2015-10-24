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
<%dim dname,retailid,sname,xname,suredate,suretime,add,vipcode,centum,tel,nums,sums,ssums,zsums,comment
retailid=trim(request.querystring("id"))
cn=session("cn")
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.source = " select a.s_sums,a.z_sums,a.s_name,b.d_name,convert(char(10),a.sure_date,126) as suredate,"&_
						" convert(char(8),getdate(),114) as suretime,b.address,a.comment,"&_
            " b.tel,isnull(a.vipcode,'') as vipcode from d_retail a,j_depot b "&_
						" where a.retailid='"&retailid&"' and a.depotid=b.depotid "
'response.Write "<textarea>"& ds.Source&"</textarea>"
'response.end
ds.open
dname=ds("d_name") '店铺名称
sname=ds("s_name") '收银员
suredate=ds("suredate") '销售日期
suretime=ds("suretime") '销售时间
add=ds("address") '店铺地址
tel=ds("tel") '店铺电话
vipcode=ds("vipcode") 'VIP卡号
ssums=ds("s_sums") '实收
zsums=ds("z_sums") '找回
comment=ds("comment") '找回
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
if xname<>"" then xname=left(xname,len(xname)-1) '营业员
%>
<center>
<table width='350' border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td colspan=4 align=center><b><font class="t2">迷底小票</font></b><br><br></td></tr>
<tr><td width=50>核销单：</td><td colspan="3"><%=retailid%></td></tr>
<tr><td>店铺：</td><td><%=dname%></td><td width=55>VIP卡号：</td><td><%=vipcode%></td></tr>
<tr><td>日期：</td><td><%=suredate%></td><td> 时间：</td><td><%=suretime%></td></tr>
</table>
<%ds.Source =" select a.s_name,b.clothingid,b.sizeid,c.c_name,b.colorid,b.x_price,b.discount,b.s_price,b.nums,b.nums*b.s_price as sums"& _
  			"  from j_style a,d_retailsub b,j_color c where a.styleid=b.styleid and b.colorid=c.colorid and b.retailid='"&retailid&"'"
  ds.Open
%>
<%dim ds,cn,tmp,i,j,retype
nums=0
sums=0
i=0
%><table width='350' border="0" align="center" cellpadding="0" cellspacing="0" id="t">
  <tr><td colspan=8><hr size=1></td></tr>
  <tr align='center'>
    <td width="25%">货号</td>
    <td width="15%">货品名称</td>
    <td width="15%">颜色</td>
	<td width="10%">尺码</td>
    <td width="10%">数量</td>
    <td width="10%">单价</td>
    <td width="10%">结算额</td>
      </tr>
  <%
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td><%=ds("clothingid")%></td>
    <td><%=ds("s_name")%></td>
    <td><%=ds("colorid")&ds("c_name")%></td>
	<td><%=ds("sizeid")%></td>
	<td><%=ds("nums")%></td>
	<td><%=ds("s_price")%></td>
    <td><%=ds("sums")%></td>
  </tr>
  <%nums=nums+cdbl(ds("nums"))
	sums=sums+cdbl(ds("sums"))
  ds.MoveNext
  wend
  ds.Close%>
  <tr align='center'>
    <td>总计：</td>
    <td></td>
    <td></td>
	<td></td>
    <td><%=nums%></td>
    <td></td>
    <td><%=sums%></td>
  </tr>
  <tr><td colspan=8><hr size=1></td></tr>
  <!--
  <tr><td colspan=6><hr size=1></td></tr>
  <tr height="30">
  <td colspan="5" align="right"><font class="t2">总计：</font></td>
  <td colspan="5" align="right"><font class="t2">总计：</font></td>
  <td><font class="t2"><%=sums%></font></td>
  </tr>-->
</table>
<table width='350' border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td>应收：</td><td><%=sums%></td><td>实收：</td><td><%=ssums%></td><td>找回金额：</td><td><%=zsums%></td></tr>
</table>
<table width='350' border="0" align="center" cellpadding="0" cellspacing="0">
<%ds.source = "select retype,sums from pos_skfs where retailid='"&retailid&"' and isnull(sums,0)<>0"
ds.open
j=1
while not ds.eof
   retype=ds("retype")
   if j=1 then%>
   <tr><td width=100>收款方式：</td><td width=250><%response.write(retype&"："&ds("sums"))%></td></tr>
   <%else%>
   <tr><td></tr><td><%response.write(retype&"："&ds("sums"))%></td></tr>
   <%end if
   j=j+1
ds.movenext
wend
ds.close
set ds=nothing%>
</table><br>
<table width='350' border="0" align="center" cellpadding="0" cellspacing="0">   
<tr><td>备　注：</td><td colspan="3"><%=comment%></td></tr>
<tr><td>导购员：</td><td><%=xname%></td><td>电&nbsp;话：</td><td><%=tel%></td></tr>
<tr><td colspan="4"></td></tr>
<tr height="30"><td colspan="4" align="center">***多谢惠顾***</td></tr>
</table>
</center> 
<center class="Noprint" ><hr width="350" size=1>
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

