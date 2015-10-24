<%option explicit
'菜单权限
session("formid")=6102040
Dim typ
typ=request.QueryString("typ")
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%dim t,rq1,rq2,userid,depotid,sql,act,tmp,tmp1,tmps,cd,wdl,lkc,wldc,cid
rq1=trim(request.QueryString("rq1"))
rq2=trim(request.QueryString("rq2"))
depotid=trim(session("dm").System_Depotid)
userid=trim(session("dm").System_UserId)
act=trim(request.QueryString("act"))
cid=trim(request.QueryString("cid"))
lkc=trim(request.QueryString("lkc"))
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
<%

styleid=trim(request.QueryString("styleid"))
if styleid<>"" then styleid=ucase(styleid)
dim dl,styleid
dl=trim(request.QueryString("dl"))
if instr(styleid,"'") then  response.Write "出错！不允许输入单引号！"
if act=1 then depotid=trim(request.QueryString("depotid"))

%>

<%if cint(typ)<>2 then%>
<html>
<head>
<link href="css/report.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
  var querystring="<%=request.ServerVariables("QUERY_STRING")%>";
  function gtDoSelect(t){
  }

  function gtDoDblClick(t){
  <%if act<>3 then%>
	var row = t.getSelectedRow();
	var id2=row.cells[0].outerText;
	style(id2);
	<%end if%>
  }

  function gtDoEnter(t){}
  
function style(id){
  showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}
</SCRIPT>
</head>

<body>
<table width="100%"  border="0" class="bar">
<form name="form1" method="get" action="f22qry_stylekcsub.asp">
  <tr>
    <td>库存查询
        <input name="styleid" type="text" id="styleid" value="<%=styleid%>" size="20" maxlength="20">
    <input type="submit" value="查询" onClick="document.all.form1.typ.value=1;">
    <input name="act" type="hidden" id="act" value="<%=act%>">
    <input name="depotid" type="hidden" id="depotid" value="<%=depotid%>"> 
    <input name="cid" type="hidden" id="cid" value="<%=cid%>">
    <input name="lkc" type="checkbox" id="lkc" value="1" <%if lkc=1 then response.Write " checked" end if%> > 
    不显示零库存
    </td>
	<td>
    
    <!--
指定店铺 : <input name="get_depotid" type="text" id="get_depotid" value="<%=depotid%>" size="15" maxlength="10" readonly>
<input type="button" name="Submit" value="..." onClick="selectMD('move',1);">
<input name="edptname" type="text" id="edptname" style="border:none;" value="<%=""%>" size="16" readonly>
-->
    
    <input type="hidden" name="typ" value="1">
  		<%if pexport then%>
	    <input type="button" name="but" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
      <%end if%>
	</td>
  </tr></form>
</table>
<%end if %>
<%
if request("depotid")="" then response.End()

	if dl<>"" then
	  wdl=" and c.st_dl="&qts(dl)
	end if
if lkc=1 then
  wdl=wdl&" and a.k_num<>0 "
end if
set t=new Table
t.Activeconnection = cn
t.Commandtype=1

dim sums,snums,tprice
sums=0
snums=0

dim utype
utype=session("dm").System_UserType
select case act
case 1
  'depotid=trim(request.QueryString("depotid"))
  depotid=trim(session("dm").System_depotid)
	set ds=server.CreateObject("ADODB.Recordset")
	ds.Activeconnection = cn
	ds.Source = "select isnull(sum(b.j_price * a.k_num),0) sums,isnull(sum(a.k_num),0) from j_stock a,j_style b"& _
			" where a.styleid=b.styleid and a.depotid="&qts(depotid)
	ds.Open
	
	if not ds.eof then
	  snums=ds(1)
	  sums=cdbl(ds(0))
	end if
	ds.close
  select case utype
  case 4
