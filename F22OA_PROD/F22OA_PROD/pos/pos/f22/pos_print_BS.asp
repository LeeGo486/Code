<%Response.cachecontrol = "no-cache"
Response.Expires=-1000%>
<HTML>
  <HEAD><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <title>��ӡСƱ</title>
  <link href="css/f22.css" rel="stylesheet" type="text/css">
  <meta http-equiv="pragma" content="no-cache" />
  <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />  
		<script language="javascript">
    //  function printTable()
	  //{
		//		window.focus();
        //window.print();
      //  window.setTimeout(function(){window.close()},1000);//�رմ���
      //}
	  
	  function pagePrint()
        {
            try{
                eprint.InitPrint(); 
                eprint.setMarginMeasure(1); 

                eprint.paperSize = "������׼ Fanfold"; //�û��Զ��� 
                eprint.orientation = 1;
                
                //�������²������Ե�����ӡ��ʽBEGIN
                //ֽ�Ÿ߶�(mm)
                eprint.pageHeight = 165.00;
                 //ֽ�ſ��(mm)����ݰ�˿��СƱ����޸�
                eprint.pageWidth = 100.00;
           
                
                //ҳ�߾����
                eprint.marginLeft = 10.00;
                
                  //ҳ�߾��ұ�
                eprint.marginRight= 10.00;
                
                 //ҳ�߾��ϱ�
                eprint.marginTop = 10.00;
                  
                
                 //ҳ�߾��±�
                eprint.marginBottom= 10.00;
                //�������²������Ե�����ӡ��ʽEND
                
 
                eprint.header="";
                eprint.footer="";

                if (eprint.defaultPrinterName.length==0)
                {
                    alert("û�����ô�ӡ����")
                }else{
                  
                  //  eprint.Print(true);     //������ӡ�Ի���ֱ�Ӵ�ӡ
                    eprint.Preview();     //��ӡԤ��
                }
            }catch(e){
                alert('��ӡʱ����������ȷ�ϵ�ǰ�������Ѱ�װ�˴�ӡ�����')
            }
            setTimeout(function(){window.close()},0);

        }
        //�Զ���ӡ
        function window.onload()
        {
            pagePrint();
        }
    </script>

  <style type="text/css">
<!--
body,td,th {
	font-size: 12px;
}

.t1{font-size:12px}
.t2{font-size:15px}
.ff1 {font-size:15px;font-family :"������"}
.ff2 {font-size:12px;font-family :"������"}
.ff3 {font-size:12px;font-family :"������"}
.ff5 {font-size:12px;font-family :Times New Roman}
.style1 {font-size: small}
.style2 {font-size: small; font-family: Times New Roman; }
.style3 {font-size: small; font-family: "������"; }
.style4 {
	font-family: "������";
	font-weight: bold;
}
.style5 {font-family: "������"}
.style6 {font-size: medium}
.style8 {font-size: 13px}
.style9 {font-size: 13px; font-family: "������"; }
-->
  </style></HEAD>
 <body>
  <object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext style="display:none;"></object>
  <form>
    <style media='print'>
   .Noprint { DISPLAY: none }
   .PageNext { PAGE-BREAK-AFTER: always }
  </style>
<%dim dname,retailid,sname,xname,suredate,suretime,add,vipcode,centum,tel,nums,sums,ssums,zsums, x_name, s_name, CompanyNM
retailid=trim(request.querystring("id"))
cn=request.Cookies("cn")
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
'---------------------ȡСƱ̧ͷ
   ds.source = "select sysdefvalue from sys_system where systemid='1001'"
   ds.open
   CompanyNM=ds("sysdefvalue")
   ds.close
'-------------------------------   
ds.source = "select a.sellnametel,a.sellname,a.s_sums,a.z_sums,a.s_name,b.d_name,convert(char(10),a.sure_date,126) as suredate,convert(char(8),a.sure_date,114) as suretime,b.address,"&_
            "b.tel,isnull(a.vipcode,'') as vipcode,  a.x_name, a.s_name from d_retail a,j_depot b "&_
			"where a.retailid='"&retailid&"' and a.depotid=b.depotid "
'response.Write "<textarea>"& ds.Source&"</textarea>"
'response.end
ds.open
dname=ds("d_name") '��������
sname=ds("s_name") '����Ա
suredate=ds("suredate") '��������
suretime=ds("suretime") '����ʱ��
add=ds("address") '���̵�ַ
tel=ds("tel") '���̵绰
vipcode=ds("vipcode") 'VIP����
ssums=ds("s_sums") 'ʵ��
zsums=ds("z_sums") '�һ�
sellname=ds("sellname") '�˿�����
sellnametel=ds("sellnametel")'�˿͵绰
x_name=ds("x_name")'���
s_name=ds("s_name")'����Ա
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
<center>
<table width='280' border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td height="12" colspan="3">&nbsp;</td>
</tr>
<tr>
  <td height="37" colspan="3"><div align="center" class="style6"><font class=style4><%=CompanyNM%>СƱ</font></div></td>
  </tr>
<tr>
  <td height="15" colspan="3"><span class="style1">���ţ�   <%=retailid%>    </span>    <div align="left" class="style1"></div></td></tr>
