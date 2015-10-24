<%'on error resume next%>
<!--#include file="inc/function.asp" -->
<%dim ds
set ds=server.CreateObject("ADODB.Recordset")
    ds.activeconnection = cn%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="inc/abc.js"></script>
<style type="text/css">
a {color:#0000FF;}
body {
	overflow:hidden;
}
</style>
<script language="javascript">
function cid(styleid){
  showModalDialog("create_indent_dhh.asp?id="+styleid,"","dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no");
}

function style(id){
  showModalDialog('style.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}

function cf(t){
  if(isDigital(t.num.value)){
    if(parseInt(t.num.value)!=0){
      t.nums.value=t.num.value;
      return true;
	}else{
	  return false;
	}
  }else{
    alert("必须输入整数!");
	t.num.focus();
	t.num.select();
    return false;
  }
}
function goto(str){
  window.location.href="f22_bh_top.asp?dl="+str;
}

</script>
</head>

<body>
<%dim cid
cid=trim(request.QueryString("cid"))
if cid="" then
  cid=0
else
  cid=cint(cid)
end if

dim num1,num2,depotid,depotname,userid,dl
num1=trim(request.QueryString("num1"))
num2=trim(request.QueryString("num2"))
depotid=session("dm").System_DepotId
depotname=session("dm").System_DepotName
userid=session("dm").System_UserId
dl=trim(request.QueryString("dl"))
select case cid
case 0
  if num1="" then
    num1=0
  else
    num1=cint(num1)
  end if
  if num2="" then
    num2=10
  else
    num2=cint(num2)
  end if
case 1
  if num1="" then
    num1=30
  else
    num1=cint(num1)
  end if
  if num2="" then
    num2=20
  else
    num2=cint(num2)
  end if
end select
%>
<table width="100%"  border="0" class="bar">
  <tr>
    <td height="20" align="center"><font color="#FF0000"><%=session("dm").System_depotname%></font> 补货</td>
  </tr>
</table>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" bordercolor="#EBD4D0" class="bkf12">
  <tr>
    <td>补货方式: <a href="f22_bh_top.asp?cid=0"><%if cid=0 then %><font color="#FF0000">按目前库存</font><%else%>按目前库存<%end if%></a> <a href="f22_bh_top.asp?cid=1"><%if cid=1 then %><font color="#FF0000">按销售量</font><%else%>按销售量<%end if%></a> <a href="f22_bh_top.asp?cid=2"><%if cid=2 then %><font color="#FF0000">按补货建议</font><%else%>按补货建议<%end if%></a> </td>
  </tr>
</table>
<form name="form1" method="get" action="">
<%
select case cid
case 0%>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" bordercolor="#EBD4D0" class="bkf12">
  <tr>
    <td><a href="f22_bh_top.asp?cid=0">
    </a>
      
        库存范围:
        <input name="num2" type="text" id="num2" value="<%=num2%>" size="5" maxlength="5">
        <input type="submit" name="Submit" value="查询"> 
        <input name="rad" type="radio" value="" checked onClick="goto('')">
        全部
		<%
	
	sql="select lookcode,lookname from j18_lookupsub where lookupid=2002 order by lookcode"
	ds.source = sql
	ds.open
	while not ds.eof
	%>
	<input type="radio" name="rad" value="<%=ds(0)%>" onClick="goto('<%=ds(1)%>')" <%if dl=trim(ds(1)) then response.Write " checked" end if%>><%=ds(1)%>
	<%ds.movenext
	 wend
	 ds.close
	 %>
        <input name="cid" type="hidden" id="cid" value="<%=cid%>"> 
      (按库存数量从小到大排序)</td>
  </tr>
</table>
<%case 1%>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" bordercolor="#EBD4D0" class="bkf12">
  <tr>
    <td><a href="f22_bh_top.asp?cid=0"> </a> 销售天数:
        <input name="num1" type="text" id="num1" value="<%=num1%>" size="5" maxlength="5">
      <input name="cid" type="hidden" id="cid" value="<%=cid%>"> 
      名次:
      <input name="num2" type="text" id="num2" value="<%=num2%>" size="5" maxlength="5">
      <input type="submit" name="Submit" value="查询"></td>
  </tr>
</table>
<%end select%>
</form>
<%yr=year(date)
  mth=month(date)
  pmth=mth-1
  dt=get_date(date)
  week=get_date(date-7)
%>
<table width="100%" border="0" class="bkf12">
  <tr>
    <td width="9%" bgcolor="#FCF5F3">上月销售额:</td>
	<%sql="select isnull(sum(isnull(nums,0)*s_price),0) from d_retailsub a,d_retail b,webp_depot c where a.retailid=b.retailid and b.depotid=c.depotid and c.userid="&qts(userid)&" and year(b.setdate)="&yr&" and month(b.setdate)="&pmth
	ds.source = sql
	ds.open%>
    <td width="5%"><%=ds(0)%></td>
	<%ds.close%>
    <td width="10%" bgcolor="#FCF5F3">本月销售额:</td>
	<%sql="select isnull(sum(isnull(nums,0)*s_price),0) from d_retailsub a,d_retail b,webp_depot c where a.retailid=b.retailid and b.depotid=c.depotid and c.userid="&qts(userid)&" and year(b.setdate)="&yr&" and month(b.setdate)="&mth
	ds.source = sql
	ds.open%>
    <td width="7%"><%=ds(0)%></td>
	<%ds.close%>
    <td width="11%" bgcolor="#FCF5F3">前七天销售额:</td>
	<%sql="select isnull(sum(isnull(nums,0)*s_price),0) from d_retailsub a,d_retail b,webp_depot c where a.retailid=b.retailid and b.depotid=c.depotid and c.userid="&qts(userid)&" and b.setdate between getdate()-7 and getdate()"
	ds.source = sql
	ds.open%>
    <td width="8%"><%=ds(0)%></td>
	<%ds.close%>
    <td width="9%" bgcolor="#FCF5F3">本月销售目标:</td>
	
    <td width="8%"><%'=ds(0)%></td>
	
    <td width="11%" bgcolor="#FCF5F3">本月目标达成率:</td>
    <td width="7%">&nbsp;</td>
  </tr>
</table>
<%
dim cd,tmp,tmps,rs
set cd=Server.Createobject("ADODB.Command")
cd.ActiveConnection = cn
cd.CommandType = 1
randomize
tmp="#tmp"&replace(cstr(rnd+1),".","")
tmp1="#tmp1"&replace(cstr(rnd+1),".","")
tmps="#tmps"&replace(cstr(rnd+1),".","")
'de tmp&"<br>"&tmps
'call droptmp()
select case cid
case 0
 call calkc()
 
 '填充数据
 sql="insert into "&tmps& _
 	" select clothingid,max(styleid),max(s_name),max(colorid),max(c_name),max(sizeid),isnull(sum(nums),0) as nums,max(j_price),"& _
	" max(selltype),sum(syxs),sum(byxs),sum(bzxs),sum(pjxsl),sum(wfh),sum(xlkc),sum(aqkc) ,sum(bhjy)"& _
	" from "&tmp&" group by clothingid order by sum(nums)"
 cd.CommandText = sql
 cd.Execute
	'de sql
 
case 1

  dt=date-num1
  'de dt
   call calxs()
 '填充数据
 sql="insert into "&tmps&" select clothingid,max(styleid),max(s_name),max(colorid),max(c_name),max(sizeid),isnull(sum(nums),0) as nums,max(j_price),max(selltype),sum(syxs),sum(byxs),sum(bzxs),sum(pjxsl),sum(wfh),sum(xlkc),sum(aqkc),sum(bhjy) from "&tmp&" group by clothingid order by sum(xnums) desc"
 cd.CommandText = sql
 cd.Execute

case 2

 call calbh()
 
 '填充数据
 sql="insert into "&tmps& _
 	" select clothingid,max(styleid),max(s_name),max(colorid),max(c_name),max(sizeid),isnull(sum(nums),0) as nums,max(j_price),"& _
	" max(selltype),sum(syxs),sum(byxs),sum(bzxs),sum(pjxsl),sum(wfh),sum(xlkc),sum(aqkc) ,avg(bhjy)"& _
	" from "&tmp&" group by clothingid order by sum(bhjy) desc"
 cd.CommandText = sql
 cd.Execute

end select
'de sql%>

<table width="100%"  border="1" cellpadding="0" cellspacing="0" bordercolor="#EBD4D0" bordercolorlight="#FFFFFF" class="bkf12">
  <tr align="center" bgcolor="#FCF5F3">
    <td width="12%">货号</td>
    <td width="9%">产品名称</td>
    <td width="10%">产品型号</td>
    <td width="8%">颜色</td>
    <td width="4%">规格</td>
    <td width="5%">单价</td>
    <td width="9%">销售类型</td>
    <td width="4%">上月销售</td>
    <td width="4%">本月销售</td>
    <td width="4%">七天销售</td>
    <td width="6%">现库存</td>
    <td width="6%">未发货数量</td>
    <td width="7%">补货建议</td>
    <td width="12%">实际订货数</td>
	<td width="10px">&nbsp;&nbsp;</td>
  </tr>
</table><div class="broad">
  <%select case cid
    case 0
      sql="select * from "&tmps
	case 1
	  sql="select top "&num2&" * from "&tmps
	case 2
      sql="select * from "&tmps
	end select
    ds.source =sql
	
	ds.open
	i=0
	while not ds.eof
	i=i+1
	%>
	
<table width="100%"  border="1" cellpadding="0" cellspacing="0" bordercolor="#EBD4D0" bordercolorlight="#FFFFFF" class="bkf12">
  <tr>
    <td width="12%"><a href="javascript:style('<%=ds("styleid")%>')"><%=ds("clothingid")%></a></td>
    <td width="9%"><%=ds("s_name")%>&nbsp;</td>
    <td width="10%"><%=ds("styleid")%>&nbsp;</td>
    <td width="8%"><%=ds("c_name")%>(<span class="au"><%=ds("colorid")%></span>)</td>
    <td width="4%"><%=ds("sizeid")%></td>
	<%cd.ActiveConnection = cn
	cd.CommandType = 4
	cd.CommandText = "t18tj_Getstyleprice"
	cd.Parameters.Append cd.CreateParameter("@dtype",adInteger,adParamInput,4,1)
	cd.Parameters.Append cd.CreateParameter("@depotid",adVarchar,adParamInput,10,depotid)
	cd.Parameters.Append cd.CreateParameter("@styleid",adVarchar,adParamInput,34,ds("styleid"))
	'cd.Parameters.Append cd.CreateParameter("@pricedate",adVarchar,adParamInput,10,"")
	set rs=cd.execute%>
    <td width="5%"><%if not rs.eof then response.Write rs("s_price") end if%></td>
	<%set rs=nothing
	cd.Parameters.delete 2
	cd.Parameters.delete 1
	cd.Parameters.delete 0
	%>
	
    <td width="9%"><%=ds("selltype")%>&nbsp;</td>
    <td width="4%" align="center"><%=ds("syxs")%>&nbsp;</td>
    <td width="4%" align="center"><%=ds("byxs")%>&nbsp;</td>
    <td width="4%" align="center"><%=ds("bzxs")%>&nbsp;</td>
    <td width="6%" align="center"><span class="notice"><%=ds("nums")%>&nbsp;</span></td>
    <td width="6%" align="center"><%if ds("wfh")>0 then%><span class="notice"><%=ds("wfh")%></span><%end if%>&nbsp;</td>
    <td width="7%" align="center"><span class="notice"><%=ds("bhjy")%>&nbsp;</span></td>
    <td width="12%"><form action="f22_bh_save.asp" method="get" name="form2" target="bottomFrame" onSubmit="return cf(this);">
      <input name="clothingid" type="hidden" id="clothingid" value="<%=ds("clothingid")%>">
      <input name="num" type="text" id="num" size="5" maxlength="5" autocomplete="off">
      <input type="submit" name="Submit" value="确定">
      <input name="nums" type="hidden" id="nums">
    </form></td>
  </tr>
  
  <%
  ds.movenext
wend
ds.close
set ds=nothing
call droptmp()
set cd=Nothing
%>
<tr>
    <td><%=i%></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

<%
sub droptmp()
  'on error resume next
    sql="drop table "&tmp
    cd.CommandType =1
    cd.CommandText = sql
    cd.Execute
    sql="drop table "&tmp1
    cd.CommandText = sql
    cd.Execute
    sql="drop table "&tmps
    cd.CommandText = sql
    cd.Execute
end sub
%>

<%
sub calkc()

 sql="create table "&tmp&"(clothingid varchar(30),styleid varchar(20),s_name varchar(20),colorid varchar(10),c_name varchar(10),sizeid varchar(10)"& _
 ",nums int,j_price numeric(8,2),selltype varchar(20),syxs int ,byxs int,bzxs int,pjxsl numeric(8,2),wfh int,xlkc int,aqkc int,bhjy int)"
 cd.CommandText = sql
 cd.Execute
 
 sql="create table "&tmp1&"(clothingid varchar(30),styleid varchar(20),s_name varchar(20),colorid varchar(10),c_name varchar(10),sizeid varchar(10)"& _
 ",nums int,j_price numeric(8,2),selltype varchar(20),syxs int ,byxs int,bzxs int,pjxsl numeric(8,2),wfh int,xlkc int,aqkc int,bhjy int)"
 cd.CommandText = sql
 cd.Execute

 '查货号,款号,颜色,尺码,目前库存
 if dl<>"" then
   dl=" and b.st_dl="&qts(dl)
 end if
 sql="insert into "&tmp&"(clothingid,styleid,s_name,colorid,c_name,sizeid,nums,selltype) "& _
    " select a.clothingid,max(a.styleid),max(b.s_name),max(a.colorid),max(c.c_name),max(a.sizeid),sum(a.k_num) as nums,max(b.st_usetype) " & _
	" from  J_stock a,j_style b,j_color c,webp_depot d,j_stylesort jss  " & _
	" where a.styleid=b.styleid  and a.colorid=c.colorid" &dl& _
	" and a.depotid=d.depotid and d.userid="&qts(userid) & _
	" and jss.styleid=a.styleid and jss.sort1<>'历史' and jss.sort2<>'新'"& _
	" group by a.clothingid having sum(a.k_num) <="&num2& _
	" order by nums"
	'de sql
 cd.CommandText = sql
 cd.Execute
 sql="insert into "&tmp1&"(clothingid,styleid,s_name,colorid,c_name,sizeid,nums,selltype) "& _
 	 " select clothingid,styleid,s_name,colorid,c_name,sizeid,nums,selltype"& _
	 " from "&tmp
 cd.CommandText = sql
 cd.Execute
 '插入上月销售	 
	'de sql
	 
 sql=" insert into "&tmp&"(clothingid,syxs) "& _
 	 " select a.clothingid,isnull(sum(a.nums),0)"& _
	 "  from d_retailsub a ,d_retail b,webp_depot d,"&tmp1&" c "& _
	 " where a.retailid=b.retailid and b.depotid=d.depotid and d.userid="&qts(userid)& _
	 " and year(b.setdate)="&yr&" and month(b.setdate)="&pmth& _
	 " and a.clothingid=c.clothingid " & _
	 " group by a.clothingid "
 cd.CommandText = sql
 cd.Execute
 
 '插入本月销售
	 
 sql=" insert into "&tmp&"(clothingid,byxs) "& _
 	 " select a.clothingid,isnull(sum(a.nums),0)"& _
	 "  from vd_retailsub a ,webp_depot d,"&tmp1&" c "& _
	 " where a.depotid=d.depotid and d.userid="&qts(userid)& _
	 " and year(a.setdate)="&yr&" and month(a.setdate)="&mth& _
	 " and a.clothingid=c.clothingid " & _
	 " group by a.clothingid "
	 'de sql
 cd.CommandText = sql
 cd.Execute
 
'插入本周销售
 sql=" insert into "&tmp&"(clothingid,bzxs) "& _
 	 " select a.clothingid,isnull(sum(a.nums),0)"& _
	 "  from vd_retailsub a ,webp_depot d,"&tmp1&" c "& _
	 " where a.depotid=d.depotid and d.userid="&qts(userid)& _
	 " and year(a.setdate)="&yr&" and month(a.setdate)="&mth& _
	 " and a.clothingid=c.clothingid " & _
	 " group by a.clothingid "
 cd.CommandText = sql
 cd.Execute
 
 '插入未发货数
 dim s1,s2
 
   s2= " select sum(d.set_nums) from d_sellsub d,d_sell e,webp_depot f"& _
	   " where d.sellid=e.sellid and e.get_depotid=f.depotid"& _
	   " and a.clothingid=d.clothingid and f.userid="&qts(userid)& _
	   " group by d.clothingid"
	   
  s1 = " select sum(g.nums) from d_indentsub g,d_indent h,webp_depot i"& _
	   " where g.indentid=h.indentid and h.get_depotid=i.depotid"& _
	   " and a.clothingid=g.clothingid and i.userid="&qts(userid)& _
	   " group by g.clothingid"
	   
 sql = " insert into "&tmp&"(clothingid,wfh) "& _
	   " select a.clothingid,("&s1&")-("&s2&") from d_sellsub a,d_sell b,webp_depot c,"&tmp1&" j"& _
	   " where a.sellid=b.sellid and b.get_depotid=c.depotid"& _
	   " and c.userid="&qts(userid)& _
	   " and j.clothingid=a.clothingid "& _
	   " group by a.clothingid"
	   'de sql
 cd.CommandText = sql
 cd.Execute

 '插入补货建议
  sql = " insert into "&tmp&"(clothingid,bhjy) "& _ 
  		" select j.clothingid,b.nums from d_indentadvicesub b,"&tmp1&" j"& _
		" where b.indentadviceid=(select top 1 a.indentadviceid from d_indentadvice a where a.depotid="&qts(depotid)&" order by a.cr_date desc)"& _
		" and b.clothingid=j.clothingid"
 cd.CommandText = sql
 cd.Execute

 '建结果表
 sql="create table "&tmps&"(clothingid varchar(30),styleid varchar(20),s_name varchar(20),colorid varchar(10),c_name varchar(10),sizeid varchar(10)"& _
 ",nums int,j_price numeric(8,2),selltype varchar(20),syxs int ,byxs int,bzxs int,pjxsl numeric(8,2),wfh int,xlkc int,aqkc int,bhjy int)"
 cd.CommandText = sql
 cd.Execute

end sub

sub calxs()

 sql="create table "&tmp&"(clothingid varchar(30),styleid varchar(20),s_name varchar(20),colorid varchar(10),c_name varchar(10),sizeid varchar(10)"& _
 ",nums int,j_price numeric(8,2),selltype varchar(20),syxs int ,byxs int,bzxs int,pjxsl numeric(8,2),wfh int,xlkc int,aqkc int,xnums int,bhjy int)"
 cd.CommandText = sql
 cd.Execute
 sql="create table "&tmp1&"(clothingid varchar(30),styleid varchar(20),s_name varchar(20),colorid varchar(10),c_name varchar(10),sizeid varchar(10)"& _
 ",nums int,j_price numeric(8,2),selltype varchar(20),syxs int ,byxs int,bzxs int,pjxsl numeric(8,2),wfh int,xlkc int,aqkc int,xnums int,bhjy int)"
 cd.CommandText = sql
 cd.Execute
 '查货号,款号,颜色,尺码,销售数量
 sql="insert into "&tmp&"(clothingid,styleid,selltype,s_name,colorid,c_name,sizeid,xnums) "& _
 	 " select top "&num2&" max(a.clothingid),max(a.styleid),max(b.st_usetype),max(b.s_name),max(a.colorid),max(c.c_name),max(a.sizeid),sum(a.nums) as nums "& _
	 " from vd_retailsub a,j_style b,j_color c,webp_depot d,j_stylesort jss  " & _
	 " where a.styleid=b.styleid and a.colorid=c.colorid"& _
	 " and a.depotid=d.depotid and d.userid="&qts(userid) & _
	 " and jss.styleid=a.styleid and jss.sort1<>'历史'"& _
	 " and a.setdate >="&qts(dt) & _
	 " group by a.clothingid order by sum(a.nums) desc"
	 'de sql
 cd.CommandText = sql
 cd.Execute
 sql=" insert into "&tmp1&"(clothingid,styleid,s_name,colorid,c_name,sizeid,xnums) "& _
 	 " select clothingid,styleid,s_name,colorid,c_name,sizeid,xnums"& _
	 " from "&tmp
 cd.CommandText = sql
 cd.Execute
 '插入库存
 sql="insert into "&tmp&"(clothingid,nums) "& _
    " select a.clothingid,a.k_num as nums " & _
	" from  J_stock a, webp_depot b,"&tmp1&" f"& _
	" where a.clothingid=f.clothingid and a.depotid=b.depotid and b.userid="&qts(userid)
 cd.CommandText = sql
 cd.Execute

 '插入上月销售
 sql=" insert into "&tmp&"(clothingid,syxs) "& _
 	 " select a.clothingid,isnull(sum(a.nums),0)"& _
	 "  from vd_retailsub a , webp_depot b,"&tmp1&" e"& _
	 " where year(a.setdate)="&yr&" and month(a.setdate)="&pmth&" and "& _
	 "  a.clothingid=e.clothingid and a.depotid=b.depotid and b.userid="&qts(userid)& _
	 " group by a.clothingid"
	'de sql
 cd.CommandText = sql
 cd.Execute
 
 '插入本月销售
 sql=" insert into "&tmp&"(clothingid,byxs) "& _
 	 " select a.clothingid,isnull(sum(a.nums),0)"& _
	 "  from vd_retailsub a ,webp_depot d, "&tmp1&" e"& _
	 " where  a.depotid=d.depotid and d.userid="&qts(userid)& _
	 " and year(a.setdate)="&yr&" and month(a.setdate)="&mth&" and "& _
	 "  a.clothingid=e.clothingid group by a.clothingid"
 cd.CommandText = sql
 cd.Execute
 
'插入本周销售
 sql="insert into "&tmp&"(clothingid,bzxs) "& _
 	"select a.clothingid ,isnull(sum(a.nums),0)"& _
	" from vd_retailsub a,webp_depot b, "&tmp1&" e"& _
	" where a.depotid=b.depotid and b.userid="&qts(userid)&" and a.setdate between getdate()-7 and getdate() "& _
	" and a.clothingid=e.clothingid  group by a.clothingid "
 cd.CommandText = sql
 cd.Execute
 
 '插入补货建议
  sql = " insert into "&tmp&"(clothingid,bhjy) "& _ 
  		" select j.clothingid,b.nums from d_indentadvicesub b,"&tmp1&" j"& _
		" where b.indentadviceid=(select top 1 a.indentadviceid from d_indentadvice a where a.depotid="&qts(depotid)&" order by a.cr_date desc)"& _
		" and b.clothingid=j.clothingid"
 cd.CommandText = sql
 cd.Execute
 
 '建结果表
 sql="create table "&tmps&"(clothingid varchar(30),styleid varchar(20),s_name varchar(20),colorid varchar(10),c_name varchar(10),sizeid varchar(10)"& _
 ",nums int,j_price numeric(8,2),selltype varchar(20),syxs int ,byxs int,bzxs int,pjxsl numeric(8,2),wfh int,xlkc int,aqkc int,bhjy int)"
 cd.CommandText = sql
 cd.Execute

end sub


sub calbh()

 sql="create table "&tmp&"(clothingid varchar(30),styleid varchar(20),s_name varchar(20),colorid varchar(10),c_name varchar(10),sizeid varchar(10)"& _
 ",nums int,j_price numeric(8,2),selltype varchar(20),syxs int ,byxs int,bzxs int,pjxsl numeric(8,2),wfh int,xlkc int,aqkc int,bhjy int)"
 cd.CommandText = sql
 cd.Execute
 
 sql="create table "&tmp1&"(clothingid varchar(30),styleid varchar(20),s_name varchar(20),colorid varchar(10),c_name varchar(10),sizeid varchar(10)"& _
 ",nums int,j_price numeric(8,2),selltype varchar(20),syxs int ,byxs int,bzxs int,pjxsl numeric(8,2),wfh int,xlkc int,aqkc int,bhjy int)"
 cd.CommandText = sql
 cd.Execute
 
  sql = " insert into "&tmp&"(clothingid,styleid,s_name,colorid,c_name,sizeid,selltype,bhjy) "& _ 
  		" select distinct b.clothingid,jst.styleid,jst.s_name,jc.colorid,jc.c_name,jcth.sizeid,jst.st_usetype,b.nums "& _
		" from d_indentadvicesub b,j_style jst,j_color jc,j_stylesort jss ,j_clothing jcth"& _
		" where b.clothingid=jcth.clothingid and jcth.styleid=jst.styleid and jcth.colorid=jc.colorid and jss.styleid=jst.styleid and "& _ 
		" jss.sort1<>'历史' and "& _
		" b.indentadviceid=(select top 1 a.indentadviceid from d_indentadvice a where sure>0 and a.depotid="&qts(depotid)& _
		" order by a.cr_date desc,indentadviceid desc)"& _
		" and b.clothingid=jcth.clothingid and b.nums>0"
		'de sql
 cd.CommandText = sql
 cd.Execute

 sql="insert into "&tmp1&"(clothingid,styleid,s_name,colorid,c_name,sizeid,nums,selltype) "& _
 	 " select clothingid,styleid,s_name,colorid,c_name,sizeid,nums,selltype"& _
	 " from "&tmp
 cd.CommandText = sql
 cd.Execute
 
 '查目前库存
 sql=" insert into "&tmp&"(clothingid,nums) "& _
 	 " select a.clothingid,a.k_num from j_stock a ,webp_depot b ,"&tmp1&" j"& _
	 " where a.clothingid=j.clothingid and a.depotid=b.depotid and b.userid="&qts(userid)
	'de sql
 cd.CommandText = sql
 cd.Execute

 '插入上月销售	 
	'de sql
	 
 sql=" insert into "&tmp&"(clothingid,syxs) "& _
 	 " select a.clothingid,isnull(sum(a.nums),0)"& _
	 "  from d_retailsub a ,d_retail b,webp_depot d,"&tmp1&" c "& _
	 " where a.retailid=b.retailid and b.depotid=d.depotid and d.userid="&qts(userid)& _
	 " and year(b.setdate)="&yr&" and month(b.setdate)="&pmth& _
	 " and a.clothingid=c.clothingid " & _
	 " group by a.clothingid "
 cd.CommandText = sql
 cd.Execute
 
 '插入本月销售
	 
 sql=" insert into "&tmp&"(clothingid,byxs) "& _
 	 " select a.clothingid,isnull(sum(a.nums),0)"& _
	 "  from vd_retailsub a ,webp_depot d,"&tmp1&" c "& _
	 " where a.depotid=d.depotid and d.userid="&qts(userid)& _
	 " and year(a.setdate)="&yr&" and month(a.setdate)="&mth& _
	 " and a.clothingid=c.clothingid " & _
	 " group by a.clothingid "
	 'de sql
 cd.CommandText = sql
 cd.Execute
 
'插入本周销售
 sql=" insert into "&tmp&"(clothingid,bzxs) "& _
 	 " select a.clothingid,isnull(sum(a.nums),0)"& _
	 "  from vd_retailsub a ,webp_depot d,"&tmp1&" c "& _
	 " where a.depotid=d.depotid and d.userid="&qts(userid)& _
	 " and year(a.setdate)="&yr&" and month(a.setdate)="&mth& _
	 " and a.clothingid=c.clothingid " & _
	 " group by a.clothingid "
 cd.CommandText = sql
 cd.Execute
 
 '插入未发货数
 dim s1,s2
 
   s2= " select sum(d.set_nums) from d_sellsub d,d_sell e,webp_depot f"& _
	   " where d.sellid=e.sellid and e.get_depotid=f.depotid"& _
	   " and a.clothingid=d.clothingid and f.userid="&qts(userid)& _
	   " group by d.clothingid"
	   
  s1 = " select sum(g.nums) from d_indentsub g,d_indent h,webp_depot i"& _
	   " where g.indentid=h.indentid and h.get_depotid=i.depotid"& _
	   " and a.clothingid=g.clothingid and i.userid="&qts(userid)& _
	   " group by g.clothingid"
	   
 sql = " insert into "&tmp&"(clothingid,wfh) "& _
	   " select a.clothingid,("&s1&")-("&s2&") from d_sellsub a,d_sell b,webp_depot c,"&tmp1&" j"& _
	   " where a.sellid=b.sellid and b.get_depotid=c.depotid"& _
	   " and c.userid="&qts(userid)& _
	   " and j.clothingid=a.clothingid "& _
	   " group by a.clothingid"
	   'de sql
 cd.CommandText = sql
 cd.Execute

 '插入补货建议
  sql = " insert into "&tmp&"(clothingid,bhjy) "& _ 
  		" select j.clothingid,b.nums from d_indentadvicesub b,"&tmp1&" j"& _
		" where b.indentadviceid=(select top 1 a.indentadviceid from d_indentadvice a where a.depotid="&qts(depotid)&" order by a.cr_date desc)"& _
		" and b.clothingid=j.clothingid"
 cd.CommandText = sql
 cd.Execute

 '建结果表
 sql="create table "&tmps&"(clothingid varchar(30),styleid varchar(20),s_name varchar(20),colorid varchar(10),c_name varchar(10),sizeid varchar(10)"& _
 ",nums int,j_price numeric(8,2),selltype varchar(20),syxs int ,byxs int,bzxs int,pjxsl numeric(8,2),wfh int,xlkc int,aqkc int,bhjy int)"
 cd.CommandText = sql
 cd.Execute

end sub

%>
</table>
</div>
</body>
</html>
