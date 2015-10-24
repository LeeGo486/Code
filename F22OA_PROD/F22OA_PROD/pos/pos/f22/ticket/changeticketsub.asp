<!--#include file="../../f22/inc/function.asp"-->
<!--#include file="../report/inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>积分兑换券</title>
<link href="../report/css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../report/inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../report/inc/gridtable.js"></SCRIPT>
<script src="../../../../jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="../../../../b28web/Retail/Scripts/VipIdentify.js" type="text/javascript"></script>
<script src="../../../../b28web/Utility/jquery.blockUI.js" type="text/javascript"></script>
</head>

<body>
<%
act=request("act")
if act=""  then  act=0  
vipcode=trim(request("vipcode"))
'截取
if request.cookies("vipflash")("cut")=1 and trim(request("id"))="" then
   vipcode=mid(vipcode,request.cookies("vipflash")("beg"),request.cookies("vipflash")("cnt"))
end if
%>
<table width="100%"  border="0" cellpadding="0" cellspacing="1" class="bar">
<form action="?" method="post" name="form1">
<input type="hidden" name="vipcode" value="<%=vipcode%>">
    <tr>
      <td>
        <label><input type="radio" name="act" value="0" 
        onClick="document.form1.submit()" <%if act=0 then response.write("checked") end if%>>顾客档案</label>
        <label><input type="radio" name="act" value="1" 
        onClick="document.form1.submit()" <%if act=1 then response.write("checked") end if%>>未使用的兑换券</label>
        <label><input type="radio" name="act" value="2" 
        onClick="document.form1.submit()" <%if act=2 then response.write("checked") end if%>>已使用的兑换券</label>
        </td>
    </tr>
</form>
</table>
<%set rs=server.CreateObject("adodb.recordset")
select case act
case 0 call vipda()
case 1 call ticketw()
case 2 call ticketo()
end select
set rs=nothing

sub vipda()
sql="select ISNULL(a.VerifyMsg,0) VerifyMsg,a.vipid,vipcodejm='*****',a.vipcode,a.vipname,a.vipsex,a.vipbirth,a.mobtel,isnull(a.centum,0)+isnull(b.starcentum,0) as centum ,isnull(a.pcentum,0) as pcentum "&_
    "from vip_user a,vip_cardvip b where a.vipcode=b.vipcardid and a.vipcode='"&vipcode&"' "&_ 
    "and convert(char(10),b.vipemit+isnull(b.limitday,0),126)>=convert(char(10),getdate(),126) "&_
    "and convert(char(10),isnull(b.viplastdate,getdate())+isnull(b.maxday,0),126)>=convert(char(10),getdate(),126)"
rs.open sql,cn
if rs.eof then
   ebox(vipcode&"不存在或未发放或已过期！")
else
   vipid=rs("vipid")
   VerifyMsg =rs("VerifyMsg")
end if
rs.close

set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
t.SetField "vipid","顾客编号","140",3
t.SetField "vipname","顾客姓名","60",0
if  session("pos_vipshow")=true then 
  t.SetField "vipcodejm","VIP卡","80",4
else
  t.SetField "vipcode","VIP卡","80",4
end  if 
t.SetField "vipsex","性别","30",4
t.SetField "vipbirth","生日","60",4
't.SetField "mobtel","手机","80",4
t.SetField "centum","总积分","80",4
t.SetField "pcentum","上季积分","80",4
t.height="30%"
t.show
set t=nothing%>
<iframe name="is" id="is" width="100%" height="62%" frameborder="0" src="changeticketsub1.asp?vipid=<%=vipid%>&VerifyMsg=<%=VerifyMsg %>"></iframe>
<%end sub

sub ticketw()
sql="select a.ticketid,a.tckname,b.tictypename,"&_
    "case when a.dtype=0 then '所有用户' else case when dtype=1 then '普通用户' else 'VIP用户' end end as dtype,"&_
    "case when a.ttype=0 then '抵值券' else '现金券' end ttype,a.sums,a.sellsums,a.fbegdate,a.fenddate,"&_
    "case when a.acttype=0 then '按有效天数' else case when acttype=1 then '按截止日期' else '按日期段' end end acttype,"&_
    "a.days,a.closedate,a.begdate,a.enddate,a.setdepotid,c.d_name as setdptname,a.selldate,a.sellname,a.vipid "&_
	"from vip_ticket a inner join vip_tictype b on a.tictypeid=b.tictypeid left join j_depot c on a.setdepotid=c.depotid "&_
	"inner join vip_user d on a.vipid=d.vipid "&_
	"where a.freeze=0 and a.sellsure>0 and a.getsure=0 and d.vipcode='"&vipcode&"' order by a.ticketid"
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
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
t.SetField "selldate","发放日期","80",4
t.SetField "sellname","发放人","50",4
t.height="92%"
t.show
set t=nothing
end sub

sub ticketo()
sql="select a.ticketid,a.tckname,b.tictypename,"&_
    "case when a.dtype=0 then '所有用户' else case when dtype=1 then '普通用户' else 'VIP用户' end end as dtype,"&_
    "case when a.ttype=0 then '抵值券' else '现金券' end ttype,a.sums,a.sellsums,a.fbegdate,a.fenddate,"&_
    "case when a.acttype=0 then '按有效天数' else case when acttype=1 then '按截止日期' else '按日期段' end end acttype,"&_
    "a.days,a.closedate,a.begdate,a.enddate,a.setdepotid,c.d_name as setdptname,a.selldate,a.sellname,"&_
	"a.getdepotid,e.d_name as getdptname,a.getdate,a.getname "&_
	"from vip_ticket a inner join vip_tictype b on a.tictypeid=b.tictypeid left join j_depot c on a.setdepotid=c.depotid "&_
	"inner join vip_user d on a.vipid=d.vipid inner join j_depot e on a.getdepotid=e.depotid "&_
	"where a.freeze=0 and a.getsure>0 and d.vipcode='"&vipcode&"' order by a.ticketid"
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
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
t.SetField "selldate","发放日期","80",4
t.SetField "sellname","发放人","50",4
t.SetField "setdepotid","回收店铺","50",4
t.SetField "setdptname","回收店铺名称","80",4
t.SetField "selldate","回收日期","80",4
t.SetField "sellname","回收人","50",4
t.height="92%"
t.show
set t=nothing
end sub%>
<script language="javascript">
    //显示短信对话框
    function showMsgDilog() {
        SendVipMsg("change", "<%=vipcode%>", btnChange)
    }

    //确认兑换
    function btnChange() {
        is.window.btnChange(); 
    }
try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</body>
</html>
