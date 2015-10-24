<!--#include file="../../f22/inc/function.asp"-->
<!--#include file="../report/inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>查询券</title>
<link href="../report/css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../report/inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../report/inc/gridtable.js"></SCRIPT>
<script type="text/javascript" src="../../inc/js/setday.js"></script>
</head>

<body>
<%act=request("act")
depotid=trim(session("dm").system_depotid)
begdate=request("rq1")
enddate=request("rq2")
if begdate="" then begdate=get_date(date()) end if
if enddate="" then enddate=get_date(date()) end if%>
<table width="100%"  border="0" cellpadding="0" cellspacing="1" class="bar">
<form action="?" method="post" name="form1">
    <tr>
      <td>
        <input type="radio" name="act" value="0" onClick="document.form1.submit()" <%if act=0 then response.write("checked") end if%>>按签收日期
        <input type="radio" name="act" value="1" onClick="document.form1.submit()" <%if act=1 then response.write("checked") end if%>>按发放日期
		<input type="radio" name="act" value="2" onClick="document.form1.submit()" <%if act=2 then response.write("checked") end if%>>按回收日期
		<input name="rq1" type="text" id="rq1" size="11" maxlength="10" value="<%=begdate%>" onFocus="setday(this);" readonly>
        <input name="rq2" type="text" id="rq2" size="11" maxlength="10" value="<%=enddate%>" onFocus="setday(this);" readonly>
		<input type="submit" name="submit" value=" 查 询 ">
		</td>
    </tr>
</form>
</table>
<%select case act
case 0 tj=" and a.signsure>0 and convert(char(10),a.signdate,126) between '"&begdate&"' and '"&enddate&"' and a.setdepotid='"&depotid&"' "
case 1 tj=" and a.sellsure>0 and convert(char(10),a.selldate,126) between '"&begdate&"' and '"&enddate&"' and a.setdepotid='"&depotid&"' "
case 2 tj=" and a.getsure>0 and convert(char(10),a.getdate,126) between '"&begdate&"' and '"&enddate&"' and getdepotid='"&depotid&"' "
end select
sql="select a.ticket,a.ticketid,a.tckname,b.tictypename,"&_
    "case when a.dtype=0 then '所有用户' else case when dtype=1 then '普通用户' else 'VIP用户' end end as dtype,"&_
    "case when a.ttype=0 then '抵值券' else '现金券' end ttype,a.sums,a.sellsums,a.fbegdate,a.fenddate,"&_
    "case when a.acttype=0 then '按有效天数' else case when acttype=1 then '按截止日期' else '按日期段' end end acttype,"&_
    "a.days,a.closedate,a.begdate,a.enddate,a.setdepotid,c.d_name as setdptname,a.signsure,a.signdate,a.signname,"&_
	"a.sellsure,a.selldate,a.sellname,a.getsure,a.getdate,a.getname "&_
	"from vip_ticket a inner join vip_tictype b on a.tictypeid=b.tictypeid left join j_depot c on a.setdepotid=c.depotid "&_
	"where a.freeze=0 "&tj&" order by a.ticket"
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
t.SetField "ticket","券流水号","120",3
t.SetField "ticketid","券号","120",3
t.SetField "tckname","券名称","80",0
t.SetField "tictypename","券类型","60",4
t.SetField "dtype","使用范围","60",4
t.SetField "ttype","券种类","60",4
t.SetField "sums","面值金额","50",1
t.SetField "sellsums","购买金额","50",1
t.SetField "fbegdate","发放开始日期","80",4
t.SetField "fenddate","发放结束日期","80",4
t.SetField "acttype","生效方式","70",4
t.SetField "days","有效天数","50",4
t.SetField "closedate","截止日期","60",4
t.SetField "begdate","生效日期","60",4
t.SetField "enddate","失效日期","60",4
t.SetField "setdepotid","发放店铺","50",4
t.SetField "setdptname","发放店铺名称","80",4
t.SetField "signsure","签收","30",4
t.SetField "signdate","签收日期","80",4
t.SetField "signname","签收人","50",4
t.SetField "sellsure","发放","30",4
t.SetField "selldate","发放日期","80",4
t.SetField "sellname","发放人","50",4
t.SetField "getsure","回收","30",4
t.SetField "getdate","回收日期","80",4
t.SetField "getname","回收人","50",4
t.height="95%"
t.show
set t=nothing
%>
</body>
</html>
<script language="javascript">
try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>