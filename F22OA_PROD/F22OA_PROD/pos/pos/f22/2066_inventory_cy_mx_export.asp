<%
  response.ContentType ="application/vnd.ms-excel"
  response.AddHeader "content-disposition", "attachment; filename=盘点差异明细.xls" 
%>

<!--#include file="inc/function.asp"-->
<!--#include file="inc/class.asp"-->

<%dim inventoryid,d_name,d_type,z_num,d_nums,z_price,d_price,setdate
  dim j_nums,j_price,j_k_nums,j_d_nums,j_d_price,sql,style,styleid,s_name,colorid
  dim a_nums,a_price,a_k_nums,a_d_nums,a_d_price,rs,z_nums
inventoryid=request("id")
%>

<%set rs=server.createobject("adodb.recordset")
rs.ActiveConnection = cn
rs.source = "select case when a.d_type=0 then '全局盘点' else '局部盘点' end as d_type,a.setdate,b.d_name, "&_
      "(select sum(nums) from d_inventorysub where d_inventorysub.inventoryid=a.inventoryid) as nums,"&_
	  "(select sum(d_nums) from d_inventorysub where d_inventorysub.inventoryid=a.inventoryid) as d_nums,"&_
	  "(select sum(nums*x_price) from d_inventorysub where d_inventorysub.inventoryid=a.inventoryid) as price,"&_
	  "(select sum(d_nums*j_price) from d_inventorysub where d_inventorysub.inventoryid=a.inventoryid) as c_price"&_
      " from d_inventory a,j_depot b where a.depotid=b.depotid and a.inventoryid='"&inventoryid&"'"
rs.open
d_name=rs("d_name")
d_type=rs("d_type")
z_nums=rs("nums")
d_nums=rs("d_nums")
z_price=rs("price")
d_price=rs("c_price")
setdate=rs("setdate")
rs.close
set rs=nothing
%>
<table width="100%" height="85" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td colspan="6"><div align="center">盘&nbsp;&nbsp;&nbsp;&nbsp; 点&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;差 
        &nbsp;&nbsp; 异&nbsp;&nbsp;&nbsp; 单</div></td>
  </tr>
  <tr> 
    <td width="11%" height="29"> 
      <div align="center"><font size="2">盘点仓柜：</font></div></td>
    <td width="18%"><font size="2"><%=d_name%></font></td>
    <td width="11%"><div align="right"><font size="2">盘点单号：</font></div></td>
    <td width="31%"><font size="2"><%=inventoryid%></font></td>
  </tr>
  <tr> 
    <td><div align="center"><font size="2">盘点类型：</font></div></td>
    <td><font size="2"><%=d_type%></font></td>
    <td><div align="right"><font size="2">盘点日期：</font></div></td>
    <td><font size="2"><%=setdate%></font></td>
  </tr>
</table><hr size="1">
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr bgcolor="#FFEFEF" align="center"> 
    <td><font size="2">款 式</font></td>
    <td><font size="2">款式名称</font></td>
    <td><font size="2">颜 色</font></td>
    <td><font size="2">尺 码</font></td>
    <td><font size="2">单 价</font></td>
    <td><font size="2">盘点数量</font></td>
    <td><font size="2">盘点金额</font></td>
    <td><font size="2">库存数量</font></td>
    <td><font size="2">盘点差异</font></td>
    <td><font size="2">差异金额</font></td>
  </tr>
  <%j_nums=0
	j_price=0
	j_k_nums=0
	j_d_nums=0
	j_d_price=0
	 sql="select a.styleid,b.s_name,a.colorid,c.c_name,a.sizeid,isnull(a.j_price,0) as s_price,isnull(a.nums,0) as nums,"&_
	     "isnull(a.j_price,0)*isnull(a.nums,0) as price,isnull(a.nums,0)-a.d_nums as k_nums,a.d_nums,"&_
			 " a.d_nums*isnull(a.j_price,0) as d_price from d_inventorysub a,j_style b,j_color c "&_
			 " where isnull(a.d_nums,0)<>0 and a.styleid=b.styleid and a.colorid=c.colorid and a.inventoryid='"&inventoryid&"'"&_
			 " order by a.styleid"
	 set rs=server.createobject("adodb.recordset")
	 rs.open sql,cn,1,1
	 if not rs.eof then
	 style=rs("styleid")
	 while not rs.eof
   if style=rs("styleid") then%>
  <tr> 
    <td height="20"><div align="center"><font size="2"><%if 1=1 then
	                                                        response.Write(rs("styleid"))
															styleid=rs("styleid")
														 else response.Write("&nbsp;") end if%></font></div></td>
    <td height="20"><div align="center"><font size="2"><%if 1=1 then
	                                                        response.Write(rs("s_name"))
															s_name=rs("s_name")
														 else response.Write("&nbsp;") end if%></font></div></td>
    <td height="20"><div align="center"><font size="2">
															<%if 1=1 then
																response.write(rs("colorid")&rs("c_name"))
															colorid=rs("colorid")
														 else response.Write("&nbsp;") end if%></font></div></td>
    <td height="20"><div align="center"><font size="2"><%=rs("sizeid")%></font></div></td>
    <td height="20"><div align="center"><font size="2">￥<%=rs("s_price")%></font></div></td>
    <td height="20"><div align="center"><font size="2"> 
        <%if rs("nums")<>0 then
		     response.write(rs("nums"))
			 j_nums=j_nums+rs("nums")
		  else response.write("&nbsp;") end if%></font></div></td>
    <td height="20"><div align="center"><font size="2"> 
        <%if round(rs("price"),2)<>0 then
		   response.write("￥"&rs("price"))
		   j_price=j_price+round(rs("price"),2)
		  else response.write("&nbsp;") end if%></font></div></td>
    <td height="20"><div align="center"><font size="2"><%response.write(rs("k_nums"))
	                                                     j_k_nums=j_k_nums+rs("k_nums")%></font></div></td>
    <td><div align="center"><font size="2"><%response.write(rs("d_nums"))
	                                                         j_d_nums=j_d_nums+rs("d_nums")%></font></div></td>
    <td><div align="center"><font size="2">￥<%response.write(rs("d_price"))
	                                                           j_d_price=j_d_price+round(rs("d_price"),2)%></font></div></td>
  </tr>
  <%else%>
  
  <%style=rs("styleid")
    rs.movePrevious
	a_nums=a_nums+j_nums
	a_price=a_price+round(j_price,2)
	a_k_nums=a_k_nums+j_k_nums
	a_d_nums=a_d_nums+j_d_nums
	a_d_price=a_d_price+round(j_d_price,2)  
	j_nums=0
	j_price=0
	j_k_nums=0
	j_d_nums=0
	j_d_price=0
	styleid=""
	s_name=""
	colorid=""
  end if
  rs.movenext
  wend  
  rs.close%>
 
<%end if%>
</table>
