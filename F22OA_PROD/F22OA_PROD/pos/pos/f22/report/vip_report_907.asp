<%session("formid")=6102068%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<%
dim opt,stype,n,setdate,t,depotid,userid,sql,typ
typ=request("typ")
userid=trim(session("dm").System_userid)
depotid=trim(session("dm").System_depotid)
opt1=trim(request("opt1"))
opt2=trim(request("opt2"))

if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
  response.AddHeader "content-disposition", "attachment; filename=查询目前库存(含现价).xls" 
end if

if opt1="" then opt1=1
if opt2="" then opt2=1
setdate=trim(request("setdate"))
if setdate="" then setdate=date

%>
<% if cint(typ)<>2 then %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>查询目前库存(含现价)</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<link href="../css/gt.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<script type="text/javascript">
	function selectStyle(){
		showModalDialog('select1.asp','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
	}
</script>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">查询目前库存(含现价)</td>
  </tr>
</table>
<table width="100%" border="0">
<form name="form1" method="post" action="">
<input type="hidden" value="1"  name="typ" id="typ" />
  <tr>
    <td>汇总方式：
  <input type="radio" name="opt1" value="0" id="opt11" <%if opt1="0" then %>checked<%end if%> /><label for="opt11">一维</label>
  <input type="radio" name="opt1" value="1" id="opt12" <%if opt1="1" then %>checked<%end if%> /><label for="opt12">二维</label>
  <input type="checkbox" name="opt2" id="opt21" value="0" <%if opt2="0" then %>checked<%end if%> /><label for="opt21">按指定款查询</label>
	&nbsp;&nbsp;<input type="submit" class="btn" name="subm" value=" 查 询 "
   onClick="this.form.typ.value=1;this.disabled=true;this.value='请稍等...';this.form.submit()" />
  <input name="button2" type="button" class="btn" id="button2" value="选择款式"  onClick="javascript:selectStyle()">
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
dim rs,width
set rs=server.CreateObject("adodb.recordset")
rs.open "pos_query_907 '"&depotid&"','"&userid&"','"&opt2&"','"&opt1&"'",cn,1,1
set t=new Table
	For f = 0 to rs.fields.count-1
		if f>2 then
			n=1
		else
			n=4
		end if
		
		if f<4 or instr(rs(f).name,"价")>0 then
			width="80"
		else
			width="40"
		end if
		t.SetField rs(f).name,rs(f).name,width,n
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
