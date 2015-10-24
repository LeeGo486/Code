<%option explicit%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>VIP消费明细</title>
<base target="_self">
<link href="css/f22.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
dim ds,sql,depotid,id,nums,sums,znums,zsums
depotid=trim(session("dm").System_depotid)
id=trim(request.QueryString("id"))
set ds=server.CreateObject("ADODB.Recordset")

%>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">VIP消费明细</td>
  </tr>
</table>
<div style="padding:10px 0 ; font-size:12px;color:#ddd;">
<%
dim minyear,y,ys,vipid,vipcode
ys=trim(request.QueryString("ys"))
if ys="" then ys= year(now())

ds.open "select vipid from vip_cardvip where vipid="&qts(id)&" or vipcardid="&qts(id)&"",cn,1,1
if ds.eof and ds.bof then
response.Write("<span style='color:red'>传入参数错误或VIP卡不存在！！</span>")
response.End()
else
id = ds(0)
end if
ds.close

sql = "select min(CONVERT(char(4),sure_date,126)) as sure_date from d_retail "&_
	  " where vipcode in (select vipcardid from vip_cardvip where vipid="&qts(id)&") and isnull(sure,0)>0"
ds.open sql,cn,1,1
	if ds.eof and ds.bof then
	minyear = year(now())
	else 
	minyear = ds("sure_date")
	if isnull(minyear) or minyear="" then minyear = year(now())
	end if
ds.close

for y = minyear to year(now())
	if cdbl(ys)=cdbl(y) then
		response.write "<a href='?id="&id&"&ys="&y&"'><strong>"&y&"年</strong></a>&nbsp;&nbsp;"
	else
		response.write "<a href='?id="&id&"&ys="&y&"'>"&y&"年</a>&nbsp;&nbsp;"
	end if
Next

%>
</div>
<table width="100%"  border="1" cellspacing="0" bordercolor="#ECD4D0" class="f12" bordercolorlight="#FFFFFF">
  <tr align="center">
    <td>店铺名称</td>
    <td>购买时间</td>
    <td>款式编号</td>
    <td>款式名称</td>
    <td>颜 色</td>
    <td>尺 码</td>
    <td>结算价</td>
    <td>折 扣</td>
    <td>数 量</td>
    <td>金 额</td>
    <td>优惠<br>金额</td>
    <td>积分<br>抵扣</td>
  	<td>积分</td>
    <td>实收<br>金额</td>
    <td>类型</td>
  </tr>
  <%
sql= "select CONVERT(char(10),a.sure_date,126) as sure_date,a.depotid,c.d_name,a.cx_price,a.dk_price,b.styleid,d.s_name,b.colorid,e.c_name,"&_
"b.sizeid,b.discount,b.s_price,isnull(b.nums,0) as nums,isnull((b.s_price*b.nums),0) as sums,b.comment,"&_
 "(isnull((select sum(nums*s_price) from d_retailsub where d_retailsub.retailid=a.retailid),0) - isnull(cx_price,0) - isnull(dk_price,0)) as ss_price,"&_
"case when isnull(a.dtype,0)=0 then '&nbsp;' else case when isnull(a.dtype,0)=1 then '礼物' else '换购' end end as dtype,vipcentum "&_
" from d_retail a,d_retailsub b,j_depot c,j_style d,j_color e where a.retailid=b.retailid and isnull(a.sure,0)>0 "& _
		 " and b.styleid=d.styleid and b.colorid=e.colorid and a.depotid=c.depotid "&_
		 " and a.vipcode in (select vipcardid from vip_cardvip where vipid="&qts(id)&")" &_
		 " and year(a.sure_date)="&qts(ys)&" order by a.sure_date desc "
ds.Open sql,cn,1,1
do while not ds.eof

nums = ds("nums")
sums = ds("sums")
response.write "<tr>"
	response.write "<td>"&ds("d_name")&"</td>"
	response.write "<td>"&ds("sure_date")&"</td>"
	response.write "<td>"&ds("styleid")&"</td>"
	response.write "<td>"&ds("s_name")&"</td>"
	response.write "<td>"&ds("colorid")&ds("c_name")&"</td>"
	response.write "<td>"&ds("sizeid")&"</td>"
	response.write "<td>"&ds("s_price")&"</td>"
	response.write "<td>"&FormatNumber(ds("discount"),,-1)&"</td>"
	response.write "<td>"&nums&"</td>"
	response.write "<td>"&sums&"</td>"
	response.write "<td>"&ds("cx_price")&"&nbsp;</td>"
	response.write "<td>"&ds("dk_price")&"&nbsp;</td>"
	response.write "<td>"&ds("vipcentum")&"</td>"
	response.write "<td>"&ds("ss_price")&"</td>"
	response.write "<td>"&ds("dtype")&"</td>"	
response.write "</tr>"
  znums=znums+cdbl(nums)
  zsums=zsums+cdbl(sums)
  
  ds.movenext
  loop
  ds.close
  set ds=Nothing%>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><%=znums%></td>
    <td><%=zsums%></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
   <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
