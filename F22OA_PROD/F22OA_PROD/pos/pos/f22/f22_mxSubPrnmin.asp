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
<title>����Ԥ��</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
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
	TitleName="����������"
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
	TitleName="����������"
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

 
  sql = "Select styleid as ��ʽ,colorid as ��ɫ,sizeid as ����,sum("&zdnum&") as ���� From  "&tn&" where "&FkName&"='"&id&"' Group By styleid,colorid,sizeid"
  'de sql
  ds.Source = sql
  ds.Open
  
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
		if session("formid")=2163 then
		surename="�����ˣ�"&rs(zdsurename)
		suredate="�������ڣ�"&rs("suredate")
		else
		surename="�����ˣ�"&rs(zdsurename)
		suredate="�������ڣ�"&rs("suredate")
		end if
	 znums="��������"&rs("znums")
	 zsums="�ܽ�"&rs("zsums")
	 comment="��ע��"&rs("comment")
  else
  if tn="d_msellsub" then
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
	 surename="�����ˣ�"&rs(zdsurename)
	 suredate="�������ڣ�"&rs("suredate")
	 znums="��������"&rs("znums")
	 zsums="�ܽ�"&rs("zsums")
	 selltype="���ͣ�"&rs("selltype")
	 comment="��ע��"&rs("comment")
  end if
  rs.close
  set rs=nothing
  
  str="<table width=100% border=0 cellspacing=0 bordercolor=0 bordercolordark=0 style='font-size:12px'>"&_
      "<tr height=40><td align=center colspan=3><font size=3>"&titlename&"</font></td></tr>"&_
	  "<tr><td colspan=2>��ˮ�ţ�"&id&"</td></tr>"&_
	  "<tr><td colspan=2>"&selltype&"</td></tr>"&_
	  "<tr><td colspan=2>"&setdname&"</td></tr>"&_
	  "<tr><td colspan=2>"&getdname&"</td></tr>"&_
	  "<tr><td>"&znums&"</td><td>"&zsums&"</td></tr>"&_
	  "<tr><td colspan=2>"&comment&"</td></tr></table>"
  response.write str
  
  str = "<table width=100% border=1 cellspacing=0 bordercolor='#999999' bordercolordark='#FFFFFF' style='font-size:12px'><thead><tr>"
  For i = 0 To ds.Fields.Count - 1
    If Len(Hex(Asc(ds.Fields(i).Name))) > 2 Then
      tw = CStr(Len(ds.Fields(i).Name) * 15 + 20)
    Else
      tw = "25"
    End If
    str = str & "<td width=" & tw & ">" & ds.Fields(i).Name & "</td>"
    'fds.MoveNext
  Next
  str = str & "</tr></thead> "
  'fds.MoveFirst
  'Response.Write sql
  'Response.End
  
  While Not ds.EOF
   str = str & "<tr>"
   For i = o To ds.Fields.Count - 1
     v = ds.Fields(i).Value
     If v = "0" Then v = "&nbsp;"
     str = str & "<td>" & v & "</td>"
   Next
   ds.MoveNext
   str = str & "</tr>"
  Wend
  
  str = str & "</table>"
  
  Response.Write str

  str="<table width=100% border=0 cellspacing=0 bordercolor=0 bordercolordark=0 style='font-size:12px'>"&_
	  "<tr height=40><td>"&surename&"</td></tr>"&_
	  "<tr><td>"&suredate&"</td></tr>"&_
	  "<tr height=60><td>ǩ���ˣ�_______________</td></tr>"&_
	  "<tr height=40><td>ǩ�����ڣ�_______________</td></tr>"&_
	  "</table>"
  response.write str
End Sub

if newformid<>"" then
   session("formid")=oldformid
end if%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="noprint">
  <tr> 
    <td> <div align="center"> 
        <input type="button" name="Submit" value="�رմ˴���" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onClick="javascript:window.close();">
      </div></td>
    <td><div align="center"> 
        <input type="button" name="print" value="��ӡ�˵�" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onClick="javascript:print()">
      </div></td>
  </tr>
</table>
