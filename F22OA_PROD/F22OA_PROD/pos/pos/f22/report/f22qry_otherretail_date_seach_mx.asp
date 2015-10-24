<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=request.QueryString("suredate")%>号的店柜销售</title>
</head>
<style media="print">.noprint { display: none }</style>
<body> 
<%suredate=request.QueryString("suredate")
dptid=request.querystring("dptid")
    
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><font size=2><font color="#FF0000"><%=suredate%></font>号的店柜销售情况（按销售金额排序）</font></td>
  </tr>  
</table>
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF"> 
  <tr bgcolor="#336699"> 
	<td width="19%"><div align="center"><font color="#FFFF00" size="2">款式编号</font></div></td>
	<td width="15%"><div align="center"><font color="#FFFF00" size="2">颜色编号</font></div></td>
	<td width="10%"><div align="center"><font color="#FFFF00" size="2">尺 码</font></div></td> 
    <td width="19%"><div align="center"><font color="#FFFF00" size="2">销售数量</font></div></td> 
    <td width="15%"><div align="center"><font color="#FFFF00" size="2">销售金额</font></div></td>
  </tr>  
  <%set rs1=server.CreateObject("adodb.recordset")
    sql1="select b.styleid,b.colorid,b.sizeid,sum(b.nums) as nums,sum(b.nums*b.s_price) as s_sums "&_
	     "from d_retail a,d_retailsub b where convert(char(10),a.sure_date,120)='"&suredate&"' "&_
		 "and isnull(a.sure,0)>0 and a.retailid=b.retailid "&_
		 "and a.depotid='"&dptid&"' and isnull(b.nums,0)<>0 group by b.styleid,b.colorid,b.sizeid order by s_sums "
	rs1.open sql1,cn,1,1
	while not rs1.eof%>
  <tr bgcolor="#E8FDFF"> 
	<td height="20"><div align="center"><font size="2"><%=rs1("styleid")%></font></font></div></td>
	<td height="20"><div align="center"><font size="2"><%=rs1("colorid")%></font></font></div></td>
	<td height="20"><div align="center"><font size="2"><%=rs1("sizeid")%></font></font></div></td>
    <td height="20"><div align="center"><font size="2"><%response.write(rs1("nums"))
	                                                     z_nums=z_nums+round(rs1("nums"),4)%> 件</font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">￥ <%response.write(rs1("s_sums"))
	                                            z_sums=z_sums+round(rs1("s_sums"),4)%></font></div></td>
  </tr>
<%rs1.movenext
 wend
	rs1.close
	set rs1=nothing%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20" colspan=3><div align="center"><font size="2">合&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        计</font></div></td>
    <td height="20"><div align="center"><font size="2"><%=z_nums%> 件</font></div></td>
    <td height="20"><div align="center"><font size="2" color="#FF0000">￥ <%=z_sums%></font></div></td>
  </tr>
</table>
<div align="center"><br>
  <input type="button" name="Submit" class="noprint" value=": 关闭此窗口 :" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onclick="javascript:window.opener=null;window.close();">
<br>
</div>
  </body>
</html>

