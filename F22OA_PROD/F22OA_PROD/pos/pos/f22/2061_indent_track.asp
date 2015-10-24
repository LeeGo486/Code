<%
'option explicit
'on error resume next
'Response.Expires=-1000

Dim typ,act,key
typ=request("typ")
act=request("act")
key=trim(request("key"))
if act = "" then act=0 else act=1 end if
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if

ext = request("ext")
if ext="" then ext=0
	
rq1=request("begdate")
rq2=request("enddate")
%>

<!--#include file="report/inc/function.asp" -->
<!--#include file="report/inc/Class.asp" -->
<% if cint(typ)<>2 then %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../inc/js/setday.js"></SCRIPT>
<SCRIPT language="JavaScript" src="report/inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="report/inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
	function style(id){
		showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
	}
	
	function selectStyle(){
		showModalDialog('select1.asp','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
	}
	
	function gtDoDblClick(t){
		var row = t.getSelectedRow();
		var id=row.cells[0].outerText;
		showModalDialog('2061_indent_tracksub.asp?id='+id,'e','dialogWidth:700px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no');
	}
</SCRIPT>
<style>
body{margin:0}
a{ text-decoration:none; color:black}
a:hover{ text-decoration:none; color:red}
form{padding-bottom:10px;}
</style>
</head>
<body>
<%else%>
<style>
table{
	 border-collapse:collapse;
	}
</style>
<%end if%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bar">
  <tr>
    <td align="center" style="height:30px;" colspan="14">查　询　补　配　发</td>
  </tr>
</table>

<% if cint(typ)<>2 then %>
<div style="padding:10px;width:98%;font-size:12px">
<form name="form1" method="get" action="">
<label>
<input name="ext" type="radio" value="0" <%if ext=0 then response.write "checked=checked"%>>
未结案
</label>
<label>
<input name="ext" type="radio" value="1" <%if ext=1 then response.write "checked=checked"%>>
已结案
</label>
<input type="hidden" value="1"  name="typ" id="typ" />
<label>指定日期：</label>
  <input type="text" name="begdate" id="begdate" style="width:80px;" class="box" onFocus="setday(this);" value="<%=rq1%>">
  <input type="text" name="enddate" id="enddate" style="width:80px;" class="box" onFocus="setday(this);" value="<%=rq2%>">
<label for="key">货号：</label>
<input type="text" name="key" id="key" style="width:90px;" class="box" value="<%=key%>">
  <input name="button" type="submit" class="btn" id="button" value="查 询" onClick="document.all.form1.typ.value=1;document.all.form1.submit();">
  <input name="button3" type="button" class="btn" id="button3" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
</label>
<div style="height:10px;clear:both;"></div>
</form>
<%
if request("button")="" then response.End()
%>
<% End If %>
<%
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
depotid=trim(session("dm").System_depotid)
userid=trim(session("dm").System_userid)
ss=""

if rq1<>"" and rq2<>"" then ss=" and convert(char(10),a.cr_date,126) between '"&rq1&"' and '"&rq2&"' "
if key<>"" then ss=ss&" and a.indentid in (select indentid  from d_indentsub where clothingid like '%"&key&"%') "

  sql="select a.indentid,a.depotid as setdepotid,b.d_name as setdptname,a.get_depotid as getdepotid,c.d_name as getdptname," &_
      " (select sum(nums) from d_indentsub where d_indentsub.indentid=a.indentid) as nums," &_
      " (select sum(phnums) from d_indentsub where d_indentsub.indentid=a.indentid) as phnums,"&_
			" (select sum(fhnums) from d_indentsub where d_indentsub.indentid=a.indentid) as fhnums, "&_
			" a.selltype,a.getdate,a.sure,a.sure_date,a.sure_name," &_
  	  " a.comment,a.cr_name,a.chk_sure,a.chk_date,a.chk_name,a.cr_date,a.ov_sure,a.ov_date,a.backdate,a.backrate,a.indent " &_
      " from d_indent a,j_depot b,j_depot c where a.d_type=2 and a.depotid=b.depotid and a.get_depotid=c.depotid " &_
			" and isnull(ov_sure,0)="&ext&" and isnull(sure,0)=1 and a.get_depotid="&qts(session("dm").System_depotid)&ss
	t.CommandType = 1
	  t.SetField "indentid","流水号","140",3
	  t.SetField "selltype","补货类型","60",3
	  t.SetField "setdepotid","发货地","50",3
	  t.SetField "setdptname","发货地名称","80",3
	  t.SetField "nums","补货数","40",1
	  t.SetField "phnums","配货数","40",1
	  t.SetField "fhnums","发货数","40",1
	  t.SetField "sure_date","登帐日期","85",3
	  t.SetField "sure_name","登帐人","50",3
	  t.SetField "comment","备注","80",3
		t.SetField "cr_name","制单人","60",3
		t.SetField "cr_date","制单日期","85",3
	  t.SetField "ov_date","结案日期","85",3
	  t.SetField "indent","补单号","140",3
	t.CommandText=sql
	t.height="440px"
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
