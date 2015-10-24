<%

session("formid") = 6102058

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
dim t,rq1,rq2,userid,depotid,rs,i,areaid,suredate
areaid=trim(request("areaid"))
suredate=trim(request("suredate"))

if suredate="" then
	suredate = get_date(date())
elseif datediff("m",suredate,date())<>0 then
		'suredate = get_date(date())
		'response.write "<script>alert('您只能查询当前月的数据！')</script>"
end if
%>
<% if cint(typ)<>2 then
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>今日营业汇总</title>
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
    <td align="center" style="height:25px;">今 日 营 业 汇 总 </td>
  </tr>
</table>
<div style="padding:10px;width:100%;font-size:12px">
<form name="form1" method="get" action="">
<input type="hidden" name="act" id="act" value="true">
<input type="hidden" name="typ" id="typ" value="1">
<label>区域：</label>
  <select name="areaid" id="areaid">
  <option value=""></option>
  <%
		set rs=server.CreateObject("adodb.recordset")
		rs.open "select areaid,s_name from j_area order by s_order",cn,1,1
			do while not rs.eof 
				response.write "<option  value="""&rs("areaid")&""" "
					if rs("areaid")=areaid then response.write " selected=selected "
				response.write ">"&rs("s_name")&"</option>"
			rs.movenext
			loop
		rs.close
		set rs=nothing
	%>
  </select>
<label>日期：</label>
  <input type="text" name="suredate" id="suredate" style="width:90px;" readonly="readonly" class="box" onFocus="setday(this);" value="<%=suredate%>">
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
if areaid<>"" then
	depotid=trim(session("dm").System_Depotid)
	set t=new Table
		t.Activeconnection = cn
		t.Commandtype=4
		t.CommandText="depotReport_forarea"
		t.SetParam "@suredate",adVarChar,10,suredate
		t.SetParam "@areaid",adVarChar,10,areaid

		t.SetField "depotid","编号","80",0
		t.SetField "dname","名称","140",0
		t.SetField "dsums","日销售额","80",1
		t.SetField "msums","月销售额","80",1
		t.SetField "wsums","周销售额","80",1
		t.SetField "mrate","月时间率","80",1
		t.SetField "mplan","月指标","80",1
		t.SetField "frate","月累计完成率","80",1

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

