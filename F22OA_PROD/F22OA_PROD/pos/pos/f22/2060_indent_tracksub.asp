<%
'option explicit
'on error resume next
'Response.Expires=-1000

Dim typ,act,key
typ=request("typ")
act=request("act")
key=trim(request("key"))
if act = "" then act=0 else act=1 end if
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if

ext = request("ext")
if ext="" then ext=0
	
rq1=request("begdate")
rq2=request("enddate")
%>

<!--#include file="report/inc/function.asp" -->
<!--#include file="report/inc/Class.asp" -->
<% if cint(typ)<>2 then %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=request("id")&" ��ϸ"%></title>
<base target="_self" />
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../inc/js/setday.js"></SCRIPT>
<SCRIPT language="JavaScript" src="report/inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="report/inc/gridtable.js"></SCRIPT>
<style>
body{margin:0}
a{ text-decoration:none; color:black}
a:hover{ text-decoration:none; color:red}
form{padding-bottom:10px;}
table{}
</style>
</head>
<body>
<div style="padding:10px;width:98%;font-size:12px;">
<form name="form1" method="get" action="">
<input type="hidden" value="<%=request("id")%>"  name="id" id="id" />
<input type="hidden" value="1"  name="typ" id="typ" />
<label for="key">��ţ�</label>
<input type="text" name="key" id="key" style="width:100px;" class="box" value="<%=key%>">
  <input name="button" type="submit" class="btn" id="button" value="�� ѯ" onClick="document.all.form1.typ.value=1;document.all.form1.target='';document.all.form1.submit();">
<input name="button3" type="button" class="btn" id="button3" value="����Excel" onClick="document.all.form1.typ.value=2;document.all.form1.target='hf';document.all.form1.submit();">
<input name="button4" type="button" class="btn" id="button4" value="�˳�" onClick="window.close();">
</label>
</form>
</div>
<%
if request("id")="" then
response.write "<span style='color:red'>����������Ҫ��ѯ�Ŀ�ʽ���!</span>"
response.End()
end if
%>
<%else%>
<style>
table{
	 border-collapse:collapse;
	}
</style>

<table border="1">
<tr>
<td colspan="9" align="center" height="50"><strong><%=request("id")&" ���䷢����ϸ"%></strong></td>
</tr>
</table>

<% End If %>
<%
set t=new Table
t.Activeconnection = cn
sql=" select a.indentid,a.styleid,a.colorid,a.sizeid,a.nums,a.phnums,"&_
		" a.fhnums,(a.nums-a.phnums) as dpx,(a.phnums-a.fhnums) as pfx,(a.nums-a.fhnums) as dfx from d_indentsub a"&_
		" left join j_size b on b.sizeid=a.sizeid"&_
		" where indentid='"&request("id")&"' and clothingid like '%"&request("key")&"%' "&_
		" order by a.styleid asc,colorid asc,b.s_order asc"
	t.CommandType = 1
	  t.SetField "indentid","��ˮ��","140",3
	  t.SetField "styleid","���","70",3
	  t.SetField "colorid","ɫ��","70",3
	  t.SetField "sizeid","����","70",3
	  t.SetField "nums","������","40",1
	  t.SetField "phnums","�����","40",1
	  t.SetField "fhnums","������","40",1
	  t.SetField "dpx","�����","40",1
	  t.SetField "dfx","������","40",1
	t.CommandText=sql
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
<iframe src="about:blank" style="display:none" name="hf"></iframe>

</body>
</html>
<% End If %>
