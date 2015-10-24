<%session("formid")=6102070%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<%
dim opt,stype,n,setdate,t,depotid,userid,sql,typ
typ=request("typ")
userid=trim(session("dm").System_userid)
depotid=trim(session("dm").System_depotid)
opt=trim(request("opt"))

if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
  response.AddHeader "content-disposition", "attachment; filename=VIP顾客统计分析表.xls" 
end if

if opt="" then opt=1
setdate=trim(request("setdate"))
if setdate="" then setdate=date
stype = array("未消费","90天内","90天以上","180天以上","270天以上","360天以上","720天以上","总数")

%>
<% if cint(typ)<>2 then %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>VIP顾客统计分析表</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<link href="../css/gt.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">VIP顾客统计分析表</td>
  </tr>
</table>
<table width="100%" border="0">
<form name="form1" method="post" action="">
<input type="hidden" value="1"  name="typ" id="typ" />
  <tr>
    <td>
    查询日期：
  <input name="setdate" type="text" id="setdate" onFocus="setday(this);" onKeyPress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=get_date(setdate)%>" size="10" maxlength="10" readonly>
  &nbsp;&nbsp;类型：
	<%FOR n=0 to ubound(stype)
		%>
    <input type="radio" name="opt" id="opt<%=n%>" value="<%=n%>"
     <%if cdbl(opt)=n then%>checked<%end if%> /><label for="opt<%=n%>"><%=stype(n)%></label>
    <%NEXT%>
    &nbsp;<input type="submit" class="btn" name="subm" value=" 查 询 "
     onClick="this.form.typ.value=1;this.disabled=true;this.value='请稍等...';this.form.submit()" />
		<%if pexport then%>
    <input name="button3" type="button" class="btn" id="button3" value="导出Excel"
     onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
		<%end if%>
  </td>
  </tr>
</form>
</table>
<%end if%>
<%
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
  sql = "pos_query_2055_sub '"&depotid&"',"&opt&",'"&setdate&"'"
	t.CommandText=sql
	t.CommandType = 1
	t.SetField "VIP卡号","VIP卡号","80",3
	t.SetField "发卡店铺","发卡店铺","80",0
	t.SetField "顾客姓名","顾客姓名","80",4
	t.SetField "性别","性别","50",4
	t.SetField "出生日期","出生日期","80",4
	t.SetField "总积分","总积分","60",1
	t.SetField "总储值","总储值","60",1
	t.SetField "最后消费日期","最后消费日期","80",4
	t.SetField "固定电话","固定电话","80",4
	t.SetField "移动电话","移动电话","80",4
	t.SetField "电子邮件","电子邮件","80",4
	t.SetField "地址","地址","120",4
	t.height="90%"
	t.show
	set t=nothing
set cn=nothing

%>
<% if cint(typ)<>2 then %>
<script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</div>
</body>
</html>
<% End If %>
