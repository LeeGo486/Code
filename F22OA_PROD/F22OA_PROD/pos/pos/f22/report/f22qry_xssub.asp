<%
option explicit
session("formid")=6102031
Dim typ
typ=request.QueryString("typ")
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%if cint(typ)<>2 then%>
<html>
<link href="css/report.css" rel="stylesheet" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
  var querystring="<%=request.ServerVariables("QUERY_STRING")%>";
  function gtDoSelect(t){
  }

  function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id1=row.cells[0].outerText;
	var id2=row.cells[1].outerText;
	var id3=row.cells[2].outerText;
	//window.parent.parent.iss.location.href="f22qry_xssubsub.asp?"+querystring+"&id1="+id1+"&id2="+id2+"&id3="+id3;
	//alert("f22qry_xssubsub.asp?"+querystring+"&id1="+id1+"&id2="+id2+"&id3="+id3);
	//window.open("f22qry_xssubsub.asp?"+querystring+"&id1="+id1+"&id2="+id2+"&id3="+id3,"newopen");
  }

  function gtDoEnter(t){}
  

</SCRIPT>
</head>

<body>
<%end if%>
<%dim t,rq1,rq2,userid,depotid,sql,act,rqopt,dptopt,qrydaytj
rq1=trim(request.QueryString("rq1"))
rq2=trim(request.QueryString("rq2"))
rqopt=trim(request.QueryString("rqopt"))
dptopt=trim(request.QueryString("dptopt"))
depotid=trim(session("dm").System_Depotid)
userid=trim(session("dm").System_UserId)
act=trim(request.QueryString("act"))
if act="" then
  act=0
else
  act=cint(act)
end if
if rq1="" then rq1=get_date(date()-1)
if rq2="" then rq2=get_date(date())
if rqopt="1" then
  rqopt=" "
else
  rqopt=" and convert(char(10),a.sure_date,126) between "&qts(rq1)&" and "&qts(rq2)&" "
   'rqopt=" and (a.sure_date>= "&qts(rq1)&" and a.sure_date<='"&rq2&" 23:59:59' and a.sure=1) "
end if
if dptopt="1" then
  dptopt=" "
else
  dptopt=" ,a.depotid "
end if

'控制查询天数
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
end if

set t=new Table
t.Activeconnection = cn
t.Commandtype=1

dim sums
sums=1
set ds=server.CreateObject("ADODB.Recordset")
ds.Activeconnection = cn
ds.Source = " select isnull(sum(s_price * nums),0) sums from d_retail a,d_retailsub b"& _
			" where a.retailid=b.retailid and a.sure>0 "&_
			" and b.styleid in (select styleid from sys_stylepower18ql where userid='"&session("dm").System_Userid&"' and selection=1) "&_
			" and a.depotid="&qts(session("dm").System_Depotid)&rqopt&qrydaytj
ds.Open
if not ds.eof then
  sums=cdbl(ds(0))
end if
if sums=0 then sums=0.01
ds.close

