<%option explicit
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%dim t,rq1,userid,id
rq1=trim(request.QueryString("rq1"))
id=trim(request.QueryString("id"))
userid=trim(session("dm").System_UserId)
%>
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
	style();
  }

  function gtDoEnter(t){}
  
function style(){
  var id="<%=id%>";
  showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}
</SCRIPT>
</head>

<body>
<%dim sql
if rq1="" then rq1=date
set t=new Table
t.Activeconnection = cn
t.Commandtype=1

	sql="select max(b.depotid) as depotid,max(d_name) as dptname,isnull(sum(k_num),0) as k_num,isnull(sum(p_num),0) as p_num"& _
	" from j_stock a right join webp_depot b on  a.depotid=b.depotid and a.clothingid="&qts(id)& _
	" where userid="&qts(userid)&" group by b.depotid"
	'de sql
t.CommandText=sql
t.SetField "depotid","店铺编号","80",0
t.SetField "dptname","店铺名称","150",0
't.SetField "clothingid","款号","100",0
t.SetField "k_num","库存","80",1
't.SetField "sellset","sellset","60",1
't.SetField "setget","setget","60",1
't.SetField "indepot","indepot","60",1
't.SetField "outdepot","outdepot","60",1
't.SetField "moveset","moveset","60",1
't.SetField "moveget","moveget","60",1
't.SetField "zt","在途","60",0
't.SetField "pd","pd","20",0
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
