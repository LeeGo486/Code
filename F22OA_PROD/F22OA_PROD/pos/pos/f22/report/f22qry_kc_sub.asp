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
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	window.parent.iss.location.href="f22qry_kc_subsub.asp?id="+id;
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
</head>

<body>
<%dim t,rq1,userid,sql
rq1=trim(request.QueryString("rq1"))
userid=trim(session("dm").System_UserId)
'if rq1="" then rq1=date
set t=new Table
t.Activeconnection = cn
t.Commandtype=1

sql="select a.clothingid,sum(k_num) k_num,sum(p_num) p_num"& _
	" from j_stock a right join webp_depot b on  a.depotid=b.depotid "& _
	" where b.userid="&qts(userid)&" group by a.clothingid"
	
select case session("dm").System_userType
case 1,2,3
sql=" select a.clothingid,max(c.s_name) s_name,max(a.styleid) styleid,max(d.c_name) c_name,"& _
	" max(a.colorid) colorid,max(sizeid) sizeid,sum(k_num) k_num,sum(p_num) p_num,max(c.x_price) x_price, "& _
	" max(c.x_price) * sum(k_num) as kcjr  "& _
	" from j_stock a right join webp_depot b on  a.depotid=b.depotid  "& _
	" join j_style c on a.styleid=c.styleid left join j_color d on a.colorid=d.colorid "& _
	" where userid="&qts(userid)&" group by a.clothingid"
case 4
sql="select a.clothingid,max(c.s_name) s_name,max(a.styleid) styleid,max(d.c_name) c_name,"& _
	" max(a.colorid) colorid,max(sizeid) sizeid,sum(k_num) k_num,sum(p_num) p_num,max(c.x_price) x_price,"& _
	" max(c.x_price) * sum(k_num) as kcjr  "& _
	"from j_stock a right join webp_depot b on  a.depotid=b.depotid  "& _
	"join j_style c on a.styleid=c.styleid left join j_color d on a.colorid=d.colorid "& _
	" where b.userid="&qts(userid)&" group by a.clothingid"
end select
'de sql
t.CommandText=sql
't.SetField "depotid","店铺编号","80",0
t.SetField "clothingid","款号","100",0
t.SetField "styleid","款式编号","80",1
t.SetField "s_name","款式名称","80",1
t.SetField "c_name","颜色","80",1

t.SetField "k_num","库存","80",1
't.SetField "p_num","可配库存","80",1
t.SetField "x_price","单价","60",0
t.SetField "kcjr","库存金额","60",1
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
