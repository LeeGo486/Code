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
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	
  }

  function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:350px;center: yes;help:no;resizable:yes;status:no');
  }

  function gtDoEnter(t){}
</SCRIPT>
</head>

<body>
<%dim rq1,rq2,sql,t,userid,depotid,com,rs
com=session("com")
rq1=trim(request("rq1"))
rq2=trim(request("rq2"))
userid=trim(session("dm").System_UserId)
depotid=trim(session("dm").System_DepotId)


dim tmp,tmps
'randomize
tmp="#tmp"&replace(cstr(rnd+1),".","")
tmps="#tmps"&replace(cstr(rnd+1),".","")

dim cd 
set cd=server.createObject("adodb.command")
cd.activeConnection = cn
cd.CommandType=1

'de tmp&"<br>"&tmps

sql="create table "&tmp&"(clothingid varchar(20),c_name varchar(10),colorid varchar(10),dhs int,yds int,yps int,yfs int,yss int,kc int,wfh int,zt int)"
cd.CommandText = sql
cd.Execute

'求订货数
sql=" insert into "&tmp&"(clothingid,dhs) "& _
	" select clothingid,sum(nums) from v22d_indentsub "& _
	" where clothingid is not null and getdepotid="&qts(depotid)&" and  setdate between "&qts(rq1) &" and "&qts(rq2)& _
	" group by clothingid"
cd.CommandText = sql
cd.Execute

'求已登数
sql="insert into "&tmp&"(clothingid,yds) "& _
	" select clothingid,sum(nums) from v22d_indentsub "& _
	" where clothingid is not null and sure>0 and getdepotid="&qts(depotid)&" and  setdate between "&qts(rq1) &" and "&qts(rq2)& _
	" group by clothingid"
cd.CommandText = sql
'de sql
cd.Execute

'求已配数
sql="insert into "&tmp&"(clothingid,yps) "& _
	" select clothingid,sum(nums) from v22d_quotasub "& _
	" where clothingid is not null and sure>0 and getdepotid="&qts(depotid)&" and  setdate between "&qts(rq1) &" and "&qts(rq2)& _
	" group by clothingid"
cd.CommandText = sql
cd.Execute

'求已发数
sql="insert into "&tmp&"(clothingid,yfs) "& _
	" select clothingid,sum(set_nums) from v22d_sellsub "& _
	" where clothingid is not null and set_sure>0 and getdepotid="&qts(depotid)&" and  setdate between "&qts(rq1) &" and "&qts(rq2)& _
	" group by clothingid"
cd.CommandText = sql
cd.Execute

'求已收数
sql="insert into "&tmp&"(clothingid,yss) "& _
	" select clothingid,sum(set_nums) from v22d_sellsub "& _
	" where clothingid is not null and get_sure>0 and getdepotid="&qts(depotid)&" and  setdate between "&qts(rq1) &" and "&qts(rq2)& _
	" group by clothingid"
