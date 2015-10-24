<%
session("formid") = 6102042
Dim typ
typ=request("typ")
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if%>
<!--#include file="inc/function.asp" -->

<%if cint(typ)<>2 then%>
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

<%
  seachtype=request.form("seachtype")
  showdepot=request.form("showdepot")
  order=request.Form("order")

select case seachtype
case 1
   sname="年 份"
   select case order
   case 0 orderby=" order by a.st_year"
   case 1 orderby=" order by sum(b.k_num) desc"
   case 2 orderby=" order by sum(b.k_num*a.x_price) desc"
   end select 
   if showdepot=1 then
      a1="a.st_year,c.d_name,sum(isnull(b.k_num,0)) as k_num,sum(isnull(b.k_num*a.x_price,0)) as price "
	  b1="group by a.st_year,c.d_name "&orderby
   else
      a1="a.st_year,sum(isnull(b.k_num,0)) as k_num,sum(isnull(b.k_num*a.x_price,0)) as price "
	  b1="group by a.st_year "&orderby
   end if
case 2
   sname="季 节"
   select case order
   case 0 orderby=" order by a.st_month"
   case 1 orderby=" order by sum(b.k_num) desc"
   case 2 orderby=" order by sum(b.k_num*a.x_price) desc"
   end select 
   if showdepot=1 then
      a1="a.st_month,c.d_name,sum(isnull(b.k_num,0)) as k_num,sum(isnull(b.k_num*a.x_price,0)) as price "
	  b1="group by a.st_month,c.d_name "&orderby
   else
      a1="a.st_month,sum(isnull(b.k_num,0)) as k_num,sum(isnull(b.k_num*a.x_price,0)) as price "
	  b1="group by a.st_month "&orderby
   end if
case 3
   sname="种 类"
   select case order
   case 0 orderby=" order by a.st_xl"
   case 1 orderby=" order by sum(b.k_num) desc"
   case 2 orderby=" order by sum(b.k_num*a.x_price) desc"
   end select 
   if showdepot=1 then
      a1="a.st_xl,c.d_name,sum(isnull(b.k_num,0)) as k_num,sum(isnull(b.k_num*a.x_price,0)) as price "
	  b1="group by a.st_xl,c.d_name "&orderby
   else
      a1="a.st_xl,sum(isnull(b.k_num,0)) as k_num,sum(isnull(b.k_num*a.x_price,0)) as price "
	  b1="group by a.st_xl "&orderby
   end if
case 4
   sname="大 类"
   select case order
   case 0 orderby=" order by a.st_dl"
   case 1 orderby=" order by sum(b.k_num) desc"
   case 2 orderby=" order by sum(b.k_num*a.x_price) desc"
   end select 
   if showdepot=1 then
      a1="a.st_dl,c.d_name,sum(isnull(b.k_num,0)) as k_num,sum(isnull(b.k_num*a.x_price,0)) as price "
	  b1="group by a.st_dl,c.d_name "&orderby
   else
      a1="a.st_dl,sum(isnull(b.k_num,0)) as k_num,sum(isnull(b.k_num*a.x_price,0)) as price "
	  b1="group by a.st_dl "&orderby
   end if
case 5
   sname="小 类"
   select case order
   case 0 orderby=" order by a.st_xz"
   case 1 orderby=" order by sum(b.k_num) desc"
   case 2 orderby=" order by sum(b.k_num*a.x_price) desc"
   end select 
   if showdepot=1 then
      a1="a.st_xz,c.d_name,sum(isnull(b.k_num,0)) as k_num,sum(isnull(b.k_num*a.x_price,0)) as price "
	  b1="group by a.st_xz,c.d_name "&orderby
   else
      a1="a.st_xz,sum(isnull(b.k_num,0)) as k_num,sum(isnull(b.k_num*a.x_price,0)) as price "
	  b1="group by a.st_xz "&orderby
   end if
end select
sql="select "&a1&" from j_style a,j_stock b,j_depot c where b.depotid='"&session("dm").System_Depotid&"' "
sql=sql&" and a.styleid in (select styleid from sys_stylepower18ql where userid='"&session("dm").System_Userid&"' and selection=1 and access=1) "
sql=sql&" and b.depotid=c.depotid and a.styleid=b.styleid "&b1
%>

<%if cint(typ)<>2 then%>
<table width="100%" border="0" cellspacing="0">
<form name="form1" method="post" action="f22qry_kclb_seach_mx.asp">
<input type="hidden" name="seachtype" value="<%=seachtype%>">
<input type="hidden" name="showdepot" value="<%=showdepot%>">
<input type="hidden" name="order" value="<%=order%>">
<input type="hidden" name="typ" value="2">
  <tr> 
    <td><font size="2">当前位置：--&gt; 库存查询 --&gt; 库存查询-按类别综合</font></td>
	<td align="right"><input type="button" name="but" value="导出Excel" onClick="document.all.form1.submit();"></td>
    <td><div align="right"><input type="button" name="but1" value="返 回" onClick="location='f22qry_kclb_seach.asp'"></div></td>
  </tr>
