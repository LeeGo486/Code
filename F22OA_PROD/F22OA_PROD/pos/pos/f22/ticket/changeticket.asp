<!--#include file="../../f22/inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ֶһ�ȯ</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
function subm()
{var obj=document.form1;
 if(obj.vipcode.value=="")
	{alert("������ȯ�ţ�");}
 else
    {obj.submit();}
 obj.vipcode.focus();
 }
</script>
<body onLoad="document.form1.vipcode.focus()">
<table width="100%"  border="0" cellpadding="0" cellspacing="1" class="bar">
<form action="changeticketsub.asp?vipflash=1" method="post" name="form1" target="is" onSubmit="return subm()">
    <tr>
      <td>����VIP���ţ�<input type="text" name="vipcode" size="32" onFocus="this.select()"
       onKeyDown="if(event.keyCode==13){this.form.submit1.click();event.returnValue=false;}" 
       onKeyUp="if(this.value){this.form.submit1.disabled=false}else{this.form.submit1.disabled=true}" />
       <input type="submit" name="submit1" id="submit1" value="�ύ" disabled="disabled"></td>
    </tr>
</form>
</table>
<iframe name="is" id="is" width="100%" height="90%" frameborder="0" src="about:blank"></iframe>
</body>
</html>