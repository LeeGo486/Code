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
function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	showModalDialog('f22_mx.asp?id='+id+'&formid=2071&pksname=<%=session("pksname")%>&ext=<%=ext%>','e','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

  function gtDoEnter(t){}
</SCRIPT>

</head>

<body>
<%
dim rs,sql,t,ext,id
id=trim(request.QueryString("id"))

'de rq1
set t = new Table
  t.ActiveConnection =cn
  t.CommandType=1
  dim s
  sql="select a.msellid,a.selltype,a.set_depotid,a.get_depotid,a.setchk_sure,a.set_sure,a.setchk_name,a.setchk_date,a.setsure_date,a.setsure_name,"&_
		    "(select sum(b.set_nums) from d_msellsub b where a.msellid=b.msellid) as nums,"& _
			"(select sum(c.set_nums*c.s_price1) from d_msellsub c where a.msellid=c.msellid) as sums,"& _
			"(select d.d_name from j_depot d where a.set_depotid=d.depotid ) as setdptname,"& _
			"(select e.d_name from j_depot e where a.get_depotid=e.depotid ) as getdptname, "&_
			"a.setdate,a.set_comment,a.setcr_date,a.setcr_name,"&_
			" a.noticeid,a.get_sure,a.fmscash,a.fmsinfo, "&_
			" case when isnull(a.fmstype,0)=1 then '寄付' else  case when isnull(a.fmstype,0)=2 then '到付' else '' end  end as fmstyp "&_
			" from d_msell a "&_
			" where isnull(a.noticeid,'')!='' and a.noticeid="&qts(id)


			t.SetField "msellid","流水号","140",2
			t.SetField "selltype","调货类型","80",2
			t.SetField "set_depotid","发货地","60",2
			t.SetField "setdptname","发货地名称","150",2
			t.SetField "get_depotid","收货地","60",2
			t.SetField "getdptname","收货地名称","150",2
			t.SetField "nums","发货数量","50",1
			if psprice then  t.SetField "sums","发货金额","50",1
			
			
			
			'新加 2009-02-17 start
			t.SetField "fmscash","运费","50",1
			t.SetField "fmstyp","付款方式","50",2
			t.SetField "fmsinfo","货运信息","150",2
			'新加 2009-02-17 end
			t.SetField "setchk_sure","审核","30",2
			t.SetField "set_sure","登帐","30",2
			t.SetField "get_sure","收货登帐","50",2
			t.SetField "setchk_name","审核人","50",2
			t.SetField "setchk_date","审核日期","80",2
			t.SetField "setsure_date","登帐日期","80",2
			t.SetField "setsure_name","登帐人","50",2
			t.SetField "setcr_name","制单人","50",2
			t.SetField "setcr_date","制单日期","80",2
			t.SetField "set_comment","备注","140",2
			t.SetField "noticeid","通知单号","80",2
			t.CSureName="setchk_sure"
			t.SureName="set_sure"
	  
t.CommandText = sql
t.Show
set rs = nothing
set t = nothing
%>

</body>
</html>