select case act
case 2000
 'sql=" select max(a.depotid) depotid,b.clothingid,max(b.styleid) styleid,max(j.s_name) stname, sum(nums * s_price) as sums,sum(nums * b.x_price)-sum(nums * s_price) as zk,"& _
	'" max(b.colorid) colorid,max(c.c_name) c_name,max(b.sizeid) sizeid,isnull(sum(b.nums),0) nums, str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	'" from d_retail a,d_retailsub b ,j_color c,webp_depot d ,j_style j"& _
	'" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	'" and  b.colorid=c.colorid "& _
	'" and b.styleid=j.styleid"& _
	'" and d.userid="&qts(userid)& _
	'" group by b.clothingid,a.depotid"
	
	
	
	sql=" select max(a.depotid) depotid,a.retailid,b.clothingid,max(b.styleid) styleid,max(j.s_name) stname, "&_
	 " max(b.x_price) as x_price, sum(nums * s_price) as sums,"& _
	 " sum(case isNull(b.larg,0) when 0 then nums * b.x_price-nums * s_price else 0 end) as zk,"&_
	 " sum(case isNull(b.larg,0) when 1 then nums * b.x_price-nums * s_price else 0 end) as zs,"&_
	 " max(b.colorid) colorid,max(c.c_name) c_name,max(b.sizeid) sizeid,b.discount,"&_
	 " isnull(sum(b.nums),0) nums, str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and a.sure>0 "&qrydaytj&_
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and b.styleid in (select styleid from sys_stylepower18ql where userid='"&session("dm").System_Userid&"' and selection=1) "&_
	" and a.depotid="&qts(session("dm").System_Depotid)& _
	" group by a.retailid,b.clothingid,b.discount  order by a.retailid desc ,b.clothingid"

	
	t.SetField "depotid","店铺编号","50",3
	t.SetField "retailid","单号","150",0
	t.SetField "clothingid","货号","100",0
	t.SetField "styleid","款式编号","80",4
	t.SetField "stname","款式名称","80",4
	t.SetField "c_name","颜色名称","70",4
	t.SetField "discount","折扣","50",4
	t.SetField "nums","销售数量","50",1
	if pxprice then t.SetField "x_price","单价","50",4
	t.SetField "sums","销售金额","50",1
	t.SetField "sp","占总销售百分比","90",4
	t.SetField "zk","折扣金额","50",1
	t.SetField "zs","赠送金额","50",1
case 3001
 sql=" select max(a.depotid) depotid,b.clothingid,max(b.styleid) styleid,max(j.s_name) stname,  sum(nums * s_price) as sums,"& _
	" max(b.colorid) colorid,max(c.c_name) c_name,max(b.sizeid) sizeid,isnull(sum(b.nums),0) nums,sums/"&sums& _
	" from d_retail a,d_retailsub b ,j_color c,v22p_setmerchant d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"& _
	" and setdate between "&qts(rq1)&" and "&qts(rq2)& _
	" and  b.colorid=c.colorid "& _
	" and a.sure>0 "&qrydaytj&_
	" and isnull(selection,0)=1 and access=1 "& _
	" and b.styleid=j.styleid"& _
	" and d.userid="&qts(userid)& _
	" group by b.clothingid"
	
	t.SetField "depotid","店铺编号","80",3
	t.SetField "clothingid","货号","100",0
	t.SetField "styleid","款式编号","100",4
	t.SetField "stname","款式名称","100",4
	t.SetField "c_name","颜色名称","80",4
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
case 3002 '按店铺
 sql=" select max(a.depotid) depotid,b.clothingid,max(b.styleid) styleid,max(j.s_name) stname, sum(nums * s_price) as sums,sum(nums * b.x_price)-sum(nums * s_price) as zk,"& _
	" max(b.colorid) colorid,max(c.c_name) c_name,max(b.sizeid) sizeid,isnull(sum(b.nums),0) nums, str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,j_color c,v22p_setmerchant d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and  b.colorid=c.colorid "& _
	" and isnull(selection,0)=1 and access=1 "& _
	" and a.sure>0 "&qrydaytj&_
	" and b.styleid=j.styleid"& _
	" and d.userid="&qts(userid)& _
	" group by b.clothingid"',a.depotid"
	
	't.SetField "depotid","店铺编号","80",0
	t.SetField "clothingid","货号","100",3
	t.SetField "styleid","款式编号","100",0
	t.SetField "stname","款式名称","100",4
	t.SetField "c_name","颜色名称","70",4
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "sp","占总销售百分比","90",4
	t.SetField "zk","折扣金额","50",1
