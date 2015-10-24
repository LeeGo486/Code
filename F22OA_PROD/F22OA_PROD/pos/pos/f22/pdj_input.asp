<!--#include file="inc/function.asp"-->
<%id=request.querystring("id") '单号
act=request.QueryString("act") '单据类型
if id="" then
   response.write("<script>alert('单号不能为空！');window.close()</script>")
   response.end
end if
response.write("单号："&id&"<hr>")%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>文本导入</title>
<link href="link.css" rel="stylesheet" type="text/css">
<base target="_self">
</head>
<script language="javascript" src="ShowProcessBar.js"></script>
<script>
window.name="pdj_input";
function check(theform)
{if(theform.txt.value==""){alert("请选择文本！");return false;}
theform.subm.disabled=true;
submitok();}
</script>
<body>
<div id="submitok"  style="visibility:hidden;position: absolute; width: 320; height: 100"> 
<table width="320" border="1" align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" ID="Table1">
<tr><td width=100% valign=top>
<table width="320" border="0" height=100 align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor=Honeydew ID="Table2">
<tr><td align=center valign=middle>数据传送中，请稍候……</td></tr>
</table></td></tr></table></div>

<table width="100%" height="250" border="0" cellpadding="0" cellspacing="0">
  <form method="post" target="pdj_input" action="pdj_input_insert.asp?id=<%=id%>&act=<%=act%>" enctype="multipart/form-data" name="form1" onSubmit="return check(this)">
    <tr> 
      <td colspan="2"><font size=2>选择文本文件：</font> <input type=file name="txt"></td>
    </tr>
    <tr> 
      <td colspan="2" align=center><input type=submit name="subm" value="  导  入  "></td>
    </tr>
  </form>
</table>
<hr>
<div align="left"><font size=2 color="#FF0000">导入说明：<br>
  导入文件限文本文件，导入格式可以如下3种任一种<br>
  &nbsp;&nbsp;款号+逗号+数量 如：T12EP4166aH2,1<br>
  &nbsp;&nbsp;款号+空格+数量 如：T12EP4166aH2 1<br>
  &nbsp;&nbsp;款号+TAB +数量 如：T12EP4166aH2	1<br>
  </font></div>
</body></html>