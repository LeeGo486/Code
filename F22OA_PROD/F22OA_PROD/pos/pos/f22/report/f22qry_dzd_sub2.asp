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

<%if cint(act)<>2 then%>
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
	var id=row.cells[10].outerText;
	var readme=row.cells[1].outerText;
	var str="",tmpstr;
	tmpstr=id.substr(0,2);
	if(tmpstr=="PF")
	  {str="../f22_mx.asp?id="+id+"&pksname=sell&formid=2062"}
	else if(tmpstr=="TD")
	  {if(readme.substr(0,2)=="Ӧ��")
	   {str="../f22_mx.asp?id="+id+"&pksname=msell&formid=2069"}
	   else
	   {str="../f22_mx.asp?id="+id+"&pksname=msell&formid=2071"}
	   }
	else if(tmpstr=="FH")
	  {str="../f22_mx.asp?id="+id+"&pksname=outindent&formid=2065"}
	else if (tmpstr=="TF")
	  {str="../f22_mx.asp?id="+id+"&pksname=outindent&formid=2065&billtype=TF"}  
	else if (tmpstr=="TS")
	  {str="../f22_mx.asp?id="+id+"&pksname=outindent&formid=2065&billtype=TS"}	
	if(str!="")
	{showModalDialog(str,'e','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');}
  }

  function gtDoEnter(t){}
</SCRIPT>
</head>

<body>
<%end if%>
<%Server.ScriptTimeout=999999
dim t,rq1,rq2,userid,depotid
rq1=trim(request.QueryString("rq1"))
rq2=trim(request.QueryString("rq2"))
if rq1<>"" and rq2<>"" then
userid=trim(session("dm").System_UserId)

set t=new Table
t.Activeconnection = cn
t.Commandtype=4
t.CommandText="F18_get_Merchant"
t.SetParam "@MerchantId",adVarChar,8,session("dm").system_unitid
t.SetParam "@begdate",adVarChar,10,rq1
t.SetParam "@enddate",adVarChar,10,rq2

t.SetField "surdate","����","86",0
t.SetField "pricis","ժҪ","250",0
t.SetField "setmer","��������","120",0
t.SetField "setname","��������","120",0
t.SetField "getmer","�ջ�����","120",0
t.SetField "getname","�ջ�����","120",0
't.SetField "getname","�ջ���","80",0
t.SetField "nums","����","40",1
t.SetField "bedit","Ӧ�����","60",1
t.SetField "credit","�Ѹ����","60",1
t.SetField "skfsname","���ʽ","70",1
t.SetField "beditid","�ʵ���","140",1
t.SetField "comment","��ע","100",1
t.SetField "surname","������","60",1
t.show
set t=nothing
end if%>
</div>
<%if cint(act)<>2 then%>
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