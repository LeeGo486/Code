<%option explicit
Dim act
act=request.QueryString("act")
if cint(act)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%if cint(act)<>2 then %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<style type="text/css">
table{
	border-collapse:collapse;
}
table th{
	font-weight:bold;
	line-height:25px;
}
table td{
	line-height:18px;
}
</style>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
  var querystring="<%=request.ServerVariables("QUERY_STRING")%> ";
  function gtDoSelect(t){
	
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
<%end if%>
<%Server.ScriptTimeout=999999
dim t,rq1,rq2,userid,depotid,dtype
rq1=trim(request.QueryString("rq1"))
rq2=trim(request.QueryString("rq2"))
if rq1<>"" and rq2<>"" then
userid=trim(session("dm").System_UserId)
depotid=trim(session("dm").System_Depotid)
dtype=request.QueryString("dtype")
'if rq1="" then rq1=date
'if rq2="" then rq2=rq1

set t=new Table
t.Activeconnection = cn
t.Commandtype=4
t.CommandText="f22qry_kcjxc"
t.SetParam "@rq1",adVarChar,10,rq1
t.SetParam "@rq2",adVarChar,10,rq2
t.SetParam "@userid",adVarChar,10,userid
t.SetParam "@depotid",adVarChar,20,depotid
t.SetParam "@dtype",adVarChar,4,dtype
'qckc,indepot,outdepot,sellset,sellget,moveset,moveget,outindentset,outindentget,retail,zt,pd,qmkc

't.SetField "depotid","���̱��","60",0
if dtype=0 then
t.SetField "styleid","��ʽ","80",0
t.SetField "s_name","��ʽ����","60",0
t.SetField "colorid","��ɫ","40",0
t.SetField "c_name","��ɫ����","60",0
t.SetField "sizeid","����","40",0
t.SetField "qckc","�ڳ����","70",1
t.SetField "sellset","����","30",1
t.SetField "sellget","�ջ�","30",1
t.SetField "outindentset","�˻�����","60",1
t.SetField "outindentget","�˻��ջ�","60",1
t.SetField "moveset","���η���","60",1
t.SetField "moveget","�����ջ�","60",1
t.SetField "retail","����","30",1
t.SetField "pd","�̲�","30",1
t.SetField "zt","��;","30",1
t.SetField "qmkc","��ĩ���","70",1
elseif dtype=1 then
t.SetField "styleid","��ʽ","80",0
t.SetField "s_name","��ʽ����","60",0
t.SetField "qckc","�ڳ����","70",1
t.SetField "sellset","����","30",1
t.SetField "sellget","�ջ�","30",1
t.SetField "outindentset","�˻�����","60",1
t.SetField "outindentget","�˻��ջ�","60",1
t.SetField "moveset","���η���","60",1
t.SetField "moveget","�����ջ�","60",1
t.SetField "retail","����","30",1
t.SetField "pd","�̲�","30",1
t.SetField "zt","��;","30",1
t.SetField "qmkc","��ĩ���","70",1
elseif dtype=2 then
t.SetField "qckc","�ڳ����","70",1
t.SetField "sellset","����","30",1
t.SetField "sellget","�ջ�","30",1
t.SetField "outindentset","�˻�����","60",1
t.SetField "outindentget","�˻��ջ�","60",1
t.SetField "moveset","���η���","60",1
t.SetField "moveget","�����ջ�","60",1
t.SetField "retail","����","30",1
t.SetField "pd","�̲�","30",1
t.SetField "zt","��;","30",1
t.SetField "qmkc","��ĩ���","70",1
end if
t.show
set t=nothing
end if%>
<%if cint(act)<>2 then %>
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