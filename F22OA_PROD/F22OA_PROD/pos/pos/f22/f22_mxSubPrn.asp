<%option explicit
Response.Expires=-1000
oldformid=session("formid")
newformid=request("formid")
if newformid<>"" then
   session("formid")=newformid
end if%>
<!--#include file="inc/function.asp"-->
<%Dim v, sql, str, tw 'As String
Dim i 'As Integer
Dim fc, fs' As String
Dim fds 'As New ADODB.Recordset
Dim cd 'As ADODB.Command
Dim ds,rs 'As ADODB.Recordset

Dim id 'As String
Dim styleid 'As String
Dim userid 'As String
Dim TableName 'As String
Dim SPName 'As String
Dim PkName 'As String
Dim FkName 'As String
Dim FkValue 'As String
Dim TitleName,company 'As String

Dim Tid 'As String
Dim Css 'As String

Dim setdname,getdname,znums,zsums,suredate,surename,selltype,comment
Dim setdptid,getdptid,zdnum,zdsuredate,zdsurename,zdcomment

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=session("formid")%>����Ԥ��</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script   language="javascript">   
  function   tableToExcel()   {     
  window.clipboardData.setData("Text",document.all('theObjTable').outerHTML);   
  try   
  {   
  var   ExApp   =   new   ActiveXObject("Excel.Application")   
  var   ExWBk   =   ExApp.workbooks.add()   
  var   ExWSh   =   ExWBk.worksheets(1)   
  ExApp.DisplayAlerts   =   false   
  ExApp.visible   =   true   
  }       
  catch(e)   
  {   
  alert("���ĵ���û�а�װMicrosoft   Excel�����")   
  return   false   
  }     
    ExWBk.worksheets(1).Paste;   
    }   
  </script>
</head>
<style media="print">
.noprint { display: none }
</style>
<body>
<div id="m2kc" style="width:100%;height:94%;">
<%
dim o,tn,pksname,oldformid,newformid
tn=trim(request.QueryString("tn"))
pksname=trim(request.QueryString("pksname"))
if pksname<>"movenotice" then
  select case session("formid")
  case 2019
	pksname="retail"
	tn="d_retailsub"
	pkname="retailid"
	TitleName="���۵�"
	zdnum="nums"
	zdsuredate="sure_date"
	zdsurename="sure_name"
	setdptid="depotid"
	getdptid=""
	zdcomment="comment"
  case 2060
  	pksname = "indent"
    tn="d_indentsub"
	pkname="indentid"
	TitleName="������"
	zdnum="nums"
	zdsuredate="sure_date"
	zdsurename="sure_name"
	setdptid="depotid"
	getdptid="get_depotid"
	zdcomment="comment"
  case 2061
    pksname = "indent"
    tn="d_indentsub"
	pkname="indentid"
	spname="f22_lrindentsub"
	TitleName="������"
	zdnum="nums"
	zdsuredate="sure_date"
	zdsurename="sure_name"
	setdptid="depotid"
	getdptid="get_depotid"
	zdcomment="comment"
  case 2062
    pksname = "sell"
    tn="d_sellsub"
	pkname="sellid"
	spname="f22_lrsellget"
	TitleName="������"
	zdnum="set_nums"
	zdsuredate="setsure_date"
	zdsurename="setsure_name"
	setdptid="set_depotid"
	getdptid="get_depotid"
	zdcomment="set_comment"
  case 2063
    pksname = "outindentpro"
    tn="d_outindentprosub"
	pkname="outindentid"
	spname="f22_lroutindentPRO" 
	TitleName="�˻����뵥"
	zdnum="nums"
	zdsuredate="sure_date"
	zdsurename="sure_name"
	setdptid="set_depotid"
	getdptid="depotid"
	zdcomment="comment"
  case 2163
    pksname = "outindentsq"
    tn="d_outindentsqsub"
	pkname="outindentsqid"
	spname="f22_lroutindentsq" 
	TitleName="�˻����뵥"
	zdnum="sq_tjnums"
	zdsuredate="sq_tjdate"
	zdsurename="sq_tjname"
	setdptid="set_depotid"
	getdptid="depotid"
	zdcomment="sq_tjcomment"
  case 2064
    pksname = "outindentchk"
    tn="d_outindentchksub"
	pkname="outindentid"
	spname="f22_lroutindentCHK"
	TitleName="�˻�������"
	zdnum="nums"
	zdsuredate="sure_date"
	zdsurename="sure_name"
	setdptid="set_depotid"
	getdptid="depotid"
	zdcomment="comment"
  case 2065
    pksname = "outindentset"
    tn="d_outindentsetsub"
	pkname="outindentid"
	spname="f22_lroutindentset"
	TitleName="�˻�������"
	zdnum="nums"
	zdsuredate="sure_date"
	zdsurename="sure_name"
	setdptid="set_depotid"
	getdptid="depotid"
	zdcomment="comment"
  case 2066
    pksname = "inventory" 
    tn="d_inventorysub"
	pkname="inventoryid"
	TitleName="�̵㵥"
	zdnum="nums"
	zdsuredate="sure_date"
	zdsurename="sure_name"
	setdptid="depotid"
	getdptid=""
	zdcomment="comment"
  case 2067,2068
    pksname = "move"
    tn="d_movesub"
	pkname="moveid"
	spname="f22_lrmovesub"
	TitleName="������"
	zdnum="set_nums"
	zdsuredate="setsure_date"
	zdsurename="setsure_name"
	setdptid="set_depotid"
	getdptid="get_depotid"
	zdcomment="set_comment"
  case 2069
    pksname = "msell"
    tn="d_msellsub"
	pkname="msellid"
	spname="t18_lrmsell"
	TitleName="���������ջ���"
	zdnum="set_nums"
	zdsuredate="setsure_date"
	zdsurename="setsure_name"
	setdptid="set_depotid"
	getdptid="get_depotid"
	zdcomment="set_comment"
  case 2071
    pksname = "msell"
    tn="d_msellsub"
	pkname="msellid"
	spname="t18_lrmsell"
	TitleName="��������������"
	zdnum="set_nums"
	zdsuredate="setsure_date"
	zdsurename="setsure_name"
	setdptid="set_depotid"
	getdptid="get_depotid"
	zdcomment="set_comment"
  end select
