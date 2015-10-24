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
if typ=0  then ss="setcr_date" else ss="getsure_date" end if
if rq1<>"" and rq2<>"" and ext<>4 then  ss=" and a."&ss&" between '"&rq1&"' and '"&rq2&"' " else ss="" end if

'de rq1
set t = new Table
  t.ActiveConnection =cn
  t.CommandType=1
if seachid="" then
        sql="select a.msellid, a.msell, a.set_depotid as setdepotid,b.d_name as setdptname,a.getdate,a.get_depotid as GetDepotid,"&_
		" c.d_name as GetDptname,a.setsure_date,a.selltype,a.getchk_sure,a.getchk_sure,a.get_sure,a.getchk_name,a.getchk_date,"& _
        " a.getsure_name,a.getsure_date,a.getcr_date,a.getcr_name,a.set_comment,a.get_comment,a.backrate,a.backdate,a.noticeid,"&_
		" (select sum(set_nums) from d_msellsub where d_msellsub.msellid=a.msellid) as set_nums,"&_
		" (select sum(set_nums*s_price) from d_msellsub where d_msellsub.msellid=a.msellid) as set_sums,"&_
		" a.noticeid,a.get_sure,a.fmscash,a.fmsinfo, "&_
			" case when isnull(a.fmstype,0)=1 then '寄付' else  case when isnull(a.fmstype,0)=2 then '到付' else '' end  end as fmstyp "&_
        " from d_msell a ,j_depot b,j_depot c"& _
	    " where  isnull(a.set_sure,0)>0 and a.get_depotid="&qts(session("dm").System_depotid) & _
        " and a.set_depotid=b.depotid and a.get_depotid=c.depotid "&ss
		select case ext
		case 0
		
		case 1
		  tmp=" and isnull(a.getchk_sure,0)=0 and isnull(a.get_sure,0)=0"
		case 2
		  tmp=" and isnull(a.getchk_sure,0)>0 and isnull(a.get_sure,0)=0"
		case 3
		  tmp=" and isnull(a.get_sure,0)>0 "
		case 4
		  tmp=" and isnull(a.get_sure,0)=0 "
		end select
	  sql = sql & tmp
else
        sql="select a.msellid, a.msell, a.set_depotid as setdepotid,b.d_name as setdptname,a.getdate,a.get_depotid as GetDepotid,"&_
		" c.d_name as GetDptname,a.setsure_date,a.selltype,a.getchk_sure,a.getchk_sure,a.get_sure,a.getchk_name,a.getchk_date,"& _
        " a.getsure_name,a.getsure_date,a.getcr_date,a.getcr_name,a.set_comment,a.get_comment,a.backrate,a.backdate,a.noticeid,"&_
		" (select sum(set_nums) from d_msellsub where d_msellsub.msellid=a.msellid) as set_nums,"&_
		" (select sum(set_nums*s_price) from d_msellsub where d_msellsub.msellid=a.msellid) as set_sums"&_
			" a.noticeid,a.get_sure,a.fmscash,a.fmsinfo, "&_
			" case when isnull(a.fmstype,0)=1 then '寄付' else  case when isnull(a.fmstype,0)=2 then '到付' else '' end  end as fmstyp "&_
			" from d_msell a, j_depot b,j_depot c"& _
	    " where  isnull(a.set_sure,0)>0 and a.get_depotid="&qts(session("dm").System_depotid) & _
        " and a.set_depotid=b.depotid and a.get_depotid=c.depotid and a.msellid="&qts(seachid)
end if
	  t.SetField "msellid","流水号","140",2
	  t.SetField "selltype","发货类型","50",0
	  t.SetField "setdepotid","发货地","50",2
	  t.SetField "setdptname","发货地名称","100",2
	  t.SetField "getdepotid","收货地","60",2
	  t.SetField "getdptName","收货地名称","100",2
	  t.SetField "set_nums","发货数量","50",1
	  t.SetField "set_sums","发货金额","60",1
	  t.SetField "setsure_date","发货日期","80",2
		'新加 2009-02-17 start
		t.SetField "fmscash","运费","50",1
		t.SetField "fmstyp","付款方式","50",2
		t.SetField "fmsinfo","货运信息","150",2
		'新加 2009-02-17 end


	  t.SetField "getchk_sure","收货审核","50",2
	  t.SetField "get_sure","收货登帐","50",2
	  t.SetField "getchk_name","收货审核人","50",2
	  t.SetField "getchk_date","收货审核日期","80",2
	  t.SetField "getsure_name","收货登帐人","80",2
	  t.SetField "getsure_date","收货登帐日期","80",2
      t.SetField "getcr_name","收货制单人","50",2
	  t.SetField "getcr_date","收货制单日期","80",2
	  t.SetField "set_comment","发货备注","80",2
	  t.SetField "get_comment","收货备注","80",2
	  t.SetField "backrate","换货率","40",2
      t.SetField "backdate","换货日期","80",2
      t.SetField "getdate","计划到货日期","80",2
	  t.SetField "noticeid","通知单号","140",2
	  t.SetField "msell","发货单号","140",2
      t.CSureName="getchk_sure"
      t.SureName="get_sure"
	  
t.CommandText = sql
t.Show
set rs = nothing
set t = nothing
%>

</body>
</html>
