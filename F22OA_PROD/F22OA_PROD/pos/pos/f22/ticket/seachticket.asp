<!--#include file="../../f22/inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>查询券</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
function subm(t)
{if(t==0)
   {document.form1.action="seachticketsub.asp"}
 else if(t==1)
   {document.form1.action="seachticketsub1.asp"}
  document.form1.submit();
}
</script>
<body>
<table width="100%"  border="0" cellpadding="0" cellspacing="1" class="bar">
<form method="post" name="form1" target="is">
    <tr>
      <td>查询方式:
        <input type="radio" name="types" value="0" onClick="subm(this.value)" checked>按券查询
        <input type="radio" name="types" value="1" onClick="subm(this.value)">按日期查询
		</td>
    </tr>
</form>
</table>
<iframe name="is" id="is" width="100%" height="90%" frameborder="0" src="seachticketsub.asp"></iframe>
</body>
</html>