<!--#include file="../../f22/inc/function.asp"-->
<!--#include file="../report/inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>签收券</title>
<link href="../report/css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../report/inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../report/inc/gridtable.js"></SCRIPT>
</head>

<%
act=request("act")
depotid=trim(session("dm").System_depotid)
username=trim(session("dm").System_Username)
 
 
if act="" then act=0 end if
select case act
case 0 call ticket1()
case 1 call ticket2()
end select



sub ticket1

types=request("types")
ticketid=trim(request("ticketid"))
'签收
if types="sign" then
   set rs=server.CreateObject("adodb.recordset")
   sql="select ticketid from vip_ticket where ticketid='"&ticketid&"' and setdepotid='"&depotid&"' and setsure>0 and signsure=0 and freeze=0"
   'de sql
   rs.open sql,cn
   if rs.eof then
	  response.Write("<script>")
	  response.write("alert('"&ticketid&"券签收失败：\n\n1、此券号不存在或不属于本店；\n2、此券已签收；');")
	  response.write("window.location.href='signticketsub.asp?act=0';")
	  response.write("</script>")
	  response.End()
   else
      sql="update vip_ticket set signsure=1,signdate=getdate(),signname='"&username&"' where ticketid='"&ticketid&"' "
      cn.execute sql
   end if
   rs.close
   set rs=nothing
end if 
%>
<body onLoad="document.all.ticketid.focus()">
<table width="100%"  border="0" cellpadding="0" cellspacing="1">
<form name="form1" method="post" action="?">
<input type="hidden" name="act" value="<%=act%>">
<input type="hidden" name="types" value="sign">
    <tr>
      <td>&nbsp;&nbsp;输入签收的券号：
	  <input type="text" name="ticketid" size="32" onFocus="this.select()">
	  </td>
    </tr>
</form>
</table>
<%
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
sql="select a.ticket,a.ticketid,a.tckname,a.tictypeid,b.tictypename,"&_
    "case when a.dtype=0 then '所有用户' else case when dtype=1 then '普通用户' else 'VIP用户' end end as dtype,"&_
    "case when a.ttype=0 then '抵值券' when a.ttype=1 then  '现金券' else '折扣券' end ttype,a.sums,a.fbegdate,a.fenddate,"&_
    "case when a.acttype=0 then '按有效天数' else case when acttype=1 then '按截止日期' else '按日期段' end end acttype,"&_
    "a.days,a.closedate,a.begdate,a.enddate "&_
    "from vip_ticket a inner join vip_tictype b on a.tictypeid=b.tictypeid "&_
	"where a.freeze=0 and a.setsure>0 and a.signsure=0 and a.setdepotid='"&depotid&"' order by a.ticket"
t.CommandText=sql
t.SetField "ticket","券流水号","120",3
t.SetField "ticketid","券号","120",3
t.SetField "tckname","券名称","80",0
t.SetField "tictypeid","券类型","45",4
t.SetField "tictypename","券类型名称","70",4
t.SetField "dtype","使用范围","60",4
t.SetField "ttype","券种类","50",4
t.SetField "sums","面值金额","50",1
t.SetField "fbegdate","发放开始日期","80",4
t.SetField "fenddate","发放结束日期","80",4
t.SetField "acttype","生效方式","80",4
t.SetField "days","有效天数","50",4
t.SetField "closedate","截止日期","60",4
t.SetField "begdate","生效日期","60",4
t.SetField "enddate","失效日期","60",4
t.height="95%"
t.show
set t=nothing%>

<script language="javascript">
try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</body>
<%end sub

sub ticket2
uid=request("uid")
'签收
if uid<>"" then
   tmpid=split(uid,",")
   if ubound(tmpid)<>2 then
      mbox("参数错误！")
   end if
   tictypeid=trim(tmpid(0))
   ttype=trim(tmpid(1))
   sums=trim(tmpid(2))
   sql="update vip_ticket set signsure=1,signdate=getdate(),signname='"&username&"' "&_
       "where tictypeid='"&tictypeid&"' and ttype="&ttype&" and sums="&sums&" and freeze=0 and setsure>0 and signsure=0 "&_
	   "and setdepotid='"&depotid&"'"
   cn.execute sql
end if%>
<script type="text/javascript">
var uid="";

function gtDoSelect(t){
	var row = t.getSelectedRow();
	uid=row.cells[0].outerText;
}

function signticket()
{if(uid!="")
  { if(confirm('确定签收吗？'))
     {window.location.href="signticketsub.asp?act=<%=act%>&uid="+uid;}
  }
  else
  {alert("请选择记录！");}
}
</script>
<body>
<form name="form2" method="post" action="?">
<table width="100%"  border="0" cellpadding="0" cellspacing="1">
    <tr align="right">
      <td><input type="button" name="sign" value=" 签 收 " onClick="signticket()"> </td>
    </tr>
</table>
<%
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
sql="select max(rtrim(a.tictypeid)+','+cast(a.ttype as varchar(2))+','+cast(a.sums as varchar(20))) as uid,"&_
    "a.tictypeid,max(b.tictypename) as tictypename,"&_
    "case when a.ttype=0 then '抵值券' when a.ttype=1 then  '现金券' else '折扣券' end ttype,a.sums,count(*) as cnt,sum(a.sums) as ssums "&_
    "from vip_ticket a inner join vip_tictype b on a.tictypeid=b.tictypeid "&_
	"where a.freeze=0 and a.setsure>0 and a.signsure=0 and a.setdepotid='"&depotid&"' "&_
	"group by a.tictypeid,case when a.ttype=0 then '抵值券' when a.ttype=1 then  '现金券' else '折扣券' end ,a.sums"
t.CommandText=sql
'de sql
t.SetField "uid","序号","30",4
t.SetField "tictypename","券类型名称","80",3
t.SetField "ttype","券种类","60",0
t.SetField "sums","面值金额","60",4
t.SetField "cnt","张数","50",1
t.SetField "ssums","合计金额","80",1
t.height="95%"	
t.show()
set t=nothing%>
</form>
<script language="javascript">
try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</body>
<%end sub%>

</html>
