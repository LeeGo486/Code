<%
session("formid") = 6102059

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

dim t,lifedays,saledays,styleid,depotid,rs,i

lifedays=trim(request("lifedays"))
saledays=trim(request("saledays"))
styleid=trim(request("styleid"))

if lifedays="" then lifedays=14
if saledays="" then saledays=14


%>
<% if cint(typ)<>2 then
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>自动补货提示</title>
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
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	style(id);
  }

  function gtDoEnter(t){}
  
function style(id){
  showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
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
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bar">
  <tr>
    <td align="center" style="height:25px;">自 动 补 货 提 示</td>
  </tr>
</table>
<div style="padding:10px;width:100%;font-size:12px">
<form name="form1" method="get" action="">
<input type="hidden" name="act" id="act" value="true">
<input type="hidden" name="typ" id="typ" value="1">
<label>款号：</label>
  <input type="text" name="styleid" id="styleid" style="width:90px;" class="box"  value="<%=styleid%>">
<label>生命周期：</label>
  <input type="text" name="lifedays" id="lifedays" style="width:60px;" class="box" value="<%=lifedays%>" 
       onkeydown="if(event.keyCode==13)event.keyCode=9"
       onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false"
       onBlur="javascript:if(isNaN(this.value)){alert('数据类型错误！');this.focus();}this.value=Math.floor(this.value);">
<label>已售天数：</label>
  <input type="text" name="saledays" id="saledays" style="width:60px;" class="box" value="<%=saledays%>" 
       onkeydown="if(event.keyCode==13)event.keyCode=9"
       onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false"
       onBlur="javascript:if(isNaN(this.value)){alert('数据类型错误！');this.focus();}this.value=Math.floor(this.value);">
<label>
  <input name="button" type="submit" class="btn" id="button" value="查 询" onClick="document.all.form1.typ.value=1;document.all.form1.submit();">
  <% if pexport then %>
  <input name="button3" type="button" class="btn" id="button3" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
  <%end if%>
</label>
</form>
</div>
<% End If %>
<%
if styleid<>"" then
depotid=trim(session("dm").System_Depotid)
styleid = "%"&styleid&"%"
	set t=new Table
		t.Activeconnection = cn
		t.Commandtype=4
		t.CommandText="depotReport_forjstock"
		t.SetParam "@styleid",adVarChar,24,styleid
		t.SetParam "@depotid",adVarChar,20,depotid
		t.SetParam "@lifedays",adInteger,20,lifedays
		t.SetParam "@saledays",adInteger,20,saledays

		t.SetField "styleid","款号","80",0
		t.SetField "colorid","颜色","80",0
		t.SetField "sizeid","尺码","80",0
		t.SetField "bnums","可补进数","60",1
		t.SetField "xnums","销售数量","60",1
		t.SetField "rnums","日均销售","60",1
		t.SetField "knums","库存数量","60",1
		t.SetField "wnums","未配齐","60",1
		t.SetField "hnums","回转天数","60",1
	
	t.show
	set t=nothing
end if%>

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
