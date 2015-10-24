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
<%dim depotname,retailid,sum,xname,suredate
retailid=trim(request.querystring("id"))
depotname=trim(session("dm").System_depotname)
cn=session("cn")
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
sum=0
ds.source = "select convert(char(10),sure_date,126) from d_retail where retailid='"&retailid&"'"
ds.open
suredate=ds(0)
ds.close
%>
<center>
<span style="font-size:16px "><%=depotname%> 小票<br>
</span><span style="font-size:12px ">销售日期:<%=suredate%></span> <br>
<%ds.Source =" select a.s_name,a.cr_name,b.clothingid,b.x_price,b.discount,b.s_price,b.nums,isnull(b.larg,0) as zs,b.nums*b.s_price as sums"& _
  			"  from d_retail a,d_retailsub b "& _
  			 " where a.retailid=b.retailid and a.retailid='"&retailid&"'"& _
			 " order by b.s_price desc"

  'response.Write "<textarea>"& ds.Source&"</textarea>"
  ds.Open
%>
<%'营业员
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
set rs=nothing
if xname<>"" then xname=left(xname,len(xname)-1)%>
<font class='f12'>
<%=retailid%><br>
收银员:<%=ds("cr_name")%> 
营业员:<%=xname%></font>
<hr width="220" size="1" noshade>
<%dim ds,cn,tmp,i
sum=0
%><table width='220' border="0" align="center" cellpadding="0" cellspacing="0"  class='f12' id="t">
  <tr bgcolor='#FFEFEF' align='center'>
    <td width="25%">编号</td>
    <td width="9%">数量</td>
	<td width="9%">零售价</td>
    <td width="9%">折扣</td>
    <td width="17%">金额</td>
  </tr>
  <%
  i=0
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td>&nbsp;<%=ds("clothingid")%></td>
    <td>&nbsp;<%=ds("nums")%></td>
	<td>&nbsp;<%=ds("x_price")%></td>
    <td>&nbsp;<%=ds("discount")%></td>
    <td>
	<%sums=cdbl(ds("sums"))
	sum=sum+sums
	 if ds("zs")=false then
	   response.Write sums
	   
	  elseif ds("zs")=true then
	    response.write sums&"(<font color=#FF0000>赠送</font>)"
	  end if%></td>
  </tr>
  <%ds.MoveNext
  wend
  ds.Close
  set ds=nothing%>
    <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan=2>总计:</td>
    <td><%=sum%></td>
  </tr>

</table>
<hr width="220" size="1" noshade> 
欢迎下次光临!
</center> 
<center class="Noprint" ><hr width="220" size=1>
</span><span style="font-size:12px ">打印日期:<%=date%></span> <br>
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

