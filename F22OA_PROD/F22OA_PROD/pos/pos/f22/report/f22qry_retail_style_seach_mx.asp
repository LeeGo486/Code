<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

function op(url){
　//window.open (url, 'newwindow', 'height=500, width=500, center, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no');
　window.showModalDialog(url,'','dialogWidth:500px;dialogHeight:500px;help:no;scroll:yes;status:no');
}

</script>


<title><%=request.QueryString("styleid")%>的店柜销售</title>
</head>
<style media="print">.noprint { display: none }</style>
<body>
<%
'控制查询天数
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","c.sure_date")
end if
  
  f_date=request.QueryString("f_date")
  l_date=request.QueryString("l_date")
  styleid=request.QueryString("styleid")
  %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><font size=2><font color="#FF0000"><%=styleid%></font>款在<font color="#FF0000"><%=f_date%></font>至<font color="#FF0000"><%=l_date%></font>的店柜销售情况</font></td>
  </tr>
</table>
<table id=yes width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr bgcolor="#336699"> 
    <td width="19%"><div align="center"><font color="#FFFF00" size="2">店柜名称</font></div></td>
    <td width="19%"><div align="center"><font color="#FFFF00" size="2">销售数量</font></div></td>
    <td width="15%"><div align="center"><font color="#FFFF00" size="2">销售金额</font></div></td>
  </tr>
  <%sql="select b.d_name,isnull(sum(a.s_price*a.nums),0) as s_price,isnull(sum(a.nums),0) as nums from d_retailsub a,j_depot b,d_retail c "
	sql=sql+"where a.retailid=c.retailid and isnull(c.sure,0)>0 and b.depotid=c.depotid and a.styleid in (select styleid from sys_stylepower18ql where userid='"&session("dm").System_Userid&"' and selection=1) "
	sql=sql+"and convert(char(10),c.sure_date,126) between '"&f_date&"' and '"&l_date&"' "&qrydaytj
	sql=sql+" and a.styleid='"&styleid&"' and c.depotid='"&session("dm").System_Depotid&"' group by b.d_name"
	
    set rs1=server.CreateObject("adodb.recordset")
    
	rs1.open sql,cn,1,1
    while not rs1.eof%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20"><div align="center"><font size="2"><%=rs1("d_name")%></font></font></div></td>
    <td height="20"><div align="center"><font size="2">

	<a href="#" onclick="javascript:op('f22qry_retail_style_seach_mxsub.aspx?f_date=<%=request.QueryString("f_date")%>&l_date=<%=request.QueryString("l_date")%>&styleid=<%=request.QueryString("styleid")%>');"
	 title="点击看明细"><%response.write(rs1("nums"))
	 z_nums=z_nums+round(rs1("nums"),4)%></a>
	 件</font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">￥ <%response.write(rs1("s_price"))
	                                            z_price=z_price+round(rs1("s_price"),4)%></font></div></td>
  </tr>
<%rs1.movenext
  wend
  rs1.close
  cn.close
  set rs1=nothing
  set cn=nothing%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20"><div align="center"><font size="2">合&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        计</font></div></td>
    <td height="20"><div align="center"><font size="2"><%=z_nums%> 件</font></div></td>
    <td height="20"><div align="center"><font size="2" color="#FF0000">￥ <%=z_price%></font></div></td>
  </tr>
</table>
<div align="center"><br>
  <input type="button" name="Submit" class="noprint" value=": 关闭此窗口 :" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onClick="javascript:window.opener=null;window.close();">
<br>
</div>
  </body>
</html>
