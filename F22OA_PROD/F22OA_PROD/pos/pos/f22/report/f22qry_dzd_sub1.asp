<%option explicit
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
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

t.SetField "merchantid","���","50",0
t.SetField "shutname","�ͻ�����","80",0
t.SetField "sums","�ڳ����","70",1
t.SetField "innums","���۽��","70",1
t.SetField "benum","Ӧ��ƾ֤","70",1
t.SetField "outnums","�˻����","70",1
t.SetField "crnum","�Ѹ�ƾ֤","70",1
t.SetField "dj","����֧��","70",1
t.SetField "endnum","��ĩ���","70",1
t.SetField "djsums","�������","70",1
t.SetField "djye","�������","70",1
t.SetField "nofreesums","������","70",1
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
