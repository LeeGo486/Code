<%option explicit
Dim exportExcel
exportExcel = trim(request.QueryString("ExportExcel"))
if exportExcel="1" then
response.ContentType ="application/vnd.ms-excel"
response.AddHeader "content-disposition", "attachment; filename=零售单.xls" 
end if

%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/class.asp"-->

<%if exportExcel<>"1" then%>
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
	
	parent.document.getElementById("retailidText").innerHTML=id
	
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
	showModalDialog('f22_mx.asp?id='+id+'&pksname=<%=session("pksname")%>&ext=<%=ext%>','e','dialogWidth:100;dialogHeight:100;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

  function gtDoEnter(t){}
</SCRIPT>

</head>

<body>
<% end if %>

<%
dim rs,rs1,ext,sql,sql1,t,rq1,rq2,stype,userid,tmp,typ,ss,seachid,qrydaytj,idorsn,crname,ActPlanID
Call getParam '取得传入的参数
seachid = trim(request.QueryString("seachid"))
ext = trim(request.QueryString("ext"))
rq1 = trim(request.querystring("rq1"))
rq2 = trim(request.querystring("rq2"))
ActPlanID = trim(request.querystring("ActPlanID"))

if rq1="" then rq1=get_date(date) end if
if rq2="" then rq2=get_date(date) end if
typ=request("stype")
idorsn=trim(request.QueryString("idorsn"))
crname=trim(request.QueryString("crname"))


'控制查询天数
if session("QryDay")>0 and typ=0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","a.cr_date")
elseif session("QryDay")>0 then 
   qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
end if
if typ=0 then 
   ss=" and convert(char(10),a.cr_date,126) between '"&rq1&"' and '"&rq2&"' "
else
   ss=" and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' " 
end if
if ext="" then
  ext=1
else
  ext = cint(ext)
end if
'de rq1
set t = new Table
  t.ActiveConnection =cn
  if seachid=""  then
   sql="select a.retailid,a.depotid,b.d_name,isnull((select sum(nums*x_price) from d_retailsub where d_retailsub.retailid=a.retailid)-(select sum(FSSums) from d_retailsub where d_retailsub.retailid=a.retailid),0 )as cx_price,a.dk_price,a.vipcode,a.s_name,a.x_name,"&_
	 "a.setdate,a.chk_sure,a.sure,a.chk_date,a.chk_name,a.FCalcSums,"&_
       "a.sure_date,a.sure_name,a.cr_date,a.cr_name,a.comment,a.daystat,a.discount,"&_
	   "(select sum(nums) from d_retailsub where d_retailsub.retailid=a.retailid) as nums,"&_
	   "(select sum(nums*x_price) from d_retailsub where d_retailsub.retailid=a.retailid) as xsums,"&_
	   "(SELECT PlanTitle FROM D_MarketActPlan WHERE ActPlanID=a.ActPlanID) as PlanTitle,"&_
	  "a.zssums as sums ,a.shopcardid,"&_
		 "(isnull(a.zssums,0) - isnull(cx_price,0) - isnull(dk_price,0)) as ss_price,"&_
	   "case when isnull(a.dtype,0)=0 then '正常' else case when isnull(a.dtype,0)=1 then '礼物' else '换购' end end as dtype, "&_
	   "dbo.FUN_GetEmployeeName(a.retailid) as Employee,vipcodejm=case when vipcode<>'' then '*****' else '' end "&_
        ",case a.isbirth when 1 then '是' else '否' end as isbirth,a.ReasonType,a.Reason,case a.ifnewvip when 1 then '是' else '否' end as ifnewvip,a.channel,case when ISNULL(a.vipcode,'')<>'' then case a.nocentum when 1 then '否' else '是' end ELSE '否' END as nocentum,case a.vipdisc when 1 then '是' else '否' end as vipdisc"&_
	   " from d_retail a,j_depot b where a.depotid=b.depotid and a.depotid="&qts(session("dm").System_depotid)&ss&qrydaytj
	select case ext
	case 0

	case 1
		sql=sql&" and isnull(a.chk_sure,0)=0 "
	case 2
		sql=sql&" and isnull(a.chk_sure,0)>0 and isnull(a.sure,0)=0 "
	case 3
		sql=sql&" and isnull(a.sure,0)>0 "
	case 4
	  sql=sql&" and isnull(sure,0)=0 "
	end select

    if ActPlanID <> "全部" then
          sql =sql &" and isnull(ActPlanID,'')='"&ActPlanID&"' "
    end if

	sql=sql&" order by a.retailid"
 else
 '判断输入的是Id还是操作员名称

sql1="select username from f18master..sys_f22user where userid='"&seachid&"'" 
set cn=server.CreateObject("adodb.connection")
cn.open session("cn")
set rs1=cn.execute(sql1) 
if rs1.eof then 
seachid=seachid
else 
seachid=rs1("username")
 end if
cn.close
if cn.state=0 then
end if
set cn=nothing

   sql="select a.retailid,a.depotid,b.d_name,isnull((select sum(nums*x_price) from d_retailsub where d_retailsub.retailid=a.retailid)-(select sum(FSSums) from d_retailsub where d_retailsub.retailid=a.retailid),0 )as cx_price,a.dk_price,a.vipcode,a.s_name,a.x_name,"&_
        "a.setdate,a.chk_sure,a.sure,a.chk_date,a.chk_name,a.FCalcSums,"&_
        "a.sure_date,a.sure_name,a.cr_date,a.cr_name,a.comment,a.daystat,a.discount,"&_
        "(select sum(nums) from d_retailsub where d_retailsub.retailid=a.retailid) as nums,"&_
        "(select sum(nums*x_price) from d_retailsub where d_retailsub.retailid=a.retailid) as xsums,"&_
	   "(SELECT PlanTitle FROM D_MarketActPlan WHERE ActPlanID=a.ActPlanID) as PlanTitle,"&_
        "a.zssums as sums,a.shopcardid,"&_
        "(isnull(a.zssums,0) - isnull(cx_price,0) - isnull(dk_price,0)) as ss_price,"&_
        "case when isnull(a.dtype,0)=0 then '正常' else case when isnull(a.dtype,0)=1 then '礼物' else '换购' end end as dtype, "&_
        "dbo.FUN_GetEmployeeName(a.retailid) as Employee,vipcodejm=case when vipcode<>'' then '*****' else '' end "&_
        ",case a.isbirth when 1 then '是' else '否' end as isbirth,a.ReasonType,a.Reason,case a.ifnewvip when 1 then '是' else '否' end as ifnewvip,a.channel,case when ISNULL(a.vipcode,'')<>'' then case a.nocentum when 1 then '否' else '是' end ELSE '否' END as nocentum,case a.vipdisc when 1 then '是' else '否' end as vipdisc"&_
        " from d_retail a,j_depot b where a.depotid=b.depotid and a.depotid="&qts(session("dm").System_depotid)
	 select case idorsn 
	 case 0 sql=sql&" and a.retailid="&qts(seachid)

	 case 1
		sql=sql&" and a.s_name="&qts(seachid)&ss

	 case 2
		sql=sql&" and dbo.FUN_GetEmployeeName(a.retailid) like '%"&seachid&"%'"&ss
	end select
	  
 end if
	  'de sql
	  t.SetField "retailid","流水号","140",2
	  t.SetField "dtype","类型","30",0
	  t.SetField "depotid","店铺编号","60",2
	  t.SetField "d_name","店铺名称","80",2
	  t.SetField "setdate","销售日期","90",2
	  t.SetField "nums","数量","50",1
	  t.SetField "xsums","现价金额","60",1
	  t.SetField "sums","结算金额","60",1
	  t.SetField "FCalcSums","实销金额","50",1
	  t.SetField "cx_price","优惠金额","50",1
	  t.SetField "dk_price","积分抵扣","50",1
	  t.SetField "ss_price","实收金额","50",1
	  
      if session("pos_vipshow")=true then
	    t.SetField "vipcodejm","VIP卡号","100",2
	  else
	    t.SetField "vipcode","VIP卡号","100",2
	  end if
	  
	  t.SetField "vipdisc","VIP是否打折","80",2
	  t.SetField "nocentum","VIP是否积分","80",2
	  t.SetField "ifnewvip","是否新V消费","80",2
	  t.SetField "shopcardid","优惠卡","80",2
      t.SetField "s_name","操作员","50",2
	  t.SetField "Employee","营业员","50",2
	  t.SetField "x_name","班组","50",2
	  t.SetField "chk_sure","审核","30",2
	  t.SetField "sure","登帐","30",2
	  t.SetField "chk_name","审核人","50",2
	  t.SetField "chk_date","审核日期","80",2
	  t.SetField "sure_date","登帐日期","80",2
	  t.SetField "sure_name","登帐人","50",2
	  t.SetField "cr_date","制单日期","80",2
      t.SetField "cr_name","制单人","50",2
	  t.SetField "comment","备注","80",2
      t.SetField "daystat","天气情况","100",2
	  t.SetField "discount","整单折扣","50",2
	  t.SetField "isbirth","是否生日优惠","100",2
	  t.SetField "ReasonType","打折/退货类别","100",2
	  t.SetField "Reason","打折/退货自定义原因","100",2
	  t.SetField "channel","成交渠道","100",2
	  t.SetField "PlanTitle","商场活动内容","120",2
      t.CSureName="chk_sure"
      t.SureName="sure"
  
t.CommandText = sql
t.Show
set rs = nothing
set t = nothing
%>

</body>
</html>