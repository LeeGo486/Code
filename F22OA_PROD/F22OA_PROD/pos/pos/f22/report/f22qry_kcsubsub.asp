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
	var id=row.cells[2].outerText;
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
    <td>库存明细</td>
  </tr>
</table>
<%dim t,rq1,rq2,userid,depotid,sql,act,rqopt,dptopt,cid
dim clothingid,sname,styleid
rq1=trim(request.QueryString("rq1"))
rq2=trim(request.QueryString("rq2"))
rqopt=trim(request.QueryString("rqopt"))
dptopt=trim(request.QueryString("dptopt"))
depotid=trim(session("dm").System_Depotid)
userid=trim(session("dm").System_UserId)
act=trim(request.QueryString("act"))
cid=trim(request.QueryString("cid"))
act=cid
if act="" then
  act=0
else
  act=cint(act)
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
	" and setdate between "&qts(rq1)&" and "&qts(rq2)& _
	" and  b.colorid=c.colorid "& _
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
depotid=trim(request.QueryString("id1"))
clothingid=trim(request.QueryString("id2"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid="&qts(depotid)& _
	" and b.clothingid="&qts(clothingid)& _
	" order by a.setdate desc"
	
	t.SetField "depotid","店铺编号","60",0
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
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid="&qts(depotid)& _
	" and a.s_name="&qts(sname)& _
	" order by a.setdate desc"
	
	t.SetField "depotid","店铺编号","60",0
	t.SetField "s_name","售货员","60",1
	t.SetField "clothingid","货号","100",1
	t.SetField "styleid","款式编号","90",1
	t.SetField "st_name","款式名称","100",1
	t.SetField "c_name","颜色名称","70",1
	t.SetField "nums","销售数量","50",1
	t.SetField "sums","销售金额","50",1
	t.SetField "zk","折扣金额","50",1
	t.SetField "setdate","销售日期","70",0
case 3004
depotid=trim(request.QueryString("id1"))
styleid=trim(request.QueryString("id2"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and  b.colorid=c.colorid "& _
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
case 3008
depotid=trim(request.QueryString("id1"))
styleid=trim(request.QueryString("id2"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and  b.colorid=c.colorid "& _
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
case 3009
dim st_xl
st_xl=trim(request.QueryString("id1"))
	sql=" select b.d_name,sum(a.k_num) as nums,sum(a.k_num*j.x_price) as sums"& _
		" from j_stock a,webp_depot b,j_style j"& _
		" where a.depotid=b.depotid "& _
		" and b.userid="&qts(userid)& _
		" and a.styleid=j.styleid "& _
		" and j.st_xl="&qts(st_xl)& _
		" group by b.d_name"
	t.SetField "d_name","店铺名称","100",0
	t.SetField "nums","库存数量","80",1
	t.SetField "sums","库存金额","80",1
case 3010
dim st_dl
st_dl=trim(request.QueryString("id1"))
	sql=" select b.d_name,sum(a.k_num) as nums,sum(a.k_num*j.x_price) as sums"& _
		" from j_stock a,webp_depot b,j_style j"& _
		" where a.depotid=b.depotid "& _
		" and b.userid="&qts(userid)& _
		" and a.styleid=j.styleid "& _
		" and j.st_dl="&qts(st_dl)& _
		" group by b.d_name"
	t.SetField "d_name","店铺名称","100",0
	t.SetField "nums","库存数量","80",1
	t.SetField "sums","库存金额","80",1
case 3011
dim st_xb
st_xb=trim(request.QueryString("id1"))
	sql=" select b.d_name,sum(a.k_num) as nums,sum(a.k_num*j.x_price) as sums"& _
		" from j_stock a,webp_depot b,j_style j"& _
		" where a.depotid=b.depotid "& _
		" and b.userid="&qts(userid)& _
		" and a.styleid=j.styleid "& _
		" and j.st_xb="&qts(st_xb)& _
		" group by b.d_name"
	t.SetField "d_name","店铺名称","100",0
	t.SetField "nums","库存数量","80",1
	t.SetField "sums","库存金额","80",1
case 3012
dim st_cloth
st_cloth=trim(request.QueryString("id1"))
	sql=" select b.d_name,sum(a.k_num) as nums,sum(a.k_num*j.x_price) as sums"& _
		" from j_stock a,webp_depot b,j_style j"& _
		" where a.depotid=b.depotid "& _
		" and b.userid="&qts(userid)& _
		" and a.styleid=j.styleid "& _
		" and j.st_cloth="&qts(st_cloth)& _
		" group by b.d_name"
	t.SetField "d_name","店铺名称","100",0
	t.SetField "nums","库存数量","80",1
	t.SetField "sums","库存金额","80",1
case 3013
dim setdate
depotid=trim(request.QueryString("id1"))
setdate=trim(request.QueryString("id2"))
 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid="&qts(depotid)& _
	" and a.setdate="&qts(setdate)& _
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
case 3014
dim ys,ms
depotid=trim(request.QueryString("id1"))
ys=trim(request.QueryString("id2"))
ms=trim(request.QueryString("id3"))

 sql=" select a.depotid,b.clothingid,b.styleid,j.s_name as st_name,b.colorid,c.c_name,b.sizeid,a.s_name,a.setdate,"& _
 	" b.nums,b.discount,b.s_price,b.nums*b.s_price as sums,b.x_price-s_price as zk"& _
	" from d_retail a,d_retailsub b ,j_color c,j_style j"& _
	" where a.retailid=b.retailid "&rqopt& _
	" and  b.colorid=c.colorid "& _
	" and b.styleid=j.styleid"& _
	" and a.depotid="&qts(depotid)& _
	" and year(a.setdate)="&qts(ys)& _
	" and month(a.setdate)="&qts(ms)& _
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
case 3015
dim st_month
st_month=trim(request.QueryString("id1"))

	sql=" select b.d_name,sum(a.k_num) as nums,sum(a.k_num*j.x_price) as sums"& _
		" from j_stock a,webp_depot b,j_style j"& _
		" where a.depotid=b.depotid "& _
		" and b.userid="&qts(userid)& _
		" and a.styleid=j.styleid "& _
		" and j.st_month="&qts(st_month)& _
		" group by b.d_name"
	t.SetField "d_name","店铺名称","100",0
	t.SetField "nums","库存数量","80",1
	t.SetField "sums","库存金额","80",1
case 3016
dim st_pattern
st_pattern=trim(request.QueryString("id1"))

	sql=" select b.d_name,sum(a.k_num) as nums,sum(a.k_num*j.x_price) as sums"& _
		" from j_stock a,webp_depot b,j_style j"& _
		" where a.depotid=b.depotid "& _
		" and b.userid="&qts(userid)& _
		" and a.styleid=j.styleid "& _
		" and j.st_pattern="&qts(st_pattern)& _
		" group by b.d_name"
	t.SetField "d_name","店铺名称","100",0
	t.SetField "nums","库存数量","80",1
	t.SetField "sums","库存金额","80",1
case else
  sql="select colorid from j_color where 1=0"
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
