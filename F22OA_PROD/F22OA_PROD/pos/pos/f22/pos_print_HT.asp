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
.style1 {font-size: 12px}
.style2 {font-size: 15px}
.style3 {font-size: 14px}
-->
    </style>
  </HEAD>
 <body>
  <form>
    <style media='print'>
   .Noprint { DISPLAY: none }
   .PageNext { PAGE-BREAK-AFTER: always }
  </style>
<%dim depotname,retailid,sum,xname,suredate, bc, znums, zssums, s_sums, z_sums, comment, vipcode, tel 
retailid=trim(request.querystring("id"))
depotname=trim(session("dm").System_depotname)
cn=session("cn")
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
sum=0
ds.source = "select convert(char(10),a.sure_date,126), a.x_name as bc, a.znums, a.zssums, a.s_sums, a.z_sums, a.comment, a.vipcode, b.tel from d_retail a, j_depot b where a.depotid=b.depotid and a.retailid='"&retailid&"'"
ds.open
suredate=ds(0)
bc=ds(1)
znums=ds(2)
zssums=ds(3)
s_sums=ds(4)
z_sums=ds(5)
comment=ds(6)
vipcode=ds(7)
tel=ds(8)
ds.close
%>
<center>
<span style="font-size:16px "> </span><span style="font-size:16px "><br>
</span><br>
<table width='256' border="0" align="center" cellpadding="0" cellspacing="0"  class='f12' id="t">
  <tr bgcolor='#FFFFFF' align='center'>
    <td height="65" colspan="6"><p class="style1"><span style="font-size: 16px"><font class=ff1 style1>銷售小票</font></span>
        <%ds.Source =" select a.s_name,a.cr_name,b.clothingid, c.s_name as StyName, b.x_price,b.discount,b.s_price,b.nums,isnull(b.larg,0) as zs,b.nums*b.s_price as sums"& _
  			"  from d_retail a,d_retailsub b, j_style c"& _
  			 " where a.retailid=b.retailid and b.styleid=c.styleid and a.retailid='"&retailid&"'"& _
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

        <%'收款方式
set skfs=server.CreateObject("adodb.recordset")
skfs.ActiveConnection=cn
skfs.Source="select retype, sums from pos_skfs where retailid='"&retailid&"'"
skfs.Open
%>

        <%dim ds,cn,tmp,i
sum=0
%>
      </p>      </td>
  </tr>
  <tr bgcolor='#FFFFFF' align='center'>
    <td height="17" colspan="6"><div align="left" class="style1"><font class=ff5>單號：</font><font class='f12'><%=retailid%></font></div></td>
    </tr>
  <tr bgcolor='#FFFFFF' align='center'>
    <td height="17" colspan="6"><div align="left" class="style1"><font class=ff2>店鋪：<span style=""><%=depotname%></span></font></div></td>
  </tr>
  <tr bgcolor='#FFFFFF' align='center'>
    <td height="17" colspan="6"><div align="left" class="style1"><font class=ff5>日期：<span style=""><%=suredate%></span></font></div></td>
  </tr>
  <tr bgcolor='#FFFFFF' align='center'>
    <td height="17" colspan="6"><div align="left" class="style1"><font class=ff5>電話：<font class=ff5><span style=""><%=tel%></span></font></font></div>      
    <div align="left" class="style1"></div></td>
    </tr>
  <tr bgcolor='#FFFFFF' align='center'>
    <td height="17" colspan="3"><div align="left" class="style1"><font class=ff2>收銀員：</font><font class='f12'><%=ds("cr_name")%></font></div></td>
    <td height="17" colspan="3"><div align="left"><span class="style1"><font class=ff2>班次：<font class=ff5><span style=""><%=bc%></span></font></font></span></div></td>
    </tr>
  <tr bgcolor='#FFFFFF' align='center'>
    <td height="17" colspan="6"><div align="left" class="style1"><font class=ff2>營業員：<font class=ff2><font class='f12'><%=xname%></font></font></font></div></td>
    </tr>
  <tr bgcolor='#FFFFFF' align='center'>
    <td height="12" colspan="6"><hr size=1></td>
    </tr>
  <tr bgcolor='#FFFFFF' align='center'>
    <td height="12" colspan="2"><div align="left"><font class=ff3 style1>款式編號</font></div></td>
    <td width="11%" height="12"><div align="left"><font class=ff3 style1>單價</font></div></td>
	<td width="13%" height="12"><div align="left"><font class=ff3 style1>折扣</font></div></td>
    <td width="11%" height="12"><div align="left"><font class=ff3 style1>數量</font></div></td>
    <td width="13%" height="12"><div align="left"><font class=ff3 style1>金額</font></div></td>
  </tr>
  <%
  i=0
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td colspan="2"><div align="left"><span class="style1"><%=ds("clothingid")&"<br>"&ds("styname")%>
    </span></div></td>
    <td><div align="left"><span class="style1"><%=ds("x_price")%></span></div></td>
	<td><div align="left"><span class="style1"><%=ds("discount")%></span></div></td>
    <td><div align="left"><span class="style1"><%=ds("nums")%></span></div></td>
    <td>
	  <div align="left"><span class="style1">
	    <%sums=cdbl(ds("sums"))
	sum=sum+sums
	 if ds("zs")=false then
	   response.Write sums
	   
	  elseif ds("zs")=true then
	    response.write sums&"(<font color=#FF0000>赠送</font>)"
	  end if%>
	    </span></div></td>
  </tr>
  <%ds.MoveNext
  wend
  ds.Close
  set ds=nothing%>
    <tr>
      <td colspan="6"><hr size=1></td>
      </tr>
    <tr>
      <td height="17" colspan="3"><font class=ff5 style2 style1>總數量：<%=znums%></font></td>
      <td height="17" colspan=3><span class="style2"><font class=ff5>總金額：</font><%=sum%></span></td>
    </tr>
    <tr>
      <td height="17" colspan="3"><font class=ff5 style2 style1>實收：<%=s_sums%></font></td>
      <td height="17" colspan=3><font class=ff5 style2 style1>找回：<%=z_sums%></font></td>
    </tr>
    <tr>
      <td height="17" colspan="3"><font class=ff5 style2 style1>VIP卡：<%=vipcode%></font></td>
      <td height="17" colspan=3><span class="style2"></span></td>
    </tr>
    <tr>
      <td height="17" colspan="3"><font class=ff2 style2 style1>付款方式：</font></td>
      <td height="17" colspan=3><span class="style2"></span></td>
    </tr>
    <tr>
      <td width="2%">&nbsp;</td>
      <td colspan="4"><table width="200" border="0">
        <tr bordercolor="#ECE9D8">
		<%'收款方式表格开始  
		  while not skfs.eof
		%>
		  <tr align=center>
          <td height="15"><div align="left"><span class="style1"><%=skfs("retype")%></span></div></td>
          <td height="15"><div align="left"><span class="style1"><%=skfs("sums")%></span></div></td>			
          </tr>
		<%
  		  skfs.MoveNext
  		  wend
 		  skfs.Close
  		  set skfs=nothing		  
		%>
		
      </table></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td colspan="6"><font class="ff5 style1">備注：</font><font class=ff5 style1><span class="style1"><%=comment%></span></font></td>
    </tr>
    <tr>
    <td height="63" colspan="6"><div align="center" class="style3"><font class=ff1>* * * 多 謝 惠 顧 * * *</font> </div></td>
    </tr>
</table>
</center> 
<center class="Noprint" >
<br>
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

