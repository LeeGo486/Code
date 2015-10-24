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

%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<% if cint(typ)<>2 then %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<link href="../css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
	function style(id){
		showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
	}
	
	function selectStyle(){
		showModalDialog('select1.asp','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
	}
/*  function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	style(id);
  }*/
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
    <td align="center" style="height:30px;">款　式　零　售　价　查　询</td>
  </tr>
</table>
<div style="padding:10px;width:98%;font-size:12px">
<form name="form1" method="get" action="">
<input type="hidden" value="1"  name="typ" id="typ" />
<label>
<input name="act" type="checkbox" value="1" <%if act="1" then response.write "checked" %>> 
模糊搜索：</label>
  <input type="text" name="key" id="key" style="width:90px;" class="box" value="<%=key%>">
  <input name="button" type="submit" class="btn" id="button" value="查 询" onClick="document.all.form1.typ.value=1;document.all.form1.submit();">
  <input name="button2" type="button" class="btn" id="button2" value="选择款式" onClick="javascript:selectStyle()">
  <input name="button3" type="button" class="btn" id="button3" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
</label>
<div style="height:10px;clear:both;"></div>
</form>
<%
if key="" and act=1 then
response.write "<span style='color:red'>请先输入需要查询的款式编号!</span>"
response.End()
end if
if request("button")="" then response.End()
%>
<% End If %>

<%
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
  depotid=trim(session("dm").System_depotid)
  userid=trim(session("dm").System_userid)
  sql = "webqry_styleprice '"&depotid&"','"&key&"','"&userid&"',"&act&""
	t.CommandType = 1
	t.SetField "styleid","款式编号","100",0
	t.SetField "s_name","款式名称","120",0
	
	't.SetField "x_price","现价","100",0
	't.SetField "discount","折扣","100",0
	
	t.SetField "s_price","结算价","100",0
	t.SetField "tj","是否调价","80",0
	t.CommandText=sql
	t.height="440px"
	t.show
	set t=nothing
'de sql
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
