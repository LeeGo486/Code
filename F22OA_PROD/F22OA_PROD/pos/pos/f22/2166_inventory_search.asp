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
	showModalDialog('f22_mx.asp?id='+id+'&pksname=<%=session("pksname")%>&ext=<%=ext%>','e',
		'dialogWidth:100;dialogHeight:100;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
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
rq1 = trim(request.querystring("rq1"))
rq2 = trim(request.querystring("rq2"))

typ=request("stype")
if rq1<>"" then rq1=get_datetime(rq1,1)
if rq2<>"" then rq2=get_datetime(rq2,2)
if ext="" then ext=1 else ext = cint(ext) end if
if typ=0  then ss="cr_date" else ss="sure_date" end if
if rq1<>"" and rq2<>"" and ext<>4 then ss=" and a."&ss&" between '"&rq1&"' and '"&rq2&"' " else ss="" end if

ss=ss&" and left(a.inventoryid,2)='PC' "

'de rq1
set t = new Table
  t.ActiveConnection =cn
  t.CommandType=1
if seachid="" then
	 sql="SELECT a.inventoryid,a.depotid,b.d_name as dptname,case when a.d_type=0 then '全局' else '局部' end as d_type,"&_
	     "a.setdate,a.chk_sure,a.sure,a.chk_date,a.chk_name,a.sure_date,"&_
	     "a.sure_name,a.cr_date,a.cr_name,a.comment,case when isnull(diff,0)=1 then '是' else '否' end as diff,"&_
		 "(select sum(nums) from d_inventorysub where d_inventorysub.inventoryid=a.inventoryid) as nums,"&_
		 "(select sum(nums*j_price) from d_inventorysub where d_inventorysub.inventoryid=a.inventoryid) as sums,"&_
		 "(select sum(d_nums) from d_inventorysub where d_inventorysub.inventoryid=a.inventoryid) as cynums,"&_
		 "(select sum(d_nums*j_price) from d_inventorysub where d_inventorysub.inventoryid=a.inventoryid) as cysums "&_
		 " from d_inventory a,j_depot b where a.depotid=b.depotid and a.depotid="&qts(session("dm").System_depotid)&ss
		 
		 dim cy
		 select case ext
		 case 0

		 case 1
		   tmp=" and isnull(chk_sure,0)=0 "
		 case 2
		   tmp=" and isnull(chk_sure,0)>0 and isnull(sure,0)=0"
		 case 3
		   tmp=" and isnull(sure,0)>0 "
		case 4
		   tmp=" and isnull(sure,0)=0 "
		end select
		 
		 sql = sql & tmp
		 
else
	 sql="SELECT a.inventoryid,a.depotid,b.d_name as dptname,case when a.d_type=0 then '全局' else '局部' end as d_type,"&_
	     "a.setdate,a.chk_sure,a.sure,a.chk_date,a.chk_name,a.sure_date,"&_
	     "a.sure_name,a.cr_date,a.cr_name,a.comment,case when isnull(diff,0)=1 then '是' else '否' end as diff,"&_
		 "(select sum(nums) from d_inventorysub where d_inventorysub.inventoryid=a.inventoryid) as nums,"&_
		 "(select sum(nums*j_price) from d_inventorysub where d_inventorysub.inventoryid=a.inventoryid) as sums,"&_
		 "(select sum(d_nums) from d_inventorysub where d_inventorysub.inventoryid=a.inventoryid) as cynums,"&_
		 "(select sum(d_nums*j_price) from d_inventorysub where d_inventorysub.inventoryid=a.inventoryid) as cysums "&_
		 " from d_inventory a,j_depot b where a.depotid=b.depotid and a.depotid="&qts(session("dm").System_depotid)&_
		 " and a.inventoryid="&qts(seachid)
end if
	  t.SetField "inventoryid","流水号","140",2
	  t.SetField "d_type","盘点类型","50",0
	  t.SetField "depotid","店铺编号","60",2
	  t.SetField "dptname","店铺名称","100",2
	  t.SetField "nums","盘点数量","50",1
	  t.SetField "Sums","盘点金额","60",1
	  t.SetField "cynums","差异数量","50",1
	  t.SetField "cysums","差异金额","60",1
	  t.SetField "setdate","盘点日期","80",2
	  t.SetField "diff","生成差异","80",2
	  t.SetField "chk_sure","审核","30",2 
	  t.SetField "sure","登帐","30",2 
	  t.SetField "chk_date","审核日期","80",2
	  t.SetField "sure_date","登帐日期","80",2 
	  t.SetField "chk_name","审核人","50",2
	  t.SetField "sure_name","登帐人","50",2
	  t.SetField "cr_date","制单日期","80",2
	  t.SetField "cr_name","制单人","50",2
	  t.SetField "comment","备注","80",2
		t.CSureName="chk_sure"
		t.SureName="sure"
	  
t.CommandText = sql
t.Show
set rs = nothing
set t = nothing
%>

</body>
</html>
