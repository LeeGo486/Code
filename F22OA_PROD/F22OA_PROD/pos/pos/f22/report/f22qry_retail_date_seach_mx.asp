<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=request.QueryString("suredate")%>号的店柜销售</title>
</head>
<style media="print">.noprint { display: none }</style>
<body> 
<%
par=request.QueryString("par")
m=InStrRev(par,"|",-1)
suredate=Right(par,Len(par)-m)
bid=Left(par,m-1)
'控制查询天数
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
end if%>
<%
     brid="1=1"
    if bid <> "0" then brid=" d.brandid='"&bid&"'" end if
 %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><font size=2><font color="#FF0000"><%=suredate%></font>号的销售情况（按销售金额排序）</font></td>
  </tr>  
</table>
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF"> 
  <tr bgcolor="#336699"> 
    <td width="20%"><div align="center"><font color="#FFFF00" size="2">款式编号</font></div></td> 
    <td width="20%"><div align="center"><font color="#FFFF00" size="2">款式名称</font></div></td> 
    <td width="20%"><div align="center"><font color="#FFFF00" size="2">销售数量</font></div></td> 
    <td width="20%"><div align="center"><font color="#FFFF00" size="2">销售金额</font></div></td>
    <td width="20%"><div align="center"><font color="#FFFF00" size="2">销售正价金额</font></div></td>
  </tr>  
  <%set rs1=server.CreateObject("adodb.recordset")
    sql1=" select b.styleid,max(d.s_name) as s_name,sum(b.nums) as nums,sum(b.nums*b.s_price) as s_sums ,b.x_price "&_
	     " from d_retail a,d_retailsub b,j_style d where convert(char(10),a.sure_date,120)='"&suredate&"' "&_
		 " and isnull(a.sure,0)>0 and a.retailid=b.retailid and b.styleid=d.styleid "&qrydaytj&_
		 " and "&brid&" and a.depotid='"&session("dm").System_Depotid&"' group by b.styleid ,b.x_price order by s_sums"
	rs1.open sql1,cn,1,1
	while not rs1.eof%>
  <tr bgcolor="#E8FDFF"> 
  <td height="20"><div align="center"><font size="2"><%=rs1("styleid")%></font></font></div></td>
    <td height="20"><div align="center"><font size="2"><%=rs1("s_name")%></font></font></div></td>
    <td height="20"><div align="center"><font size="2"><%response.write(rs1("nums"))
	                                                     z_nums=z_nums+round(rs1("nums"),4)%> 件</font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">￥ <%response.write(rs1("s_sums"))
	                                            z_sums=z_sums+round(rs1("s_sums"),4)%></font></div></td>
	 <td height="20"><div align="center"><font size="2"><%=rs1("x_price")%></font></font></div></td>                                           
  </tr>
<%rs1.movenext
 wend
	rs1.close
	set rs1=nothing%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20" colspan=2><div align="center"><font size="2">合&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        计</font></div></td>
    <td height="20"><div align="center"><font size="2"><%=z_nums%> 件</font></div></td>
    <td height="20" colspan="2"><div align="center"><font size="2" color="#FF0000">￥ <%=z_sums%></font></div></td
  ></tr>
</table>
<div align="center"><br>
  <input type="button" name="Submit" class="noprint" value=": 关闭此窗口 :" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onClick="javascript:window.opener=null;window.close();">
<br>
</div>
  </body>
</html>

