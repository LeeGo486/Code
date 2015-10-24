<%
Response.Expires = 0 
Response.Expiresabsolute = Now() - 1 
Response.AddHeader "pragma","no-cache" 
Response.AddHeader "cache-control","private" 
Response.CacheControl = "no-cache" 
%>
<%dim dname,retailid,sname,xname,suredate,suretime,add,vipcode,centum,tel,nums,sums,ssums,zsums,comment
retailid=trim(request.querystring("id"))
cn=session("cn")
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.source = "select a.comment,a.s_sums,a.z_sums,a.s_name,b.d_name,convert(char(10),a.sure_date,126) as suredate,convert(char(8),a.sure_date,114) as suretime,b.address,"&_
            "b.tel,isnull(a.vipcode,'') as vipcode from d_retail a,j_depot b "&_
			"where a.retailid='"&retailid&"' and a.depotid=b.depotid "
'response.Write "<textarea>"& ds.Source&"</textarea>"
'response.end
ds.open
comment=ds("comment")
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
				h2{ margin:0; font-size:11pt; padding:6mm 0; line-height:100%;}
        body td{ height:5mm; line-height:5mm;}
				table{ width:158mm; clear:both; table-layout:fixed;}
    </style>
    <style media="print" type="text/css">
        .Noprint { DISPLAY: none; }
            INPUT {display:none}
        .PageNext { PAGE-BREAK-BEFORE: always; }
    </style>
    <script type="text/javascript" defer="defer">
        function pagePrint()
        {
            try{
                eprint.InitPrint(); 
                eprint.setMarginMeasure(1); 

                eprint.paperSize = "美国标准 Fanfold"; //用户自定义 
                eprint.orientation = 1;

								eprint.pageHeight = 101.7;
                eprint.pageWidth = 170.00;
                eprint.marginLeft = 6.00;
                eprint.marginTop = 17.00;
                eprint.marginRight= 6.00;
                eprint.marginBottom= 1.00;
 
                eprint.header="";
                eprint.footer="";

                if (eprint.defaultPrinterName.length==0)
                {
                    alert("没有设置打印机！")
                }
                else
                {
                    //eprint.Print(true);     //不出打印对话框直接打印
                    eprint.Preview();     //打印预览
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
  <form action="" name="form1" method="get" target="is">
  <input type="hidden" value="<%=retailid%>" name="id"/>
  <input type="hidden" value="print" id="act" name="act"/>
<center>
<%ds.Source =" select a.s_name,b.clothingid,b.x_price,b.discount,b.s_price,b.nums,b.nums*b.s_price as sums,b.sizeid,b.colorid"& _
  			"  from j_style a,d_retailsub b where a.styleid=b.styleid and b.retailid='"&retailid&"'"
  ds.Open
%>
<%dim ds,cn,tmp,i,j,retype
nums=0
sums=0
i=0
%>
<table border="0" align="center" cellpadding="0" cellspacing="0" id="t" >
<thead >
  <tr><td>
  <table border="0" align="center" cellpadding="0" cellspacing="0" id="t" >
    <tr>
      <td style="width:59mm"><div style="padding-left:14mm;"><%=retailid%></div></td>
      <td style="width:54mm"><div style="padding-left:14mm;"><%=dname%></div></td>
      <td style="width:45mm"><div style="padding-left:10mm;"><%=suredate%></div></td>
    </tr>
    </table>
  </td>
</tr>
<tr align="center">
  <td>&nbsp;</td>
</tr>
</thead>
<tbody>
  <%
  while not ds.eof
		if i mod 8 = 0 then 
		if i>0 then response.write "</table></td></tr>"
		response.write "<tr><td style=""vertical-align:top;height:41mm; "
		if i>0 then  response.write "padding-top:10mm;height:51mm; "
		response.write """"
		if i>0 then  response.write " class=""PageNext"""
		response.write ">"
		response.write "<table border=0 align=center cellpadding=0 cellspacing=0>"
		end if
		%>
    <tr align="center">
			<td style="width:9mm"><%=i+1%></td>
			<td style="width:30mm"><%=ds("clothingid")%></td>
			<td style="width:20mm"><%=ds("s_name")%></td>
			<td style="width:24mm"><%=ds("colorid")%><%=ds("sizeid")%></td>
			<td style="width:12mm"><%=ds("x_price")%></td>
			<td style="width:9mm"><%=ds("nums")%></td>
			<td style="width:9mm"><%=cdbl(ds("discount"))*100%></td>
			<td style="width:45mm"><%=ds("sums")%></td>
    </tr>
		<%
		nums=nums+cdbl(ds("nums"))
		sums=sums+cdbl(ds("sums"))
		i=i+1
  ds.MoveNext
  wend
	response.write "</table></td></tr>"
  ds.Close
	%>
</tbody>
<tfoot>
  <tr>
    <td style="height:25mm;">
      <table border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td style="width:59mm;" align="center"></td>
            <td style="width:37mm" align="center">￥<%=sums%>元</td>
            <td style="width:9mm" align="center"></td>
            <td style="width:54mm" rowspan="5"><%=comment%></td>
          </tr>
          <tr>
              <td><div style="padding-left:10mm;"><%=Ucase(vipcode)%></div></td>
              <td>
                  <div style="padding-left:18mm;"><%
                  ds.source = "select retype,sums from pos_skfs where retailid='"&retailid&"' and isnull(sums,0)<>0"
                  ds.open
                  retype=""
											while not ds.eof
													if retype<>"" then retype=retype&","
													retype=retype&trim(ds("retype"))
											ds.movenext
											wend
											ds.close
											set ds=nothing
											response.write retype
											%></div></td>
									</tr>
									<tr>
											<td><div style="padding-left:10mm;"><%=discount%></div></td>
											<td><div style="padding-left:18mm;"><%=ssums%></div></td>
									</tr>
									<tr>
						<td></td>
						<td></td>
					</tr>
					<tr>
					<td><div style="padding-left:18mm;"><%=comment%></div></td>
						<td></td>
					</tr>
        </table>
    </td>
    </tr>
    <tr>
    <td>
      <table border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
          <td><div style="padding-left:18mm;"><%=add%></div></td>
            <td><div style="padding-left:10mm;"><%=tel%></div></td>
            <td><div style="padding-left:14mm;"><%=xname%></div></td>
          </tr>
      </table>
    </td>
  </tr>
</tfoot>
</table>
</center>

<center class="Noprint" >
<br><br>
<input  type="submit"  value="打印(P)" accesskey="p">
<!--<input  type="button"  value="直接打印"  onclick="b2();">
<input  type="button"  value="页面设置"  onclick="b3();">-->
<input  type="button"  value="关闭(C)"  onclick="window.close();" accesskey="c">
</center>
</form>

<iframe style="display:none;" name="is" src="about:blank"></iframe>
 </body>
</HTML>

