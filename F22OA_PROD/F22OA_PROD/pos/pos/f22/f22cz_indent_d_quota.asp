<%option explicit
%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<%dim ds,id,i,sql,action,t,act,opt
id=trim(request.QueryString("id"))
action=trim(request.QueryString("action"))
  select case action
  case "cz_indent"
    act="quota"
	opt="quota"
  case "cz_quota"
    act="sell"
	opt="sell"
  case "cz_outindentCHK"
    act="outindent"
	opt="outindentCHK"
  end select%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<script language="javascript">
  function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	//showModalDialog('f22_mx.asp?id='+id+'&pksname=quota','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
	//showModalDialog('f22_main.asp?id='+id+'&pksname=<%=act%>&opt=<%=opt%>&numName=nums',"es","dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no");
  }
</script>
</head>

<body>
<%
if id<>"" then
  set t = new Table
  t.CommandType=1
  t.ActiveConnection=cn
    sql="select a.outindentid, a.outindent, a.depotid, c.d_name as getdptname,a.comment, a.set_depotid,b.d_name as setdptname,a.chk_sure,a.sure,  "& _
	  "(select sum(e.nums) from d_outindentsetsub e where a.outindentid=e.outindentid) as nums,"&_
	  "(select sum(e.nums*e.s_price) from d_outindentsetsub e where a.outindentid=e.outindentid) as sums "&_
      "from d_outindentset a,j_depot b,j_depot c "& _
	  "where a.quotaid="&qts(id)&" and a.set_depotid=b.depotid and a.depotid=c.depotid "
	  'de sql
	  t.SetField "outindentid","��ˮ��","140",2
	  t.SetField "set_depotid","������","60",0
	  t.SetField "setdptname","����������","100",2
	  t.SetField "depotid","�ջ���","60",2
	  t.SetField "getdptname","�ջ�������","100",2
	  t.SetField "nums","����","50",1
	  t.SetField "sums","���","80",1
	  t.SetField "comment","��ע","300",2
	t.CSureName="chk_sure"
	t.SureName="sure"
  t.CommandText=sql
  t.Show
  set t=nothing
else%>
  <div id="gt1" style="width:100%;height:100%">
  <table><thead><tr>
  <th width="140">��ˮ��</th>
  <th width="60">������</th>
  <th width="100">����������</th>
  <th width="60">�ջ���</th>
  <th width="100">�ջ�������</th>
  <th width="50">����</th>
  <th width="80">���</th>
  <th width="300">��ע</th> 
  </tr></thead></table>
  </div>
  <script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
<%end if%>
</body>
</html>
