<%option explicit

session("formid")=6102043

Dim typ
typ=request.QueryString("typ")
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
 ' response.ContentType ="application/ms-excel"

end if
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%dim t,rq1,rq2,userid,depotid,sql,act,tmp,tmp1,tmps,cd,wdl,lkc,wldc,cid,ds,tj
dim clothingid,get_depotid,getdptname,stype,ss
clothingid=trim(request.QueryString("clothingid"))
'rq1=trim(request.QueryString("rq1"))
'rq2=trim(request.QueryString("rq2"))
depotid=trim(session("dm").System_Depotid)
userid=trim(session("dm").System_UserId)
act=trim(request.QueryString("act"))
cid=trim(request.QueryString("cid"))
lkc=trim(request.QueryString("lkc"))
get_depotid=request("get_depotid")
getdptname=request("edptname")
stype=request("stype")

if act="" then
  act=0
else
  act=cint(act)
end if
if lkc="" then
  lkc=0
else
  lkc=1
end if
%>
<%if cint(typ)<>2 then%>
<html>
<link href="css/report.css" rel="stylesheet" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/setday.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
	function selectMD(){
		var m=showModalDialog('../SelectMD.asp?action=spdx',window,
							  'dialogWidth:780px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
							  
							//  window.open('../SelectMD.asp?action=sp','','');return;
		
		var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid;
		
		try
		{
		   
		 
		 if (m!=undefined)
		 {
		     if (m=="all")
			 {
			   get_depotid="all";
		     
			 }
			 else
			 {
			   get_depotid=m;
			 }
			 
		 }
		 else  
		 get_depotid='';
		//arr=m.split(",");
		//get_depotid=arr[0];//仓库ID
		//edptname=arr[1];//仓库名
		document.form1.get_depotid.value=get_depotid;
		//document.form1.edptname.value=edptname;
		}
		catch(ex)
		{
			
		}
	}
	function selectStyle(){
		showModalDialog('select1.asp','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
	}
  var querystring="<%=request.ServerVariables("QUERY_STRING")%>";
  function gtDoSelect(t){
  }

  function gtDoDblClick(t){
  <%if act<>3 then%>
	var row = t.getSelectedRow();
	var id2=row.cells[2].outerText;
	style(id2);
	<%end if%>
  }

  function gtDoEnter(t){}
  
function style(id){
  showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}

function open2(){
showModalDialog('f22qry_otherkc2_seach.asp?styleid='+document.form1.clothingid.value+'&styleact=a&order=0',window,'dialogWidth:800px;dialogHeight:600px;center: yes;help:no;resizable:no;status:no');
}
</SCRIPT>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td><form name="form1" method="get" action="f22qry_otherkcsub.asp">
    模糊查询：
    <input name="clothingid" type="text" id="clothingid" size="12" maxlength="30" value="<%=clothingid%>" />
    <input type="checkbox" value="1" <%if stype=1 then%>checked<%end if%>
     name="stype" id="stype" /><label for="stype">按所选款式</label>
    <input name="button2" type="button" class="btn" id="button2" value="选择款式" onClick="javascript:selectStyle()" />
    <input name="button4" type="button" class="btn" id="button4" value="选择店铺" onClick="javascript:selectMD();">
    <input name="get_depotid" type="text" id="get_depotid" style="background:#efefef;"
     value="<%=get_depotid%>" size="10" maxlength="10" readonly />
    <input type="submit" value="查询" onClick="document.all.form1.typ.value=1;" />
    <input type="button" name="but" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
    <!--<input type="button" value="二维库存查询" onClick="open2()" />-->
    <input name="edptname" type="hidden" id="edptname" value="<%=getdptname%>" />  
    <input type="hidden" name="typ" value="1">
	</form></td>
  </tr>
</table>
<%end if%>
<%

if typ<>"" then
	
	'选款或模糊查询
	if stype=1 then 
		ss=" and a.styleid in (select styleid from sys_stylepower18ql where userid='"&userid&"' and selection=1 and access=1)"
	else
		if clothingid<>"" then ss=" and a.clothingid like '"&clothingid&"%' "
	end if
	
	'不允许查询仓库数据
	if session("nozckc") then
		 tj=" and d.depotid not in (select depotid from j_depot where m_type in (0,1,80,90)) "
	else
		 tj=""
	end if
	
	if get_depotid<>"" and get_depotid<>"all" then ss=ss&" and a.depotid in ("&get_depotid&") " end if
	
	dim rs
	set rs =server.CreateObject("adodb.recordset")
dim sizestr
sizestr = ""
		rs.open " select sizeid,s_name from j_size where sizeid in (select sizeid from j_stock "&_
						" where depotid='"&session("dm").System_Depotid&"' and isnull(k_num,0)<>0) order by s_order",cn
		do while not rs.eof
				if sizestr<>"" then sizestr=sizestr&", "
				sizestr=sizestr&"isnull(sum(case when ( ( a.sizeid= '"&rs("sizeid")&"')) then a.k_num end),0) as ["&rs("sizeid")&"]"
		rs.movenext
		loop
		rs.close
		
		sql=" select max(d.depotid) as [店铺号],max(d.d_name) as [店铺名],max(a.styleid) as [款式编号],"&_
		" max(b.s_name) as [款式名称],max(c.colorid) as [色号],max(c.c_name) as [颜色], "
		
		if psprice then  sql = sql&" max(b.x_price) as [单价], sum(isnull(a.k_num,0)*isnull(b.x_price,0)) as [库存总额], "
		
		sql = sql&sizestr&_
		" from j_stock a,j_style b,j_color c,webp_depot d "& _
		" where a.styleid=b.styleid and a.colorid=c.colorid and a.depotid=d.depotid "&_
		" and d.unitid="&qts(session("dm").System_unitid)& _
		" and a.depotid "&session("QryDepotTj") &" and a.k_num<>0 "&ss&_
		" and d.userid='"&session("dm").System_Userid&"' "&tj&_
		" group by a.depotid,a.styleid,a.colorid "&_
		" union all "&_
		 "select max(a.depotid) as [店铺号],max(b.d_name) as [店铺名],max(a.styleid) as [款式编号],"&_
		" max(c.s_name) as [款式名称],max(d.colorid) as [色号],max(d.c_name) as [颜色],"
		
		if psprice then  sql = sql&" max(c.x_price) as [单价], sum(isnull(a.k_num,0)*isnull(c.x_price,0)) as [库存总额], "
		
		sql = sql&sizestr&_
		" from j_stock a,j_depot b,j_style c,j_color d where a.depotid=b.depotid "&_
		" and a.styleid=c.styleid and a.colorid=d.colorid "&_
		
		" and a.depotid in (select a.depotid from j_depot a,j_merchantsub b "&_
		" where a.unitid=b.depotid and b.merchantid='"&session("dm").System_unitid&"' and b.p_kc=1) "&_
		" and a.k_num<>0 "&ss&_
		" group by a.depotid,a.styleid,a.colorid order by  [店铺号] , [款式编号]"
		'de  sql
		rs.open sql,cn,1,1
		dim n,arr,width
		'抬头
		%>
    <div id="gt1" style="width:100%;height:94%;">
    <table border="0">
    <thead>
		<%
		if psprice then
		arr = array("80","120","120","120","60","40","40","80","60")
		else
		arr = array("80","120","120","120","60","40","40")
		end if
		
		response.write "<tr>"
		for n=0 to rs.fields.count-1
		
			if n < ubound(arr) then width = arr(n) else width="30" end if
				response.write "<td  style='border:#ddd 1px solid' width="""&width&""">"&rs.fields(n).name&"</td>"
		next
		response.write "</tr>"
		%>
</thead>
 <tbody>
		<%
		'数据
		do while not rs.eof
			response.write "<tr>"
				for n=0 to rs.fields.count-1
						response.write "<td style='border:#ddd 1px solid'>"&rs.fields(n)&"</td>"
				next
			response.write "</tr>"
		rs.movenext
		loop
%>
 </tbody>
</table>
</div>
<%
	rs.close
	set rs=nothing
end if

cn.close
set cn=nothing

%>
<%if cint(typ)<>2 then%>
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