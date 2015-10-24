<%option explicit
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<html>
<link href="css/report.css" rel="stylesheet" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
  var querystring="<%=request.ServerVariables("QUERY_STRING")%> ";
  function gtDoSelect(t){
  }

  function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[3].outerText;
	style(id);
  }

  function gtDoEnter(t){}
function style(id){
  showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}

</SCRIPT>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td>销售明细</td>
  </tr>
</table>
<%dim t,rq1,rq2,userid,depotid,sql,act,rqopt,dptopt,qrydaytj
dim clothingid,sname,styleid
rq1=trim(request.QueryString("rq1"))
rq2=trim(request.QueryString("rq2"))
rqopt=trim(request.QueryString("rqopt"))
dptopt=trim(request.QueryString("dptopt"))
depotid=trim(session("dm").System_Depotid)
userid=trim(session("dm").System_UserId)
act=trim(request.QueryString("act"))
msid=trim(request.QueryString("msid"))
if msid="" then msid=0
if act="" then
  act=0
else
  act=cint(act)
end if

if rq1="" then
  rq1=get_date(date()-1)
else
  rq1=year(rq1)&"-"&month(rq1)&"-"&day(rq1)
end if
if rq2="" then rq2=get_date(date())
'de rq2
if rqopt="1" then
  rqopt=" "
else
  rqopt=" and convert(char(10),a.sure_date,126) between "&qts(rq1)&" and "&qts(rq2)&" "
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

