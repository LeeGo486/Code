<%Dim act
act=request("act")
if cint(act)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if%>
<!--#include file="inc/function.asp" -->
<%if cint(act)<>2 then%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>查询结果</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<script language="javascript">
function op(url){
showModalDialog(url,'example05','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no');
}
</script>
</head>
<body>
<%end if%>
<%f_date=request.form("f_date")
  l_date=request.form("l_date")
  seachtype=request.form("seachtype")
  showdepot=request.form("showdepot")
  order=request.Form("order")
'控制查询天数
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","b.sure_date")
end if 
select case seachtype
case 1
   sname="年 份" 
   select case order
   case 0 orderby=" order by a.st_year"
   case 1 orderby=" order by sum(c.nums) desc"
   case 2 orderby=" order by sum(c.nums*c.s_price) desc"
   end select
   if showdepot=1 then
      a1="a.st_year,d.d_name,sum(isnull(c.nums,0)) as nums,sum(isnull(c.nums*c.s_price,0)) as price "
	  b1="group by a.st_year,d.d_name "&orderby
   else
      a1="a.st_year,sum(isnull(c.nums,0)) as nums,sum(isnull(c.nums*c.s_price,0)) as price "
	  b1="group by a.st_year "&orderby
   end if
case 2
   sname="季 节"
   select case order
   case 0 orderby=" order by a.st_month"
   case 1 orderby=" order by sum(c.nums) desc"
   case 2 orderby=" order by sum(c.nums*c.s_price) desc"
   end select 
   if showdepot=1 then
      a1="a.st_month,d.d_name,sum(isnull(c.nums,0)) as nums,sum(isnull(c.nums*c.s_price,0)) as price "
	  b1="group by a.st_month,d.d_name "&orderby
   else
      a1="a.st_month,sum(isnull(c.nums,0)) as nums,sum(isnull(c.nums*c.s_price,0)) as price "
	  b1="group by a.st_month "&orderby
   end if
case 3
   sname="种 类" 
   select case order
   case 0 orderby=" order by a.st_xl"
   case 1 orderby=" order by sum(c.nums) desc"
   case 2 orderby=" order by sum(c.nums*c.s_price) desc"
   end select
   if showdepot=1 then
      a1="a.st_xl,d.d_name,sum(isnull(c.nums,0)) as nums,sum(isnull(c.nums*c.s_price,0)) as price "
	  b1="group by a.st_xl,d.d_name "&orderby
   else
      a1="a.st_xl,sum(isnull(c.nums,0)) as nums,sum(isnull(c.nums*c.s_price,0)) as price "
	  b1="group by a.st_xl "&orderby
   end if
case 4
   sname="大 类" 
   select case order
   case 0 orderby=" order by a.st_dl"
   case 1 orderby=" order by sum(c.nums) desc"
   case 2 orderby=" order by sum(c.nums*c.s_price) desc"
   end select
   if showdepot=1 then
      a1="a.st_dl,d.d_name,sum(isnull(c.nums,0)) as nums,sum(isnull(c.nums*c.s_price,0)) as price "
	  b1="group by a.st_dl,d.d_name "&orderby
   else
      a1="a.st_dl,sum(isnull(c.nums,0)) as nums,sum(isnull(c.nums*c.s_price,0)) as price "
	  b1="group by a.st_dl "&orderby
   end if
case 5
   sname="小 类"
   select case order
   case 0 orderby=" order by a.st_xz"
   case 1 orderby=" order by sum(c.nums) desc"
   case 2 orderby=" order by sum(c.nums*c.s_price) desc"
   end select 
   if showdepot=1 then
      a1="a.st_xz,d.d_name,sum(isnull(c.nums,0)) as nums,sum(isnull(c.nums*c.s_price,0)) as price "
	  b1="group by a.st_xz,d.d_name "&orderby
   else
      a1="a.st_xz,sum(isnull(c.nums,0)) as nums,sum(isnull(c.nums*c.s_price,0)) as price "
	  b1="group by a.st_xz "&orderby
   end if
case 6
   sname="品 牌"
   select case order
   case 0 orderby=" order by drname"
   case 1 orderby=" order by sum(c.nums) desc"
   case 2 orderby=" order by sum(c.nums*c.s_price) desc"
   end select 
   if showdepot=1 then
      a1="isnull(e.drname,'无') as drname,d.d_name,sum(isnull(c.nums,0)) as nums,sum(isnull(c.nums*c.s_price,0)) as price "
	  b1="group by drname,d.d_name "&orderby
   else
      a1="isnull(e.drname,'无') as drname,sum(isnull(c.nums,0)) as nums,sum(isnull(c.nums*c.s_price,0)) as price "
	  b1="group by drname "&orderby
   end if
end select
if seachtype=6 then
sql="select "&a1&" from j_style a left join j_brand e on e.drandid=a.brandid,d_retail b,d_retailsub c,j_depot d "
else
sql="select "&a1&" from j_style a,d_retail b,d_retailsub c,j_depot d"
end if
sql=sql&" where b.depotid='"&session("dm").System_Depotid&"' "
sql=sql&" and a.styleid=c.styleid and c.retailid=b.retailid and isnull(b.sure,0)>0 and b.depotid=d.depotid "&qrydaytj
sql=sql&" and convert(char(10),b.sure_date,126) between '"&f_date&"' and '"&l_date&"' "&b1
'de sql
%>

<%set rs=server.CreateObject("adodb.recordset")
rs.open sql,cn,1,1%>

<%if cint(act)<>2 then%>