cd.CommandText = sql
cd.Execute

 '插入未发货数
 dim s1,s2
 
   s2= " select sum(d.set_nums) from d_sellsub d,d_sell e,webp_depot f"& _
	   " where d.sellid=e.sellid and e.get_depotid=f.depotid"& _
	   " and a.clothingid=d.clothingid and f.userid="&qts(userid)& _
	   " and e.set_sure>0"& _
	   " group by d.clothingid"
	   
  s1 = " select sum(g.nums) from d_indentsub g,d_indent h,webp_depot i"& _
	   " where g.indentid=h.indentid and h.get_depotid=i.depotid"& _
	   " and a.clothingid=g.clothingid and i.userid="&qts(userid)& _
	   " and h.sure>0 "& _
	   " group by g.clothingid"
	   
 sql = " insert into "&tmp&"(clothingid,wfh) "& _
	   " select a.clothingid,("&s1&")-("&s2&") from d_sellsub a,d_sell b,webp_depot c"& _
	   " where a.sellid=b.sellid and b.get_depotid=c.depotid"& _
	   " and c.userid="&qts(userid)& _
	   " group by a.clothingid"
	   'de sql
 cd.CommandText = sql
 cd.Execute
 
 '插入在途
 'dim s1,s2
 
   s2= " select sum(d.set_nums) from d_sellsub d,d_sell e,webp_depot f"& _
	   " where d.sellid=e.sellid and e.get_depotid=f.depotid"& _
	   " and a.clothingid=d.clothingid and f.userid="&qts(userid)& _
	   " and set_sure>0 "& _
	   " group by d.clothingid"
	   
   s2= " select sum(d.set_nums) from d_sellsub d,d_sell e,webp_depot f"& _
	   " where d.sellid=e.sellid and e.get_depotid=f.depotid"& _
	   " and a.clothingid=d.clothingid and f.userid="&qts(userid)& _
	   " and get_sure>0 "& _
	   " group by d.clothingid"
	   
 sql = " insert into "&tmp&"(clothingid,zt) "& _
	   " select a.clothingid,("&s1&")-("&s2&") from d_sellsub a,d_sell b,webp_depot c"& _
	   " where a.sellid=b.sellid and b.get_depotid=c.depotid"& _
	   " and c.userid="&qts(userid)& _
	   " group by a.clothingid"
	   'de sql
 cd.CommandText = sql
 cd.Execute

'求目前库存
sql="insert into "&tmp&"(clothingid,kc) "& _
	" select clothingid,k_num from j_stock"& _
	" where depotid="&qts(depotid)
cd.CommandText = sql
cd.Execute

sql="create table "&tmps&"(clothingid varchar(20),c_name varchar(10),colorid varchar(10),dhs int,yds int,yps int,yfs int,yss int,kc int,wfh int,zt int)"
cd.CommandText = sql
cd.Execute


sql=" insert into "&tmps&"(clothingid,c_name,colorid,dhs,yds,yps,yfs,yss,kc,wfh,zt) "& _
	" select clothingid,max(c_name),max(colorid),sum(dhs),sum(yds),sum(yps),sum(yfs),sum(yss),sum(kc),sum(wfh),sum(zt) from "&tmp&" group by clothingid"
cd.CommandText = sql
cd.Execute

sql=" select clothingid,c_name,colorid,isnull(dhs,0) as dhs,isnull(yds,0) as yds,"& _
	" isnull(yps,0) as yps,isnull(yfs,0) as yfs,isnull(yss,0) as yss,isnull(kc,0) as kc,isnull(wfh,0) as wfh,isnull(zt,0) as zt from "&tmps
cd.CommandText = sql
set rs=cd.Execute

%><div id="gt1" style="height:100%;width:100%">
<table width="100%" border="1">
<thead>
  <tr>
    <th width="17%">货号</th>
    <th width="8%">颜色</th>
    <th width="9%">订货数</th>
    <th width="7%">已登帐</th>
    <th width="6%">已配</th>
    <th width="7%">已发</th>
    <th width="7%">已收</th>
    <th width="7%">在途</th>
    <th width="10%">订补发差</th>
    <th width="10%">目前库存</th>
    <th width="9%">虚拟库存</th>
    <th width="3%">&nbsp;</th>
  </tr>
  </thead>
  <%dim i
  i=0
  while not rs.eof
  i=i+1%>
  <tr id="<%=i%>">
    <td><%=rs("clothingid")%></td>
    <td>&nbsp;</td>
    <td><%=rs("dhs")%></td>
    <td><%=rs("yds")%></td>
    <td><%=rs("yps")%></td>
    <td><%=rs("yfs")%></td>
    <td><%=rs("yss")%></td>
    <td><%'=rs("yfs")-rs("yss")%><%=rs("zt")%></td>
    <td><%'=rs("dhs")-rs("yfs")%><%=rs("wfh")%></td>
    <td><%=rs("kc")%></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <%rs.movenext
  wend
  rs.close
  set rs=nothing%>
</table>
</div>
<script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
<%
    sql="drop table "&tmp
    cd.CommandType =1
    cd.CommandText = sql
    cd.Execute
  
    sql="drop table "&tmps
    cd.CommandText = sql
    cd.Execute
set cd=nothing
%>
</body>
</html>