</form>
</table>
<hr size="2">
<%end if%>

<%set rs=server.CreateObject("adodb.recordset")
rs.open sql,cn,1,1
if not rs.eof then
if showdepot=1 then show1() else show2() end if
sub show1()%>
<table width="500" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr bgcolor="#336699"> 
    <td><div align="center"><font color="#FFFF00" size="2"><%=sname%></font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">店铺名称</font></div></td>
    <td><div align="center"><font size="2" color="#FFFF00">库存数量</font></div></td>
    <%if psprice then%>
    <td><div align="center"><font color="#FFFF00" size="2">库存金额</font></div></td>
    <%end if%>
  </tr>
  <%z1=0
   zz1=0
  z2=0
  zz2=0
  ss1=rs(0)
  while not rs.eof
  if ss1=rs(0) then%>
  <tr>
    <td><div align="center"><font size="2">
				<%if s1<>rs(0) then%>
					<%if cint(typ)<>2 then%>
                        <a href="javascript:op('f22qry_kclb_seach_mx_sub.asp?act=<%=seachtype%>&types=<%=rs(0)%>')"><%=rs(0)%></a>
                 	<%else%>
                    	<%=rs(0)%>
                    <%end if%>
				 <%
                 s1=rs(0)
                 else%>
				 	&nbsp;
				 <%end if%>
             </font></div></td>
	<td><div align="center"><font size="2"><%=rs(1)%></font></div></td>
	<td><div align="center"><font size="2"><%response.write(rs(2))
	                                         z1=z1+rs(2)%></font></div></td>
    <%if psprice then%>
	<td><div align="center"><font size="2"><%response.write(rs(3))
	                                         z2=z2+round(rs(3),2)%></font></div></td>
		<%end if%>
  </tr>
  <%else%>
  <tr bgcolor="#00FFFF">
    <td colspan=2><div align="center"><font size="2" color="#FF0000">小 计</font></div></td>
	<td><div align="center"><font size="2" color="#FF0000"><%=z1%></font></div></td>
    <%if psprice then%>
	<td><div align="center"><font size="2" color="#FF0000">￥ <%=z2%></font></div></td>
		<%end if%>
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
    <%if psprice then%>
	<td><div align="center"><font size="2" color="#FF0000">￥ <%=z2%></font></div></td>
  <% End If %>
  </tr>
  <%zz1=zz1+z1
   zz2=zz2+z2%>
  <tr bgcolor="#FFFF00">
    <td colspan=2><div align="center"><font size="2" color="#FF0000">合 计</font></div></td>
	<td><div align="center"><font size="2" color="#FF0000"><%=zz1%></font></div></td>
    <%if psprice then%>
	<td><div align="center"><font size="2" color="#FF0000">￥ <%=zz2%></font></div></td>
  <% End If %>
  </tr>
</table>
<%end sub
sub show2()%>
<table width="500" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr bgcolor="#336699"> 
    <td><div align="center"><font color="#FFFF00" size="2"><%=sname%></font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">库存数量</font></div></td>
    <%if psprice then%>
    <td><div align="center"><font size="2" color="#FFFF00">库存金额</font></div></td>
    <% End If %>
  </tr>
  <%z1=0
  z2=0
  while not rs.eof%>
  <tr>
    <td><div align="center"><font size="2">
		<%if cint(typ)<>2 then%>
        <a href="javascript:op('f22qry_kclb_seach_mx_sub.asp?act=<%=seachtype%>&types=<%=rs(0)%>')"><%=rs(0)%></a>
        <%else%>
            <%=rs(0)%>
        <%end if%>
    </font></div></td>
	<td><div align="center"><font size="2"><%response.write(rs(1))
	                                         z1=z1+rs(1)%></font></div></td>
    <%if psprice then%>
	<td><div align="center"><font size="2"><%response.write("￥ "&rs(2))
			z2=z2+round(rs(2),2)%></font></div></td>
		<% End If %>
  </tr>
  <%rs.movenext
  wend%>
  <tr>
    <td><div align="center"><font size="2" color="#FF0000">合 计</font></div></td>
	<td><div align="center"><font size="2" color="#FF0000"><%=z1%></font></div></td>
    <%if psprice then%>
	<td><div align="center"><font size="2" color="#FF0000">￥ <%=z2%></font></div></td>
  <% End If %>
  </tr>
</table>
<%end sub
else%>
<div align="center"><font size="2">没 有 库 存 数 据</font></div></td>
<%end if%>

<%if cint(typ)<>2 then%>
</body>
</html>

<%end if%>
<%rs.close
  set rs=nothing
  cn.close
  set cn=nothing%>
