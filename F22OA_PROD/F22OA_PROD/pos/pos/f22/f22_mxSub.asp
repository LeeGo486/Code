<%
Response.Buffer = True 
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
Response.AddHeader "Pragma", "No-Cache" 
%>
<%
Dim act
act=request.QueryString("act")
if cint(act)=1 then
  response.ContentType ="application/vnd.ms-excel"
   Response.Addheader   "Content-Disposition",   "attachment;Filename="   &   date()   &   ".xls" 
 Response.Charset   =   "GB2312"   
end if

oldformid=session("formid")
newformid=trim(request("formid"))
if newformid="" or isnull(newformid) or isempty(newformid) then
   newformid=oldformid
end if
%>
<!--#include file="inc/function.asp"-->
<%Dim v, sql, str, tw 'As String
Dim i 'As Integer
Dim fc, fs' As String
Dim fds 'As New ADODB.Recordset
Dim cd 'As ADODB.Command
Dim ds 'As ADODB.Recordset

Dim id 'As String
Dim styleid 'As String
Dim userid 'As String
Dim TableName 'As String
Dim SPName 'As String
Dim PkName 'As String
Dim FkName 'As String
Dim FkValue 'As String

Dim Tid 'As String
Dim Css 'As String

%>
<%if cint(act)<>1 then%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
function gtDoSelect(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].innerHTML;
	//top.id=id;//�ڿͻ��˹��õĵ���ID
}