case 3003 '按营业员
 'on error resume next
 dim s1,s2,s3,s4,tmp,tmp1,tmpnames,tmptable
 tmptable=session("dbname")&"_f22_tmp.dbo.tmp"&session("dm").system_userid&replace(replace(replace(replace(now(),"/","")," ",""),":",""),"-","")
 'de tmptable
 s2="select retailid,names into "&tmptable&" from jk_retailhistory where 1=2"
 s4="alter table "&tmptable&" alter column [names] varchar(255)"	'现在names保存多个用户名，加这个改宽度
 s3=" insert into "&tmptable&" (retailid) "&_
    " select c.retailid from d_retail a,d_retailsub b,jk_retailhistory c where a.retailid=b.retailid and a.sure>0 "&qrydaytj&_
    " and a.retailid=c.retailid and a.depotid="&qts(depotid)&" and convert(char(10),sure_date,126) "&_
    " between "&qts(rq1)&" and "&qts(rq2)&" group by c.retailid"
 cn.execute s2
 cn.execute s4
 cn.execute s3
 
 set tmp=server.CreateObject("adodb.recordset")
 set tmp1=server.CreateObject("adodb.recordset")
 
 tmp.open "select retailid from "&tmptable,cn
 while not tmp.eof
   tmpnames=""
   tmp1.open "select names from jk_retailhistory where retailid="&qts(tmp("retailid")),cn
   while not tmp1.eof
     tmpnames=tmpnames&tmp1("names")&","
     tmp1.movenext
   wend
   tmp1.close
   tmpnames=left(tmpnames,len(tmpnames)-1)
   cn.execute "update "&tmptable&" set names="&qts(tmpnames)&" where retailid="&qts(tmp("retailid"))
   tmp.movenext
 wend
 tmp.close
 set tmp=nothing
 set tmp1=nothing
 
 sql=" select c.names,max(a.depotid) depotid,sum(nums * s_price) as sums, "& _
	" isnull(sum(b.nums),0) nums , str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp,"& _
   "sum(case isNull(b.larg,0) when 0 then nums * b.x_price-nums * s_price else 0 end) as zk,"&_
		"sum(case isNull(b.larg,0) when 1 then nums * b.x_price-nums * s_price else 0 end) as zs"&_
	" from d_retail a,d_retailsub b,"&tmptable&" c "& _
	" where a.retailid=b.retailid and a.sure>0 and c.retailid=a.retailid  and a.depotid="&qts(depotid)&" "&rqopt&qrydaytj& _
	" group by c.names"
	
	't.SetField "depotid","店铺编号","80",0
	t.SetField "names","售货员","200",0
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
	t.SetField "zk","折扣金额","80",1
	t.SetField "zs","赠送金额","80",1
	t.SetField "sp","占总销售百分比","100",4
    
case 3004 '按款式编号
 sql=" select max(a.depotid) depotid,max(b.styleid) styleid,max(j.s_name) stname,sum(nums * s_price) as sums, "& _
	" max(b.colorid) colorid,max(c.c_name) c_name,max(b.sizeid) sizeid,isnull(sum(b.nums),0) nums , str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,j_color c,v22p_setmerchant d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and  b.colorid=c.colorid "& _
	" and a.sure>0 "&qrydaytj&_
	" and isnull(selection,0)=1 and access=1 "& _
	" and b.styleid=j.styleid"& _
	" and d.userid="&qts(userid)& _
	" group by b.styleid,a.depotid"
	'de sql
	t.SetField "depotid","店铺编号","80",3
	t.SetField "styleid","款式编号","100",0
	t.SetField "stname","款式名称","100",4
	t.SetField "c_name","颜色名称","80",4
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
	t.SetField "sp","占总销售百分比","100",4
case 3008 '按款式编号
 sql=" select max(a.depotid) depotid,max(b.styleid) styleid,max(j.s_name) stname,sum(nums * s_price) as sums, "& _
	" max(b.colorid) colorid,max(c.c_name) c_name,max(b.sizeid) sizeid,isnull(sum(b.nums),0) nums , str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,j_color c,v22p_setmerchant d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and  b.colorid=c.colorid "& _
	" and a.sure>0 "&qrydaytj&_
	" and isnull(selection,0)=1 and access=1 "& _
	" and b.styleid=j.styleid"& _
	" and d.userid="&qts(userid)& _
	" group by b.styleid,a.depotid"
	
	t.SetField "depotid","店铺编号","80",3
	t.SetField "styleid","款式编号","100",0
	t.SetField "stname","款式名称","100",4
	t.SetField "c_name","颜色名称","80",4
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
	t.SetField "sp","占总销售百分比","100",4
