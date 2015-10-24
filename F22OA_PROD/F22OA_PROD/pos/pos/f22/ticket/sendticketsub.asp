<!--#include file="../../f22/inc/function.asp"-->
<!--#include file="../report/inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>发放券</title>
<link href="../report/css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../report/inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../report/inc/gridtable.js"></SCRIPT>
</head>

<body>
<%
act=request("act")
depotid=trim(session("dm").System_depotid)
username=trim(session("dm").System_Username)

select case cdbl(act)
case 0  call main()
case 1  call delsel()
case 2  call sendall()
end select

sub main()%>
<script type="text/javascript">
var ticid="";
function gtDoSelect(t){
	var row = t.getSelectedRow();
	ticid=row.cells[0].outerText;
	window.parent.form1.delid.value=ticid;
}

</script>
<%set rs=server.CreateObject("adodb.recordset")
ticketid=trim(request("ticketid"))
sendticket=session("sendticket")

if ticketid<>"" then
  sql="select ticketid from vip_ticket where freeze=0 and signsure>0 and sellsure=0 and setdepotid='"&depotid&"' and ticketid='"&ticketid&"' "&_
      "and convert(char(10),getdate(),126) between convert(char(10),fbegdate,126) and convert(char(10),fenddate,126) "
  rs.open sql,cn
  if rs.eof then
	 response.Write("<script>")
	 response.write("alert('"&ticketid&"券输入失败：\n\n1、此券不存在或不属于本店；\n2、此券已过发放期；\n3、此券已发放；\n4、此券还未签收；');")
	 response.write("window.location.href='sendticketsub.asp?act="&act&"';")
	 response.write("</script>")
	 response.End()
  end if
  rs.close

  if sendticket<>"" then
     sendtic=split(sendticket,";")
     find=false
     for i=0 to ubound(sendtic)-1
	   tic=split(sendtic(i),",")
       if trim(tic(0))=ticketid then
          find=true
	      exit for
       end if
     next
     if not find then
        sendticket=sendticket+ticketid+",0;"
     end if
  else
     sendticket=sendticket+ticketid+",0;"
  end if
end if
session("sendticket")=sendticket

'显示
ticketlist="''"
if sendticket<>"" then
   sendtic=split(sendticket,";")
   for i=0 to ubound(sendtic)-1
      tic=split(sendtic(i),",")
	  ticketlist=ticketlist&",'"&trim(tic(0))&"'"
   next
end if

sql="select a.ticket,a.ticketid,a.tckname,b.tictypename,"&_
    "case when a.dtype=0 then '所有用户' else case when dtype=1 then '普通用户' else 'VIP用户' end end as dtype,"&_
    "case when a.ttype=0 then '抵值券' when a.ttype=1 then  '现金券' else '折扣券' end ttype,a.sums,a.fbegdate,a.fenddate,"&_
    "case when a.acttype=0 then '按有效天数' else case when acttype=1 then '按截止日期' else '按日期段' end end acttype,"&_
    "a.days,a.closedate,a.begdate,a.enddate from vip_ticket a,vip_tictype b where a.tictypeid=b.tictypeid "&_
	"and a.ticketid in ("&ticketlist&") order by a.ticket"
'de sql
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
t.SetField  "ticket","券流水号","120",3
t.SetField  "ticketid","券号","120",3
t.SetField "tckname","券名称","80",0
t.SetField "tictypename","券类型","60",4
t.SetField "dtype","使用范围","60",4
t.SetField "ttype","券种类","60",4
t.SetField "sums","面值金额","50",1
t.SetField "fbegdate","发放开始日期","80",4
t.SetField "fenddate","发放结束日期","80",4
t.SetField "acttype","生效方式","70",4
t.SetField "days","有效天数","50",4
t.SetField "closedate","截止日期","60",4
t.SetField "begdate","生效日期","60",4
t.SetField "enddate","失效日期","60",4
t.height="95%"
t.show
set t=nothing
set rs=nothing
response.write("<script>window.parent.form1.ticketid.value='';</script>")%>
<script language="javascript">
try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
<%end sub

sub delsel()
delid=trim(request("delid"))
if delid="" then
  mbox("参数错误！")
end if
sendtic=split(session("sendticket"),";")
tmpsend=""
for i=0 to ubound(sendtic)-2
  tic=split(sendtic(i),",")
  if lcase(delid)<>lcase(trim(tic(0))) then
     tmpsend=tmpsend+sendtic(i)+";"
  end if
next
session("sendticket")=tmpsend
response.Redirect("sendticketsub.asp?act=0")
end sub

sub sendall()

sendticket=session("sendticket")
if sendticket="" then
   mbox("没有券需要发放！")
end if
ticketlist="''"
if sendticket<>"" then
   sendtic=split(sendticket,";")
   for i=0 to ubound(sendtic)-1
      tic=split(sendtic(i),",")
	  ticketlist=ticketlist&",'"&trim(tic(0))&"'"
   next
end if

sql="update vip_ticket set sellsure=1,selldate=getdate(),sellname='"&username&"' where ticketid in ("&ticketlist&")"
cn.execute sql
session("sendticket")=""
response.Redirect("sendticketsub.asp?act=0")
end sub%>
</body>
</html>
