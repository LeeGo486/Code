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
dim rq1,rq2,begtime,endtime,mbman,jdman
rq1=trim(request("begdate"))
rq2=trim(request("enddate"))
begtime=trim(request("begtime"))
endtime=trim(request("endtime"))
mbman=trim(request("mbman"))
jdman=trim(request("jdman"))
if begtime="" then begtime=8
if endtime="" then endtime=18

if rq1="" then rq1 = get_date(date()-1)
if rq2="" then rq2 = get_date(date())

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
    <td align="center">�����������</td>
  </tr>
</table>
<div style="padding:10px;width:100%;font-size:12px">
<form name="form1" method="get" action="">
<input type="hidden" name="act" id="act" value="true">
<input type="hidden" name="typ" id="typ" value="1">
<label>���ڣ�</label>
  <input type="text" name="begdate" id="begdate" style="width:70px;" readonly="readonly" class="box" onFocus="setday(this);" value="<%=rq1%>">
<label>��ʼʱ�䣺</label>
  <input type="text" name="begtime" id="begtime" style="width:60px;" class="box" value="<%=begtime%>" 
       onkeydown="if(event.keyCode==13)event.keyCode=9"
       onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false"
       onBlur="javascript:if(isNaN(this.value)){alert('�������ʹ���');this.focus();}this.value=Math.floor(this.value);">
<label>����ʱ�䣺</label>
  <input type="text" name="endtime" id="endtime" style="width:60px;" class="box" value="<%=endtime%>" 
       onkeydown="if(event.keyCode==13)event.keyCode=9"
       onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false"
       onBlur="javascript:if(isNaN(this.value)){alert('�������ʹ���');this.focus();}this.value=Math.floor(this.value);">
<label>Ŀ������������</label>
  <input type="text" name="mbman" id="mbman" style="width:60px;" class="box" value="<%=mbman%>" 
       onkeydown="if(event.keyCode==13)event.keyCode=9"
       onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false"
       onBlur="javascript:if(isNaN(this.value)){alert('�������ʹ���');this.focus();}this.value=Math.floor(this.value);">
<label>����������</label>
  <input type="text" name="jdman" id="jdman" style="width:60px;" class="box" value="<%=jdman%>" 
       onkeydown="if(event.keyCode==13)event.keyCode=9"
       onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false"
       onBlur="javascript:if(isNaN(this.value)){alert('�������ʹ���');this.focus();}this.value=Math.floor(this.value);">
  <br />
  <input name="button2" type="button" class="btn" id="button2" value="ѡ���ʽ" onClick="javascript:selectStyle()" />
  <input name="button" type="submit" class="btn" id="button" value="�� ѯ" onClick="document.all.form1.typ.value=1;document.all.form1.submit();" />
  <input name="button3" type="button" class="btn" id="button3" value="����Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();" />
</form>
</div>
<% End If %>
<%
   if rq1<>"" and begtime<>"" and endtime<>"" and mbman<>"" and jdman<>"" then
    depotid=trim(session("dm").System_Depotid)
	set rs=server.CreateObject("adodb.recordset")
	rs.open "webqry_lrcs '"&rq1&"','"&begtime&"','"&endtime&"','"&depotid&"','"&mbman&"','"&jdman&"'",cn,1,1
	set t=new Table
		t.SetField "rdate","ʱ��","100",0
		t.SetField "mbman","Ŀ����������","80",0
		t.SetField "jdman","��������","60",1
		t.SetField "jdr","������","60",1
		t.SetField "cjman","�ɽ�����","60",1
		t.SetField "cjr","�ɽ���","60",1
		t.SetField "nums","�ɽ�����","60",1
		t.SetField "ldr","������","60",1
		t.SetField "price","ƽ������","60",1
		t.SetField "sums","�ܳɽ���","60",1
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