else
    pksname = "movenotice"
    tn="d_movenoticesub"
	pkname="noticeid"
	spname="t18_lrmovenotice"
	TitleName="����֪ͨ��"
	zdnum="nums"
	zdsuredate="sure_date"
	zdsurename="sure_name"
	setdptid="set_depotid"
	getdptid="get_depotid"
	zdcomment="comment"
end if  


TableName=lcase(tn)
FkName=pkname

Tid = "tt"
'de tn
call sopen()
%></div>
</body>
</html>
<%

Public Sub sopen()
  id = Trim(Request.QueryString("id"))
  FkValue = id
  CreateAdo
  show
  CloseAdo
End Sub

Public Sub CreateAdo()
  Set cn = server.CreateObject("ADODB.Connection")
  cn.ConnectionString = Session("cn")
  cn.Open
  Set cd = server.CreateObject("ADODB.Command")
  cd.ActiveConnection = cn
  Set ds = server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
End Sub

Public Sub CloseAdo()
  ds.Close
  cn.Close
  Set ds = Nothing
  Set cd = Nothing
  Set cn = Nothing
End Sub


Public Sub show()

id = Trim(Request.QueryString("id"))
  FkValue = id

  Set fds = server.CreateObject("ADODB.Recordset")
  fds.ActiveConnection = cn
  fds.ActiveConnection = cn
  
  sql = "Select Distinct sizeid From " & TableName & " where " & FkName & "='" & id & "' Group By sizeid"
  'de sql
  ds.Source = sql
  ds.Open
  
  sql = "Select Distinct t.boxid ���, t.styleid ��ʽ���, jst.s_name ��ʽ����, jc.colorid ɫ��, jc.c_name ɫ�� "

  Select Case TableName
  Case "d_indentsub"  '��������
  
    While Not ds.EOF
      v = Trim(ds.Fields.Item("sizeid").Value)
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.nums) ����, isnull(t.s_price,0) �����, sum(isnull(t.s_price,0)*nums) as ������, isnull(t.x_price,0) �ּ�,sum(isnull(t.x_price,0) * nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.s_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
        
  Case "d_quotasub" '�������
  
    While Not ds.EOF
      v = Trim(ds.Fields.Item("sizeid").Value)
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.nums) ����, isnull(t.s_price,0) �����, sum(isnull(t.s_price,0)*nums) as ������, isnull(t.px_price,0) �ּ�,sum(isnull(t.px_price,0) * nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
    " Group By t.boxid,t.colorid,t.s_price,t.px_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
    " Order By t.styleid "
    
  Case "d_retailsub"
  
    While Not ds.EOF
      v = Trim(ds.Fields.Item("sizeid").Value)
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.nums) ����, isnull(t.s_price,0) �����, sum(isnull(t.s_price,0)*nums) as ������, isnull(t.x_price,0) �ּ�,sum(isnull(t.x_price,0) * nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.s_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "

  Case "d_outindentprosub", "d_outindentchksub", "d_outindentsetsub","d_outindentsub"
  
    While Not ds.EOF
      v = Trim(ds.Fields.Item("sizeid").Value)
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.nums) ����, isnull(t.s_price,0) �����, sum(isnull(t.s_price,0)*nums) as ������, isnull(t.x_price,0) �ּ�,sum(isnull(t.x_price,0) * nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.s_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
  Case "d_outindentsqsub"
  
    While Not ds.EOF
      v = Trim(ds.Fields.Item("sizeid").Value)
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then sq_tjnums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.sq_tjnums) ����, isnull(t.s_price,0) �����, sum(isnull(t.s_price,0)*sq_tjnums) as ������, isnull(t.x_price,0) �ּ�,sum(isnull(t.x_price,0) * sq_tjnums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.s_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
        
  Case "d_inventorycysub" '�̵����
  
    While Not ds.EOF
      v = Trim(ds.Fields.Item("sizeid").Value)
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then d_nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.d_nums) ����, isnull(t.j_price,0) ����, sum(isnull(t.j_price,0)*d_nums) as ���۽��, isnull(t.x_price,0) �ּ�,sum(isnull(t.x_price,0) * d_nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.j_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
		
   Case "d_inventorysub" '�̵�
   
    While Not ds.EOF
      v = Trim(ds.Fields.Item("sizeid").Value)
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.nums) ����, isnull(t.j_price,0) ����, sum(isnull(t.j_price,0)*nums) as ���۽��, isnull(t.x_price,0) �ּ�,sum(isnull(t.x_price,0) * nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.j_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
		
 Case "d_movenoticesub" '֪ͨ��
   
    While Not ds.EOF
      v = Trim(ds.Fields.Item("sizeid").Value)
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.nums) ����, isnull(t.j_price,0) ����, sum(isnull(t.j_price,0)*nums) as ���۽��, isnull(t.x_price,0) �ּ�,sum(isnull(t.x_price,0) * nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.j_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
		
  Case "d_msellsub" '��������
   if session("formid")=2069 then
    While Not ds.EOF
      v = ds.Fields.Item("sizeid").Value
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then set_nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.set_nums) ����, isnull(t.s_price,0) �����, sum(isnull(t.s_price,0)*set_nums) as ������, isnull(t.x_price,0) �ּ�,sum(isnull(t.x_price,0) * set_nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.s_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
   else
    While Not ds.EOF
      v = ds.Fields.Item("sizeid").Value
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then set_nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.set_nums) ����, isnull(t.s_price1,0) �����, sum(isnull(t.s_price1,0)*set_nums) as ������, isnull(t.x_price1,0) �ּ�,sum(isnull(t.x_price1,0) * set_nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.s_price1,t.x_price1,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
   end if
		
  Case Else '����
  
    While Not ds.EOF
      v = ds.Fields.Item("sizeid").Value
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then set_nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.set_nums) ����, isnull(t.s_price,0) �����, sum(isnull(t.s_price,0)*set_nums) as ������, isnull(t.x_price,0) �ּ�,sum(isnull(t.x_price,0) * set_nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.s_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
        
  End Select
  
  'de sql
  fds.Source = sql
  fds.Open
  
  set rs=server.createobject("adodb.recordset")
  rs.open "select sysdefvalue from sys_system where systemid=1001",cn
  company=rs("sysdefvalue")
  rs.close
  if session("formid")=2019 or session("formid")=2066 then
     sql="select a."&setdptid&",b.d_name,convert(char(10),a."&zdsuredate&",126) as suredate,a."&zdsurename&","&_
	     "(select sum(d."&zdnum&") from "&tn&" d where d."&pkname&"=a."&pkname&") as znums,"&_
		 "(select sum(d."&zdnum&"*d.s_price) from "&tn&" d where d."&pkname&"=a."&pkname&") as zsums,a."&zdcomment&" as comment "&_
		 "from d_"&pksname&" a,j_depot b where a."&setdptid&"=b.depotid and a."&pkname&"='"&id&"'"
	 rs.open sql,cn
	 setdname="�������ƣ�"&rs("d_name")
	 surename="�����ˣ�"&rs(zdsurename)
	 suredate="�������ڣ�"&rs("suredate")
	 znums="��������"&rs("znums")
	 zsums="�ܽ�"&rs("zsums")
	 comment="��ע��"&rs("comment")
  else
   if TableName="d_msellsub" then
     if session("formid")=2069 then
	 sql="select a."&setdptid&",b.d_name as setdname,a."&getdptid&",c.d_name as getdname,convert(char(10),a."&zdsuredate&",126) as suredate,a."&zdsurename&","&_
	     "(select sum(d."&zdnum&") from "&tn&" d where d."&pkname&"=a."&pkname&") as znums,"&_
		 "(select sum(d."&zdnum&"*d.s_price) from "&tn&" d where d."&pkname&"=a."&pkname&") as zsums,a.selltype,a."&zdcomment&" as comment  "&_
		 "from d_"&pksname&" a,j_depot b,j_depot c where a."&setdptid&"=b.depotid and a."&getdptid&"=c.depotid and a."&pkname&"='"&id&"'"
     else
     sql="select a."&setdptid&",b.d_name as setdname,a."&getdptid&",c.d_name as getdname,convert(char(10),a."&zdsuredate&",126) as suredate,a."&zdsurename&","&_
	     "(select sum(d."&zdnum&") from "&tn&" d where d."&pkname&"=a."&pkname&") as znums,"&_
		 "(select sum(d."&zdnum&"*d.s_price1) from "&tn&" d where d."&pkname&"=a."&pkname&") as zsums,a.selltype,a."&zdcomment&" as comment  "&_
		 "from d_"&pksname&" a,j_depot b,j_depot c where a."&setdptid&"=b.depotid and a."&getdptid&"=c.depotid and a."&pkname&"='"&id&"'"
		 end if
   else
     sql="select a."&setdptid&",b.d_name as setdname,a."&getdptid&",c.d_name as getdname,convert(char(10),a."&zdsuredate&",126) as suredate,a."&zdsurename&","&_
	     "(select sum(d."&zdnum&") from "&tn&" d where d."&pkname&"=a."&pkname&") as znums,"&_
		 "(select sum(d."&zdnum&"*d.s_price) from "&tn&" d where d."&pkname&"=a."&pkname&") as zsums,a.selltype,a."&zdcomment&" as comment  "&_
		 "from d_"&pksname&" a,j_depot b,j_depot c where a."&setdptid&"=b.depotid and a."&getdptid&"=c.depotid and a."&pkname&"='"&id&"'" 
   end if 
	 
	 rs.open sql,cn
	 setdname="�����ֵ꣺"&rs("setdname")
	 getdname="�ջ��ֵ꣺"&rs("getdname")
		if session("formid")=2163 then
		surename="�����ˣ�"&rs(zdsurename)
		suredate="�������ڣ�"&rs("suredate")
		else
		surename="�����ˣ�"&rs(zdsurename)
		suredate="�������ڣ�"&rs("suredate")
		end if
	 znums="��������"&rs("znums")
	 zsums="�ܽ�"&rs("zsums")
	 selltype="���ͣ�"&rs("selltype")
	 comment="��ע��"&rs("comment")
  end if
  rs.close
  set rs=nothing
  
  str="<table width=100% border=0 cellspacing=0 bordercolor=0 bordercolordark=0 style='font-size:12px'>"&_
      "<tr height=50><td align=center colspan=3><font size=3>"&company&"-"&titlename&"</font></td></tr>"&_
	  "<tr><td>��ˮ�ţ�"&id&"</td><td>"&setdname&"</td><td>"&znums&"</td></tr>"&_
	  "<tr><td>"&selltype&"</td><td>"&getdname&"</td><td>"&zsums&"</td></tr>"&_
	  "<tr><td colspan=3>"&comment&"</td></tr></table>"
  response.write str
  
  str = "<table id='theObjTable' width=100% border=1 cellspacing=0 bordercolor='#999999' bordercolordark='#FFFFFF' style='font-size:12px'><thead><tr>"
  Dim x1,x2,x3,x4,list(100)
  For i = 1 To fds.Fields.Count - 3
    If Len(Hex(Asc(fds.Fields(i).Name))) > 2 Then
      tw = CStr(Len(fds.Fields(i).Name) * 15 + 20)
    Else
      tw = "25"
    End If
    str = str & "<td width=" & tw & ">" & fds.Fields(i).Name & "</td>"
	if fds.Fields(i).Name = "�ּ�" or fds.Fields(i).Name = "����" then
	   x1=i
	end if
	if fds.Fields(i).Name = "�ּ۽��" or fds.Fields(i).Name = "���۽��" then
	   x2=i
	end if
	if fds.Fields(i).Name = "�����" then
	   x3=i
	end if
	if fds.Fields(i).Name = "������" then
	   x4=i
	end if
    'fds.MoveNext
  Next
  str = str & "</tr></thead> "
  'fds.MoveFirst
  'Response.Write sql
  'Response.End
  
  While Not fds.EOF
   str = str & "<tr>"
   For i = 1 To fds.Fields.Count - 3
     '����Ȩ��
     if (x1=i and not pxprice) or (x2=i and not pxprice) or (x3=i and not psprice) or (x4=i and not psprice) then
	    v="0"
	 else
	    v = fds.Fields(i).Value
	 end if
     If v = "0" Then v = "&nbsp;"
     str = str & "<td>" & v & "</td>"
	 
	 if fds.Fields(i).Name="���" or fds.Fields(i).Name="��ʽ���" then
	    list(i)="�ϼ�"
	 elseif fds.Fields(i).Name="��ʽ����" or fds.Fields(i).Name="ɫ��" or fds.Fields(i).Name="ɫ��" or fds.Fields(i).Name="�ּ�" or fds.Fields(i).Name="�����" then
	    list(i)="0"
	 else
		if cdbl(fds.Fields(i).Value)<>0 then
	       list(i)=list(i)+cdbl(fds.Fields(i).Value)
		'else
		'   list(i)="0"
		end if
	 end if
   Next
   fds.MoveNext
   str = str & "</tr>"
  Wend
  
  str = str + "<tr>"
  For i = 1 To fds.Fields.Count -3
    if (fds.Fields(i).Name="�ּ۽��" and not pxprice) or (fds.Fields(i).Name="������" and not psprice) then
       str = str + "<td>&nbsp;</td>"
	else
	  if list(i)="0" then
         str = str + "<td>&nbsp;</td>"
	  else
	     str = str + "<td>"&list(i)&"</td>"
	  end if
	end if
  Next
  str = str + "</tr>"
  
  str = str & "</table>"
  
  Response.Write str
  
  fds.Close
  Set fds = Nothing

  str="<table width=100% border=0 cellspacing=0 bordercolor=0 bordercolordark=0 style='font-size:12px'>"&_
	  "<tr height=60><td width=25% >"&surename&"</td><td width=25% >"&suredate&"</td>"&_
	  "<td width=25% >ǩ���ˣ�_______________</td><td width=25% >ǩ�����ڣ�_______________</td></tr>"&_
	  "</table>"
  response.write str
End Sub

if newformid<>"" then
   session("formid")=oldformid
end if%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="noprint">
  <tr> 
    <td><div align="center"> 
        <input type="button" name="Submit" value="�رմ˴���" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onClick="javascript:window.close();">
      </div></td>
	<!--<td><div align="center"> 
        <input type="button" name="Submit1" value="����Excel" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onclick="javascript:tableToExcel();">
      </div></td>-->
    <td><div align="center"> 
        <input type="button" name="print" value="��ӡ�˵�" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onClick="javascript:print()">
      </div></td>
  </tr>
</table>
