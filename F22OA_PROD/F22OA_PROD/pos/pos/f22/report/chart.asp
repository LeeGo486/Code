<%'option explicit
'on error resume next
'Response.Expires=-1000%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
<!--[if !mso]>
<style>
v\:*         { behavior: url(#default#VML) }
o\:*         { behavior: url(#default#VML) }
.shape       { behavior: url(#default#VML) }
</style>
<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>志华WEB图表生成中心</title>
<style>
TD {	FONT-SIZE: 9pt}
</style>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/chart.asp" -->
</head>

<body>

<%dim act,userid,depotid,ds,rc,i,sql,j,rq1,rq2,rqopt
chart=trim(request("chart"))
act=trim(request("act"))
userid=trim(session("dm").System_UserId)
depotid=trim(session("dm").System_depotid)
rq1=trim(request.QueryString("rq1"))
rq2=trim(request.QueryString("rq2"))
if rq1="" then rq1=get_date(date()-1)
if rq2="" then rq2=get_date(date())
if rqopt="1" then
  rqopt=" "
else
  rqopt=" and setdate between "&qts(rq1)&" and "&qts(rq2)&" "
end if
response.write "日期范围:"&rq1&" ---- "&rq2
set ds=server.CreateObject("ADODB.Recordset")
ds.Activeconnection = cn

select case chart
case "xs"
  call xs()
case "kc"
  call kc()
case ""

end select%>
</body>
</html>

<%
sub xs()
  dim total()
  dim cid
  dim dep()
  act=trim(request("act"))
  if not isnumeric(cid) then
    act=0
  else
    act=cint(act)
  end if
  
  select case act
  case 3002
  	dim color2(12)
	color2(1)="#FF0000,1.5,1,2,"
	color2(2)="#0000FF,1,2,3,"
	color2(3)="#004D00,1,1,3,"
	
	sql="select depotid,d_name from webp_depot where userid="&qts(userid)
	ds.CursorType = 1
	ds.Source = sql
	ds.open
	rc=ds.RecordCount
  	redim total(12,rc)
	
	for i=1 to 12
	  total(i,0)=i&"月"
	next
	redim dep(rc,1)
	for i=1 to rc
	  dep(i,0)=ds(0)
	  dep(i,1)=ds(1)
	  ds.movenext
	next
	ds.close
	for j=1 to rc
	total(0,j)=color2(j)&dep(j,1)
	for i=1 to 12'" sum(nums * s_price) as sums "& _
 		sql=" select year(setdate) ys,month(setdate) ms,isnull(sum(b.nums),0) nums"& _
		" from d_retail a,d_retailsub b "& _
		" where a.retailid=b.retailid "& _
		" and a.depotid="&qts(dep(j,0))& _
		" and month(setdate)="&i& _
		" group by year(setdate),month(setdate)"
		'de sql
  		ds.Source = sql
		ds.open
		if not ds.eof then
	 	  total(i,j)=ds("nums")
		else
		  total(i,j)=0
		end if
		ds.close
	next
    next
	j=0
	response.write 	"<div id=""Layer1"" style="" top:20px; "& _
					"z-index:1;font-size:20px;""><center>各店铺月销售折线图</center></div>"
	call table2(total,100,90,600,250,rc)
	
  case 3003
 	sql=" select a.s_name,sum(nums * s_price) as sums "& _
	" from d_retail a,d_retailsub b ,webp_depot d "& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and d.userid="&qts(userid)& _
	" group by a.s_name"
	ds.CursorType = 1
	ds.Source = sql
	ds.Open
	rc=ds.RecordCount
	redim total(rc,1)
	for i=1 to rc
	  total(i,0)=ds(0)
	  total(i,1)=cdbl(ds(1))
	  ds.Movenext
	next
	ds.close
	call table3(total,300,120,250,250,"B")
	response.write 	"<div id=""Layer1"" style="" top:20px; "& _
					"font-size:20px;""><center>营业员分类(按销售金额金额) 销售饼图</center></div>"
					
  case 3009
 	sql=" select st_xl,isnull(sum(b.nums),0) nums"& _
	" from d_retail a,d_retailsub b ,webp_depot d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and b.styleid=j.styleid"& _
	" and d.userid="&qts(userid)& _
	" group by j.st_xl"
	ds.CursorType = 1
	ds.Source = sql
	ds.Open
	rc=ds.RecordCount
	redim total(rc,1)
	for i=1 to rc
	  if ds(0)="" then
	    total(i,0)="其它"
	  else
	    total(i,0)=ds(0)
	  end if
	  total(i,1)=ds(1)
	  ds.Movenext
	next
	ds.close
	call table3(total,300,120,250,250,"B")
	response.write 	"<div id=""Layer1"" style="" top:20px; "& _
					"height:69px; z-index:1;font-size:20px;""><center>按款式种类分类 销售饼图</center></div>"
  
  case 3010
 	sql=" select st_dl,isnull(sum(b.nums),0) nums"& _
	" from d_retail a,d_retailsub b ,webp_depot d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and b.styleid=j.styleid"& _
	" and d.userid="&qts(userid)& _
	" group by j.st_dl"
	ds.CursorType = 1
	ds.Source = sql
	ds.Open
	rc=ds.RecordCount
	redim total(rc,1)
	for i=1 to rc
	  if ds(0)="" then
	    total(i,0)="其它"
	  else
	    total(i,0)=ds(0)
	  end if
	  total(i,1)=ds(1)
	  ds.Movenext
	next
	ds.close
	call table3(total,300,120,250,250,"B")
	response.write 	"<div id=""Layer1"" style=""position:absolute; left:260px; top:20px; width:300px; "& _
					"height:69px; z-index:1;font-size:20px;""><center>按产品大类分类 销售饼图</center></div>"
					
  case 3012
 	sql=" select isnull(st_cloth,''),isnull(sum(b.nums),0) nums"& _
	" from d_retail a,d_retailsub b ,webp_depot d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and b.styleid=j.styleid"& _
	" and d.userid="&qts(userid)& _
	" group by j.st_cloth"
	ds.CursorType = 1
	ds.Source = sql
	ds.Open
	rc=ds.RecordCount
	redim total(rc,1)
	for i=1 to rc
	  if ds(0)="" then
	    total(i,0)="其它"
	  else
	    total(i,0)=ds(0)
	  end if
	  total(i,1)=ds(1)
	  
	  ds.Movenext
	next
	ds.close
	call table3(total,300,120,250,250,"B")
	response.write 	"<div id=""Layer1"" style=""position:absolute; left:260px; top:20px; width:300px; "& _
					"height:69px; z-index:1;font-size:20px;""><center>按产品布种分类 销售饼图</center></div>"

  case 3014
  	redim total(12,2)
	depotid=trim(request.queryString("depotid"))
	for i=1 to 12
	  total(i,2)=i&"月"
	next
	sql="select depotid,d_name from webp_depot where userid="&qts(userid)
	ds.CursorType = 1
	ds.Source = sql
	ds.open
	rc=ds.RecordCount
	redim dep(rc,1)
	for i=1 to rc
	  dep(i,0)=ds(0)
	  dep(i,1)=ds(1)
	  ds.movenext
	next
	ds.close
	for j=1 to rc
	response.write 	"<div id=""Layer1"" style=""position:absolute; left:250px; top:"&j*300-280&"px; width:300px; height:69px; z-index:1;font-size:20px;""><center>"&dep(j,1)&"月销售条形图</center></div>"

	for i=1 to 12'isnull(sum(b.nums),0) nums"& _
 		sql=" select year(setdate) ys,month(setdate) ms,"& _
		" sum(nums * s_price) as sums "& _
		" from d_retail a,d_retailsub b "& _
		" where a.retailid=b.retailid "& _
		" and a.depotid="&qts(dep(j,0))& _
		" and month(setdate)="&i& _
		" group by year(setdate),month(setdate)"
		'de sql
  		ds.Source = sql
		ds.open
		if not ds.eof then
	 	  total(i,1)=cdbl(ds("sums"))
		else
		  total(i,1)=0
		end if
		ds.close
	next
    
	call table1(total,150,j*300-250,10,22,500,200,"A")
	next
  case 3016
 	sql=" select j.st_pattern,isnull(sum(b.nums),0) nums"& _
	" from d_retail a,d_retailsub b ,webp_depot d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and b.styleid=j.styleid "& _
	" and d.userid="&qts(userid)& _
	" group by j.st_pattern"
	'de sql
	ds.CursorType = 1
	ds.Source = sql
	ds.Open
	rc=ds.RecordCount
	redim total(rc,1)
	for i=1 to rc
	  total(i,0)=ds(0)
	  total(i,1)=ds(1)
	  ds.Movenext
	next
	ds.close
	call table3(total,300,120,250,250,"B")
	response.write 	"<div id=""Layer1"" style=""position:absolute; left:260px; top:20px; width:300px; "& _
					"height:69px; z-index:1;font-size:20px;""><center>按产品大类分类 销售饼图</center></div>"
  end select
  
end sub
%>