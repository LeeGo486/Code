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
.colstyle
{
    width: 50px;
}
</style>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bar">
  <tr>
    <td align="center">类 别 尺 码 分 析</td>
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


<table width="100%" border="1" cellpadding="2" cellspacing="0"  bordercolor="#003333" bordercolordark="#FFFFFF" style="font-size:12px ">
	<%
  qrydaytj=""
  if session("QryDay")>0 then
     qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
  end if
  depotid=trim(session("dm").System_Depotid)
  userid=trim(session("dm").System_UserId)
  set ds=server.createobject("adodb.recordset")
  ds.open "webqry_lbsize_fx '"&rq1&"','"&rq2&"','"&depotid&"','"&userid&"','"&qrydaytj&"'",cn,1,1
  dsfc = ds.fields.count
%>
  
  <tr bgcolor="#336699">
    <td rowspan="2" style="width:100px" ><div align="center" ><font color="#FFFF00" size="2">类别</font></div></td>
    <%for i = 1 to dsfc-1 step 2 
      str = left(ds(i).name,len(ds(i).name)-1)
    %>
     <td colspan="2" ><div align="center"><font color="#FFFF00" size="2"><%=str%></font></div></td>
    <%Next%>
  </tr>
  <tr bgcolor="#336699">
  	<%
      str ="销售"  	  
  	  for i = 1 to dsfc-1
  	%>
    <td ><div align="center"><font color="#FFFF00" size="2"><%=str%></font></div></td>
    <%
      if str="销售" then
          str ="库存"
      else
          str ="销售"  	  
      end if
      next%>
  </tr>
<%
if ds.eof and ds.bof then
		%>
    <tr>
      <td colspan="<%=dsfc%>"><div align="center"><font size="2">没 有 数 据</font></div></td>
    </tr>
		<%
else
	do while not ds.eof
			%>
			<tr onMouseOver="this.bgColor='#DCF7D2'" onMouseOut="this.bgColor='#FFFFFF'"> 
			<%for i = 0 to dsfc-1%>
			 <td>
			    <%response.write ds(i)%>
			 </td>
			<%Next%>
			</tr>
			<%
	   ds.movenext
    loop
end if
ds.close
set ds=nothing
%>

</table>

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

