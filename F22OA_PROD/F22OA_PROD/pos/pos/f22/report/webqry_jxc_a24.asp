<%
'option explicit
'on error resume next
'Response.Expires=-1000

Dim typ
typ=request.QueryString("typ")
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if

%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%
dim rq1,rq2,dtype
rq1=trim(request("begdate"))
rq2=trim(request("enddate"))
dtype=request.QueryString("dtype")

if rq1="" then rq1 = get_date(date()-1)
if rq2="" then rq2 = get_date(date())
if dtype="" then dtype=1
%>

<% if cint(typ)<>2 then
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../../inc/js/setday.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
	function style(id){
		showModalDialog('../clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
	}
	function selectMD(str,opt){
		var m=showModalDialog('../SelectMD.asp?action='+str,'SelectDepot','dialogWidth:780px;dialogHeight:'+(screen.height-350)+'px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
		var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid;
		if(opt==0){
		try{
		arr=m.split(",");
		get_depotid=arr[0];//�ֿ�ID
		edptname=arr[1];//�ֿ���
		document.form1.set_depotid.value=get_depotid;
		document.form1.sdptname.value=edptname;
		}catch(ex){}
		}else
		 if(opt==1){
		try{
		arr=m.split(",");
		get_depotid=arr[0];//�ֿ�ID
		edptname=arr[1];//�ֿ���
		document.form1.get_depotid.value=get_depotid;
		document.form1.edptname.value=edptname;
		}catch(ex){}
		}
	}
	function selectStyle(){
		showModalDialog('select1.asp','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
	}
</SCRIPT>
<style>
body{margin:0;}
a{ text-decoration:none; color:black}
a:hover{ text-decoration:none; color:red}
form{padding-bottom:10px;}
</style>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bar">
  <tr>
    <td align="center">���̽�����</td>
  </tr>
</table>
<div style="padding:10px;width:100%;font-size:12px">
<form name="form1" method="get" action="">
<input type="hidden" name="act" id="act" value="true">
<input type="hidden" name="typ" id="typ" value="1">
<label>���ڣ�</label>
  <input type="text" name="begdate" id="begdate" style="width:70px;" readonly="readonly" class="box" onFocus="setday(this);" value="<%=rq1%>">
  <input type="text" name="enddate" id="enddate" style="width:70px;" readonly="readonly" class="box" onFocus="setday(this);" value="<%=rq2%>">
<label>���ܷ�ʽ��</label>
  <select name="dtype" size="1"><option value="1">�����</option><option value="2">�����</option></select>
  <input name="button2" type="button" class="btn" id="button2" value="ѡ���ʽ" onClick="javascript:selectStyle()" />
  <input name="button" type="submit" class="btn" id="button" value="�� ѯ" onClick="document.all.form1.typ.value=1;document.all.form1.submit();" />
  <input name="button3" type="button" class="btn" id="button3" value="����Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();" />
</form>
</div>
<% End If %>
<%
   if rq1<>"" and rq2<>""  then
    userid=trim(session("dm").System_UserId)
    depotid=trim(session("dm").System_Depotid)
	set rs=server.CreateObject("adodb.recordset")
	rs.open "webqry_depot_jxc '"&rq1&"','"&rq2&"','"&userid&"','"&depotid&"',"&dtype&"",cn,1,1
	set t=new Table
	  if dtype=1 then
		t.SetField "st_xl","��Ʒ���","80",0
	  else
		t.SetField "clothingid","��Ʒ���","100",0
	  end if
		t.SetField "sellset","��������","60",1
		t.SetField "outindentset","�˻ع�˾","60",1
		t.SetField "retail","���ۼ���","60",1
		t.SetField "retailget","�����˻�","60",1
		t.SetField "moveget","����","60",1
		t.SetField "moveset","����","60",1
		t.SetField "dfc","δ����","60",1
		t.SetField "zt","��;��","60",1
		t.SetField "depotkc","���̿��","60",1
		t.SetField "totalkc","�ܿ��","60",1
		t.SetField "totalin","�ܽ�����","60",1
    t.height ="85%"
	t.ShowRs(rs)
	set t=nothing
	set rs=nothing
end if%>

<% if cint(typ)<>2 then%>
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