function gtDoDblClick(t){
	var row = t.getSelectedRow();
	//showModalDialog('move2_kuchun.asp','example04','dialogWidth:'+screen.width+'px;dialogHeight:400px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

function gtDoEnter(t){
}

</SCRIPT>
</head>

<body>
<div id="m2kc" style="width:100%;height:94%;">
<%end if%>
<%
dim o,tn,pksname,oldformid,newformid
tn=trim(request.QueryString("tn"))
pksname=trim(request.QueryString("pksname"))
if pksname<>"movenotice" then
  select case newformid
  case 2019
	tn="d_retailsub"
	pkname="retailid"
  case 2060
  	pksname = "indent"
    tn="d_indentsub"
	pkname="indentid"
  case 2061
    pksname = "indent"
    tn="d_indentsub"
	pkname="indentid"
	spname="f22_lrindentsub"
  case 2062
    pksname = "sell"
    tn="d_sellsub"
	pkname="sellid"
	spname="f22_lrsellget"
  case 2063
    pksname = "outindentpro"
    tn="d_outindentprosub"
		pkname="outindentid"
		spname="f22_lroutindentPRO"  
  case 2163
    pksname = "outindentsq"
    tn="d_outindentsqsub"
		pkname="outindentsqid"
		spname="f22_lroutindentsq"
  case 2064
    pksname = "outindentchk"
    tn="d_outindentchksub"
		pkname="outindentid"
		spname="f22_lroutindentCHK"
  case 2065,2165
    pksname = "outindentset"
    tn="d_outindentsetsub"
	pkname="outindentid"
	spname="f22_lroutindentset"
  case 2066,2166
    pksname = "inventory" 
    tn="d_inventorysub"
	pkname="inventoryid"
  case 2067,2068
    pksname = "move"
    tn="d_movesub"
	pkname="moveid"
	spname="f22_lrmovesub"
  case 2069
    pksname = "msell"
    tn="d_msellsub"
	pkname="msellid"
	spname="t18_lrmsell"
  case 2071
    pksname = "msell"
    tn="d_msellsub"
	pkname="msellid"
	spname="t18_lrmsell"
  end select
else
    pksname = "movenotice"
    tn="d_movenoticesub"
	pkname="noticeid"
	spname="t18_lrmovenotice"
end if  


TableName=lcase(tn)
FkName=pkname

Tid = "tt"
'de tn
call sopen()
set cn = nothing
%>
<%if cint(act)<>1 then%>
</div>
  <script language="javascript">
    try{
	 gt = new GtTable("m2kc");
	 gtTables.addTable(gt);
	 gt.loadTable();
	 gt.setSelectRow(1);
	}catch(ex){}//catch the ex 
</script>
</body>
</html>
<%end if%>
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
  
  sql = "Select b.sizeid From " & TableName & " a,j_size b where a." & FkName & "='" & id & "' and a.sizeid=b.sizeid Group By b.sizeid,b.s_order order by b.s_order"
  'de sql
  ds.Source = sql
  ds.Open
  
  'Response.Write "<textarea rows=60>" & sql & "</textarea>"
  'Response.End
  'sql = "Select Distinct t.boxid boxid, t.styleid styleid, t.set_nums set_nums, t.j_price j_price, t.j_price*set_nums as sj_price, " & _
  '"t.x_price x_price,t.x_price * set_nums sx_price,jst.s_name s_name, jc.colorid colorid, jc.c_name c_name,jd.d_name d_name "
  
  sql = "Select Distinct t.boxid ���, t.styleid ��ʽ���, jst.s_name ��ʽ����, jc.colorid ɫ��, jc.c_name ɫ�� "

  Select Case TableName
  Case "d_indentsub"  '��������
  
    While Not ds.EOF
      v = Trim(ds.Fields.Item("sizeid").Value)
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.nums) ����, t.s_price �����, sum(t.s_price*nums) as ������, t.x_price �ּ�,sum(t.x_price * nums) �ּ۽�� " & _
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

    sql = sql & ", sum(t.nums) ����, t.s_price �����, sum(t.s_price*nums) as ������, t.px_price �ּ�,sum(t.px_price * nums) �ּ۽�� " & _
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

    sql = sql & ", sum(t.nums) ����, t.s_price �����, sum(t.FSSums) as ������, t.x_price �ּ�,sum(t.x_price * nums) �ּ۽�� " & _
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

    sql = sql & ", sum(t.nums) ����, t.s_price �����, sum(t.s_price*nums) as ������, t.x_price �ּ�,sum(t.x_price * nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.s_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
        
  Case "d_outindentsqsub" '�˻����루�������̣�
  
    While Not ds.EOF
      v = Trim(ds.Fields.Item("sizeid").Value)
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then sq_tjnums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.sq_tjnums) ����, t.s_price �����, sum(t.s_price*sq_tjnums) as ������, t.x_price �ּ�,sum(t.x_price * sq_tjnums) �ּ۽�� " & _
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

    sql = sql & ", sum(t.d_nums) ����, t.j_price ����, sum(t.j_price*d_nums) as ���۽��, t.x_price �ּ�,sum(t.x_price * d_nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.j_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
		
   Case "d_inventorysub" '�̵�
   
		Dim NumName
		NumName = "nums"
		IF newformid=2166 THEN NumName="d_nums"
		
    While Not ds.EOF
      v = Trim(ds.Fields.Item("sizeid").Value)
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then "&NumName&" Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend
	  '�����˹���t.nums����0������
    sql=sql&",sum(t."&NumName&") as ����,t.j_price ����,sum(t.j_price*"&NumName&") as ���۽��,t.x_price �ּ�,sum(t.x_price*"&NumName&") �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc "& _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid and isnull(t."&NumName&",0)<>0" & _
        " Group By t.boxid,t.colorid,t.j_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
		
	 Case "d_movenoticesub" '֪ͨ��
   
    While Not ds.EOF
      v = Trim(ds.Fields.Item("sizeid").Value)
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.nums) ����, t.j_price1 ����, sum(t.j_price1*nums) as ���۽��, t.x_price1 �ּ�,sum(t.x_price1 * nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.j_price1,t.x_price1,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
		
 Case "d_msellsub" '��������
   
  if newformid=2069 then '�����ջ�
    While Not ds.EOF
      v = ds.Fields.Item("sizeid").Value
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then set_nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.set_nums) ����, t.s_price �����, sum(t.s_price*set_nums) as ������, t.x_price �ּ�,sum(t.x_price * set_nums) �ּ۽�� " & _
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

    sql = sql & ", sum(t.set_nums) ����, t.s_price1 �����, sum(t.s_price1*set_nums) as ������, t.x_price1 �ּ�,sum(t.x_price1 * set_nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.s_price1,t.x_price1,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
  end if
  Case "d_movesub" 'ͬ������
  	 While Not ds.EOF
      v = ds.Fields.Item("sizeid").Value
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then set_nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.set_nums) ����, t.s_price �����, sum(t.s_price*set_nums) as ������, t.x_price �ּ�,sum(t.x_price * set_nums) �ּ۽��, max(t.comment) ���ע " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.s_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
  	
  Case Else '����
  
    While Not ds.EOF
      v = ds.Fields.Item("sizeid").Value
      sql = sql & " ,SUM(Case When t.sizeid='" & v & "'  Then set_nums Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend

    sql = sql & ", sum(t.set_nums) ����, t.s_price �����, sum(t.s_price*set_nums) as ������, t.x_price �ּ�,sum(t.x_price * set_nums) �ּ۽�� " & _
        " From " & TableName & " as t, j_style jst,j_color jc" & _
        " Where t." + FkName + "='" & id & "' And t.styleid=jst.styleid And t.colorid=jc.colorid " & _
        " Group By t.boxid,t.colorid,t.s_price,t.x_price,t.styleid,jst.s_name,jc.colorid,jc.c_name " & _
        " Order By t.styleid "
        
  End Select
  
  'fds.CursorType = adOpenKeyset
  'de sql
  fds.Source = sql
  fds.Open
  
  'str = "<table><thead><tr id='n0'><td width=50>���</td><td width=100>��ʽ���</td><td width=100>��ʽ����</td><td width=50>ɫ��</td><td width=50>ɫ��</td>"
	'de sql
  str = "<table id=" & Tid & " Class=" & Css & "><thead><tr>"
  Dim x1,x2,x3,x4,list(100),fname,pwrstr
	
	pwrstr="|"	'Ȩ�޵�
	
	
  For i = 0 To fds.Fields.Count - 1
	fname = fds.Fields(i).Name	
    If Len(Hex(Asc(fname))) > 2 Then
      tw = CStr(Len(fname) * 15 + 20)
    Else
      tw = "25"
    End If
		if(fname="�ּ�" or fname="����" or fname="�ּ۽��" or fname="���۽��") and not pxprice then
			pwrstr = pwrstr&i&"|"		
		elseif (fname="�����" or fname="������") and not psprice then
			pwrstr = pwrstr&i&"|"
		else
		    if(fname="���ע") then
		        str = str & "<td width=" & tw+80 & ">" & fname & "</td>"
		    else
			    str = str & "<td width=" & tw & ">" & fname & "</td>"
			end if
		end if
  Next
  str = str & "</tr></thead> "
	'de str
  'fds.MoveFirst
  'Response.Write sql
  'Response.End
  dim fdsval
  While Not fds.EOF
   str = str & "<tr>"
   For i = 0 To fds.Fields.Count - 1
	 	if instr(pwrstr,"|"&i&"|")>0 then
		
		else
			v = fds.Fields(i).Value
     If v = "0" Then v = "&nbsp;"
     str = str & "<td>"
		 if fds.Fields(i).Name="ɫ��" and cint(act)=1 then str = str & "&nbsp;"	'���ɫ�������ֵĵ���Excelʱ�ᵱ�������ʹ���
		 str = str & v & "</td>"
		end if
	 if fds.Fields(i).Name="���" then
	    list(i)="�ϼ�"
	 elseif fds.Fields(i).Name="��ʽ���" or fds.Fields(i).Name="��ʽ����" or fds.Fields(i).Name="ɫ��" or fds.Fields(i).Name="ɫ��" or fds.Fields(i).Name="�ּ�" or fds.Fields(i).Name="�����" then
	    list(i)="0"
	 elseif  fds.Fields(i).Name="���ע"	then
	 	list(i)=""
	 else
	fdsval = fds.Fields(i).Value
	
	if fdsval="" or isnull(fdsval) then fdsval=0
 	fdsval = cdbl(fdsval)
		if fdsval<>0 then
	       list(i)=list(i)+fdsval
		'else
		'   list(i)=0
		end if
	 end if
   Next
   fds.MoveNext
   str = str & "</tr>"
  Wend
  
  str = str + "<tr>"
  For i = 0 To fds.Fields.Count -1    
    if (fds.Fields(i).Name="������" and not psprice) or (fds.Fields(i).Name="�ּ۽��" and not pxprice) then
       str = str + "<td>"&list(i+2)&"</td>"
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

End Sub
'
'if newformid<>"" then
'   session("formid")=oldformid
'end if
%>
