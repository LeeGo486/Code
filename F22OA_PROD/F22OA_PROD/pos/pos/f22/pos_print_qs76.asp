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
ds.source = "select a.retailid,b.d_name,isnull(a.vipcode,'') as vipcode,convert(char(10),a.sure_date,126) as surdate,"&_
"convert(char(8),a.sure_date,114) as surtime,a.s_name,a.comment from d_retail a,j_depot b"&_
" where a.depotid=b.depotid and a.retailid='"&retailid&"'"
'"where a.retailid='"&retailid&"' and a.depotid=b.depotid "
'response.Write "<textarea>"& ds.Source&"</textarea>"
'response.end
ds.open
dname=ds("d_name") '��������
sname=ds("s_name") '����Ա
suredate=ds("surdate") '��������
suretime=ds("surtime") '����ʱ��
'add=ds("address") '���̵�ַ
'tel=ds("tel") '���̵绰
vipcode=ds("vipcode") 'VIP����
comment=ds("comment") '���ݱ�ע
'ssums=ds("s_sums") 'ʵ��
'zsums=ds("z_sums") '�һ�
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
<table style="width:183pt" border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td align=center><b><font class="t2">����СƱ</font></b><br><br></td></tr>
<tr><td align=center><b><font class="t2"><%=dname%></font></b><br></td></tr>
<tr><td>���۵��ţ�<%=retailid%></td></tr><br>
<!--<tr><td>���̣�</td><td><%=dname%></td><td width=55>VIP���ţ�</td><td><%=vipcode%></td></tr>
<tr><td>���ڣ�</td><td><%=suredate%></td><td> ʱ�䣺</td><td><%=suretime%></td></tr>-->
</table>
<%ds.Source =" select a.clothingid,b.s_name,a.nums,a.discount,a.x_price,a.s_price,a.nums*a.s_price as sums "&_
"from d_retailsub a,j_style b"&_
             " where a.styleid=b.styleid and a.retailid='"&retailid&"'"
  ds.Open
%>
<%dim ds,cn,tmp,i,j,retype
nums=0
sums=0
i=0
%><table style="width:183pt" border="0" align="center" cellpadding="0" cellspacing="0" id="t">
  <tr><td colspan=8><hr size=1></td></tr>
  <tr align='center'>
    <td width="25%">������</td>
    <td width="15%">����</td>
    <td width="13%">����</td>
	<td width="10%">�ۿ�</td>
    <td width="16%">���ۼ�</td>
    <td width="16%">ʵ�ս��</td>
    </tr>
  <%
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td><%=ds("clothingid")%></td>
    <td><%=ds("s_name")%></td>
    <td><%=ds("nums")%></td>
	<td><%=ds("discount")%></td>
	<td><%=ds("x_price")%></td>
	<td><%=ds("sums")%></td>
  </tr>
  <%nums=nums+cdbl(ds("nums"))
	sums=sums+cdbl(ds("sums"))
  ds.MoveNext
  wend
  ds.Close%>
 <tr><td colspan=8><hr size=1></td></tr>
  <tr align=center>
    <td>&nbsp;�ܼƣ�</td>
    <td>&nbsp;&nbsp;&nbsp;</td>
    <td><%=nums%></td>
    <td></td>
    <td></td>
    <td width="5%"><%=sums%></td>
  </tr>
  <tr><td colspan=8><hr size=1></td></tr>
  <!--
  <tr><td colspan=6><hr size=1></td></tr>
  <tr height="30">
  <td colspan="5" align="right"><font class="t2">�ܼƣ�</font></td>
  <td colspan="5" align="right"><font class="t2">�ܼƣ�</font></td>
  <td><font class="t2"><%=sums%></font></td>
  </tr>-->
</table>
<table style="width:183pt" border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td width='60'>VIP:<%=vipcode%></td><td colspan="2">����:<%=xname%></td>
</tr>
<tr><td>����:<%=sname%></td></tr><br>
<tr><td colspan="2">ʱ��:<%=suredate%></td>
</tr>
</table>
<table style="width:198pt" border="0" align="center" cellpadding="0" cellspacing="0">  
<tr><td colspan="5">��&nbsp;&nbsp;ע:<%=comment%></td></tr>
<tr><td>1.������Ʒ�����ʾ���ﵥ�ݣ��ؼۻ�Ʒ</td></tr>
<tr><td> &nbsp;&nbsp;ˡ���˻�).</td></tr>
<tr><td>2.��Ӱ��������۵������,��ƾ������7</td></tr>
<tr><td> &nbsp;&nbsp;���ڸ�����Ʒ.</td></tr>
<tr><td>3.�˿��밴��ǩ֮ϴ�ӷ�����ϴ�·�.</td></tr>
<!--<tr><td>����Ա��</td><td><%=xname%></td><td>��&nbsp;����</td><td><%=tel%></td></tr>
<tr height="30"><td colspan="4" align="center">***��л�ݹ�***</td></tr>-->
</table>
<center class="Noprint" ><hr style="width:183pt" size=1>
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

