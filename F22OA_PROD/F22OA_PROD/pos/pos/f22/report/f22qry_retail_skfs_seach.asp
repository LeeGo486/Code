<%Dim act
response.Redirect("../../../../b28web/Report/report_retail_skfs.aspx")
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
function op(url){
showModalDialog(url,'example05','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no');
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
    <td><font size="2">当前位置：--&gt; 报表查询 --&gt; 销售查询-按收款方式</font></td>
  </tr>
  <tr><td><hr size="2"></td></tr>
</table>
<table width="100%" class="noprint">
  <tr><td>
<table width="100%" height="28" border="0" cellspacing="0">
        <form name="form1" method="get" action="f22qry_retail_skfs_seach.asp" onSubmit="this.Subm.disabled=true">
          <tr> 
            <td width="53%"><font size="2">开始日期： 
              <input name="f_date" type="text" id="f_date" size="10" class="box" value="<%=f_date%>" readonly onFocus="setday(this);" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
              </font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2">结束日期： 
              <input name="l_date" type="text" id="l_date" size="10" class="box" value="<%=l_date%>" readonly onFocus="setday(this);" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
              </font></td>
            <td width="29%"><font size="2">&nbsp; </font> <input type="submit" name="Subm" value=": 确 定 :" class=box onClick="document.all.form1.act.value=1;document.all.form1.submit();"></td>
			<td><input type="hidden" name="act" value="1">
			<input type="button" name="but" value="导出Excel" onClick="document.all.form1.act.value=2;document.all.form1.submit();"></td>
          </tr>
        </form>
      </table>
</td></tr></table>
<%end if%>
<%if f_date="" or l_date="" then%>
<table class="noprint" width="100%" height="102" border="1" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006633">
  <tr>
    <td><div align="center">请 选 择 条 件</div></td>
  </tr>
</table>
<%else%>
<hr size="1">
<table width="100%" border="0" cellspacing="0">
  <tr> 
    <td width="25%"><div align="left"><font size="2">从<font color="#FF0000"><%=f_date%></font>至<font color="#FF0000"><%=l_date%></font></font></div></td>
  </tr>
</table>
<%'控制查询天数
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
end if
set rs=server.createobject("adodb.recordset")
  sql1=" select b.retype,sum(b.sums) as sums from d_retail a,pos_skfs b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&qrydaytj&_
       " and a.depotid='"&session("dm").System_Depotid&"' and convert(char(10),a.sure_date,126) between '"&f_date&"' and '"&l_date&"' "&_
	   " group by b.retype"
  rs.open sql1,cn,1,1%> 
<table width="100%" height="49" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr bgcolor="#336699"> 
  <%if not rs.eof then
    while not rs.eof%>
    <td height="22">
<div align="center"><font color="#FFFF00" size="2"><%=rs("retype")%></font></div></td>
  <%rs.movenext
   wend
   rs.movefirst%>
  </tr>
  <tr bgcolor="#E8FDFF">
  <%sums=0
    while not rs.eof%>
  <td bgcolor="#E8FDFF">
    <div align="center"><font size="2" color="#FF0000">
        <%if not isnull(rs("sums")) then%>
				<%if cint(act)<>2 then%>
                    <a href="javascript:op('f22qry_retail_skfs_seach_mx.asp?f_date=<%=f_date%>&l_date=<%=l_date%>&retype=<%=rs("retype")%>');" title="点击看明细"><%="￥ "&rs("sums")%></a>
                <%else%>
                    <%="￥ "&rs("sums")%>
                <%end if%>
            <%
            sums=sums+round(rs("sums"),4)
			else response.write("0")
            end if%>
            
            </font></div></td>
      <%rs.movenext
        wend
       rs.close
       set rs=nothing%>
  </tr>
</table>
<br>
<table width="100%" height="26" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#003333">
  <tr> 
    <td width="38%" height="24" bgcolor="#E8FDFF"> <div align="center"><font color="#FF0000" size="2">合&nbsp;&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 计</font></div></td>
    <td width="62%" bgcolor="#E8FDFF"><div align="center"><font color="#FF0000" size="2">￥ 
        <%=sums%></font></div></td>
  </tr>
</table>
<%else%>
<tr>
  <td colspan="8"><div align="center"><font size="2">没 有 销 售 数 据</font></div></td>
</tr>
<%end if
cn.close
set cn=nothing
end if%>
<%if cint(act)<>2 then%>
</body>
</html>
<%end if%>

