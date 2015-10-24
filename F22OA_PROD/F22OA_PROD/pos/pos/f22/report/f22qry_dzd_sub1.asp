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
  }

  function gtDoEnter(t){}
</SCRIPT>
</head>

<body>
<%Server.ScriptTimeout=999999
dim t,rq1,rq2,userid,depotid
rq1=trim(request.QueryString("rq1"))
rq2=trim(request.QueryString("rq2"))
if rq1<>"" and rq2<>"" then
userid=trim(session("dm").System_UserId)

set t=new Table
t.Activeconnection = cn
t.Commandtype=4
t.CommandText="F22_FUN_Merchant"
t.SetParam "@begdate",adVarChar,12,rq1
t.SetParam "@enddate",adVarChar,12,rq2
t.SetParam "@userid",adVarChar,8,userid
'qckc,indepot,outdepot,sellset,sellget,moveset,moveget,outindentset,outindentget,retail,zt,pd,qmkc

t.SetField "merchantid","编号","50",0
t.SetField "shutname","客户名称","80",0
t.SetField "sums","期初余额","70",1
t.SetField "innums","销售金额","70",1
t.SetField "benum","应付凭证","70",1
t.SetField "outnums","退货金额","70",1
t.SetField "crnum","已付凭证","70",1
t.SetField "dj","订金支付","70",1
t.SetField "endnum","期末余额","70",1
t.SetField "djsums","订货金额","70",1
t.SetField "djye","订金余额","70",1
t.SetField "nofreesums","冻结金额","70",1
t.show
set t=nothing
end if%>
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
