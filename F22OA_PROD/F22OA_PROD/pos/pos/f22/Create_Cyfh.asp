<%option explicit
response.AddHeader "Pragma","No-Cache"
response.AddHeader "Cache-Control","No-Cache"
Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>根据收货差异生成发货</title>
</head>

<body>
<br>
<br>
<%
dim id,sql1,sql2,sql3,sql4,rs,formid,djid
id=trim(request.QueryString("id"))
formid=trim(request.QueryString("formid"))
set rs = server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn
rs.Source = "select 1 from webtmp_barcodeget where [id]="&qts(id)
rs.open
if rs.eof then
  call close("此收货单没有条码扫描！")
  rs.close
  set rs=nothing
  response.end
end if
rs.close


on error resume next
cn.execute "drop table #tmpcreatefh"
select case formid
case 2062 
     sql1=" select a.clothingid,a.styleid,a.colorid,a.sizeid,isnull(a.set_nums,0) as fnums,isnull(b.nums,0) as snums into #tmpcreatefh"& _
	      " from d_sellsub a full join webtmp_barcodeget b on a.sellid=b.[id] and a.clothingid=b.clothingid where a.sellid="&qts(id)
case 2068 
     sql1=" select a.clothingid,a.styleid,a.colorid,a.sizeid,isnull(a.set_nums,0) as fnums,isnull(b.nums,0) as snums into #tmpcreatefh"& _
	      " from d_movesub a full join webtmp_barcodeget b on a.moveid=b.[id] and a.clothingid=b.clothingid where a.moveid="&qts(id)
case 2069 
     sql1=" select a.clothingid,a.styleid,a.colorid,a.sizeid,isnull(a.set_nums,0) as fnums,isnull(b.nums,0) as snums into #tmpcreatefh"& _
	      " from d_msellsub a full join webtmp_barcodeget b on a.msellid=b.[id] and a.clothingid=b.clothingid where a.msellid="&qts(id)
end select
cn.execute sql1

rs.open "select 1 from #tmpcreatefh where fnums-snums<>0",cn
if rs.eof then
   call close("此收货单没有差异！")
   rs.close
   set rs=nothing
   response.End()
else
   sql2="F22_PosCreate_Cyfh '"&id&"','"&session("dm").system_userid&"','"&session("dm").system_username&"',"&formid
   cn.execute sql2
end if
rs.close

cn.execute "drop table #tmpcreatefh"
set rs=nothing
set cn=nothing
call close("生成完成!")
%>
</body>
</html>

