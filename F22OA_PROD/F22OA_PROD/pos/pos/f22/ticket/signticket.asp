<!--#include file="../../f22/inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ǩ��ȯ</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
</head>

<body>
<table width="100%"  border="0" cellpadding="0" cellspacing="1" class="bar">
<form action="signticketsub.asp" method="post" name="form1" target="is">
    <tr>
      <td>ǩ�շ�ʽ:
        <input type="radio" name="act" value="0" onClick="document.form1.submit()" checked>��ȯǩ��
        <input type="radio" name="act" value="1" onClick="document.form1.submit()">�����ǩ��</td>
    </tr>
</form>
</table>
<iframe name="is" id="is" width="100%" height="90%" frameborder="0" src="signticketsub.asp?act=0"></iframe>
</body>
</html>