<table width="100%" border="0" cellspacing="0">
<form name="form1" method="post" action="f22qry_retail_lb_seach_mx.asp">
<input type="hidden" name="f_date" value="<%=f_date%>">
<input type="hidden" name="l_date" value="<%=l_date%>">
<input type="hidden" name="seachtype" value="<%=seachtype%>">
<input type="hidden" name="showdepot" value="<%=showdepot%>">
<input type="hidden" name="order" value="<%=order%>">
<input type="hidden" name="act" value="2">
  <tr>
    <td><font size="2">当前位置：--&gt; 销售查询 --&gt; 销售查询-按类别综合</font></td>
	<td align="right"><input type="button" name="but" value="导出Excel" onClick="document.all.form1.submit();"></td>
    <td><div align="right"><input type="button" name="but1" value="返 回" onClick="location='f22qry_retail_lb_seach.asp'"></div></td>
  </tr>
</form>
</table>
<hr size="2">

<%end if%>

<%if not rs.eof then
if showdepot=1 then show1() else show2() end if
sub show1()%>
<font color="#FF0000" size="2">开始日期：<%=f_date%> 结束日期：<%=l_date%></font>
<table width="500" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr bgcolor="#336699"> 
    <td><div align="center"><font color="#FFFF00" size="2"><%=sname%></font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">销售店铺</font></div></td>
    <td><div align="center"><font size="2" color="#FFFF00">销售数量</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">销售金额</font></div></td>
  </tr>
  <%z1=0
   zz1=0
  z2=0
  zz2=0
  ss1=rs(0)
  while not rs.eof
  if ss1=rs(0) then%>
  <tr>
    <td><div align="center"><font size="2"><a href="javascript:op(f22qry_retail_lb_seach_mx_sub.asp?act=<%=seachtype%>&types=<%=rs(0)%>&fdate=<%=f_date%>&ldate=<%=l_date%>')">
	                                       <%if s1<>rs(0) then
	                                            response.write(rs(0))
												s1=rs(0)
											 else response.write("&nbsp;") end if%></a></font></div></td>
	<td><div align="center"><font size="2"><%=rs(1)%></font></div></td>
	<td><div align="center"><font size="2"><%response.write(rs(2))
	                                         z1=z1+rs(2)%></font></div></td>
	<td><div align="center"><font size="2"><%response.write(rs(3))
	                                         z2=z2+round(rs(3),2)%></font></div></td>
  </tr>
  <%else%>
  <tr bgcolor="#00FFFF">
    <td colspan=2><div align="center"><font size="2" color="#FF0000">小 计</font></div></td>
	<td><div align="center"><font size="2" color="#FF0000"><%=z1%></font></div></td>
	<td><div align="center"><font size="2" color="#FF0000">￥ <%=z2%></font></div></td>
  </tr>
  <%zz1=zz1+z1
   zz2=zz2+z2
   z1=0
   z2=0
   ss1=rs(0)
   rs.movePrevious
  end if
  rs.movenext
  wend%>
 <tr bgcolor="#00FFFF">
    <td colspan=2><div align="center"><font size="2" color="#FF0000">小 计</font></div></td>
	<td><div align="center"><font size="2" color="#FF0000"><%=z1%></font></div></td>
	<td><div align="center"><font size="2" color="#FF0000">￥ <%=z2%></font></div></td>
  </tr>
  <%zz1=zz1+z1
   zz2=zz2+z2%>
  <tr bgcolor="#FFFF00">
    <td colspan=2><div align="center"><font size="2" color="#FF0000">合 计</font></div></td>
	<td><div align="center"><font size="2" color="#FF0000"><%=zz1%></font></div></td>
	<td><div align="center"><font size="2" color="#FF0000">￥ <%=zz2%></font></div></td>
  </tr>
</table>
<%end sub
sub show2()%>
<font color="#FF0000" size="2">开始日期：<%=f_date%> 结束日期：<%=l_date%></font>
<table width="500" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr bgcolor="#336699"> 
    <td><div align="center"><font color="#FFFF00" size="2"><%=sname%></font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">销售数量</font></div></td>
    <td><div align="center"><font size="2" color="#FFFF00">销售金额</font></div></td>
  </tr>
  <%z1=0
  z2=0
  while not rs.eof%>
  <tr>
    <td><div align="center"><font size="2">
    <%if cint(act)=2 then%>
		<%=rs(0)%>
    <%else%>
        <a href="javascript:op('f22qry_retail_lb_seach_mx_sub.asp?act=<%=seachtype%>&types=<%=rs(0)%>&fdate=<%=f_date%>&ldate=<%=l_date%>')"><%=rs(0)%></a>
    <%end if%>
    </font></div></td>
	<td><div align="center"><font size="2"><%response.write(rs(1))
	                                         z1=z1+rs(1)%></font></div></td>
	<td><div align="center"><font size="2"><%response.write("￥ "&rs(2))
	                                            z2=z2+round(rs(2),2)%></font></div></td>
  </tr>
  <%rs.movenext
  wend%>
  <tr>
    <td><div align="center"><font size="2" color="#FF0000">合 计</font></div></td>
	<td><div align="center"><font size="2" color="#FF0000"><%=z1%></font></div></td>
	<td><div align="center"><font size="2" color="#FF0000">￥ <%=z2%></font></div></td>
  </tr>
</table>
<%end sub
else%>
<div align="center"><font size="2">没 有 销 售 数 据</font></div></td>
<%end if%>
<%if cint(act)<>2 then%>
</body>
</html>
<%end if%>
<%rs.close
  set rs=nothing
  cn.close
  set cn=nothing%>
