<%
session("formid") = 6102061
Server.ScriptTimeout=999999
Dim typ
typ=request.QueryString("typ")
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if

%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%
dim t,rq1,rq2,userid,depotid,rs,i
rq1=trim(request("begdate"))
rq2=trim(request("enddate"))

if rq1="" then rq1 = get_date(date()-7)
if rq2="" then rq2 = get_date(date())
%>

<% if cint(typ)<>2 then
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>班 次 业 绩 分 析</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<link href="../css/f22.css" rel="stylesheet" type="text/css">

<SCRIPT language="JavaScript" src="../../inc/js/setday.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
  var querystring="<%=request.ServerVariables("QUERY_STRING")%> ";
  function gtDoSelect(t){
	
  }
  function gtDoDblClick(t){
  }

  function gtDoEnter(t){}
</SCRIPT>
<style>
body{margin:0}
a{ text-decoration:none; color:black}
a:hover{ text-decoration:none; color:red}
form{padding-bottom:10px;}
</style>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bar">
  <tr>
    <td align="center" style="height:25px;">班 次 业 绩 分 析</td>
  </tr>
</table>
<div style="padding:10px;width:100%;font-size:12px">
<form name="form1" method="get" action="">
<input type="hidden" name="act" id="act" value="true">
<input type="hidden" name="typ" id="typ" value="1">
<label>统计日期：</label>
  <input type="text" name="begdate" id="begdate" style="width:90px;" readonly="readonly" class="box" onFocus="setday(this);" value="<%=rq1%>">
  <input type="text" name="enddate" id="enddate" style="width:90px;" readonly="readonly" class="box" onFocus="setday(this);" value="<%=rq2%>">
<label>
  <input name="button" type="submit" class="btn" id="button" value="查 询" onClick="document.all.form1.typ.value=1;document.all.form1.submit();">
  <% if pexport then %>
  <input name="button3" type="button" class="btn" id="button3" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
  <%end if%>
</label>
</form>
<% End If %>
</div>
<%
if trim(request("begdate"))<>"" and trim(request("enddate"))<>"" then
	depotid=trim(session("dm").System_Depotid)
	set rs=server.CreateObject("adodb.recordset")
	rs.open "depotReport_forjkgroup '"&rq1&"','"&rq2&"','"&depotid&"'",cn,1,1
	set t=new Table
	t.Activeconnection = cn
	't.Commandtype=4
	't.CommandText="depotReport_forjkgroup"
	't.SetParam "@begdate",adVarChar,10,rq1
	't.SetParam "@enddate",adVarChar,10,rq2
	't.SetParam "@depotid",adVarChar,22,depotid
	
	t.SetField "suredate","日期","80",0
	for i = 2 to rs.Fields.count-1
	t.SetField i,rs.Fields(i).Name,"80",1
	Next
	t.SetField "sums","销售额","80",1
	t.ShowRs(rs)
	
	set t=nothing
end if

%>
<% if cint(typ)<>2 then%>
<script language="javascript">
	try{
		gt = new GtTable("gt1");
		gtTables.addTable(gt);
		gt.loadTable();
	}catch(ex){}
</script>
</body>
</html>
<%end if%>
