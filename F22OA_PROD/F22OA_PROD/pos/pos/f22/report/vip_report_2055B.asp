<%session("formid")=6102070%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<%
dim opt,stype,n,setdate,t,depotid,userid,sql,typ
typ=request("typ")
userid=trim(session("dm").System_userid)
depotid=trim(session("dm").System_depotid)
opt=trim(request("opt"))

if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
  response.AddHeader "content-disposition", "attachment; filename=VIP�˿�ͳ�Ʒ�����.xls" 
end if

if opt="" then opt=1
setdate=trim(request("setdate"))
if setdate="" then setdate=date
stype = array("δ����","90����","90������","180������","270������","360������","720������","����")

%>
<% if cint(typ)<>2 then %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>VIP�˿�ͳ�Ʒ�����</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<link href="../css/gt.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">VIP�˿�ͳ�Ʒ�����</td>
  </tr>
</table>
<table width="100%" border="0">
<form name="form1" method="post" action="">
<input type="hidden" value="1"  name="typ" id="typ" />
  <tr>
    <td>
    ��ѯ���ڣ�
  <input name="setdate" type="text" id="setdate" onFocus="setday(this);" onKeyPress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=get_date(setdate)%>" size="10" maxlength="10" readonly>
  &nbsp;&nbsp;���ͣ�
	<%FOR n=0 to ubound(stype)
		%>
    <input type="radio" name="opt" id="opt<%=n%>" value="<%=n%>"
     <%if cdbl(opt)=n then%>checked<%end if%> /><label for="opt<%=n%>"><%=stype(n)%></label>
    <%NEXT%>
    &nbsp;<input type="submit" class="btn" name="subm" value=" �� ѯ "
     onClick="this.form.typ.value=1;this.disabled=true;this.value='���Ե�...';this.form.submit()" />
		<%if pexport then%>
    <input name="button3" type="button" class="btn" id="button3" value="����Excel"
     onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
		<%end if%>
  </td>
  </tr>
</form>
</table>
<%end if%>
<%
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
  sql = "pos_query_2055_sub '"&depotid&"',"&opt&",'"&setdate&"'"
	t.CommandText=sql
	t.CommandType = 1
	t.SetField "VIP����","VIP����","80",3
	t.SetField "��������","��������","80",0
	t.SetField "�˿�����","�˿�����","80",4
	t.SetField "�Ա�","�Ա�","50",4
	t.SetField "��������","��������","80",4
	t.SetField "�ܻ���","�ܻ���","60",1
	t.SetField "�ܴ�ֵ","�ܴ�ֵ","60",1
	t.SetField "�����������","�����������","80",4
	t.SetField "�̶��绰","�̶��绰","80",4
	t.SetField "�ƶ��绰","�ƶ��绰","80",4
	t.SetField "�����ʼ�","�����ʼ�","80",4
	t.SetField "��ַ","��ַ","120",4
	t.height="90%"
	t.show
	set t=nothing
set cn=nothing

%>
<% if cint(typ)<>2 then %>
<script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</div>
</body>
</html>
<% End If %>
