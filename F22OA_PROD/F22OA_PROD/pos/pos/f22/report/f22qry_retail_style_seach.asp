<%
session("formid")=6102032
Dim act
act=request.QueryString("act")
if cint(act)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if

f_date=trim(request.QueryString("f_date"))
if f_date="" then
   f_date=get_date(date)
end if
l_date=trim(request.QueryString("l_date"))
if l_date="" then
   l_date=get_date(date)
end if%>
<!--#include file="inc/function.asp" -->
<%if cint(act)<>2 then%>
<html>
<head>
<%end if%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%if cint(act)<>2 then%>
<title>数据查询</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<script language="javascript" src="ShowProcessBar.js"></script>
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<script language="javascript">
function clothing(id){
  showModalDialog('clothing.asp?id='+id+'&pksname=','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}

function op(url){
　//window.open (url, 'newwindow', 'height=500, width=500, center, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no');
　window.showModalDialog(url,'','dialogWidth:600px;dialogHeight:500px;help:no;scroll:no;status:no');
}

</script>
<style media="print">.noprint { display: none }</style>
</head>
<body>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<div id="submitok"  style="visibility:hidden;position: absolute; width: 320; height: 100"> 
<table width="320" border="1" align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" ID="Table1">
<tr><td width=100% valign=top>
<table width="320" border="0" height=100 align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor=Honeydew ID="Table2">
<tr><td align=center valign=middle>数据传送中，请稍候……</td></tr>
</table></td></tr></table></div>
<table width="100%" border="0" cellspacing="0">
  <tr> 
    <td><font size="2">当前位置：--&gt; 报表查询 --&gt; 销售查询-按款</font></td>
  </tr>
  <tr><td><hr size="2"></td></tr>
</table>
<table width="100%" class="noprint">
  <tr>
    <td height="40"> 
      <table width="100%" height="38" border="0" cellspacing="0">
        <form name="form1" method="get" action="f22qry_retail_style_seach.asp" onSubmit="this.Subm.disabled=true">
          <tr> 
            <td height="38"><div align="center">
                <input name="selectdepot" type="button" class="box" value="选择款式" onClick="javascript:op('select1.asp')">
                </div></td>
            <td><font size="2">开始日期： 
              <input name="f_date" type="text" id="f_date" size="10" class="box"  value="<%=f_date%>" onFocus="setday(this);" readonly  onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
              </font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2">结束日期： 
              <input name="l_date" type="text" id="l_date" size="10" class="box"  value="<%=l_date%>" onFocus="setday(this);" readonly onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
              </font></td>
            <td><font size="2">排 序：<select name="order" size=1><option value=0>按款排序</option><option value=1>按数量排序</option><option value=2>按金额排序</option></select></font> </td>
            <td><input type="submit" name="Subm" value=" 确 定 " class=box onClick="document.all.form1.act.value=1;document.all.form1.submit();"></td>
			<td><input type="hidden" name="act" value="1">
			<input type="button" name="but" value="导出Excel" onClick="document.all.form1.act.value=2;document.all.form1.submit();"></td>
          </tr>
        </form>
      </table>
</td></tr></table>
<%else%>
<center><h2>销售查询 - 按款</h2></center>
<%end if%>
<%if f_date="" or l_date="" then%>
<table width="100%" class="noprint" height="102" border="1" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006633">
  <tr>
    <td><div align="center">请 选 择 条 件</div></td>
  </tr>
</table>
<%else%>
<table width="100%" border="0" cellspacing="0">
  <tr> 
    <td width="25%"><div align="left"><font size="2">从<font color="#FF0000"><%=f_date%></font>至<font color="#FF0000"><%=l_date%></font></font></div></td>
  </tr>
</table> 
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr bgcolor="#336699"> 
    <td><div align="center"><font color="#FFFF00" size="2">款式编号</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">款式名称</font></div></td>
	<td><div align="center"><font size="2" color="#FFFF00">零售价</font></div></td>
	<td><div align="center"><font size="2" color="#FFFF00">结算价</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">数量</font></div></td>
	<td><div align="center"><font color="#FFFF00" size="2">结算金额</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">零售金额</font></div></td>
  </tr>
  <%order=request("order")
  select case order
  case 0 orderby=" order by b.styleid"
  case 1 orderby=" order by sum(b.nums) desc"
  case 2 orderby=" order by sum(b.nums*b.s_price) desc"
  end select

'控制查询天数
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
end if

  set rs=server.createobject("adodb.recordset")
  sql1="select b.styleid,max(c.s_name) as s_name,avg(b.x_price) as x_price,isnull(b.s_price,0) as s_price,isnull(sum(b.nums),0) as nums,"&_
          " isnull(sum(b.nums*b.s_price),0) as sums,isnull(sum(b.nums*b.x_price),0) as xsums "&_
					" from d_retail a,d_retailsub b,j_style c where a.retailid=b.retailid "&_
          " and b.styleid=c.styleid and isnull(a.sure,0)>0 and a.depotid='"&session("dm").System_Depotid&"'"&_
		  " and convert(char(10),sure_date,126) between '"&f_date&"' and '"&l_date&"' "&qrydaytj&_
		  " and b.styleid in (select styleid from sys_stylepower18ql where userid='"&session("dm").System_Userid&"' and selection=1) "&_
		  " group by b.styleid,b.s_price "&orderby
'de sql1
  rs.open sql1,cn,1,1
  if not rs.eof then
    style=lcase(rs("styleid"))
	while not rs.eof 
    if not rs.eof then
	if style=lcase(rs("styleid")) then%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20"><div align="center"><font size="2"><%if styl<>lcase(rs("styleid")) then
	                                                        styl=lcase(rs("styleid"))%>
                                                          <%if cint(act)<>2 then%>
                                                          <a href="javascript:clothing('<%=rs("styleid")%>');"><%=rs("styleid")%></a>
                                                          <%else%><%=rs("styleid")%><%end if%>
																													<%else response.write("&nbsp;")end if%></font></div></td>
    <td height="20"><div align="center"><font size="2"><%if s_na<>rs("s_name") then
	                                                        response.write(rs("s_name"))
															s_na=rs("s_name")
														 else response.write("&nbsp;") end if%>
        </font></div></td>
	<td><div align="center"><font size="2">￥ <%=rs("x_price")%></font></div></td>
	<td><div align="center"><font size="2">￥ <%=rs("s_price")%></font></div></td>
    <td height="20"><div align="center"><font size="2">
                                                          <%if cint(act)<>2 then%>
    <a href="javascript:op('f22qry_retail_style_seach_mx.asp?f_date=<%=request.QueryString("f_date")%>&l_date=<%=request.QueryString("l_date")%>&styleid=<%=rs("styleid")%>');" title="点击看明细"><%=rs("nums")%></a>
                                                          <%else%><%=rs("nums")%><%end if%>
    <%zj_nums=zj_nums+cdbl(rs("nums"))%>
                     
                     </font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">￥ <%response.write(rs("sums"))
	                                                            zj_price=zj_price+cdbl(rs("sums"))%></font></div></td>
	<td><div align="center"><font size="2" color="#FF0000">￥ <%response.write(rs("xsums"))
	                                                            zx_price=zx_price+cdbl(rs("xsums"))%></font></div></td>															
  </tr>
  <%else%>
  <tr bgcolor="#00FFFF"> 
    <td height="20" colspan="4"><div align="center"><font size="2">小&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 计</font></div></td>
    <td height="20"><div align="center"><font size="2"><%=zj_nums%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">￥ <%=zj_price%></font></div></td>
	<td><div align="center"><font size="2" color="#FF0000">￥ <%=zx_price%></font></div></td>
  </tr>
    <%zz_nums=zz_nums+cdbl(zj_nums)
	zz_price=zz_price+cdbl(zj_price)
	zz_xprice=zz_xprice+cdbl(zx_price)
	zj_nums=0
	zj_price=0
	zx_price=0
	style=lcase(rs("styleid"))
	rs.movePrevious
	end if
	rs.movenext 
    end if
    wend%>
<tr bgcolor="#00FFFF"> 
    <td height="20" colspan="4"><div align="center"><font size="2">小&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 计</font></div></td>
    <td height="20"><div align="center"><font size="2"><%=zj_nums%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">￥ <%=zj_price%></font></div></td>
	<td><div align="center"><font size="2" color="#FF0000">￥ <%=zx_price%></font></div></td>
  </tr>
  <%zz_nums=zz_nums+cdbl(zj_nums)
    zz_price=zz_price+cdbl(zj_price)
	zz_xprice=zz_xprice+cdbl(zx_price)%>
  <tr bgcolor="#FFFF00"> 
    <td height="20" colspan="4"><div align="center"><font size="2">合&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 计</font></div></td>
    <td height="20"><div align="center"><font size="2"><%=zz_nums%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">￥ <%=zz_price%></font></div></td>
	<td><div align="center"><font size="2" color="#FF0000">￥ <%=zz_xprice%></font></div></td>
  </tr>

</table>
<%else%>
<tr>
  <td colspan="7"><div align="center"><font size="2">没 有 销 售 数 据</font></div></td>
</tr>
<%end if%>
<%rs.close
  set rs=nothing
  cn.close
  set cn=nothing
end if%>
<%if cint(act)<>2 then%>
</body>
</html>
<%end if%>
