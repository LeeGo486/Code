<%option explicit%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/class.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ޱ����ĵ�</title>

<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridedittable.js"></SCRIPT>
<SCRIPT language="JavaScript">
function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	showModalDialog('f22_mx.asp?id='+id+'&formid=2067&pksname=<%=session("pksname")%>&ext=<%=ext%>','e','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

  function gtDoEnter(t){}
</SCRIPT>

</head>

<body>
<%
dim rs,sql,t,ext,id
id=trim(request("id"))

set t = new Table
  t.ActiveConnection =cn
  t.CommandType=1
  dim s
  sql="select a.moveid,a.set_depotid as setdepotid,a.setdate,b.d_name as dptname,a.get_depotid as getdepotid,"&_
      "c.d_name as getdptname,(select sum(set_nums) from d_movesub where d_movesub.moveid=a.moveid) as nums,"&_
	  "(select sum(set_nums*s_price) from d_movesub where d_movesub.moveid=a.moveid) as sums,"&_
	  " a.setchk_sure,a.setchk_name,a.setchk_date,a.set_sure,a.setsure_date,a.setsure_name,a.setcr_date,"&_
	  " a.setcr_name, a.selltype,a.set_comment,a.get_sure from d_move a,j_depot b,j_depot c  "&_
	  " where  a.set_depotid=b.depotid and a.get_depotid=c.depotid  and isnull(a.indentid,'')!='' and a.indentid="&qts(id)
 
  	  t.SetField "moveid","��ˮ��","140",2
	  t.SetField "selltype","��������","80",0
	  t.SetField "setdepotid","������","50",2
 	  t.SetField "dptname","����������","150",2
	  t.SetField "getdepotid","�ջ���","50" ,2
	  t.SetField "getdptname","�ջ�������","150",2
	  t.SetField "nums","��������","50",1
	  
	  if psprice then t.SetField "sums","�������","60",1
	  t.SetField "setdate","��������","60",2
	  t.SetField "setchk_sure","���","30",2
	  t.SetField "set_sure","����","30",2
	  t.SetField "get_sure","�ջ�����","50",2
	  t.SetField "setchk_date","�������","80",2
	  t.SetField "setchk_name","�����","50",2
	  t.SetField "setsure_date","��������","80",2
	  t.SetField "setsure_name","������","80",2
	  t.SetField "setcr_date","�Ƶ�����","80",2
	  t.SetField "setcr_name","�Ƶ���","80",2
	  t.SetField "set_comment","������ע","100",2
	  t.CSureName="setchk_sure"
      t.SureName="set_sure"
	  
t.CommandText = sql
t.Show
set rs = nothing
set t = nothing
%>

</body>
</html>
