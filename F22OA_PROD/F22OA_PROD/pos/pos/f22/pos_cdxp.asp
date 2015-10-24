<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>重打小票</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../inc/js/setday.js"></script>
<script language="javascript">
window.name="cdxp";
function pp(id){
showModalDialog("<%=session("xpname")%>?id="+id,window,"dialogWidth:450px;dialogHeight:450px;center: yes;help:no;resizable:no;status:no");
}
</script>
<base target="_self">
</head>

<body>
<%dim depotid,userid
depotid=trim(session("dm").System_depotid)
nowdate=request("setdate")
if nowdate="" then
   nowdate=get_date(date)
end if%>
<table width="100%" border="0" cellpadding="0">
  <form name="form1" target="cdxp" method="get" action="pos_cdxp.asp">
  <tr><td>  <input type="text" name="aaa" value="销售日期：" size="10" style="border-bottom:0px;border-left:0px;border-top:0px;border-right:0px ">
  <input name="setdate" type="text" id="setdate" size="11" maxlength="10" value="<%=nowdate%>" readonly onFocus="setday(this);">
  <input type=submit name=subm value='查 询'>
  </td></tr></form>
</table>
<table width='100%' border=1 cellspacing=0 bordercolorlight='#ACA899' bordercolordark='#FFFFFF' class='f12'>
  <tr bgcolor='#FFEFEF' align='center'>
    <td width="25%">单号</td>
	<td width="10%">类型</td>
	<td width="20%">VIP卡号</td>
    <td width="25%">销售时间</td>
    <td width="10%">数量</td>
    <td width="10%">结算金额</td>
  </tr>

<%dim ds,i,sdate
  sdate=request("setdate")
  if sdate="" then 
     sdate=get_date(date)
  else
     sdate=get_date(sdate)
  end if
  set ds=Server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
  ds.Source = "select retailid,sure_date,vipcode,"&_
    "case when isnull(dtype,0)=0 then '正常' else case when isnull(dtype,0)=1 then '礼物' else '换购' end end as dtype,"& _
    "(select sum(d_retailsub.nums) from d_retailsub where d_retail.retailid=d_retailsub.retailid) as nums,"&_
	"(select sum(d_retailsub.nums*d_retailsub.s_price) from d_retailsub where d_retail.retailid=d_retailsub.retailid) as sums "&_
  	" from d_retail where depotid="&qts(depotid)&" and isnull(sure,0)>0 and convert(char(10),sure_date,126)="&qts(sdate)
  'response.Write "<textarea>"& ds.Source&"</textarea>"
  ds.Open
  i=0
  while not ds.eof
  i=i+1%>
  <tr align="center">
    <td><a href="#" onClick="pp('<%=ds("retailid")%>')"><%=ds("retailid")%></a></td>
	<td><%=ds("dtype")%></td>
	<td>&nbsp;<%=ds("vipcode")%></td>
    <td><%=ds("sure_date")%></td>
    <td><%=ds("nums")%></td>
    <td><%=ds("sums")%></td>
  </tr>
  <%ds.movenext
  wend
  ds.close
  set ds=nothing%>
</table>
<table width="100%" border="0" class="bk">
  <tr>
    <td align="center" height="50"><input type="button" name="Submit" value=" 关 闭 (S) " onClick="window.close();"></td>
  </tr>
</table>
</body>
</html>