sql="select a.clothingid,max(c.s_name) s_name,max(a.styleid) styleid,max(d.c_name) c_name,"& _
	" max(a.colorid) colorid,max(sizeid) sizeid,sum(k_num) k_num,sum(p_num) p_num,max(c.j_price) j_price,"& _
	" max(c.j_price) * sum(k_num) as kcjr  "& _
	"from j_stock a left join j_style c on a.styleid=c.styleid left join j_color d on a.colorid=d.colorid "& _
	" where a.depotid="&qts(depotid)&wdl& _
	" and a.clothingid like '"&styleid&"%'"& _
	" group by a.clothingid"
  case else
sql="select a.clothingid,max(c.s_name) s_name,max(a.styleid) styleid,max(d.c_name) c_name,"& _
	" max(a.colorid) colorid,max(sizeid) sizeid,sum(k_num) k_num,sum(p_num) p_num,max(c.j_price) j_price,"& _
	" max(c.j_price) * sum(k_num) as kcjr  "& _
	"from j_stock a , j_style c , j_color d   "& _
	" where a.styleid=c.styleid and a.colorid=d.colorid and a.depotid="&qts(depotid)&wdl& _
	" and a.clothingid like '"&styleid&"%'"& _
	" group by a.clothingid"
	end select
	
	
	t.SetField "clothingid","款号","100",0
	t.SetField "styleid","款式编号","80",1
	t.SetField "s_name","款式名称","120",1
	t.SetField "c_name","颜色","80",1

	t.SetField "k_num","库存","80",1
	't.SetField "p_num","可配库存","80",1
	
	if psprice then
	t.SetField "j_price","单价","60",0
	t.SetField "kcjr","库存金额","60",1
	end if
  t.CommandText=sql

  t.height="86%"
  t.show
  set t=nothing
case 2
  depotid=trim(session("dm").System_depotid)
'if styleid<>"" then
	set ds=server.CreateObject("ADODB.Recordset")
	ds.Activeconnection = cn
	sql=" select isnull(sum(b.j_price * a.k_num),0) sums,isnull(sum(a.k_num),0) from j_stock a,j_style b"& _
			" where a.styleid=b.styleid and a.depotid="&qts(depotid)
	ds.Source = sql
	ds.Open
	if not ds.eof then
	  snums=ds(1)
	  sums=cdbl(ds(0))
	end if
	ds.close

sql="select a.clothingid,max(c.s_name) s_name,max(a.styleid) styleid,max(d.c_name) c_name,"& _
	" max(a.colorid) colorid,max(sizeid) sizeid,sum(k_num) k_num,sum(p_num) p_num,max(c.j_price) j_price,"& _
	" max(c.j_price) * sum(k_num) as kcjr  "& _
	" from j_stock a ,j_style c ,j_color d where "& _
	" a.styleid=c.styleid and a.colorid=d.colorid and a.depotid="&qts(depotid)&wdl& _
	" and a.clothingid like '"&styleid&"%'"& _
	" group by a.clothingid "
	
	t.SetField "clothingid","款号","100",0
	t.SetField "styleid","款式编号","80",0
	t.SetField "s_name","款式名称","120",1
	t.SetField "c_name","颜色","80",1

	t.SetField "k_num","库存","80",1
	't.SetField "p_num","可配库存","80",1
	if psprice then
	t.SetField "j_price","单价","60",0
	t.SetField "kcjr","库存金额","60",1
	end if
  t.CommandText=sql

  t.height="86%"
  t.show
  set t=nothing
'end if
end select

'de pxprice
%>
</div>
<%dim ds%>
<table width="300"  border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#ECD4D0">
  <tr>
    <td>库存总数:<span class="notice"><%=snums%></span></td>
    <%if psprice then%>
    <td>库存总金额:<span class="bl"><%=sums%></span></td>
    <%end if%>
  </tr>
</table>
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
<%
sub droptmp()
  on error resume next
    sql="drop table "&tmp
    cd.CommandType =1
    cd.CommandText = sql
    cd.Execute
    sql="drop table "&tmps
    cd.CommandText = sql
    cd.Execute
end sub
%>
