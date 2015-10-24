<%option explicit
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%dim t,rq1,rq2,userid,depotid,sql,act,tmp,tmp1,tmps,cd,wdl,lkc,wldc,cid,ds
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
  <tr>
    <td><form name="form1" method="get" action="f22qry_kcsub.asp">库存查询
        <input name="rq1" type="text" id="rq1" onFocus="setday(this)" value="<%=get_date(date-30)%>" size="10" maxlength="10" style="height:20px; ">
    <input type="submit" value="重新查询" >
    <!--
	<%dim dl
	dl=trim(request.QueryString("dl"))
	if act<>3 then
	set ds=server.CreateObject("ADODB.Recordset")
ds.Activeconnection = cn
sql="select lookcode,lookname from j18_lookupsub where lookupid=2002 order by lookcode asc"
	ds.source = sql
	ds.open
	if dl="" then
	  if not ds.eof then
	    dl=trim(ds(1))
	  end if
	end if
	while not ds.eof
	%>
     <input type="radio" name="dl" value="<%=ds(1)%>" <%if dl=trim(ds(1)) then response.Write " checked" end if%>>
    <%=ds(1)%>
    <%ds.movenext
	 wend
	 ds.close
	 end if
	 %>
    <input name="act" type="hidden" id="act" value="<%=act%>"> 
    <input name="cid" type="hidden" id="cid" value="<%=cid%>">
	<%if act=1 then
	depotid=trim(request.QueryString("depotid"))
	end if
	%>
    <input name="depotid" type="hidden" id="depotid" value="<%=depotid%>"> 
    <input name="lkc" type="checkbox" id="lkc" value="1" <%if lkc=1 then response.Write " checked" end if%> > 
    不显示零库存
    </form></td>-->
  </tr>
</table>
<%
	if dl<>"" then
	  wdl=" and c.st_dl="&qts(dl)
	end if
if lkc=1 then
  wdl=wdl&" and a.k_num<>0 "
end if
set t=new Table
t.Activeconnection = cn
t.Commandtype=1

dim sums,snums
sums=1
snums=0
    'depotid=trim(request.QueryString("depotid"))
  depotid=trim(session("dm").System_depotid)

    'depotid=trim(request.QueryString("depotid"))
	ds.Source = " select isnull(sum(b.x_price * a.k_num),0) sums,isnull(sum(a.k_num),0)  from j_stock a,j_style b"& _
			" where a.styleid=b.styleid and a.depotid="&qts(depotid)

	ds.Open
	'de ds.source
	if not ds.eof then
	  snums=cint(ds(1))
	  sums=cdbl(ds(0))
	end if
	ds.close
	set ds =nothing
	
    sql="select a.clothingid,max(c.s_name) s_name,max(a.styleid) styleid,max(d.c_name) c_name,"& _
	" max(a.colorid) colorid,max(sizeid) sizeid,sum(k_num) k_num,sum(p_num) p_num,max(c.x_price) x_price,"& _
	" max(c.x_price) * sum(k_num) as kcjr  "& _
	"from j_stock a , j_style c , j_color d   "& _
	" where a.styleid=c.styleid and a.colorid=d.colorid and a.depotid="&qts(depotid)&" and isnull(k_num,0)<>0 "& _
	" group by a.clothingid"
	'de sql
	
	sql="f22qry_kc"
	t.CommandType = 4
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@userid",adVarchar,10,UserId
	t.SetField "clothingid","款号","100",0
	t.SetField "styleid","款式编号","80",1
	t.SetField "s_name","款式名称","80",1
	t.SetField "c_name","颜色","80",1

	t.SetField "k_num","库存","80",1
	't.SetField "p_num","可配库存","80",1
	t.SetField "x_price","单价","60",0
	t.SetField "kcjr","库存金额","60",1
  t.CommandText=sql

  t.height="86%"
  t.show
  set t=nothing
  set cn=nothing
'de sql
%>
</div>
<table width="300"  border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#ECD4D0">
  <tr>
    <td>
库存总数:<span class="notice"><%=snums%>
</span></td>
    <td>
库存总金额:<span class="bl"><%=sums%></span></td>
  </tr>
</table>
<script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</body>
</html>
