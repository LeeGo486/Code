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
dim rs,ext,sql,t,rq1,rq2,typ,ss,seachid
seachid=trim(request.QueryString("seachid"))
ext = trim(request.QueryString("ext"))
rq1=request("rq1")
rq2=request("rq2")
typ=request("stype")
if rq1<>"" then rq1=get_datetime(rq1,1)
if rq2<>"" then rq2=get_datetime(rq2,2)
if ext="" then ext=1 else ext = cint(ext) end if
if typ=0  then ss="cr_date" else ss="sure_date" end if
if rq1<>"" and rq2<>"" and ext<>4 then ss=" and a."&ss&" between '"&rq1&"' and '"&rq2&"' " else ss="" end if

set t = new Table
set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn

if seachid="" then
   sql="select a.indentid,a.depotid as setdepotid,a.setdate,b.d_name as setdptname,a.get_depotid as getdepotid,c.d_name as getdptname," &_
       "a.selltype,a.getdate,(select sum(nums) from d_indentsub where d_indentsub.indentid=a.indentid) as nums," &_
      "(select sum(nums*s_price) from d_indentsub where d_indentsub.indentid=a.indentid) as sums,a.sure,a.sure_date,a.sure_name," &_
	  "a.comment,a.cr_name,a.chk_sure,a.chk_date,a.chk_name,a.cr_date,a.ov_sure,a.ov_date,a.backdate,a.backrate,a.indent " &_
      "from d_indent a,j_depot b,j_depot c where a.d_type=1 and a.depotid=b.depotid and a.get_depotid=c.depotid " &_
	  " and a.get_depotid="&qts(session("dm").System_depotid)&ss
		select case ext
		case 0
		  sql=sql
		case 1
		  sql=sql&" and isnull(chk_sure,0)=0 "
		case 2
		  sql=sql&" and isnull(chk_sure,0)>0 and isnull(sure,0)=0"
		case 3
		  sql=sql&" and isnull(sure,0)>0"
		case 4
		  sql=sql&" and isnull(sure,0)=0 "
		end select
else
   sql="select a.indentid,a.depotid as setdepotid,a.setdate,b.d_name as setdptname,a.get_depotid as getdepotid,"&_
		" c.d_name as getdptname," &_
		" a.selltype,a.getdate,(select sum(nums) from d_indentsub where d_indentsub.indentid=a.indentid) as nums," &_
		" (select sum(nums*s_price) from d_indentsub where d_indentsub.indentid=a.indentid) as sums,a.sure,a.sure_date,a.sure_name," &_
	  " a.comment,a.cr_name,a.chk_sure,a.chk_date,a.chk_name,a.cr_date,a.ov_sure,a.ov_date,a.backdate,a.backrate,a.indent " &_
		" from d_indent a,j_depot b,j_depot c where a.d_type=1 and a.depotid=b.depotid and a.get_depotid=c.depotid " &_
	  " and a.get_depotid="&qts(session("dm").System_depotid)&" and a.indentid="&qts(seachid)
end if  
	  t.SetField "indentid","流水号","140",2
	  t.SetField "selltype","订货类型","60",0
	  t.SetField "getdepotid","收货地","70",2
	  t.SetField "getdptname","收货地名称","80",2
	  t.SetField "setdepotid","发货地","50",2
	  t.SetField "setdptname","发货地名称","80",2
	  t.SetField "getdate","计划发货日期","80",2
	  t.SetField "nums","订货数量","60",1
	  if psprice then t.SetField "sums","订货金额","60",1
		t.SetField "setdate","订货日期","60",2
	  t.SetField "chk_sure","审核","30",2
	  t.SetField "sure","登帐","30",2
	  t.SetField "chk_date","审核日期","60",2
	  t.SetField "sure_date","登帐日期","60",2
	  t.SetField "chk_name","审核人","50" ,2
	  t.SetField "sure_name","登帐人","50",2
	  t.SetField "comment","备注","80",2
		t.SetField "cr_name","制单人","60",2
		t.SetField "cr_date","制单日期","60",2
	  t.SetField "ov_sure","结案","30",2
	  t.SetField "ov_date","结案日期","60",2
	  t.SetField "backrate","换货折扣","60",2
	  t.SetField "backdate","换货日期","60",2
	  t.SetField "indent","订单号","140",2
      t.CSureName="chk_sure"
      t.SureName="sure"
rs.Source = sql
rs.Open
t.ShowRS(rs)
'rs.Close  
set rs = nothing
set t = nothing
%>

</body>
</html>