select case act
case 3001
 sql=" select max(a.depotid) depotid,b.clothingid,max(b.styleid) styleid,max(j.s_name) stname,  sum(nums * s_price) as sums,"& _
	" max(b.colorid) colorid,max(c.c_name) c_name,max(b.sizeid) sizeid,isnull(sum(b.nums),0) nums "& _
	" from d_retail a,d_retailsub b ,j_color c,v22p_setmerchant d ,j_style j"& _
	" where a.retailid=b.retailid and a.depotid=d.depotid"& _
	" and convert(char(10),a.sure_date,126) between "&qts(rq1)&" and "&qts(rq2)& _
	" and  b.colorid=c.colorid and a.sure>0 "&qrydaytj& _
	" and isnull(selection,0)=1 and access=1 "& _
	" and b.styleid=j.styleid"& _
	" and d.userid="&qts(userid)& _
	" group by b.clothingid"
	
	t.SetField "depotid","店铺编号","80",0
	t.SetField "clothingid","货号","100",0
	t.SetField "styleid","款式编号","100",0
	t.SetField "stname","款式名称","100",0
	t.SetField "c_name","颜色名称","80",0
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
case 3002
clothingid=trim(request.QueryString("id1"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,d.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,webp_depot d"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and  b.colorid=c.colorid and a.sure>0 "&qrydaytj& _
	" and b.styleid=j.styleid"& _
	" and d.depotid=a.depotid"& _
	" and d.userid="&qts(userid)& _
	" and b.clothingid="&qts(clothingid)& _
	" order by a.setdate desc"
	
	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","90",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
case 3003
depotid=trim(request.QueryString("id1"))
sname=trim(request.QueryString("id2"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code,d.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,j_depot d,webp_depot wd"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and a.depotid=d.depotid and a.sure>0 "&qrydaytj& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid= wd.depotid and wd.userid="&qts(userid)& _
	" and a.s_name="&qts(sname)& _
	" order by a.setdate desc"
	
	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","90",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",0
case 3004
depotid=trim(request.QueryString("id1"))
styleid=trim(request.QueryString("id2"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and  b.colorid=c.colorid and a.sure>0 "&qrydaytj& _
	" and b.styleid=j.styleid"& _
	" and a.depotid="&qts(depotid)& _
	" and b.styleid="&qts(styleid)& _
	" order by a.setdate desc"
	
	t.SetField "depotid","店铺编号","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","100",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",0
case 3008
depotid=trim(request.QueryString("id1"))
styleid=trim(request.QueryString("id2"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code,d.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,j_depot d,webp_depot e"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and a.depotid=d.depotid and a.sure>0 "&qrydaytj _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid=e.depotid and e.userid="&qts(userid)& _
	" and b.styleid="&qts(styleid)& _
	" order by a.setdate desc"
	
	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","100",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",1
case 3009
dim st_xl
depotid=trim(request.QueryString("id1"))
st_xl=trim(request.QueryString("id2"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code,d.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,j_depot d,webp_depot e"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and a.depotid=d.depotid and a.sure>0 "&qrydaytj& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid=e.depotid and e.userid="&qts(userid)& _
	" and j.st_xl="&qts(st_xl)& _
	" order by a.setdate desc"

	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","100",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",1
case 3010
dim st_dl
depotid=trim(request.QueryString("id1"))
st_dl=trim(request.QueryString("id2"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code,d.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,j_depot d,webp_depot e"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and a.depotid=d.depotid and a.sure>0 "&qrydaytj& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid=e.depotid and e.userid="&qts(userid)& _
	" and j.st_dl="&qts(st_dl)& _
	" order by a.setdate desc"

	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","100",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",1
case 3011
dim st_xb
depotid=trim(request.QueryString("id1"))
st_xb=trim(request.QueryString("id2"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code,d.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,j_depot d,webp_depot e"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and a.depotid=d.depotid and a.sure>0 "&qrydaytj& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid=e.depotid and e.userid="&qts(userid)& _
	" and j.st_xb="&qts(st_xb)& _
	" order by a.setdate desc"

	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","100",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",0
case 3012
dim st_cloth
depotid=trim(request.QueryString("id1"))
st_cloth=trim(request.QueryString("id2"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code,d.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,j_depot d,webp_depot e"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and a.depotid=d.depotid and a.sure>0 "&qrydaytj& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid=e.depotid and e.userid="&qts(userid)& _
	" and j.st_cloth="&qts(st_cloth)& _
	" order by a.setdate desc"

	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","100",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",1
case 3013
dim setdate
setdate=trim(request.QueryString("id1"))
if setdate="" then
  setdate=get_date(date()-1)
else
  setdate=year(setdate)&"-"&month(setdate)&"-"&day(setdate)
end if
'de setdate
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code,d.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,j_depot d,webp_depot e"& _
	" where a.retailid=b.retailid "& _
	" and a.depotid=d.depotid and e.depotid=d.depotid and e.userid="&qts(userid)& _
	" and  b.colorid=c.colorid and a.sure>0 "&qrydaytj& _
	" and b.styleid=j.styleid"& _
	" and convert(char(10),a.sure_date,126)="&qts(setdate)& _
	" order by a.setdate desc"
'de sql
	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","100",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",1
case 3014
dim ys,ms
ys=trim(request.QueryString("id1"))
ms=trim(request.QueryString("id2"))

 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code,e.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,webp_depot e"& _
	" where a.retailid=b.retailid and a.sure>0 "&qrydaytj& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and e.depotid=a.depotid and e.userid="&qts(userid)& _
	" and year(a.setdate)="&qts(ys)& _
	" and month(a.setdate)="&qts(ms)& _
	" order by a.setdate desc"

	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","100",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",1
case 3015
dim jj
depotid=trim(request.QueryString("id1"))
jj=trim(request.QueryString("id2"))

 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code,d.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,j_depot d,webp_depot wd"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and a.depotid=d.depotid and a.sure>0 "&qrydaytj& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid= wd.depotid and wd.userid="&qts(userid)& _
	" and j.st_month="&qts(jj)& _
	" order by a.setdate desc"

	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","100",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",1
case 3016
dim st_pattern
depotid=trim(request.QueryString("id1"))
st_pattern=trim(request.QueryString("id2"))

 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code,d.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,j_depot d,webp_depot wd"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and a.depotid=d.depotid and a.sure>0 "&qrydaytj& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid= wd.depotid and wd.userid="&qts(userid)& _
	" and j.st_pattern="&qts(st_pattern)& _
	" order by a.setdate desc"
'de sql
	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","100",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",1
case 3017
clothingid=trim(request.QueryString("id1"))
depotid=trim(request.QueryString("depotid"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code,d.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,j_depot d,webp_depot wd"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and a.depotid=d.depotid and a.sure>0 "&qrydaytj& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid= wd.depotid and wd.userid="&qts(userid)& _
	" and b.clothingid="&qts(clothingid)& _
	" order by a.setdate desc"
	
	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","90",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",0
case 3018
clothingid=trim(request.QueryString("id1"))
depotid=trim(request.QueryString("depotid"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk,b.code,d.d_name"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j,j_depot d,webp_depot wd"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and a.depotid=d.depotid and a.sure>0 "&qrydaytj& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid= wd.depotid and wd.userid="&qts(userid)& _
	" and a.x_name="&qts(clothingid)& _
	" order by a.setdate desc"
	
	t.SetField "depotid","店铺编号","60",0
	t.SetField "d_name","店铺名称","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","90",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
	t.SetField "code","内部编码","100",0
case else
  select case msid
  case 119
  
  case else
  	sql="select colorid from j_color where 1=0"
  end select
end select
'de sql
t.CommandText=sql

t.height="84%"
t.show
set t=nothing
%>
</div>
<script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>

</body>
</html>
