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
  .ff{font-size:12px}
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
<div style='width:58mm;text-align:left'>
<center><font class=ff>���ذ����Σ����ڣ����޹�˾��Ʒ����<br><%=depotname%></font></center>
<%ds.Source =" select a.s_name,a.cr_name,b.clothingid,b.x_price,b.discount,b.s_price,b.nums,isnull(b.larg,0) as zs,b.nums*b.s_price as sums,"& _
  			"  b.nums*b.x_price-b.nums*b.s_price as zsums from d_retail a,d_retailsub b "& _
  			 " where a.retailid=b.retailid and a.retailid='"&retailid&"'"& _
			 " order by b.s_price desc"

  'response.Write "<textarea>"& ds.Source&"</textarea>"
  ds.Open
%>
<%'ӪҵԱ
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
<font class='ff'>
���ݱ��:<%=retailid%><br>
����ʱ��:<%response.write(suredate&" "&time)%><br>
����Ա:<%=ds("cr_name")%>  ӪҵԱ:<%=xname%></font>
<hr width="220" size="1" noshade>
<%dim ds,cn,tmp,i
sum=0
%><table width='100%' border="0" align="center" cellpadding="0" cellspacing="0"  class='f12' id="t">
  <tr bgcolor='#FFEFEF' align='center'>
    <td width="20%">��Ʒ����</td>
    <td width="15%">����</td>
    <td width="15%">�ּ�</td>
    <td width="20%">�ۿ۶�</td>
    <td width="20%">�����</td>
  </tr>
  <%
  i=0
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td>&nbsp;<%=ds("clothingid")%></td>
    <td>&nbsp;<%=ds("nums")%></td>
    <td>&nbsp;<%=ds("x_price")%></td>
    <td>&nbsp;<%=ds("zsums")%></td>
    <td>
	<%sums=cdbl(ds("sums"))
	sum=sum+sums
	 if ds("zs")=false then
	   response.Write sums
	   
	  elseif ds("zs")=true then
	    response.write sums&"(<font color=#FF0000>����</font>)"
	  end if%></td>
  </tr>
  <%ds.MoveNext
  wend
  ds.Close
  set ds=nothing%>
    <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan=2>�ܼ�:</td>
    <td><%=sum%></td>
  </tr>
</table>
<hr width="220" size="1" noshade> 
<center>��ӭ�´ι���!</center>
</div></center>
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