case 3009 '按款式种类
 sql=" select st_xl,max(a.depotid) depotid,isnull(sum(b.nums),0) nums,sum(nums * s_price) as sums , str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,v22p_setmerchant d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and isnull(selection,0)=1 and access=1 "& _
	" and b.styleid=j.styleid"& _
	" and a.sure>0 "&qrydaytj&_
	" and d.userid="&qts(userid)& _
	" group by j.st_xl,a.depotid"
	
	t.SetField "depotid","店铺编号","80",3
	t.SetField "st_xl","款式种类","100",0
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
	t.SetField "sp","占总销售百分比","100",4
case 3010 '按款式大类
 sql=" select st_dl,max(a.depotid) depotid,isnull(sum(b.nums),0) nums,sum(nums * s_price) as sums , str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,v22p_setmerchant d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and isnull(selection,0)=1 and access=1 "& _
	" and b.styleid=j.styleid"& _
	" and a.sure>0 "&qrydaytj&_
	" and d.userid="&qts(userid)& _
	" group by j.st_dl,a.depotid"
	
	t.SetField "depotid","店铺编号","80",3
	t.SetField "st_dl","款式大类","100",0
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
	t.SetField "sp","占总销售百分比","100",4
case 3011 '按款式小类
 sql=" select st_xb,max(a.depotid) depotid,isnull(sum(b.nums),0) nums,sum(nums * s_price) as sums , str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,v22p_setmerchant d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and isnull(selection,0)=1 and access=1 "& _
	" and a.sure>0 "&qrydaytj&_
	" and b.styleid=j.styleid"& _
	" and d.userid="&qts(userid)& _
	" group by j.st_xb,a.depotid"
	
	t.SetField "depotid","店铺编号","80",3
	t.SetField "st_xb","款式小类","100",0
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
	t.SetField "sp","占总销售百分比","100",4
case 3012 '按布种
 sql=" select st_cloth,max(a.depotid) depotid,isnull(sum(b.nums),0) nums,sum(nums * s_price) as sums , str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,v22p_setmerchant d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and isnull(selection,0)=1 and access=1 "& _
	" and a.sure>0 "&qrydaytj&_
	" and b.styleid=j.styleid"& _
	" and d.userid="&qts(userid)& _
	" group by j.st_cloth,a.depotid"
	
	t.SetField "depotid","店铺编号","80",3
	t.SetField "st_cloth","布种","100",0
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
	t.SetField "sp","占总销售百分比","100",4
case 3013 '按时间段
 sql=" select setdate,max(a.depotid) depotid,isnull(sum(b.nums),0) nums,sum(nums * s_price) as sums , str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,v22p_setmerchant d "& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and isnull(selection,0)=1 and access=1 "& _
	" and a.sure>0 "&qrydaytj&_
	" and d.userid="&qts(userid)& _
	" group by a.setdate"',a.depotid"
	
	't.SetField "depotid","店铺编号","80",0
	t.SetField "setdate","销售日期","100",0
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
	t.SetField "sp","占总销售百分比","100",4
case 3014 '按月份
ds.Source = " select isnull(sum(s_price * nums),0) sums from d_retail a,d_retailsub b, webp_depot c"& _
			" where a.retailid=b.retailid and a.depotid=c.depotid and a.sure>0 and c.userid="&qts(userid)&qrydaytj
ds.Open
if not ds.eof then
  sums=cdbl(ds(0))
end if
if sums=0 then sums=0.01
ds.close
 sql=" select year(setdate) ys,month(setdate) ms,max(a.depotid) depotid,isnull(sum(b.nums),0) nums,"& _
 	" sum(nums * s_price) as sums , str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,v22p_setmerchant d "& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"& _
	" and isnull(selection,0)=1 and access=1 "& _
	" and d.userid="&qts(userid)& _
	" and a.sure>0 "&qrydaytj&_
	" group by year(setdate),month(setdate)"
	
	't.SetField "depotid","店铺编号","80",0
	t.SetField "ys","年份","50",3
	t.SetField "ms","月份","40",0
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
	t.SetField "sp","占总销售百分比","100",4
