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
	var tzid=row.cells[1].outerText;
	parent.id=id;//在客户端共用的单据ID
	parent.tzid=tzid;
	parent.changescan(tzid);
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
dim rs,ext,sql,t,rq1,rq2,stype,userid,tmp,typ,ss,seachid,jh,ss2
Call getParam '取得传入的参数
seachid=trim(request("seachid"))
ext = trim(request("ext"))
rq1 = trim(request("rq1"))
rq2 = trim(request("rq2"))
jh  = trim(request("jh"))

typ=request("stype")
if rq1<>"" then rq1=get_datetime(rq1,1)
if rq2<>"" then rq2=get_datetime(rq2,2)
if ext="" then ext=1 else ext = cint(ext) end if
if typ=0  then ss="setcr_date" else ss="setsure_date" end if

if rq1<>"" and rq2<>"" and ext<>4 then  ss=" and a."&ss&" between '"&rq1&"' and '"&rq2&"' " else ss="" end if

if jh="1" then ss2=" and isnull(a.indentid,'')<>''" end if

set t = new Table
  t.ActiveConnection =cn
  t.CommandType=1
if seachid="" then
	    sql=" select a.moveid,a.indentid,a.set_depotid as setdepotid,a.setdate,b.d_name as dptname,a.get_depotid as getdepotid,c.d_name as getdptname,"&_
		    "(select sum(set_nums) from d_movesub where d_movesub.moveid=a.moveid) as nums,"&_
			"(select sum(set_nums*s_price) from d_movesub where d_movesub.moveid=a.moveid) as sums,"& _
			" a.setchk_sure,a.setchk_name,a.setchk_date,a.set_sure,a.setsure_date,a.setsure_name,a.setcr_date,a.setcr_name,"&_
			" a.selltype,a.set_comment,a.get_sure from d_move a,j_depot b,j_depot c "&_
			" where a.set_depotid="&qts(session("dm").System_depotid)&_
			" and a.set_depotid=b.depotid and a.get_depotid=c.depotid "&ss&ss2
	  select case ext
	  case 0
	  
	  case 1
	    tmp=" and a.setchk_sure=0 and a.setchk_sure=0 "
	  case 2
	    tmp=" and a.setchk_sure>0 and a.setchk_sure=0 "
	  case 3
	    tmp=" and a.set_sure>0 "
		case 4
		  tmp=" and a.set_sure=0 "
		end select
	  sql = sql & tmp
else
	    sql=" select a.moveid,a.indentid,a.set_depotid as setdepotid,a.setdate,b.d_name as dptname,a.get_depotid as getdepotid,c.d_name as getdptname,"&_
		    "(select sum(set_nums) from d_movesub where d_movesub.moveid=a.moveid) as nums,"&_
			"(select sum(set_nums*s_price) from d_movesub where d_movesub.moveid=a.moveid) as sums,"& _
			" a.setchk_sure,a.setchk_name,a.setchk_date,a.set_sure,a.setsure_date,a.setsure_name,a.setcr_date,a.setcr_name,"&_
			" a.selltype,a.set_comment,a.get_sure from d_move a,j_depot b,j_depot c "&_
			" where a.set_depotid="&qts(session("dm").System_depotid)&_
			" and a.set_depotid=b.depotid and a.get_depotid=c.depotid and a.moveid="&qts(seachid)&ss2
end if
	  'de sql
	  t.SetField "moveid","流水号","140",2
  	  t.SetField "indentid","参照单号","150",2
	  t.SetField "selltype","发货类型","80",0
	  t.SetField "setdepotid","发货地","50",2
 	  t.SetField "dptname","发货地名称","150",2
	  t.SetField "getdepotid","收货地","50" ,2
		t.SetField "getdptname","收货地名称","150",2
	  t.SetField "nums","发货数量","50",1
		if psprice then t.SetField "sums","发货金额","60",1
		t.SetField "setdate","发货日期","60",2
	  t.SetField "setchk_sure","审核","30",2
	  t.SetField "set_sure","登帐","30",2
		t.SetField "get_sure","收货登帐","50",2
	  t.SetField "setchk_date","审核日期","80",2
	  t.SetField "setchk_name","审核人","50",2
	  t.SetField "setsure_date","登帐日期","80",2
	  t.SetField "setsure_name","登帐人","80",2
		t.SetField "setcr_date","制单日期","80",2
		t.SetField "setcr_name","制单人","80",2
		t.SetField "set_comment","发货备注","100",2
	  t.CSureName="setchk_sure"
      t.SureName="set_sure"
	  
t.CommandText = sql
t.Show
set rs = nothing
set t = nothing
%>

</body>
</html>
