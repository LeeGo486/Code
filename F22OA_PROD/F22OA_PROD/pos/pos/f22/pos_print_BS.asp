<%Response.cachecontrol = "no-cache"
Response.Expires=-1000%>
<HTML>
  <HEAD><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <title>打印小票</title>
  <link href="css/f22.css" rel="stylesheet" type="text/css">
  <meta http-equiv="pragma" content="no-cache" />
  <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />  
		<script language="javascript">
    //  function printTable()
	  //{
		//		window.focus();
        //window.print();
      //  window.setTimeout(function(){window.close()},1000);//关闭窗口
      //}
	  
	  function pagePrint()
        {
            try{
                eprint.InitPrint(); 
                eprint.setMarginMeasure(1); 

                eprint.paperSize = "美国标准 Fanfold"; //用户自定义 
                eprint.orientation = 1;
                
                //更改以下参数可以调整打印格式BEGIN
                //纸张高度(mm)
                eprint.pageHeight = 165.00;
                 //纸张宽度(mm)请根据百丝的小票宽度修改
                eprint.pageWidth = 100.00;
           
                
                //页边距左边
                eprint.marginLeft = 10.00;
                
                  //页边距右边
                eprint.marginRight= 10.00;
                
                 //页边距上边
                eprint.marginTop = 10.00;
                  
                
                 //页边距下边
                eprint.marginBottom= 10.00;
                //更改以下参数可以调整打印格式END
                
 
                eprint.header="";
                eprint.footer="";

                if (eprint.defaultPrinterName.length==0)
                {
                    alert("没有设置打印机！")
                }else{
                  
                  //  eprint.Print(true);     //不出打印对话框直接打印
                    eprint.Preview();     //打印预览
                }
            }catch(e){
                alert('打印时发生错误，请确认当前电脑上已安装了打印插件！')
            }
            setTimeout(function(){window.close()},0);

        }
        //自动打印
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
.ff1 {font-size:15px;font-family :"新宋体"}
.ff2 {font-size:12px;font-family :"新宋体"}
.ff3 {font-size:12px;font-family :"新宋体"}
.ff5 {font-size:12px;font-family :Times New Roman}
.style1 {font-size: small}
.style2 {font-size: small; font-family: Times New Roman; }
.style3 {font-size: small; font-family: "新宋体"; }
.style4 {
	font-family: "新宋体";
	font-weight: bold;
}
.style5 {font-family: "新宋体"}
.style6 {font-size: medium}
.style8 {font-size: 13px}
.style9 {font-size: 13px; font-family: "新宋体"; }
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
'---------------------取小票抬头
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
dname=ds("d_name") '店铺名称
sname=ds("s_name") '收银员
suredate=ds("suredate") '销售日期
suretime=ds("suretime") '销售时间
add=ds("address") '店铺地址
tel=ds("tel") '店铺电话
vipcode=ds("vipcode") 'VIP卡号
ssums=ds("s_sums") '实收
zsums=ds("z_sums") '找回
sellname=ds("sellname") '顾客姓名
sellnametel=ds("sellnametel")'顾客电话
x_name=ds("x_name")'班次
s_name=ds("s_name")'收银员
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
<table width='280' border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td height="12" colspan="3">&nbsp;</td>
</tr>
<tr>
  <td height="37" colspan="3"><div align="center" class="style6"><font class=style4><%=CompanyNM%>小票</font></div></td>
  </tr>
<tr>
  <td height="15" colspan="3"><span class="style1">单号：   <%=retailid%>    </span>    <div align="left" class="style1"></div></td></tr>
<tr><td height="15" colspan="3"><span class="style1">店铺：
      <%=dname%>    </span>  <div align="left" class="style1"></div></td></tr>
<tr>
  <td height="15" colspan="3"><span class="style1">日期：
      <%=suredate%>    </span>    <div align="left" class="style1"></div></td>
  </tr>
<tr><td height="15" colspan="3"><span class="style1">电话：
      <%=tel%>    </span>  <div align="left" class="style1"></div></td></tr>
<tr>
  <td width="131" height="15"><font class=style3>收银员：<%=s_name%></font></td>
  <td width="119" height="15"><font class=style3>班次：<%=x_name%></font></td>
  </tr>
<tr><td height="15" colspan="3"><font class=style3>营业员：<%=xname%></font></td></tr>
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
    <td width="27%" height="18"><font class="style3 t1 t1 style8">款式编码</font></td>
	<td width="19%"><p class="style8"><font class=style5>名称</font></p>	  </td>
	<td width="15%"><span class="style8">单价</span></td>
    <td width="11%"><span class="style8">折扣</span></td>
    <td width="11%"><span class="style8">数量</span></td>
    <td width="17%"><font class=style9>金额</font></td>
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
  <td width="144" height="15"><font class=style2>总数量：<%=nums%></font></td>
  <td height="15" colspan="2"><font class=style2>总金额：￥<%=sums%></font></td>
  </tr>
<tr>
  <td height="15" colspan="2"><span class="style1">实收：￥<%=ssums%></span></td>
  <td width="205" height="15"><span class="style1">找回金额：￥<%=zsums%></span></td>
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
     <td height="15" colspan="3"><font class=style2>VIP卡： <%=vipcode%></font></td>
     <td width=129>&nbsp;</td>
   </tr>
   <tr>
     <td height="15" colspan="3"><font class=style3>付款方式：</font></td>
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
    <span class="style1">     1.商品如有质量问题，请于７天内凭本小票回原购买点更换<br>
2.商品在没有穿着,修改,洗涤及不影响二次销售的情况下方可更换<br>
3.每件商品限换一次:特价商品恕不退换<br>
4.为了保障你的权益敬请保留本小票<br>
5.客服电话:020-85626860 </span></td>
</tr>
<tr>
  <td><div align="center"><font class=ff1>* * * 多 谢 惠 顾 * * *</font></div></td>
</tr>
</table>
</center> 
<center class="Noprint" ><hr width="250" size=1>
<input  type="button"  value="打印(P)" onClick="printTable('t');" accesskey="p">
<input  type="button"  value="关闭(C)"  onclick="window.close();" accesskey="c">
</center>
</form>
<script language="javascript" defer>
//var wh=300+20*<%=i%>;
//window.dialogWidth="400px";
//window.dialogHeight=wh+"px";
//printTable();//打印
//window.setTimeout(printTable,0);
</script>
 </body>
</HTML>

