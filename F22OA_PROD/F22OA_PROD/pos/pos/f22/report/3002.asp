<%option explicit
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
  var querystring="<%=request.ServerVariables("QUERY_STRING")%> ";
  function gtDoSelect(t){
  }

  function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[1].outerText;
	window.parent.iss.location.href="f22qry_kc_subsub.asp?id="+id;
  }

  function gtDoEnter(t){}
  

</SCRIPT>
</head>

<body>
<%dim t,rq1,rq2,userid,depotid,sql,act
rq1=trim(request.QueryString("rq1"))
rq2=trim(request.QueryString("rq2"))
depotid=trim(session("dm").System_Depotid)
userid=trim(session("dm").System_UserId)
act=trim(request.QueryString("act"))
if act="" then
  act=0
else
  act=cint(act)
end if
if rq1="" then rq1=get_date(date())
if rq2="" then rq2=rq1
select case act
case 3002
 sql=" select max(a.depotid) depotid,a.clothingid,max(a.styleid) styleid,max(a.stname) stname,"& _
 	 " max(a.colorid) colorid,max(c.c_name) c_name,max(a.sizeid) sizeid,isnull(sum(a.nums),0) nums"& _
	 "  from vd_retailsub a ,j_color c "& _
	 " where a.depotid="&qts(session("dm").system_depotid)&" and setdate between "&qts(rq1)&" and "&qts(rq2)&" and "& _
	 " a.colorid=c.colorid  group by a.clothingid"
case 3003
 sql=" select max(a.depotid) depotid,max(a.clothingid) clothingid,max(a.styleid) styleid,max(a.stname) stname,"& _
 	 " max(a.colorid) colorid,max(c.c_name) c_name,max(a.sizeid) sizeid,isnull(sum(a.nums),0) nums,"& _
	 " max(a.s_name) s_name"& _
	 "  from vd_retailsub a ,j_color c "& _
	 " where a.depotid="&qts(session("dm").system_depotid)&" and setdate between "&qts(rq1)&" and "&qts(rq2)&" and "& _
	 " a.colorid=c.colorid  group by a.s_name "
end select

set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
t.SetField "depotid","店铺编号","80",0
t.SetField "clothingid","货号","100",0
t.SetField "styleid","款式编号","100",0
t.SetField "stname","款式名称","100",0
t.SetField "c_name","颜色名称","80",0
t.SetField "nums","数量","80",1
t.show
set t=nothing
%>
</div>
  <script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>

</body>
</html>
