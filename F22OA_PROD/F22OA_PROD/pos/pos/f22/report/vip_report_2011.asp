<%
'session("formid")=6102069
%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<%
dim opt,stype,n,setdate,t,depotid,userid,sql,typ
typ=request("typ")
userid=trim(session("dm").System_userid)
depotid=trim(session("dm").System_depotid)

if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if

setdate=trim(request("setdate"))
if setdate="" then setdate=date

%>
<% if cint(typ)<>2 then %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>VIP数量统计分析表</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<link href="../css/gt.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">VIP数量统计分析表</td>
  </tr>
</table>
<table width="100%" border="0">
<form name="form1" method="post" action="../../vip/?">
<input type="hidden" value="1"  name="typ" id="typ" />
  <tr>
    <td>
    查询日期：
  <input name="setdate" type="text" id="setdate" onFocus="setday(this);" onKeyPress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=get_date(setdate)%>" size="10" maxlength="10" readonly>
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
dim rs
set rs=server.CreateObject("adodb.recordset")
rs.open "pos_query_2055 '"&setdate&"','"&depotid&"'",cn,1,1
set t=new Table
	For f = 0 to rs.fields.count-1
		t.SetField rs(f).name,rs(f).name,"80",3
	Next
	t.height="90%"
	t.ShowRs(rs)
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