case 3015 '按季节
 sql=" select j.st_month,max(a.depotid) depotid,isnull(sum(b.nums),0) nums,"& _
 	" sum(nums * s_price) as sums , str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,v22p_setmerchant d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and isnull(selection,0)=1 and access=1 "& _
	" and b.styleid=j.styleid "& _
	" and a.sure>0 "&qrydaytj&_
	" and d.userid="&qts(userid)& _
	" group by j.st_month,a.depotid"
	
	t.SetField "depotid","店铺编号","80",3
	t.SetField "st_month","季节","50",0
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
	t.SetField "sp","占总销售百分比","100",4
case 3016 '按风格
 sql=" select j.st_pattern,max(a.depotid) depotid,isnull(sum(b.nums),0) nums,"& _
 	" sum(nums * s_price) as sums , str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,v22p_setmerchant d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"&rqopt& _
	" and isnull(selection,0)=1 and access=1 "& _
	" and b.styleid=j.styleid "& _
	" and a.sure>0 "&qrydaytj&_
	" and d.userid="&qts(userid)& _
	" group by j.st_pattern,a.depotid"
	
	t.SetField "depotid","店铺编号","80",3
	t.SetField "st_pattern","风格类别","100",0
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
	t.SetField "sp","占总销售百分比","100",4
case 3017 '按单店
  depotid=trim(request.querystring("depotid"))
  sql=" select b.clothingid,max(b.styleid) styleid,max(j.s_name) stname, sum(nums * s_price) as sums,sum(nums * b.x_price)-sum(nums * s_price) as zk,"& _
	" max(b.colorid) colorid,max(c.c_name) c_name,max(b.sizeid) sizeid,isnull(sum(b.nums),0) nums, str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and a.depotid="&qts(depotid)& _
	" and  b.colorid=c.colorid "& _
	" and a.sure>0 "&qrydaytj&_
	" and b.styleid=j.styleid"& _
	" group by b.clothingid"
	
	t.SetField "clothingid","货号","100",3
	t.SetField "styleid","款式编号","100",0
	t.SetField "stname","款式名称","100",4
	t.SetField "c_name","颜色名称","70",4
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "sp","占总销售百分比","90",4
	t.SetField "zk","折扣金额","50",1
case 3018 '按班次
 sql=" select a.x_name,max(a.depotid) depotid,isnull(sum(b.nums),0) nums,"& _
 	" sum(nums * s_price) as sums , str((sum(nums * s_price)/"&sums&")*100,6,2)+'%' as sp,"& _
	 "sum(case isNull(b.larg,0) when 0 then nums * b.x_price-nums * s_price else 0 end) as zk,"&_
		"sum(case isNull(b.larg,0) when 1 then nums * b.x_price-nums * s_price else 0 end) as zs"&_
	" from d_retail a,d_retailsub b "& _
	" where a.retailid=b.retailid "&rqopt&qrydaytj& _
	" and a.sure>0 and a.depotid="&qts(session("dm").System_Depotid)& _
	" group by a.x_name"
	
	't.SetField "depotid","店铺编号","80",0
	t.SetField "x_name","班次","100",0
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "zs","赠送金额","50",1
	t.SetField "sp","占总销售百分比","100",4

end select
'de sql
t.CommandText=sql

t.height="90%"
t.show
set t=nothing

if act=3003 then cn.execute "drop table "&tmptable end if%>
</div>
<%dim ds%>
<table width="100%"  border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#ECD4D0">
  <tr>
    <td>
查询时段总销售金额:<span class="notice"><%if sums=0.01 then response.write("0") else response.write(sums) end if%>
</span></td>
    <td>