<tr><td height="15" colspan="3"><span class="style1">���̣�
      <%=dname%>    </span>  <div align="left" class="style1"></div></td></tr>
<tr>
  <td height="15" colspan="3"><span class="style1">���ڣ�
      <%=suredate%>    </span>    <div align="left" class="style1"></div></td>
  </tr>
<tr><td height="15" colspan="3"><span class="style1">�绰��
      <%=tel%>    </span>  <div align="left" class="style1"></div></td></tr>
<tr>
  <td width="131" height="15"><font class=style3>����Ա��<%=s_name%></font></td>
  <td width="119" height="15"><font class=style3>��Σ�<%=x_name%></font></td>
  </tr>
<tr><td height="15" colspan="3"><font class=style3>ӪҵԱ��<%=xname%></font></td></tr>
</table>
<%ds.Source =" select a.s_name,b.clothingid,b.sizeid,b.x_price,b.discount,b.s_price,b.nums,b.nums*b.s_price as sums"& _
  			"  from j_style a,d_retailsub b where a.styleid=b.styleid and b.retailid='"&retailid&"'"
  ds.Open
%>
<%dim ds,cn,tmp,i,j,retype
nums=0
sums=0
i=0
%><table width='280' border="0" align="center" cellpadding="0" cellspacing="0" id="t">
  <tr><td colspan=6><hr size=1></td></tr>
  <tr align='center'>
    <td width="27%" height="18"><font class="style3 t1 t1 style8">��ʽ����</font></td>
	<td width="19%"><p class="style8"><font class=style5>����</font></p>	  </td>
	<td width="15%"><span class="style8">����</span></td>
    <td width="11%"><span class="style8">�ۿ�</span></td>
    <td width="11%"><span class="style8">����</span></td>
    <td width="17%"><font class=style9>���</font></td>
  </tr>
  <%
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td><span class="style8"><%=ds("clothingid")%></span></td>
	<td><span class="style8"><%=ds("s_name")%></span></td>
	<td><span class="style8"><%=ds("x_price")%></span></td>
	<td><span class="style8"><%=ds("discount")%></span></td>
	<td><span class="style8"><%=ds("nums")%></span></td>
    <td><span class="style8"><%=ds("sums")%></span></td>
  </tr>
  <%nums=nums+cdbl(ds("nums"))
	sums=sums+cdbl(ds("sums"))
  ds.MoveNext
  wend
  ds.Close%>
  <tr><td colspan=6><hr size=1></td></tr>
</table>
<table width='280' border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td width="144" height="15"><font class=style2>��������<%=nums%></font></td>
  <td height="15" colspan="2"><font class=style2>�ܽ���<%=sums%></font></td>
  </tr>
<tr>
  <td height="15" colspan="2"><span class="style1">ʵ�գ���<%=ssums%></span></td>
  <td width="205" height="15"><span class="style1">�һؽ���<%=zsums%></span></td>
</tr>
</table>
<table width='280' border="0" align="center" cellpadding="0" cellspacing="0">
<%ds.source = "select retype,sums from pos_skfs where retailid='"&retailid&"' and isnull(sums,0)<>0"
ds.open
j=1
while not ds.eof
   retype=ds("retype")
   if j=1 then%>
   <tr>
     <td height="15" colspan="3"><font class=style2>VIP���� <%=vipcode%></font></td>
     <td width=129>&nbsp;</td>
   </tr>
   <tr>
     <td height="15" colspan="3"><font class=style3>���ʽ��</font></td>
     <td><span class="style1">
          <%response.write(retype&" : "&ds("sums"))%>
     </span></td>
   </tr>
  <%else%>
   <tr><td height="15" colspan="3">&nbsp;</td>
     <td height="15"><span class="style1">
          <%response.write(retype&" : "&ds("sums"))%>
     </span></td>
   </tr> 
   <tr><td width="84"></tr>
   <%end if
   j=j+1
ds.movenext
wend
ds.close
set ds=nothing%>
</table>
<table width='280' border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td><hr size=1>
    <span class="style1">     1.��Ʒ�����������⣬���ڣ�����ƾ��СƱ��ԭ��������<br>
2.��Ʒ��û�д���,�޸�,ϴ�Ӽ���Ӱ��������۵�����·��ɸ���<br>
3.ÿ����Ʒ�޻�һ��:�ؼ���Ʒˡ���˻�<br>
4.Ϊ�˱������Ȩ�澴�뱣����СƱ<br>
5.�ͷ��绰:020-85626860 </span></td>
</tr>
<tr>
  <td><div align="center"><font class=ff1>* * * �� л �� �� * * *</font></div></td>
</tr>
</table>
</center> 
<center class="Noprint" ><hr width="250" size=1>
<input  type="button"  value="��ӡ(P)" onClick="printTable('t');" accesskey="p">
<input  type="button"  value="�ر�(C)"  onclick="window.close();" accesskey="c">
</center>
</form>
<script language="javascript" defer>
//var wh=300+20*<%=i%>;
//window.dialogWidth="400px";
//window.dialogHeight=wh+"px";
//printTable();//��ӡ
//window.setTimeout(printTable,0);
</script>
 </body>
</HTML>

