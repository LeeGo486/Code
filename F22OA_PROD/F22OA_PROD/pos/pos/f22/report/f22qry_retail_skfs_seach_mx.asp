<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=request.QueryString("retype")%>收款方式在各店柜的金额分布</title>
</head>
<style media="print">.noprint { display: none }</style>
<body>
<%f_date=request.QueryString("f_date")
  l_date=request.QueryString("l_date")
  retype=request.QueryString("retype")
'控制查询天数
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","b.sure_date")
end if%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><font size=2><font color="#FF0000"><%=retype%></font>收款方式从<font color="#FF0000"><%=f_date%></font>至<font color="#FF0000"><%=l_date%></font>中的金额分布</font></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr bgcolor="#336699"> 
    <td width="19%"><div align="center"><font color="#FFFF00" size="2">销售日期</font></div></td>
    <td width="19%"><div align="center"><font color="#FFFF00" size="2">销售金额</font></div></td>
  </tr>
  <%sql="select convert(char(10),b.sure_date,126) as suredate,isnull(sum(a.sums),0) as sums from pos_skfs a,d_retail b "
	sql=sql+"where a.retailid =b.retailid and convert(char(10),b.sure_date,126) between '"&f_date&"' and '"&l_date&"' "
	sql=sql+"and a.retype='"&retype&"' "&qrydaytj
	sql=sql+"and b.depotid='"&session("dm").System_Depotid&"' group by convert(char(10),b.sure_date,126)"
    set rs4=server.CreateObject("adodb.recordset")
	'response.Write(sql)
	rs4.open sql,cn
	while not rs4.eof
	if round(rs4("sums"),2)<>0 then%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20"><div align="center"><font size="2"><%=rs4("suredate")%></font></font></div></td>
    <td height="20"><div align="center"><font size="2" color="#FF0000">￥ <%response.write(rs4("sums"))
	                                                     z_sums=z_sums+round(rs4("sums"),4)%></font></div></td>
  </tr>
  <%end if
  rs4.movenext
  wend
	rs4.close
	cn.close
	set rs4=nothing
	set cn=nothing%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20"><div align="center"><font size="2">合&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        计</font></div></td>
    <td height="20"><div align="center"><font size="2" color="#FF0000">￥ <%=z_sums%></font></div></td>
  </tr>
</table>
<div align="center"><br>
  <input type="button" name="Submit" class="noprint" value=": 关闭此窗口 :" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onclick="javascript:window.opener=null;window.close();">
<br>
</div>
  </body>
</html>