<%dim vip
set ds=server.CreateObject("ADODB.Recordset")
ds.Activeconnection = cn
'ds.Source = "select isnull(sum(s_price * nums),0) sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(vipcode,'')<>'' and setdate between "&qts(rq1)&" and "&qts(rq2)
select case act
case 3014
  ds.Source = "select isnull(sum(s_price * nums),0) sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(b.larg,0)=0 and a.sure>0 and a.depotid="&qts(session("dm").System_Depotid)&" and isnull(vipcode,'')<>'' and year(setdate)="&year(date)&qrydaytj
case else
  ds.Source = "select isnull(sum(s_price * nums),0) sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(b.larg,0)=0 and a.sure>0 and a.depotid="&qts(session("dm").System_Depotid)&" and isnull(vipcode,'')<>'' and setdate between "&qts(rq1)&" and "&qts(rq2)&qrydaytj
end select
ds.Open
if not ds.eof then
  vip=cdbl(ds(0))
else
  vip=0
end if
ds.close%>	
VIP消费金额:<span class="notice"><%=vip%></span></td>
    <td>
VIP所占百分比:<span class="notice"><%=round((vip/sums)*100,2)%>% </span></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	<%dim zk
set ds=server.CreateObject("ADODB.Recordset")
ds.Activeconnection = cn
'ds.Source = "select isnull(sum((x_price-s_price) * nums),0) sums from d_retail a,d_retailsub b where a.retailid=b.retailid and setdate between "&qts(rq1)&" and "&qts(rq2)
'select case act
	'case 2000
		'ds.Source = "select isnull(sum((x_price-s_price) * nums),0) sums from d_retail a,d_retailsub b,webp_depot c where a.retailid=b.retailid and a.depotid=c.depotid and isnull(b.larg,0)=0 and c.userid="&qts(userid)&" and year(a.setdate)="&year(date)
	'case else
		ds.Source = "select isnull(sum((x_price-s_price) * nums),0) sums from d_retail a,d_retailsub b where a.retailid=b.retailid and a.sure>0 and isnull(b.larg,0)=0  and a.depotid="&qts(session("dm").System_Depotid)&" and isnull(larg,0)=0 "&rqopt&qrydaytj
	'end select
	
ds.Open
if not ds.eof then
  zk=cdbl(ds(0))
else
  zk=0
end if
ds.close%>折扣金额:<span class="notice"><%=zk%>
    </span></td>
    <td>占总销售额百分比:<span class="notice"><%=round(zk/sums,4)*100%>%</span></td>
    <td>
	<%dim zs
set ds=server.CreateObject("ADODB.Recordset")
ds.Activeconnection = cn
'ds.Source = "select isnull(sum(s_price * nums),0) sums from d_retail a,d_retailsub b where a.retailid=b.retailid and larg>0 and setdate between "&qts(rq1)&" and "&qts(rq2)
 'ds.Source="select isNull(sum((x_price-s_price)* nums),0) sums from d_retail a,d_retailsub b where a.retailid=b.retailid and larg>0 and setdate between "&qts(rq1)&" and "&qts(rq2)
'select case act
'case 2000
		'ds.Source = "select isnull(sum(x_price * nums)-sum(s_price * nums),0) sums from d_retail a,d_retailsub b,webp_depot c  where a.retailid=b.retailid and a.depotid=c.depotid and c.userid="&qts(userid)&" and isnull(larg,0)>0 and year(a.setdate)="&year(date)
	'case else
		ds.Source = "select isnull(sum(x_price * nums)-sum(s_price * nums),0) sums from d_retail a,d_retailsub b  where a.retailid=b.retailid and a.sure>0 and a.depotid="&qts(session("dm").System_Depotid)&" and  isnull(larg,0)>0 "&rqopt&qrydaytj
	'end select
ds.Open
if not ds.eof then
  zs=cdbl(ds(0))
else
  zs=0
end if
ds.close%>赠送金额11:<span class="notice"><%=zs%>
    </span></td>
    <td>占总销售客百分比:<span class="notice"><%=round(zs/sums,4)*100%>%</span></td>
  </tr>
</table>
<%if cint(typ)<>2 then%>
<script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</body>
</html>
<%end if%>