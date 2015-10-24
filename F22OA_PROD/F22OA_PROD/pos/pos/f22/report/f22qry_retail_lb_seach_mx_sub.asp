<!--#include file="inc/function.asp" -->
<%act=request.QueryString("act")
types=request.QueryString("types")
fdate=request.querystring("fdate")
ldate=request.querystring("ldate")
'控制查询天数
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
end if%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=types%>的销售明细</title>
<script language="javascript">
function op(url){
showModalDialog(url,'example06','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no');
}
</script>
</head>
<style media="print">.noprint { display: none }</style>
<body> 
<%select case act
case 1 a1="select b.styleid,max(c.s_name) as s_name,sum(b.nums) as nums,sum(b.s_price*b.nums) as price from d_retail a,d_retailsub b,j_style c "
       a1=a1&"where c.st_year='"&types&"' and a.retailid=b.retailid and b.styleid=c.styleid and a.depotid='"&session("dm").System_Depotid&"' and isnull(a.sure,0)>0"
       a1=a1&" and convert(char(10),a.sure_date,126) between '"&fdate&"' and '"&ldate&"' "&qrydaytj&" group by b.styleid"
case 2 a1="select b.styleid,max(c.s_name) as s_name,sum(b.nums) as nums,sum(b.s_price*b.nums) as price from d_retail a,d_retailsub b,j_style c "
       a1=a1&"where c.st_month='"&types&"' and a.retailid=b.retailid and b.styleid=c.styleid and a.depotid='"&session("dm").System_Depotid&"' and isnull(a.sure,0)>0"
       a1=a1&" and convert(char(10),a.sure_date,126) between '"&fdate&"' and '"&ldate&"' "&qrydaytj&" group by b.styleid"
case 3 a1="select b.styleid,max(c.s_name) as s_name,sum(b.nums) as nums,sum(b.s_price*b.nums) as price from d_retail a,d_retailsub b,j_style c "
       a1=a1&"where c.st_xl='"&types&"' and a.retailid=b.retailid and b.styleid=c.styleid and a.depotid='"&session("dm").System_Depotid&"' and isnull(a.sure,0)>0"
       a1=a1&" and convert(char(10),a.sure_date,126) between '"&fdate&"' and '"&ldate&"' "&qrydaytj&" group by b.styleid"
case 4 a1="select b.styleid,max(c.s_name) as s_name,sum(b.nums) as nums,sum(b.s_price*b.nums) as price from d_retail a,d_retailsub b,j_style c "
       a1=a1&"where c.st_dl='"&types&"' and a.retailid=b.retailid and b.styleid=c.styleid and a.depotid='"&session("dm").System_Depotid&"' and isnull(a.sure,0)>0"
       a1=a1&" and convert(char(10),a.sure_date,126) between '"&fdate&"' and '"&ldate&"' "&qrydaytj&" group by b.styleid"
case 5 a1="select b.styleid,max(c.s_name) as s_name,sum(b.nums) as nums,sum(b.s_price*b.nums) as price from d_retail a,d_retailsub b,j_style c "
       a1=a1&"where c.st_xz='"&types&"' and a.retailid=b.retailid and b.styleid=c.styleid and a.depotid='"&session("dm").System_Depotid&"' and isnull(a.sure,0)>0  "
       a1=a1&" and convert(char(10),a.sure_date,126) between '"&fdate&"' and '"&ldate&"' "&qrydaytj&" group by b.styleid"
case 6 a1="select b.styleid,max(c.s_name) as s_name,sum(b.nums) as nums,sum(b.s_price*b.nums) as price from d_retail a,d_retailsub b,j_style c "&_
			" left join j_brand e on e.drandid=c.brandid "&_
			" where isnull(e.drname,'无')='"&types&"' and a.retailid=b.retailid and b.styleid=c.styleid and a.depotid='"&session("dm").System_Depotid&"' and isnull(a.sure,0)>0 "&_
			" and convert(char(10),a.sure_date,126) between '"&fdate&"' and '"&ldate&"' "&qrydaytj&" group by b.styleid"
end select
'de a1
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><font size=2><font color="#FF0000">从<%=fdate%>至<%=ldate%>,<%=types%></font>的款式销售情况</font></td>
  </tr>  
</table>
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF"> 
  <tr bgcolor="#336699"> 
    <td><div align="center"><font color="#FFFF00" size="2">款式编号</font></div></td> 
	<td><div align="center"><font color="#FFFF00" size="2">款式名称</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">销售数量</font></div></td> 
    <td><div align="center"><font color="#FFFF00" size="2">销售金额</font></div></td>
  </tr>  
  <%set rs=server.createobject("adodb.recordset")
  rs.open a1,cn,1,1
  while not rs.eof%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20"><div align="center"><font size="2"><%=rs(0)%></font></div></td>
    <td height="20"><div align="center"><font size="2"><%=rs(1)%></font></div></td>
	<td height="20"><div align="center"><font size="2"><a href="#" onClick="op('f22qry_retail_lb_mx.asp?styleid=<%=rs("styleid")%>&fdate=<%=fdate%>&ldate=<%=ldate%>')">
	                                                   <%response.write(rs(2))
	                                                     z_nums=z_nums+round(rs(2),0)%></a></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">￥ <%response.write(rs(3))
	                                            z_sums=z_sums+round(rs(3),4)%></font></div></td>
  </tr>
<%rs.movenext
 wend
rs.close
set rs=nothing%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20" colspan=2><div align="center"><font size="2">合&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        计</font></div></td>
    <td height="20"><div align="center"><font size="2"><%=z_nums%> 件</font></div></td>
    <td height="20"><div align="center"><font size="2" color="#FF0000">￥ <%=z_sums%></font></div></td>
  </tr>
</table>
<div align="center"><br>
  <input type="button" name="Submit" class="noprint" value=": 关闭此窗口 :" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onClick="javascript:window.opener=null;window.close();">
<br>
</div>
  </body>
</html>
