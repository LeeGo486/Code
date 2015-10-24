<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<title>修改订单</title>
<base target="_self">
<link href="css/link.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../inc/js/setday.js"></script>
<script language="javascript">
function check(theform)
{if(theform.names.value==""){alert("姓名不能为空！");theform.names.focus();return false;}
if(theform.mobel.value==""){alert("移动电话不能为空！");theform.mobel.focus();return false;}
if(theform.styleid.value==""){alert("所订款式不能为空！");theform.styleid.focus();return false;}
if(theform.nums.value==""){alert("所订数量不能为空！");theform.nums.focus();return false;}
if(theform.fullprice.value==""){alert("全价金额不能为空！");theform.fullprice.focus();return false;}
if(theform.djprice.value==""){alert("订金金额不能为空！");theform.djprice.focus();return false;}
if(isNaN(theform.nums.value)){alert('所订数量数据类型错误！');theform.nums.focus();return false;}
if(isNaN(theform.fullprice.value)){alert('全价金额数据类型错误！');theform.fullprice.focus();return false;}
if(isNaN(theform.djprice.value)){alert('订金金额数据类型错误！');theform.djprice.focus();return false;}
}
</script>
</head>
<body>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%id=request("id")
depotid=session("dm").System_depotid

set rs=server.createobject("adodb.recordset")
sql="select retaildjid,names,mobel,tel,styleid,isnull(nums,0) as nums,isnull(fullprice,0) as fullprice,isnull(djprice,0) as djprice,"&_
    "convert(char(10),setdate,126) as setdate,convert(char(10),getdate,126) as getdate,adds,comment,isnull(ov_sure,0) as ov_sure "&_
	"from d_retaildj where retaildjid='"&id&"'"
rs.open sql,cn,1,1
if cint(rs("ov_sure"))=0 then reonly="" else reonly="readonly" end if%>
<table width="590" height="300" border="0" cellpadding="0" cellspacing="0">
<form name="form1" method="post" action="dj_seach_insert.asp?act=2&id=<%=rs("retaildjid")%>" onSubmit="return check(this)">
  <tr>
    <td align=right><font size=2 color="red">姓 名：</font></td>
    <td><input type="text" name="names" size=12 class=editbox2 value="<%=rs("names")%>" <%=reonly%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    <td align=right><font size=2 color="red">移动电话：</font></td><td><input type="text" name="mobel" <%=reonly%> value="<%=rs("mobel")%>" size=12 class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    <td align=right><font size=2>固定电话：</font></td><td><input type="text" name="tel" size=12 <%=reonly%> value="<%=rs("tel")%>" class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
  </tr>
  <tr>
    <td align=right><font size=2 color="red">所订款式：</font></td><td colspan="5"><input type="text" <%=reonly%> name="styleid" value="<%=rs("styleid")%>" size=50 class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
  </tr>
  <tr>
    <td align=right><font size=2 color="red">所订数量：</font></td><td><input type="text" name="nums" size=12 <%=reonly%>  value="<%=rs("nums")%>" class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    <td align=right><font size=2 color="red">全价金额：</font></td><td><input type="text" name="fullprice" size=12 <%=reonly%> value="<%=rs("fullprice")%>" class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    <td align=right><font size=2 color="red">订金金额：</font></td><td><input type="text" name="djprice" size=12 <%=reonly%> value="<%=rs("djprice")%>" class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
  </tr>
  <tr>
    <td align=right><font size=2 color="red">下订日期：</font></td><td><input name="setdate" type="text" id="setdate" size="10"  value="<%=rs("setdate")%>" class="editbox2" readonly onFocus="setday(this)"  onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    <td align=right><font size=2 color="red">提货日期：</font></td><td><input name="getdate" type="text" id="getdate" size="10"  value="<%=rs("getdate")%>" class="editbox2" readonly onFocus="setday(this)"  onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align=right><font size=2>地 址：</font></td><td colspan="5"><input type="text" name="adds" size=90 value="<%=rs("adds")%>" <%=reonly%> class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
  </tr>
  <tr>
    <td align=right><font size=2>备 注：</font></td><td colspan="5"><input type="text" name="comment" size=90 value="<%=rs("comment")%>" <%=reonly%> class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
  </tr>
  <%if cint(rs("ov_sure"))=0 then%>
  <tr>
    <td colspan="6" align=center>
    <input type="submit" name="Subm" value=" 修 改 " class=box>
    <input type="button" name="button" value=" 关 闭 " class=box onClick="window.close()">
    
    </td>
  </tr>
  <%end if%>
</form>
</table>
<%cn.close
set cn=nothing%>
</body>
</html>