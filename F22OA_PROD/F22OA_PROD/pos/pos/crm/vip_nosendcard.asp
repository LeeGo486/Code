<%option explicit
session("formid")=6101025%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script>
function jumpPage(p)
{
	document.forms[0].p.value = p;
	document.forms[0].submit();
}
</script>
</head>

<body>
<form name="form1" method="post" action="vip_nosendcard.asp">
<input type="hidden" value="1" name="p" id="p" />
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">未发VIP卡查询</td>
  </tr>
</table>


  <%
dim ds,sql,depotid,where
depotid=trim(session("dm").System_depotid)
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.LockType = 1

if session("vip_lookunit") then
	where=where&" and a.vipemitadd in (select b.depotid from j_depot a,j_depot b where a.unitid=b.unitid and a.depotid="&qts(depotid)&") "
else
	where=where&" and a.vipemitadd="&qts(depotid)
end if

sql= "select a.vipcardid,b.viptypename,a.starcentum,a.maxday,convert(char(10),a.begdate,126) as begdate,convert(char(10),a.enddate,126) as enddate "&_
     "from vip_cardvip a,vip_typevip b where a.viptypeid=b.viptypeid "&where&""&_
		 "and isnull(a.vipid,'')='' order by a.vipcardid"
ds.Open sql,cn,1,1
dim p,i,n
ds.PageSize=18
p=1

if Request("p")<>"" then
	p=cint(Request("p"))
	if p<1 then
		p=1
	end if
	if p>ds.PageCount then
		p=ds.PageCount
	end if
end if
%>
<div style="line-height:25px;padding:10px;font-size:12px;">
页数：<span style="color:red;"><%=p%></span>/<span style="color:red;"><%=ds.PageCount%></span>
    每页数量： <span style="color:red;"><%=ds.PageSize%></span>
      总数：<span style="color:red;"><%=ds.RecordCount%></span>
　　
  [<a <%if p<=1 then%>disabled="disabled"<%else%>href="javascript:jumpPage(1);"<%end if%>>首页</a>] 
  [<a <%if p<=1 then%>disabled="disabled"<%else%>href="javascript:jumpPage(<%=p-1%>);"<%end if%>>上一页</a>]
  [<a <%if p>=ds.PageCount then%>disabled="disabled"<%else%>href="javascript:jumpPage(<%=p+1%>);"<%end if%>>下一页</a>]
  [<a <%if p>=ds.PageCount then%>disabled="disabled"<%else%>href="javascript:jumpPage(<%=ds.PageCount%>);"<%end if%>>尾页</a>] 
</div>
<table width="100%"  border="0" cellpadding="3" cellspacing="1" bordercolorlight="#FFFFFF" class="f12">
  <tr align="center">
    <td>VIP卡号</td>
    <td>卡类型</td>
    <td>初始积分</td>
    <td>最大未消费失效天数</td>
    <td>生效开始日期</td>
    <td>生效结束日期</td>
  </tr>
  <%
  if not ds.Bof and not ds.Eof then
  ds.ABSolutePage=p
  end if
  for n=0 to ds.PageSize-1
  if ds.Eof then
		exit for
	end if
%>
  <tr align="center">
    <td><%  if  session("pos_vipshow")=true then response.Write("*****") else  response.Write(ds("vipcardid")) end if %></td>
    <td><%=ds("viptypename")%></td>
    <td><%=ds("starcentum")%>&nbsp;</td>
    <td><%=ds("maxday")%>&nbsp;</td>
    <td><%=ds("begdate")%>&nbsp;</td>
    <td><%=ds("enddate")%>&nbsp;</td>
  </tr>
  <%ds.movenext
  next  
  ds.close
  set ds=Nothing%>
</table>
</form>
</body>
</html>
