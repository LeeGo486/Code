<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>查询本店指定顾客详细资料</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">查询本店指定顾客详细资料</td>
  </tr>
</table>
<table width="100%" border="0">
<form name="form1" method="get" action="../../../../b28web/Modal/vipinfo.aspx" target="detail">
  <tr>
    <td>
    VIP卡号：<input name="vipcode" type="text" id="vipcode" />
    &nbsp;<input type="submit" class="btn" name="subm" value=" 查 询 "
   onClick="this.form.typ.value=1;this.disabled=true;this.value='请稍等...';this.form.submit()" />
  </td>
  </tr>
</form>
</table>
<iframe height="100%" width="100%" name="detail" src="about:blank" frameborder="0" scrolling="auto" marginheight="0" marginwidth="0"></iframe>

</div>
</body>
</html>
