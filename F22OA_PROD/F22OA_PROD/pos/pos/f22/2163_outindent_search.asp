<%option explicit%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/class.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>

<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridedittable.js"></SCRIPT>
<SCRIPT language="JavaScript">
var rsta=-1;
function gtDoSelect(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	parent.id=id;//在客户端共用的单据ID
	var sta=row.getElementsByTagName("input")[0];
	try{
		sta=parseInt(sta.value);
	}catch(ex){}
	if(rsta!=sta){
		switch(sta){
		case 0:
	  	  parent.edit();break;
		case 1:
	  	  parent.chksured();break;
		case 2:
	  	  parent.sured();break;
		default:
	  	  break;
		}
	    rsta=sta;
	}
}

function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	showModalDialog('f22_mx.asp?id='+id+'&pksname=<%=session("pksname")%>&ext=<%=ext%>','e','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

  function gtDoEnter(t){}
</SCRIPT>

</head>

<body>
<%
dim rs,ext,sql,t,rq1,rq2,stype,userid,tmp,typ,ss,seachid
Call getParam '取得传入的参数
seachid=trim(request.QueryString("seachid"))
ext = trim(request.QueryString("ext"))
rq1 = trim(request("rq1"))
rq2 = trim(request("rq2"))

typ=request("stype")
if rq1<>"" then rq1=get_datetime(rq1,1)
if rq2<>"" then rq2=get_datetime(rq2,2)
if ext="" then ext=1 else ext = cint(ext) end if
if typ=0  then ss="cr_date" else ss="sq_tjdate" end if
if rq1<>"" and rq2<>"" and ext<>4 then ss=" and a."&ss&" between '"&rq1&"' and '"&rq2&"' " else ss="" end if

set t = new Table
  t.ActiveConnection =cn
  t.CommandType=1
		dim s
  		sql="select a.outindentsqid,a.selltype,a.set_depotid,a.depotid,a.sq_spsure,a.sq_tjsure,a.sq_spcomment,a.sq_comment, "&_
			"case when isnull(a.cancel,0)=0 then '正常' else '撤消' end as cantype , "&_
			"case when isnull(a.d_type,0)=1 and a.sq_tjsure>0 then '已提交' else case when isnull(a.d_type,0)=2 then'已审批' "&_
			" else case when isnull(a.d_type,0)=3 then '已回复' end end end as dtype , "&_
		    "(select sum(b.sq_tjnums) from d_outindentsqsub b where a.outindentsqid=b.outindentsqid) as sqnums,"& _
			"(select sum(c.sq_tjnums*c.s_price) from d_outindentsqsub c where a.outindentsqid=c.outindentsqid) as sqsums,"& _
			"(select d.d_name from j_depot d where a.set_depotid=d.depotid ) as setdptname,"& _
			"(select e.d_name from j_depot e where a.depotid=e.depotid ) as getdptname, "&_
			"a.sq_tjsure,a.sq_tjname,a.sq_tjdate,a.sq_spname,a.sq_name,a.sq_tjcomment,a.cr_date,a.cr_name from d_outindentsq a "&_
			"where a.set_depotid="&qts(session("dm").System_depotid)&ss
			
		select case ext
		case 0

		case 1
		  sql=sql&" and a.sq_tjsure>0 and d_type=1 "
		case 2
		  sql=sql&" and d_type=2"
		case 3
		  sql=sql&" and d_type=3"
		end select
		
		if seachid<>"" then sql=sql&" and a.outindentsqid="&qts(seachid)
		
	  t.SetField "outindentsqid","流水号","140",2
	  t.SetField "cantype","申请状态","50",2
	  t.SetField "dtype","单据状态","50",2
	  t.SetField "set_depotid","退货仓店","60",2
	  t.SetField "setdptname","退货仓店名称","100",2
	  t.SetField "depotid","收货仓店","60",2
	  t.SetField "getdptname","收货仓店名称","100",2
	  t.SetField "selltype","申请类型","80",2

	  t.SetField "sq_tjsure","提交","30",2
	  t.SetField "sq_tjname","提交人","50",2
	  t.SetField "sq_tjdate","提交日期","80",2
		
	  t.SetField "cr_name","制单人","50",2
	  t.SetField "cr_date","制单日期","80",2
	  t.SetField "sqnums","总数","50",1
		t.SetField "sqsums","总金额","50",1
	  t.SetField "sq_tjcomment","申请备注","80",2
	  t.SetField "sq_spcomment","审批备注","80",2
	  t.SetField "sq_comment","回复备注","80",2
	  t.CSureName="sq_tjsure"
		t.SureName="sq_spsure"
t.CommandText = sql
t.Show
set rs = nothing
set t = nothing
%>

</body>
</html>
