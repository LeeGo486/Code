<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
</head>

<body onload="document.form1.opass.focus();">
<table width="100%"  border="0" class="bar">
  <tr>
    <td>修改密码</td>
  </tr>
</table>
<form name="form1" method="post" action="Pass_modify_save.asp">
  <table width="100%"  border="0" class="tcontent">
    <tr>
      <td width="22%" align="right">登录名:</td>
      <td width="78%"><%=Session("dm").System_UserId%></td>
    </tr>
	<tr>
      <td align="right">OA帐号:</td>
      <td><input name="oauserid" type="text" id="oauserid" size=20 value="<%=session("oauserid")%>">（可不填）</td>
    </tr>
    <tr>
      <td align="right">旧密码:</td>
      <td><input name="opass" type="password" id="opass" size=20></td>
    </tr>
    <tr>
      <td align="right">新密码:</td>
      <td><input name="pass" type="password" id="pass" size=20></td>
    </tr>
    <tr>
      <td align="right">确认新密码:</td>
      <td><input name="cf" type="password" id="cf" size=20></td>
    </tr>
    <tr>
      <td align="right">&nbsp;</td>
      <td><input type="submit" name="Submit" value="提交"></td>
    </tr>
  </table>
</form>
</body>
</html>
