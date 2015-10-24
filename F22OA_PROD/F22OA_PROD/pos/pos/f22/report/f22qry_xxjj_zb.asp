<%
'option explicit
'on error resume next
'Response.Expires=-1000

Dim typ
typ=request.QueryString("typ")
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if

%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%
dim rq1,rq2
rq1=trim(request("begdate"))
rq2=trim(request("enddate"))

if rq1="" then rq1 = get_date(date()-1)
if rq2="" then rq2 = get_date(date())

%>

<% if cint(typ)<>2 then
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../../inc/js/setday.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
	function style(id){
		showModalDialog('../clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
	}
	function selectMD(str,opt){
		var m=showModalDialog('../SelectMD.asp?action='+str,'SelectDepot','dialogWidth:780px;dialogHeight:'+(screen.height-350)+'px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
		var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid;
		if(opt==0){
		try{
		arr=m.split(",");
		get_depotid=arr[0];//仓库ID
		edptname=arr[1];//仓库名
		document.form1.set_depotid.value=get_depotid;
		document.form1.sdptname.value=edptname;
		}catch(ex){}
		}else
		 if(opt==1){
		try{
		arr=m.split(",");
		get_depotid=arr[0];//仓库ID
		edptname=arr[1];//仓库名
		document.form1.get_depotid.value=get_depotid;
		document.form1.edptname.value=edptname;
		}catch(ex){}
		}
	}
	function selectStyle(){
		showModalDialog('select1.asp','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
	}
</SCRIPT>
<style>
body{margin:0;}
a{ text-decoration:none; color:black}
a:hover{ text-decoration:none; color:red}
form{padding-bottom:10px;}
</style>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bar">
  <tr>
    <td align="center">销 售 季 节 线 路 占 比</td>
  </tr>
</table>
<div style="padding:10px;width:100%;font-size:12px">
<form name="form1" method="get" action="">
<input type="hidden" name="act" id="act" value="true">
<input type="hidden" name="typ" id="typ" value="1">
<label>日期：</label>
  <input type="text" name="begdate" id="begdate" style="width:70px;" readonly="readonly" class="box" onFocus="setday(this);" value="<%=rq1%>">
  <input type="text" name="enddate" id="enddate" style="width:70px;" readonly="readonly" class="box" onFocus="setday(this);" value="<%=rq2%>">
 <input name="button2" type="button" class="btn" id="button2" value="选择款式" onClick="javascript:selectStyle()" />
  </select>  <input name="button" type="submit" class="btn" id="button" value="查 询" onClick="document.all.form1.typ.value=1;document.all.form1.submit();" />
  <input name="button3" type="button" class="btn" id="button3" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();" />
</form>
</div>
<% End If %>
<%
  '控制查询天数
  qrydaytj=""
  if session("QryDay")>0 then
     qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
  end if
  if trim(request("begdate"))<>"" and trim(request("enddate"))<>"" then
	depotid=trim(session("dm").System_Depotid)
    userid=trim(session("dm").System_UserId)
	set rs=server.CreateObject("adodb.recordset")
	rs.open "webqry_xxjj_zb '"&rq1&"','"&rq2&"','"&depotid&"','"&userid&"','"&qrydaytj&"'",cn,1,1
	set t=new Table
	t.SetField "st_xl","货品类别","80",0
	t.SetField "sums","总零售金额","80",0
	for i = 2 to rs.Fields.count-1
	t.SetField i,rs.Fields(i).Name,"80",1
	Next
    t.height ="85%"
	t.ShowRs(rs)
	set t=nothing
	set rs=nothing
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

