<%
Response.Expires = 0 
Response.Expiresabsolute = Now() - 1 
Response.AddHeader "pragma","no-cache" 
Response.AddHeader "cache-control","private" 
Response.CacheControl = "no-cache" 
%>
<%dim dname,retailid,sname,xname,suredate,suretime,add,vipcode,centum,tel,nums,sums,ssums,zsums
retailid=trim(request.querystring("id"))
'cn=session("cn")
cn=request.Cookies("cn")
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.source = "select a.s_sums,a.z_sums,a.s_name,b.d_name,convert(char(10),a.sure_date,126) as suredate,convert(char(8),a.sure_date,114) as suretime,b.address,"&_
            "b.tel,isnull(a.vipcode,'') as vipcode from d_retail a,j_depot b "&_
			"where a.retailid='"&retailid&"' and a.depotid=b.depotid "
'response.Write "<textarea>"& ds.Source&"</textarea>"
'response.end
ds.open
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

<HTML>
  <HEAD><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <title>打印小票</title>
    <style type="text/css">
        body,form {margin:0;padding:0;}
        body,td,th {font-size: 8.5pt; font-family:Verdana, Geneva, sans-serif;}
				.br{ clear:both; height:5mm; overflow:hidden}
				h2{ margin:0; font-size:11pt; padding:6mm 0; line-height:100%;}
				table{ width:100%; clear:both;}
    </style>
    <style media="print" type="text/css">
        .Noprint { DISPLAY: none; }
            INPUT {display:none}
        .PageNext { PAGE-BREAK-AFTER: always; }
    </style>
    <script type="text/javascript" defer="defer">
        function pagePrint()
        {
            try{
                eprint.InitPrint(); 
                eprint.setMarginMeasure(1); 

                eprint.paperSize = "美国标准 Fanfold"; //用户自定义 
                eprint.orientation = 1;
                
                //eprint.pageHeight = 105.00;
                eprint.pageWidth = 73.00;
                
                eprint.marginLeft = 1.00;
                eprint.marginTop = 10.00;
                eprint.marginRight= 1.00;
                eprint.marginBottom= 1.00;
 
                eprint.header="";
                eprint.footer="";

                if (eprint.defaultPrinterName.length==0)
                {
                    alert("没有设置打印机！")
                }
                else
                {
                    eprint.Print(true);     //不出打印对话框直接打印
                    //eprint.Preview();     //打印预览
                }
            }
						catch(e)
						{
                alert('打印时发生错误，请确认当前电脑上已安装了打印插件！');
								return false;
            }
            setTimeout(function(){window.close()},0);
        }
				//
				<%if request("act")="print" then%>
				function window.onload()
				{
						pagePrint()
				}
				<%end if%>
				
    </script>
</head>
<body>
  <object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext style="display:none;"></object>
  <form action="pos_print_Donoratico.asp" name="form1" method="get" target="is">
  <input type="hidden" value="<%=retailid%>" name="id"/>
  <input type="hidden" value="print" id="act" name="act"/>
<center>
<table border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td colspan=2 align=center><h2>Donoratico销售小票</h2></td></tr>
<tr>
  <td colspan="2">单号：<%=retailid%></td></tr>
<tr>
  <td>店名：<%=dname%></td>
  <td>VIP卡：<%=vipcode%></td>
</tr>
<tr>
  <td>日期：<%=suredate%></td>
  <td>时间：<%=suretime%></td></tr>
</table>
<%ds.Source =" select a.s_name,b.clothingid,b.x_price,b.discount,b.s_price,b.nums,b.nums*b.s_price as sums"& _
  			"  from j_style a,d_retailsub b where a.styleid=b.styleid and b.retailid='"&retailid&"'"
  ds.Open
%>
<%dim ds,cn,tmp,i,j,retype
nums=0
sums=0
i=0
%>
<div class="br"></div>
<table border="0" align="center" cellpadding="0" cellspacing="0" id="t">
  <tr align='center'>
    <td>货号</td>
	<td>款名</td>
    <td>数量</td>
    <td>吊牌价</td>
    <td>折扣</td>
    <td>折后价</td>
  </tr>
  <tr><td colspan=6><hr size=1></td></tr>
  <%
  while not ds.eof
  i=i+1%>
  <tr align=center>
    <td><%=ds("clothingid")%></td>
	<td><%=ds("s_name")%></td>
	<td><%=ds("nums")%></td>
	<td><%=ds("x_price")%></td>
	<td><%=ds("discount")%></td>
    <td><%=ds("sums")%></td>
  </tr>
  <%nums=nums+cdbl(ds("nums"))
	sums=sums+cdbl(ds("sums"))
  ds.MoveNext
  wend
  ds.Close%>
  <tr><td colspan=6><hr size=1></td></tr>
</table>
<table border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td>总 件 数：<%=nums%></td>
        <td>总金额：<%=sums%></td>
    </tr>
    <tr>
        <td>收款总额：<%=ssums%></td>
        <td>找回金额：<%=zsums%></td>
    </tr>
    <tr>
	    <td>收款方式：<%
        ds.source = "select retype,sums from pos_skfs where retailid='"&retailid&"' and isnull(sums,0)<>0"
        ds.open
        retype=""
        while not ds.eof
            if retype<>"" then retype=retype&", "
            retype=retype&ds("retype")
        ds.movenext
        wend
        ds.close
        set ds=nothing
        %><%=retype%></td>
        <td>营业员：<%=xname%></td>
    </tr>
</table>
<div class="br"></div>
<b>谢谢惠顾 请再光临<br />
Thank You And Please Come Again<br />
www.donoratico.net.cn</b>
</center> 
<center class="Noprint" >
<table border="0" align="center" cellpadding="0" cellspacing="0"><tr><td><hr size=1></td></tr></table>
<input  type="submit"  value="打印(P)" accesskey="p">
<!--<input  type="button"  value="直接打印"  onclick="b2();">
<input  type="button"  value="页面设置"  onclick="b3();">-->
<input  type="button"  value="关闭(C)"  onclick="window.close();" accesskey="c">
</center>
</form>

<iframe style="display:none;" name="is" src="about:blank"></iframe>
 </body>
</HTML>

