<%option explicit
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%dim ext
ext=trim(request.QueryString("ext"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
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
	showModalDialog('f22_mx.asp?id='+id+'&pksname=<%=session("pksname")%>&ext=<%=ext%>','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

  function gtDoEnter(t){}
</SCRIPT>
</head>

<body>
<%dim rq1,rq2,Userid,stype,com,i

Call getParam '取得传入的参数

  if trim(request("com"))<>"" then
    session("com")=request("com")
  end if
  com=session("com")
  
  Call getGant("search",1)

if rq1<>"" then
  dim t,sql
  set t=New Table
  t.ActiveConnection =cn
  t.CommandType=4

  select case com
    case "2005" '向总公司订货
	  
	  sql="webqry_indentdh"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "indentid","流水号","140"
	  t.SetField "phcnt","配次","30"
 	  t.SetField "fhcnt","发次","30"
	  t.SetField "getdepotid","收货地","70"
	  t.SetField "getdptname","收货地名称","80"
	  t.SetField "selltype","订货类型","60"
	  t.SetField "getdate","计划发货日期","80"
	  t.SetField "dhnums","订货数量","50"
	  t.SetField "dhjpsums","订货金额","60"
	  t.SetField "phnums","配货数量","50"
	  t.SetField "phjpsums","配货金额","60"
	  t.SetField "fhnums","发货数量","50"
	  t.SetField "fhjpsums","发货金额","60"
	  t.SetField "sure","登帐","30"
	  t.SetField "sure_date","登帐日期","60"
	  t.SetField "sure_name","登帐人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "setdepotid","发货地","50"
	  t.SetField "setdptname","发货地名称","80"
      t.SetField "cr_name","制单人","50"
	  t.SetField "chk_sure","审核","30"
	  t.SetField "chk_name","审核人","50"
      t.SetField "cr_date","制单日期","60"
	  t.SetField "ov_sure","结案","30"
	  t.SetField "ov_date","结案日期","60"
	  t.SetField "backrate","换货折扣","60"
	  t.SetField "backdate","换货日期","60"
	  t.SetField "indent","订单号","140"
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1800px"
	  't.height="100%"
    case "2006" '向总公司补货
	  sql="webqry_indentbh"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "indentid","流水号","140"
	  t.SetField "phcnt","配次","30"
	  t.SetField "indent","补单号","140"
	  t.SetField "Getdepotid","收货地","50"
	  t.SetField "GetdptName","收货地名称","100"
	  t.SetField "selltype","补货类型","50"
	  t.SetField "getdate","计划发货日期","80"
	  t.SetField "dhnums","补货数量","50"
	  t.SetField "dhjpsums","补货金额","60"
	  t.SetField "phnums","配货数量","50"
	  t.SetField "phjpsums","配货金额","60"
	  t.SetField "fhnums","发货数量","50"
	  t.SetField "fhjpsums","发货金额","60"
	  t.SetField "sure","登帐","30"
	  t.SetField "sure_name","登帐人","50"
	  t.SetField "sure_date","登帐日期","80"
	  t.SetField "comment","备注","80"
	  t.SetField "cr_name","制单人","50"
	  t.SetField "chk_sure","审核","30"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "chk_date","审核日期","80"
	  t.SetField "ov_sure","结案","30"
      t.SetField "ov_name","结案人","50"
      t.SetField "ov_date","结案日期","80"
      t.SetField "setdate","补货日期","80"
	  t.SetField "backrate","换货折扣","50"
      t.SetField "backdate","换货日期","80"
      t.SetField "setdptname","发货地名称","100"
 	  t.SetField "Setdepotid","发货地","50"    
	  t.SetField "cr_date","制单日期","80"
      t.CSureName="chk_sure"
      t.SureName="sure"
	  t.width="100%"
	  
	case "2010" '收货	  
	  if stype="0" then
        sql="select a.sellid, a.sell, a.setdepotid, a.merchantid, a.getdate,a.GetDptname,a.SetDptname, "& _
        " a.backrate, a.selltype, a.backdate,a.quotaid,a.getsure_name, a.getsure_date, a.Set_SumS,"& _
        " a.getchk_sure, a.getchk_name, a.getchk_date,a.get_comment,c.dptname as getdptname,"& _
        " b.dptname as setdptname,a.set_comment, a.cwpz, a.getdepotid,a.parentid, a.get_sure, "& _
		" a.setdate,a.set_nums,a.setcr_date,a.setcr_name,a.setchk_name,a.setchk_date,setsure_name, "& _
		" a.setsure_date,crdate,a.autoid,setchk_sure,set_sure "& _
        " from v22d_sell a,v22p_setdepot b,v22p_getdepot c "& _
	    " where  a.set_sure=1 and ((a.get_sure=0) or (a.get_sure is null)) "& _
        " and a.setdepotid=b.depotid and a.getdepotid=c.depotid "& _
        " and c.userid=b.userid and c.userid="&qts(UserId) & _
		" and a.setcr_date between "& qts(rq1) &" and "&qts(rq2)
      else
        sql="select a.sellid, a.sell, a.setdepotid, a.merchantid, a.getdate,a.GetDptname,a.SetDptname, "& _
        " a.backrate, a.selltype, a.backdate,a.quotaid,a.getsure_name, a.getsure_date,a.Set_SumS, "& _
        " a.getchk_sure, a.getchk_name, a.getchk_date,a.get_comment,c.dptname as getdptname,"& _
        " b.dptname as setdptname,a.set_comment, a.cwpz, a.getdepotid,a.parentid, a.get_sure, "& _
		" a.setdate,a.set_nums,a.setcr_date,a.setcr_name,a.setchk_name,a.setchk_date,setsure_name, "& _
		" a.setsure_date,crdate,a.autoid,setchk_sure,set_sure "& _
        " from v22d_sell a,v22p_setdepot b,v22p_getdepot c "& _
	    " where  a.set_sure=1 and ((a.get_sure=0) or (a.get_sure is null)) "& _
        " and a.setdepotid=b.depotid and a.getdepotid=c.depotid "& _
        " and c.userid=b.userid and c.userid="&qts(UserId) & _
		" and a.setsure_date between "& qts(rq1) &" and "&qts(rq2)
      end if
      't.CommandType=1
      't.SetField "sellid","批发单号","140"
	  't.SetField "setdepotid","发货地","50"
	  't.SetField "setdptname","发货地简称","80"
	  't.SetField "getdepotid","收货地","50"
	  't.SetField "getdptname","收货地简称","80"
	  't.SetField "setdate","发货日期","80"
	 ' t.SetField "getdate","收货日期","80"
	 ' t.SetField "set_nums","数量","40"
	  't.SetField "set_sums","金额","40"
	  't.SetField "setcr_name","制单人","50"
      't.SetField "setcr_date","制单日期","80"
	  ''t.SetField "getchk_name","审核人","50"
	  't.SetField "getchk_date","审核日期","80"
	  't.SetField "getsure_name","登帐人","50"
	  't.SetField "getsure_date","登帐日期","80"
      't.SetField "sell","用户自编号","140"
      't.SetField "get_mchid","订货商","50"
	 't.SetField "backrate","退货率","40"
	 ' t.SetField "backdate","最后可退货日期","90"
     ' t.SetField "selltype","销售类型","50"
      't.SetField "set_comment","发货备注","150"
      't.CSureName="getchk_sure"
      't.SureName="get_sure"
	  't.width="100%"
	  
	  sql="webqry_getsell"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "sellid","流水号","140"
	  t.SetField "sell","发货单号","140"
	  t.SetField "get_depotid","收货地","60"
	  t.SetField "getdptName","收货地名称","100"
	  t.SetField "selltype","发货类型","50"
	  t.SetField "fhnums","发货数量","50"
	  t.SetField "fhjpsums","发货金额","60"
	  t.SetField "indentsums","订金金额","60"
	  t.SetField "setdate","发货日期","80"
	  t.SetField "get_sure","收货","30"
	  t.SetField "getsure_date","登帐日期","80"
	  t.SetField "getchk_sure","审核","30"
	  't.SetField "set_sure","登帐","30" 
      t.SetField "setcr_name","制单人","50"
	  t.SetField "setcr_date","制单日期","80"
	  t.SetField "getchk_name","审核人","50"
	  t.SetField "getchk_date","审核日期","80"
	  t.SetField "set_depotid","发货地","50"
	  t.SetField "setdptname","发货地名称","100"
	  t.SetField "set_comment","发货备注","80"
	  t.SetField "quotaid","配货单号","140"
      t.SetField "get_mchid","加盟商","50"
	  t.SetField "get_comment","收货备注","80"
	  t.SetField "backrate","换货率","40"
      t.SetField "backdate","换货日期","80"
      't.SetField "getdate","到货日期","80"
      't.SetField "numrate","量扣","50"
      't.SetField "styrate","款扣","50"
      t.CSureName="getchk_sure"
      t.SureName="get_sure"
	  
	case "2050" '加盟定货
	  sql="webqry_indentdh"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,cint(stype)+10
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "indentid","流水号","140"
	  t.SetField "phcnt","配次","30"
 	  t.SetField "fhcnt","发次","30"
	  t.SetField "getdepotid","收货地","70"
	  t.SetField "getdptname","收货地名称","80"
	  t.SetField "selltype","订货类型","60"
	  t.SetField "getdate","计划发货日期","80"
	  t.SetField "dhnums","订货数量","50"
	  t.SetField "dhjpsums","订货金额","60"
	  t.SetField "phnums","配货数量","50"
	  t.SetField "phjpsums","配货金额","60"
	  t.SetField "fhnums","发货数量","50"
	  t.SetField "fhjpsums","发货金额","60"
	  t.SetField "sure","登帐","30"
	  t.SetField "sure_date","登帐日期","60"
	  t.SetField "sure_name","登帐人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "setdepotid","发货地","50"
	  t.SetField "setdptname","发货地名称","80"
      t.SetField "cr_name","制单人","50"
	  t.SetField "chk_sure","审核","30"
	  t.SetField "chk_name","审核人","50"
      t.SetField "cr_date","制单日期","60"
	  t.SetField "ov_sure","结案","30"
	  t.SetField "ov_date","结案日期","60"
	  t.SetField "backrate","换货折扣","60"
	  t.SetField "backdate","换货日期","60"
	  t.SetField "indent","订单号","140"
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1800px"
	  t.height="100%"
	  
	case "2051" '加盟补货
	
	  sql="webqry_indentbh"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,cint(stype)+10
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "indentid","流水号","140"
	  t.SetField "phcnt","配次","30"
 	  t.SetField "fhcnt","发次","30"
	  t.SetField "getdepotid","收货地","70"
	  t.SetField "getdptname","收货地名称","80"
	  t.SetField "selltype","订货类型","60"
	  t.SetField "getdate","计划发货日期","80"
	  t.SetField "dhnums","订货数量","50"
	  t.SetField "dhjpsums","订货金额","60"
	  t.SetField "phnums","配货数量","50"
	  t.SetField "phjpsums","配货金额","60"
	  t.SetField "fhnums","发货数量","50"
	  t.SetField "fhjpsums","发货金额","60"
	  t.SetField "sure","登帐","30"
	  t.SetField "sure_date","登帐日期","60"
	  t.SetField "sure_name","登帐人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "setdepotid","发货地","50"
	  t.SetField "setdptname","发货地名称","80"
      t.SetField "cr_name","制单人","50"
	  t.SetField "chk_sure","审核","30"
	  t.SetField "chk_name","审核人","50"
      t.SetField "cr_date","制单日期","60"
	  t.SetField "ov_sure","结案","30"
	  t.SetField "ov_date","结案日期","60"
	  t.SetField "backrate","换货折扣","60"
	  t.SetField "backdate","换货日期","60"
	  t.SetField "indent","订单号","140"
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="100%"
	  
	case "2052","2008" '加盟配货
	  
	  sql="webqry_quota"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "quotaid","流水号","140"
	  t.SetField "fhcnt","发次","30"
	  t.SetField "quota","配货单号","140"
	  t.SetField "get_depotid","收货地","50"
      t.SetField "getdptName","收货地名称","100"
	  t.SetField "selltype","发货类型","40"
	  t.SetField "phnums","配货数量","50"
	  t.SetField "phjpsums","配货金额","60"
	  t.SetField "fhnums","发货数量","50"
	  t.SetField "fhjpsums","发货金额","60"
	  t.SetField "setdate","配货日期","80"
	  t.SetField "getdate","发货日期","80"
	  t.SetField "sure","登帐","30"
	  t.SetField "chk_sure","审核","30"
	  t.SetField "sure_date","登帐日期","80"
	  t.SetField "chk_date","审核日期","80"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "sure_name","登帐人","50"
	  t.SetField "ov_date","结案日期","80"
	  t.SetField "ov_name","结案人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "backrate","换货率","30"
	  t.SetField "backdate","换货日期","80"
	  t.SetField "indentid","订单号","140"
 	  t.SetField "set_depotid","发货地","50"
      t.SetField "setdptname","发货地名称","100"
      t.SetField "cr_name","制单人","50"
	  t.SetField "cr_date","制单日期","80"
          
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="2000px"
	case "2053","2009" '加盟发货
	  
	  sql="webqry_setsell"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "sellid","流水号","140"
	  t.SetField "cwpz","状态","30"
	  t.SetField "sell","发货单号","140"
      t.SetField "get_depotid","收货地","60"
      t.SetField "getdptName","收货地名称","100"
	  t.SetField "selltype","发货类型","50"
	  t.SetField "fhnums","发货数量","50"
	  t.SetField "fhjpsums","发货金额","60"
	  t.SetField "indentsums","订金金额","60"
	  t.SetField "set_sure","登帐","30"
	  t.SetField "setsure_date","登帐日期","80"
	  t.SetField "get_sure","收货","30"
	  t.SetField "getsure_date","收货日期","80"
	  t.SetField "setchk_sure","审核","30"
	  t.SetField "setcr_name","制单人","50"
	  t.SetField "setcr_date","制单日期","80"
	  t.SetField "setchk_name","审核人","50"
	  t.SetField "setchk_date","审核日期","80"
	  t.SetField "setsure_name","登帐人","50"
	  t.SetField "set_depotid","发货地","50"
      t.SetField "setdptname","发货地名称","100"
	  t.SetField "set_comment","发货备注","80"
	  t.SetField "quotaid","配货单号","140"
      't.SetField "setdate","发货日期","80"
      't.SetField "getdate","到货日期","80"
      t.SetField "get_mchid","加盟商","50"
      t.SetField "get_comment","收货备注","80"
      t.SetField "backrate","换货率","40"
      t.SetField "backdate","换货日期","80"
      t.CSureName="setchk_sure"
      t.SureName="set_sure"
	  't.width="2150px"
	case "2054","2010" '加盟收货
	  
	  sql="webqry_getsell"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,cint(stype)+10
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "sellid","流水号","140"
	  t.SetField "sell","发货单号","140"
	  t.SetField "get_depotid","收货地","60"
	  t.SetField "getdptName","收货地名称","100"
	  t.SetField "selltype","发货类型","50"
	  t.SetField "fhnums","发货数量","50"
	  t.SetField "fhjpsums","发货金额","60"
	  t.SetField "indentsums","订金金额","60"
	  t.SetField "setdate","发货日期","80"
	  t.SetField "get_sure","收货","30"
	  t.SetField "getsure_date","登帐日期","80"
	  t.SetField "getchk_sure","审核","30"
	  't.SetField "set_sure","登帐","30" 
      t.SetField "setcr_name","制单人","50"
	  t.SetField "setcr_date","制单日期","80"
	  t.SetField "getchk_name","审核人","50"
	  t.SetField "getchk_date","审核日期","80"
	  t.SetField "set_depotid","发货地","50"
	  t.SetField "setdptname","发货地名称","100"
	  t.SetField "set_comment","发货备注","80"
	  t.SetField "quotaid","配货单号","140"
      t.SetField "get_mchid","加盟商","50"
	  t.SetField "get_comment","收货备注","80"
	  t.SetField "backrate","换货率","40"
      t.SetField "backdate","换货日期","80"
      't.SetField "getdate","到货日期","80"
      't.SetField "numrate","量扣","50"
      't.SetField "styrate","款扣","50"
      t.CSureName="getchk_sure"
      t.SureName="get_sure"
	  't.width="1900px"

	  
	case "2055" '加盟退货发货
	
	  sql="webqry_outindentset"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,cint(stype)+10
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","流水号","140"
	  t.SetField "outindent","申请单号","140"
	  t.SetField "set_depotid","发货地","100"
	  t.SetField "setdptname","发货地名称","100"
	  t.SetField "sqnums","申请数量","50"
	  t.SetField "sqjpsums","申请金额","60"
	  t.SetField "chknums","审核数量","50"
	  t.SetField "chkjpsums","审核金额","60"
	  t.SetField "setnums","发货数量","50"
	  t.SetField "setjpsums","发货金额","60"
	  t.SetField "getnums","收货数量","50"
	  t.SetField "getjpsums","收货金额","60"
	  t.SetField "prop_sure","提交","30"
	  t.SetField "ass_sure","已审核","40"
	  t.SetField "get_sure","发货","30"
	  t.SetField "sure","收货","30"
	  t.SetField "chk_sure","收货审核","50" 
      t.SetField "setdate","发货日期","80"
	  t.SetField "propdate","申请日期","80"
	  t.SetField "propName","申请人","50"
	  t.SetField "cr_name","制单人","50"
	  t.SetField "cr_date","建立日期","80"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "chk_date","审核日期","80"
      t.SetField "sure_date","收货日期","80"
      t.SetField "sure_name","收货人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "backrate","正常退货","50"
	  t.SetField "getchk_sure","发货审核","50"
	  t.SetField "getsure_date","发货日期","80"
	  t.SetField "getchk_suredate","发货审核日期","80"
	  t.SetField "getchk_name","发货审核人","65"
	  t.SetField "getsure_name","发货登帐人","65"
	  t.SetField "assName","审核人","60"
	  t.SetField "assdate","审核日期","80"
	  t.SetField "depotid","收货地","80"
	  t.SetField "getdptname","收货地名称","100"
	  't.SetField "per_date","仓库审核日期","80"
	  't.SetField "per_sure","仓库审核","30"
	  t.CSureName="getchk_sure"
      t.SureName="get_sure"
	  't.width="2700px"
	  
	case "2056" '加盟退货收货
	
	  sql="f22qry_outindentget"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","流水号","140"
	  t.SetField "outindent","申请单号","140"
	  t.SetField "set_depotid","发货地","100"
	  t.SetField "setdptname","发货地名称","100"
	  t.SetField "sqnums","申请数量","50"
	  t.SetField "sqjpsums","申请金额","60"
	  t.SetField "chknums","审核数量","50"
	  t.SetField "chkjpsums","审核金额","60"
	  t.SetField "setnums","发货数量","50"
	  t.SetField "setjpsums","发货金额","60"
	  t.SetField "getnums","收货数量","50"
	  t.SetField "getjpsums","收货金额","60"
	  t.SetField "prop_sure","提交","30"
	  t.SetField "ass_sure","已审核","40"
	  t.SetField "get_sure","发货","30"
	  t.SetField "sure","收货","30"
	  t.SetField "chk_sure","收货审核","50" 
      t.SetField "setdate","发货日期","80"
	  t.SetField "propdate","申请日期","80"
	  t.SetField "propName","申请人","50"
	  t.SetField "cr_name","制单人","50"
	  t.SetField "cr_date","建立日期","80"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "chk_date","审核日期","80"
      t.SetField "sure_date","收货日期","80"
      t.SetField "sure_name","收货人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "backrate","正常退货","50"
	  t.SetField "getchk_sure","发货审核","50"
	  t.SetField "getsure_date","发货日期","80"
	  t.SetField "getchk_suredate","发货审核日期","80"
	  t.SetField "getchk_name","发货审核人","65"
	  t.SetField "getsure_name","发货登帐人","65"
	  t.SetField "assName","审核人","60"
	  t.SetField "assdate","审核日期","80"
	  t.SetField "depotid","收货地","80"
	  t.SetField "getdptname","收货地名称","100"
	  't.SetField "per_date","仓库审核日期","80"
	  't.SetField "per_sure","仓库审核","30"
	  t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1800px"
	  
	case "2017" '调拔发货
	  
      sql="f22qry_setmove"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
      t.SetField "moveid","流水号","140"
      t.SetField "move","发货单号","140"
      t.SetField "setdepotid","发货地","50"
      t.SetField "dptname","发货地名称","100"
      t.SetField "getdepotid","收货地","50"
      t.SetField "getdptname","收货地名称","100"
      t.SetField "nums","发货数量","50"
      t.SetField "jpsums","发货金额","60"
      t.SetField "getnums","收货数量","50"
      t.SetField "getjpsums","收货金额","60"
      t.SetField "setchk_name","发货审核人","50"
      t.SetField "setcr_date","制单日期","80"
      t.SetField "setsure_name","登帐人","50"
      t.SetField "setcr_name","制单人","50"
      t.SetField "set_sure","登帐","30"
      t.SetField "setchk_sure","审核","30"
      t.SetField "setsure_date","登帐日期","80"
      t.SetField "setchk_date","审核日期","80"
      t.SetField "set_comment","发货备注","80"
      t.SetField "get_sure","收货登帐","50"
      t.SetField "getsure_date","收货登帐日期","80"
      t.SetField "get_comment","收货备注","80"
      t.CSureName="setchk_sure"
      t.SureName="set_sure"
	  't.width="1600px"
	  
	case "2018" '调拔收货
	  if session("dm").System_UserType=4 then
	    t.CommandType = 1
	    sql=" select a.moveid,a.move,a.setdepotid,a.dptname,a.getdepotid,getdptname,a.nums,a.jpsums,"& _
			" a.getnums,a.getjpsums,a.getchk_name,a.setcr_date,a.getsure_name,a.getcr_name,a.get_sure,a.getchk_sure,"& _
			" a.getsure_date,a.setsure_date,a.getchk_date,a.set_comment,a.get_comment"& _
			" from v22d_move a where a.set_sure>0 and a.getdepotid="&qts(session("dm").System_depotid)
	  else
	  sql="f22qry_getmove"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  end if
	  'de sql
	  t.SetField "moveid","流水号","140"
	  t.SetField "move","发货单号","140"
	  t.SetField "setdepotid","发货地","50"
 	  t.SetField "dptname","发货地名称","100"
	  t.SetField "getdepotid","收货地","50" 
      t.SetField "getdptname","收货地名称","100"
	  t.SetField "nums","发货数量","50"
      t.SetField "jpsums","发货金额","60"
	  t.SetField "getnums","收货数量","50"
	  t.SetField "getjpsums","收货金额","60"
	  t.SetField "getchk_name","审核人","50"
      t.SetField "setcr_date","制单日期","80"
	  t.SetField "getsure_name","登帐人","50"
	  t.SetField "getcr_name","制单人","50"
	  t.SetField "get_sure","登帐","30"
	  t.SetField "getchk_sure","审核","30"
      t.SetField "getsure_date","登帐日期","80"
	  t.SetField "setsure_date","发货登帐日期","80"
      t.SetField "getchk_date","审核日期","80"
      t.SetField "set_comment","发货备注","100"
      t.SetField "get_comment","收货备注","100"
	  
	  t.CSureName="getchk_sure"
      t.SureName="get_sure"
	  't.width="1600px"
	case "2019" '零售
	  if session("dm").System_UserType=4 then
	    t.CommandType = 1
		sql="select * from vd_retail where depotid="&qts(session("dm").System_depotid)& _
		" and setdate between "& qts(rq1) &" and "&qts(rq2)
		'de sql
	  t.SetField "retailid","流水号","140"
	  't.SetField "retail","销售单号","140"
	  t.SetField "depotid","店铺编号","50"
	  t.SetField "d_name","店铺名称","60"
 	  t.SetField "vipcode","贵宾卡号","100"
	  't.SetField "jpsums","原价金额","60"
	  't.SetField "xpsums","现价金额","60"
	  t.SetField "sums","结算金额","60"
	  t.SetField "nums","数量","50"
      t.SetField "s_sums","总收客户金额","80"
	  t.SetField "z_sums","回找客户","60"
      t.SetField "s_name","收银员","50"
	  t.SetField "x_name","售货员","50"
	  t.SetField "setdate","销售日期","80"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "sure_date","登帐日期","80"
      t.SetField "sure","登帐","30"
	  t.SetField "sure_name","登帐人","50"
	  t.SetField "chk_sure","审核","30"
	  t.SetField "cr_date","建立日期","80"
	  't.SetField "comment","备注","80"
      t.SetField "cr_date","系统建立日期","80"
	  t.SetField "cr_name","建立人","50"
      t.SetField "daystat","天气情况","100"
      t.SetField "chk_date","审核日期","80"
	  t.SetField "discount","整单折扣","50" 
          '收货备注
      t.CSureName="chk_sure"
      t.SureName="sure"
	  else
	  sql="f22qry_retail"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "retailid","流水号","140"
	  t.SetField "retail","销售单号","140"
	  t.SetField "depotid","店铺编号","50"
	  t.SetField "dptname","店铺名称","60"
 	  t.SetField "vipcode","贵宾卡号","100"
	  t.SetField "jpsums","原价金额","60"
	  t.SetField "xpsums","现价金额","60"
	  t.SetField "spsums","结算金额","60"
	  t.SetField "nums","数量","50"
      t.SetField "s_sums","总收客户金额","80"
	  t.SetField "z_sums","回找客户","60"
      t.SetField "s_name","收银员","50"
	  t.SetField "x_name","售货员","50"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "sure_date","登帐日期","80"
      t.SetField "sure","登帐","30"
	  t.SetField "sure_name","登帐人","50"
	  t.SetField "chk_sure","审核","30"
	  t.SetField "cr_date","建立日期","80"
	  t.SetField "comment","备注","80"
      t.SetField "crdate","系统建立日期","80"
	  t.SetField "cr_name","建立人","50"
      't.SetField "setdate","销售日期","80"
      t.SetField "daystat","天气情况","100"
      t.SetField "chk_date","审核日期","80"
	  t.SetField "discount","整单折扣","50" 
          '收货备注
      t.CSureName="chk_sure"
      t.SureName="sure"
	  end if
	  't.width="1900px"
	  
	case "2020" '盘点
	
	  select case ext
	  case "0"
	    sql="f22qry_inventory"
	  case "1"
	    sql="f22qry_inventorycy"
	  case else
	    Err.Raise 50001,"main.select.3-2-4","没有为SQL设置命令!"
	  end select
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "inventoryid","流水号","140"
	  t.SetField "depotid","店铺编号","60"
	  t.SetField "dptname","店铺名称","100"
	  t.SetField "nums","数量","50"
	  t.SetField "jpsums","原价金额","60"
	  t.SetField "cynums","差异数量","50"
	  t.SetField "cysums","差异金额","60"
	  t.SetField "d_type","盘点类型","50"
	  t.SetField "setdate","盘点日期","80"
	  t.SetField "sure_date","登帐日期","80" 
      t.SetField "sure","登帐","30"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "sure_name","登帐人","50"
	  t.SetField "chk_date","审核日期","80"
	  t.SetField "chk_sure","审核","30"
	  t.SetField "cr_date","建立日期","80"
	  t.SetField "comment","备注","80"
	  t.SetField "cr_name","建立人","50"
	  t.SetField "diff","建立差异","50"
	  t.SetField "inventory","盘点单号","140"
	  't.SetField "ov_date","结案日期","80"
      't.SetField "ov_sure","结案","30"
      't.SetField "ov_name","结案人","50"
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1600px"
	  
	case "2011" '正常退货申请
	  
	  sql="webqry_outindentzcsq"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","流水号","140"
	  t.SetField "outindent","申请单号","140"
	  t.SetField "set_depotid","发货地","100"
	  t.SetField "setdptname","发货地名称","100"
	  t.SetField "sqnums","申请数量","50"
	  t.SetField "sqjpsums","申请金额","60"
	  t.SetField "chknums","审核数量","50"
	  t.SetField "chkjpsums","审核金额","60"
	  t.SetField "setnums","发货数量","50"
	  t.SetField "setjpsums","发货金额","60"
	  t.SetField "getnums","收货数量","50"
	  t.SetField "getjpsums","收货金额","60"
	  t.SetField "prop_sure","提交","30"
	  t.SetField "ass_sure","已审核","40"
	  t.SetField "get_sure","发货","30"
	  t.SetField "sure","收货","30"
	  t.SetField "chk_sure","收货审核","50" 
      t.SetField "setdate","发货日期","80"
	  t.SetField "propdate","申请日期","80"
	  t.SetField "propName","申请人","50"
	  t.SetField "cr_name","制单人","50"
	  t.SetField "cr_date","建立日期","80"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "chk_date","审核日期","80"
      t.SetField "sure_date","收货日期","80"
      t.SetField "sure_name","收货人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "backrate","正常退货","50"
	  t.SetField "getchk_sure","发货审核","50"
	  t.SetField "getsure_date","发货日期","80"
	  t.SetField "getchk_suredate","发货审核日期","80"
	  t.SetField "getchk_name","发货审核人","65"
	  t.SetField "getsure_name","发货登帐人","65"
	  t.SetField "assName","审核人","60"
	  t.SetField "assdate","审核日期","80"
	  t.SetField "depotid","收货地","80"
	  t.SetField "getdptname","收货地名称","100"
	  't.CSureName="getchk_sure"
      't.SureName="get_sure"
	  t.CSureName="prop_sure"
      t.SureName="prop_sure"
	  't.width="2700px"
	case "2012" '特殊退货申请
	  
	  sql="webqry_outindenttssq"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","流水号","140"
	  t.SetField "outindent","申请单号","140"
	  t.SetField "set_depotid","发货地","100"
	  t.SetField "setdptname","发货地名称","100"
	  t.SetField "sqnums","申请数量","50"
	  t.SetField "sqjpsums","申请金额","60"
	  t.SetField "chknums","审核数量","50"
	  t.SetField "chkjpsums","审核金额","60"
	  t.SetField "setnums","发货数量","50"
	  t.SetField "setjpsums","发货金额","60"
	  t.SetField "getnums","收货数量","50"
	  t.SetField "getjpsums","收货金额","60"
	  t.SetField "prop_sure","提交","30"
	  t.SetField "ass_sure","已审核","40"
	  t.SetField "get_sure","发货","30"
	  t.SetField "sure","收货","30"
	  t.SetField "chk_sure","收货审核","50" 
      t.SetField "setdate","发货日期","80"
	  t.SetField "propdate","申请日期","80"
	  t.SetField "propName","申请人","50"
	  t.SetField "cr_name","制单人","50"
	  t.SetField "cr_date","建立日期","80"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "chk_date","审核日期","80"
      t.SetField "sure_date","收货日期","80"
      t.SetField "sure_name","收货人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "backrate","正常退货","50"
	  t.SetField "getchk_sure","发货审核","50"
	  t.SetField "getsure_date","发货日期","80"
	  t.SetField "getchk_suredate","发货审核日期","80"
	  t.SetField "getchk_name","发货审核人","65"
	  t.SetField "getsure_name","发货登帐人","65"
	  t.SetField "assName","审核人","60"
	  t.SetField "assdate","审核日期","80"
	  t.SetField "depotid","收货地","80"
	  t.SetField "getdptname","收货地名称","100"
	  t.CSureName="prop_sure"
      t.SureName="prop_sure"
	  't.width="2700px"
	case "5-1-3" '退货审核
	  
	  sql="f22qry_outindentchk"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","流水号","140"
	  t.SetField "outindent","申请单号","140"
	  t.SetField "depotid","收货地","140"
 	  t.SetField "sure","收货","50"
	  t.SetField "chk_sure","收货审核","30" 
          t.SetField "setdate","发货日期","80"
	  t.SetField "cr_name","制单人","50"
          t.SetField "cr_date","建立日期","80"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "chk_date","审核日期","80"
          t.SetField "sure_date","收货日期","80"
          t.SetField "sure_name","收货人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "backrate","正常退货","30"
	  t.SetField "per_date","仓库审核日期","80"
	  t.SetField "per_sure","仓库审核","30"
	  t.SetField "set_depotid","发货地","100"
          t.SetField "getchk_sure","收货审核","30"
          t.SetField "get_sure","发货","30"
          t.SetField "getsure_date","发货日期","80"
          t.SetField "getchk_suredate","发货审核日期","80"
          t.SetField "getchk_name","发货审核人","50"
          t.SetField "getsure_name","发货登帐人","50"
          t.SetField "assName","审核人","60"
          t.SetField "assdate","审核日期","80"
          t.SetField "ass_sure","已审核","30"
          t.SetField "propName","申请人","50"
          t.SetField "propdate","申请日期","80"
          t.SetField "prop_sure","提交","30"
          t.SetField "getdptname","收货地名称","100"
          t.SetField "setdptname","发货地名称","100"
          t.SetField "sqipsums","申请金额","60"
          t.SetField "sqnums","申请数量","50"
          t.SetField "chkipsums","审核金额","60"
          t.SetField "chknums","审核数量","50"
          t.SetField "setipsums","发货金额","60"
          t.SetField "setnums","发货数量","50"
          t.SetField "getipsums","收获金额","60"
          t.SetField "getnums","收货数量","50"
	  t.CSureName="ass_sure"
      t.SureName="ass_sure"
	  't.width="2700px"
	  
	case "2014" '退货发货
	  
	  sql="webqry_outindentset"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","流水号","140"
	  t.SetField "outindent","申请单号","140"
	  t.SetField "set_depotid","发货地","100"
	  t.SetField "setdptname","发货地名称","100"
	  t.SetField "sqnums","申请数量","50"
	  t.SetField "sqjpsums","申请金额","60"
	  t.SetField "chknums","审核数量","50"
	  t.SetField "chkjpsums","审核金额","60"
	  t.SetField "setnums","发货数量","50"
	  t.SetField "setjpsums","发货金额","60"
	  t.SetField "getnums","收货数量","50"
	  t.SetField "getjpsums","收货金额","60"
	  t.SetField "prop_sure","提交","30"
	  t.SetField "ass_sure","已审核","40"
	  t.SetField "get_sure","发货","30"
	  t.SetField "sure","收货","30"
	  t.SetField "chk_sure","收货审核","50" 
      t.SetField "setdate","发货日期","80"
	  t.SetField "propdate","申请日期","80"
	  t.SetField "propName","申请人","50"
	  t.SetField "cr_name","制单人","50"
	  t.SetField "cr_date","建立日期","80"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "chk_date","审核日期","80"
      t.SetField "sure_date","收货日期","80"
      t.SetField "sure_name","收货人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "backrate","正常退货","50"
	  t.SetField "getchk_sure","发货审核","50"
	  t.SetField "getsure_date","发货日期","80"
	  t.SetField "getchk_suredate","发货审核日期","80"
	  t.SetField "getchk_name","发货审核人","65"
	  t.SetField "getsure_name","发货登帐人","65"
	  t.SetField "assName","审核人","60"
	  t.SetField "assdate","审核日期","80"
	  t.SetField "depotid","收货地","80"
	  t.SetField "getdptname","收货地名称","100"
	  't.SetField "per_date","仓库审核日期","80"
	  't.SetField "per_sure","仓库审核","30"
	  t.CSureName="getchk_sure"
      t.SureName="get_sure"
	  't.width="2700px"
	case "5-1-5" '退货收货
	  
	  sql="f22qry_outindentget"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","流水号","140"
	  t.SetField "outindent","申请单号","140"
	  t.SetField "depotid","收货地","140"
 	  t.SetField "sure","收货","50"
	  t.SetField "chk_sure","收货审核","30" 
          t.SetField "setdate","发货日期","80"
	  t.SetField "cr_name","制单人","50"
          t.SetField "cr_date","建立日期","80"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "chk_date","审核日期","80"
          t.SetField "sure_date","收货日期","80"
          t.SetField "sure_name","收货人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "backrate","正常退货","30"
	  t.SetField "per_date","仓库审核日期","80"
	  t.SetField "per_sure","仓库审核","30"
	  t.SetField "set_depotid","发货地","100"
          t.SetField "getchk_sure","收货审核","30"
          t.SetField "get_sure","发货","30"
          t.SetField "getsure_date","发货日期","80"
          t.SetField "getchk_suredate","发货审核日期","80"
          t.SetField "getchk_name","发货审核人","50"
          t.SetField "getsure_name","发货登帐人","50"
          t.SetField "assName","审核人","60"
          t.SetField "assdate","审核日期","80"
          t.SetField "ass_sure","已审核","30"
          t.SetField "propName","申请人","50"
          t.SetField "propdate","申请日期","80"
          t.SetField "prop_sure","提交","30"
          t.SetField "getdptname","收货地名称","100"
          t.SetField "setdptname","发货地名称","100"
          t.SetField "sqipsums","申请金额","60"
          t.SetField "sqnums","申请数量","50"
          t.SetField "chkipsums","审核金额","60"
          t.SetField "chknums","审核数量","50"
          t.SetField "setipsums","发货金额","60"
          t.SetField "setnums","发货数量","50"
          t.SetField "getipsums","收获金额","60"
          t.SetField "getnums","收货数量","50"
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1800px"
	case "2060"
	  if session("dm").System_UserType=4 then
	    t.CommandType = 1
		select case ext
		case 0
		  sql="select * from v22d_indent where d_type=1 and  getdepotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select * from v22d_indent where d_type=1 and isnull(chk_sure,0)=0 and  getdepotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select * from v22d_indent where d_type=1 and isnull(chk_sure,0)>0 and  getdepotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select * from v22d_indent where d_type=1 and isnull(chk_sure,0)>0 and isnull(sure,0)=0 and  getdepotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select * from v22d_indent where d_type=1 and isnull(sure,0)>0 and  getdepotid="&qts(session("dm").System_depotid)
		end select
		
	  t.SetField "indentid","流水号","140"
	  't.SetField "phcnt","配次","30"
 	  't.SetField "fhcnt","发次","30"
	  t.SetField "getdepotid","收货地","70"
	  t.SetField "getdptname","收货地名称","80"
	  t.SetField "selltype","订货类型","60"
	  t.SetField "getdate","计划发货日期","80"
	  t.SetField "nums","订货数量","50"
	  t.SetField "sums","订货金额","60"
	  't.SetField "phnums","配货数量","50"
	  't.SetField "phjpsums","配货金额","60"
	  't.SetField "fhnums","发货数量","50"
	  't.SetField "fhjpsums","发货金额","60"
	  t.SetField "sure","登帐","30"
	  t.SetField "sure_date","登帐日期","60"
	  t.SetField "sure_name","登帐人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "setdepotid","发货地","50"
	  t.SetField "setdptname","发货地名称","80"
      t.SetField "cr_name","制单人","50"
	  t.SetField "chk_sure","审核","30"
	  t.SetField "chk_name","审核人","50"
      t.SetField "cr_date","制单日期","60"
	  t.SetField "ov_sure","结案","30"
	  t.SetField "ov_date","结案日期","60"
	  t.SetField "backrate","换货折扣","60"
	  t.SetField "backdate","换货日期","60"
	  t.SetField "indent","订单号","140"
	  end if
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1800px"
	  t.height="100%"
	case "2061"
	  if session("dm").System_UserType=4 then
	    t.CommandType = 1
		select case ext
		case 0
		  sql="select * from v22d_indent where d_type=2 and  getdepotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select * from v22d_indent where d_type=2 and isnull(chk_sure,0)=0 and  getdepotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select * from v22d_indent where d_type=2 and isnull(chk_sure,0)>0 and  getdepotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select * from v22d_indent where d_type=2 and isnull(chk_sure,0)>0 and isnull(sure,0)=0 and  getdepotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select * from v22d_indent where d_type=2 and isnull(sure,0)>0 and  getdepotid="&qts(session("dm").System_depotid)
		end select
	  t.SetField "indentid","流水号","140"
	  't.SetField "phcnt","配次","30"
 	  't.SetField "fhcnt","发次","30"
	  t.SetField "getdepotid","收货地","70"
	  t.SetField "getdptname","收货地名称","80"
	  t.SetField "selltype","订货类型","60"
	  t.SetField "getdate","计划发货日期","80"
	  t.SetField "nums","订货数量","50"
	  t.SetField "sums","订货金额","60"
	  't.SetField "phnums","配货数量","50"
	  't.SetField "phjpsums","配货金额","60"
	  't.SetField "fhnums","发货数量","50"
	  't.SetField "fhjpsums","发货金额","60"
	  t.SetField "sure","登帐","30"
	  t.SetField "sure_date","登帐日期","60"
	  t.SetField "sure_name","登帐人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "setdepotid","发货地","50"
	  t.SetField "setdptname","发货地名称","80"
      t.SetField "cr_name","制单人","50"
	  t.SetField "chk_sure","审核","30"
	  t.SetField "chk_name","审核人","50"
      t.SetField "cr_date","制单日期","60"
	  t.SetField "ov_sure","结案","30"
	  t.SetField "ov_date","结案日期","60"
	  t.SetField "backrate","换货折扣","60"
	  t.SetField "backdate","换货日期","60"
	  t.SetField "indent","订单号","140"
	  end if
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1800px"
	  t.height="100%"
	case "2062"
	    t.CommandType = 1
		select case ext
		case 0
		  sql="select * from v22d_move where  getdepotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select * from v22d_move where  isnull(getchk_sure,0)=0 and  getdepotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select * from v22d_move where  isnull(getchk_sure,0)>0 and  getdepotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select * from v22d_move where  isnull(getchk_sure,0)>0 and isnull(get_sure,0)=0 and  getdepotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select * from v22d_move where  isnull(get_sure,0)>0 and  getdepotid="&qts(session("dm").System_depotid)
		end select
	  t.SetField "moveid","流水号","140"
	  t.SetField "move","发货单号","140"
	  t.SetField "setdepotid","发货地","50"
 	  t.SetField "dptname","发货地名称","100"
	  t.SetField "getdepotid","收货地","50" 
      t.SetField "getdptname","收货地名称","100"
	  t.SetField "nums","发货数量","50"
      t.SetField "jpsums","发货金额","60"
	  t.SetField "getnums","收货数量","50"
	  t.SetField "getjpsums","收货金额","60"
	  t.SetField "getchk_name","审核人","50"
      t.SetField "setcr_date","制单日期","80"
	  t.SetField "getsure_name","登帐人","50"
	  t.SetField "getcr_name","制单人","50"
	  t.SetField "get_sure","登帐","30"
	  t.SetField "getchk_sure","审核","30"
      t.SetField "getsure_date","登帐日期","80"
	  t.SetField "setsure_date","发货登帐日期","80"
      t.SetField "getchk_date","审核日期","80"
      t.SetField "set_comment","发货备注","100"
      t.SetField "get_comment","收货备注","100"
	  
	  t.CSureName="getchk_sure"
      t.SureName="get_sure"
	case "2063" '正常申请
	    t.CommandType = 1
		dim s
		s=",(select sum(nums) from d_outindentPROsub b where a.outindentid=b.outindentid)as sqnums,"& _
			"(select sum(nums) from d_outindentCHKsub b where a.outindentid=b.outindentid)as chknums,"& _
			"(select sum(nums) from d_outindentSETsub b where a.outindentid=b.outindentid)as setnums,"& _
			"(select sum(nums) from d_outindentsub b where a.outindentid=b.outindentid)as getnums,"& _
			"(select b.d_name from j_depot b where a.set_depotid=b.depotid )as setdptname,"& _
			"(select b.d_name from j_depot b where a.depotid=b.depotid )as getdptname "
		select case ext
		case 0
		  sql="select a.* "&s&" from d_outindentpro a where set_depotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select a.* "&s&" from d_outindentpro a where  isnull(getchk_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select a.* "&s&" from d_outindentpro a where  isnull(getchk_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select a.* "&s&" from d_outindentpro a where  isnull(getchk_sure,0)>0 and isnull(get_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select a.* "&s&" from d_outindentpro a where  isnull(get_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		end select
	  t.SetField "outindentid","流水号","140"
	  't.SetField "outindent","申请单号","140"
	  t.SetField "set_depotid","发货地","100"
	  t.SetField "setdptname","发货地名称","100"
	  t.SetField "sqnums","申请数量","50"
	  't.SetField "sqjpsums","申请金额","60"
	  t.SetField "chknums","审核数量","50"
	  't.SetField "chkjpsums","审核金额","60"
	  t.SetField "setnums","发货数量","50"
	  't.SetField "setjpsums","发货金额","60"
	  t.SetField "getnums","收货数量","50"
	  't.SetField "getjpsums","收货金额","60"
	  t.SetField "prop_sure","提交","30"
	  t.SetField "ass_sure","已审核","40"
	  t.SetField "get_sure","发货","30"
	  t.SetField "sure","收货","30"
	  t.SetField "chk_sure","收货审核","50" 
      t.SetField "setdate","发货日期","80"
	  t.SetField "propdate","申请日期","80"
	  t.SetField "propName","申请人","50"
	  t.SetField "cr_name","制单人","50"
	  t.SetField "cr_date","建立日期","80"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "chk_date","审核日期","80"
      t.SetField "sure_date","收货日期","80"
      t.SetField "sure_name","收货人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "backrate","正常退货","50"
	  t.SetField "getchk_sure","发货审核","50"
	  t.SetField "getsure_date","发货日期","80"
	  t.SetField "getchk_suredate","发货审核日期","80"
	  t.SetField "getchk_name","发货审核人","65"
	  t.SetField "getsure_name","发货登帐人","65"
	  t.SetField "assName","审核人","60"
	  t.SetField "assdate","审核日期","80"
	  t.SetField "depotid","收货地","80"
	  t.SetField "getdptname","收货地名称","100"
	  't.CSureName="getchk_sure"
      't.SureName="get_sure"
	  t.CSureName="prop_sure"
      t.SureName="prop_sure"
	case "2064" '特殊申请
	    t.CommandType = 1
		s=",(select sum(nums) from d_outindentPROsub b where a.outindentid=b.outindentid)as sqnums,"& _
			"(select sum(nums) from d_outindentCHKsub b where a.outindentid=b.outindentid)as chknums,"& _
			"(select sum(nums) from d_outindentSETsub b where a.outindentid=b.outindentid)as setnums,"& _
			"(select sum(nums) from d_outindentsub b where a.outindentid=b.outindentid)as getnums,"& _
			"(select b.d_name from j_depot b where a.set_depotid=b.depotid )as setdptname,"& _
			"(select b.d_name from j_depot b where a.depotid=b.depotid )as getdptname "
		select case ext
		case 0
		  sql="select a.* "&s&" from d_outindent a where set_depotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select a.* "&s&" from d_outindent a where  isnull(getchk_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select a.* "&s&" from d_outindent a where  isnull(getchk_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select a.* "&s&" from d_outindent a where  isnull(getchk_sure,0)>0 and isnull(get_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select a.* "&s&" from d_outindent a where  isnull(get_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		end select
	  t.SetField "outindentid","流水号","140"
	  't.SetField "outindent","申请单号","140"
	  t.SetField "set_depotid","发货地","100"
	  t.SetField "setdptname","发货地名称","100"
	  t.SetField "sqnums","申请数量","50"
	  't.SetField "sqjpsums","申请金额","60"
	  t.SetField "chknums","审核数量","50"
	  't.SetField "chkjpsums","审核金额","60"
	  t.SetField "setnums","发货数量","50"
	  't.SetField "setjpsums","发货金额","60"
	  t.SetField "getnums","收货数量","50"
	  't.SetField "getjpsums","收货金额","60"
	  t.SetField "prop_sure","提交","30"
	  t.SetField "ass_sure","已审核","40"
	  t.SetField "get_sure","发货","30"
	  t.SetField "sure","收货","30"
	  t.SetField "chk_sure","收货审核","50" 
      t.SetField "setdate","发货日期","80"
	  t.SetField "propdate","申请日期","80"
	  t.SetField "propName","申请人","50"
	  t.SetField "cr_name","制单人","50"
	  t.SetField "cr_date","建立日期","80"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "chk_date","审核日期","80"
      t.SetField "sure_date","收货日期","80"
      t.SetField "sure_name","收货人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "backrate","正常退货","50"
	  t.SetField "getchk_sure","发货审核","50"
	  t.SetField "getsure_date","发货日期","80"
	  t.SetField "getchk_suredate","发货审核日期","80"
	  t.SetField "getchk_name","发货审核人","65"
	  t.SetField "getsure_name","发货登帐人","65"
	  t.SetField "assName","审核人","60"
	  t.SetField "assdate","审核日期","80"
	  t.SetField "depotid","收货地","80"
	  t.SetField "getdptname","收货地名称","100"
	  't.CSureName="getchk_sure"
      't.SureName="get_sure"
	  t.CSureName="prop_sure"
      t.SureName="prop_sure"
	case "2065" '退货发货
	    t.CommandType = 1
		s=",(select sum(nums) from d_outindentPROsub b where a.outindentid=b.outindentid)as sqnums,"& _
			"(select sum(nums) from d_outindentCHKsub b where a.outindentid=b.outindentid)as chknums,"& _
			"(select sum(nums) from d_outindentSETsub b where a.outindentid=b.outindentid)as setnums,"& _
			"(select sum(nums) from d_outindentsub b where a.outindentid=b.outindentid)as getnums,"& _
			"(select b.d_name from j_depot b where a.set_depotid=b.depotid )as setdptname,"& _
			"(select b.d_name from j_depot b where a.depotid=b.depotid )as getdptname "
		select case ext
		case 0
		  sql="select a.* "&s&" from d_outindent a where set_depotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select a.* "&s&" from d_outindent a where  isnull(getchk_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select a.* "&s&" from d_outindent a where  isnull(getchk_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select a.* "&s&" from d_outindent a where  isnull(getchk_sure,0)>0 and isnull(get_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select a.* "&s&" from d_outindent a where  isnull(get_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		end select
	  t.SetField "outindentid","流水号","140"
	  't.SetField "outindent","申请单号","140"
	  t.SetField "set_depotid","发货地","100"
	  t.SetField "setdptname","发货地名称","100"
	  t.SetField "sqnums","申请数量","50"
	  't.SetField "sqjpsums","申请金额","60"
	  t.SetField "chknums","审核数量","50"
	  't.SetField "chkjpsums","审核金额","60"
	  t.SetField "setnums","发货数量","50"
	  't.SetField "setjpsums","发货金额","60"
	  t.SetField "getnums","收货数量","50"
	  't.SetField "getjpsums","收货金额","60"
	  t.SetField "prop_sure","提交","30"
	  t.SetField "ass_sure","已审核","40"
	  t.SetField "get_sure","发货","30"
	  t.SetField "sure","收货","30"
	  t.SetField "chk_sure","收货审核","50" 
      t.SetField "setdate","发货日期","80"
	  t.SetField "propdate","申请日期","80"
	  t.SetField "propName","申请人","50"
	  t.SetField "cr_name","制单人","50"
	  t.SetField "cr_date","建立日期","80"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "chk_date","审核日期","80"
      t.SetField "sure_date","收货日期","80"
      t.SetField "sure_name","收货人","50"
	  t.SetField "comment","备注","80"
	  t.SetField "backrate","正常退货","50"
	  t.SetField "getchk_sure","发货审核","50"
	  t.SetField "getsure_date","发货日期","80"
	  t.SetField "getchk_suredate","发货审核日期","80"
	  t.SetField "getchk_name","发货审核人","65"
	  t.SetField "getsure_name","发货登帐人","65"
	  t.SetField "assName","审核人","60"
	  t.SetField "assdate","审核日期","80"
	  t.SetField "depotid","收货地","80"
	  t.SetField "getdptname","收货地名称","100"
	  't.CSureName="getchk_sure"
      't.SureName="get_sure"
	  t.CSureName="chk_sure"
      t.SureName="sure"
	case "2066" 'POS盘点
	  t.CommandType = 1
	  select case ext
	  case "0"
	    'sql="f22qry_inventory"
	sql="SELECT TOP 100 PERCENT d_inventory.inventoryid,"& _
		 "MAX(d_inventory.inventory) AS inventory,"& _
		 "MAX(d_inventory.depotid) AS depotid, "& _
		 "MAX(j_depot.d_name) AS d_name,"& _
		 "MAX(d_inventory.setdate) AS setdate, "& _
		 "MAX(d_inventory.d_type) AS d_type,"& _
		 "MAX(d_inventory.sure_name) AS sure_name,"& _
		 "MAX(d_inventory.ov_date) AS ov_date, "& _
		 "MAX(d_inventory.ov_sure) AS ov_sure,"& _
		 "MAX(d_inventory.ov_name) AS ov_name, "& _
		 "MAX(d_inventory.sure) AS sure, "& _
		 "MAX(d_inventory.chk_sure) AS chk_sure, "& _
		 "MAX(d_inventory.cr_date) AS cr_date, "& _
		 "MAX(d_inventory.cr_name) AS cr_name,"& _
		 "MAX(d_inventory.chk_name) AS chk_name, "& _
		 "MAX(d_inventory.chk_date) AS chk_date, "& _
		 "MAX(d_inventory.sure_date) AS sure_date,"& _
		 "MAX(d_inventory.comment) AS comment, MAX(d_inventory.crdate) AS crdate,"& _
		 "SUM(d_inventorysub.nums) AS nums,"& _
		 "SUM(ISNULL(d_inventorysub.s_price,0) * ISNULL(d_inventorysub.nums, 0)) AS SumS,"& _
		 "MIN(d_inventory.diff) AS diff"& _
		 "FROM d_inventory LEFT OUTER JOIN"& _
		 "j_depot ON d_inventory.depotid = j_depot.depotid LEFT OUTER JOIN"& _
		 "d_inventorysub ON"& _
		 "d_inventory.inventoryid = d_inventorysub.inventoryid"& _
		 "GROUP BY d_inventory.inventoryid "

	  case "1"
	    sql="f22qry_inventorycy"
	 sql="SELECT TOP 100 PERCENT d_inventory.inventoryid,"& _
		 "MAX(d_inventory.inventory) AS inventory,"& _
		 "MAX(d_inventory.depotid) AS depotid, "& _
		 "MAX(j_depot.d_name) AS dptname,"& _
		 "MAX(d_inventory.setdate) AS setdate, "& _
		 "MAX(d_inventory.d_type) AS d_type,"& _
		 "MAX(d_inventory.sure_name) AS sure_name,"& _
		 "MAX(d_inventory.ov_date) AS ov_date, "& _
		 "MAX(d_inventory.ov_sure) AS ov_sure,"& _
		 "MAX(d_inventory.ov_name) AS ov_name, "& _
		 "MAX(d_inventory.sure) AS sure, "& _
		 "MAX(d_inventory.chk_sure) AS chk_sure, "& _
		 "MAX(d_inventory.cr_date) AS cr_date, "& _
		 "MAX(d_inventory.cr_name) AS cr_name,"& _
		 "MAX(d_inventory.chk_name) AS chk_name, "& _
		 "MAX(d_inventory.chk_date) AS chk_date, "& _
		 "MAX(d_inventory.sure_date) AS sure_date,"& _
		 "MAX(d_inventory.comment) AS comment, MAX(d_inventory.crdate) AS crdate,"& _
		 "SUM(d_inventorysub.nums) AS nums,"& _
		 "SUM(ISNULL(d_inventorysub.s_price,0) * ISNULL(d_inventorysub.nums, 0)) AS sums,"& _
		 "SUM(ISNULL(d_inventorysub.d_nums,0)) AS cynums,"& _
		 "SUM(ISNULL(d_inventorysub.s_price,0) * ISNULL(d_inventorysub.d_nums, 0)) AS cysums,"& _
		 "MIN(d_inventory.diff) AS diff "& _
		 " FROM d_inventory LEFT OUTER JOIN"& _
		 " j_depot ON d_inventory.depotid = j_depot.depotid LEFT OUTER JOIN"& _
		 " d_inventorysub ON"& _
		 " d_inventory.inventoryid = d_inventorysub.inventoryid "& _
		 " JOIN j_style ON d_inventorysub.styleid=j_style.styleid "& _
		 " GROUP BY d_inventory.inventoryid "
	  case else
	    Err.Raise 50001,"main.select.3-2-4","没有为SQL设置命令!"
	  end select
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "inventoryid","流水号","140"
	  t.SetField "depotid","店铺编号","60"
	  t.SetField "dptname","店铺名称","100"
	  t.SetField "nums","数量","50"
	  t.SetField "Sums","原价金额","60"
	  t.SetField "cynums","差异数量","50"
	  t.SetField "cysums","差异金额","60"
	  t.SetField "d_type","盘点类型","50"
	  t.SetField "setdate","盘点日期","80"
	  t.SetField "sure_date","登帐日期","80" 
      t.SetField "sure","登帐","30"
	  t.SetField "chk_name","审核人","50"
	  t.SetField "sure_name","登帐人","50"
	  t.SetField "chk_date","审核日期","80"
	  t.SetField "chk_sure","审核","30"
	  t.SetField "cr_date","建立日期","80"
	  t.SetField "comment","备注","80"
	  t.SetField "cr_name","建立人","50"
	  t.SetField "diff","建立差异","50"
	  t.SetField "inventory","盘点单号","140"
	  't.SetField "ov_date","结案日期","80"
      't.SetField "ov_sure","结案","30"
      't.SetField "ov_name","结案人","50"
      t.CSureName="chk_sure"
      t.SureName="sure"
	case else  
      Err.Raise 50001,"main.select.else","没有为com设置命令!"
  end select
  
  t.CommandText=sql
  t.Show
  set t=Nothing
else%>
  <div id="gt1" style="width:100%;height:100%">
  <table><thead><tr>
  <th width="140">流水号</th>
  <th width="140">发货单号</th>
  <th width="50">发货地</th>
  <th width="100">发货地名称</th>
  <th width="50">收货地</th>
  <th width="100">收货地名称</th>
  <th width="50">数量</th>
  <th width="60">金额</th>
  </tr></thead></table>
<%end if%>
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><input type="hidden" name="te" value=""/></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td>&nbsp;</td>
  </tr>
</table>
</div>
  <script language="javascript">
    try{
	 gt = new GtEditTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
<form name="formtmp" method="post" action=""></form>
</body>
</html>
<!--#include file="inc/foot.asp" -->