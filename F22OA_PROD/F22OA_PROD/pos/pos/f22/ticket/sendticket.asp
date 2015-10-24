<!--#include file="../../f22/inc/function.asp"-->
<%
'每次进入时重新输入
session("sendticket")=""
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>发放券</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
function addtic()
{var obj=document.form1;
 if(obj.ticketid.value=="")
    {alert("请输入券号！");}
 else
    {
		obj.act.value='0';
		obj.submit();}
		obj.ticketid.focus();
}

function deltic()
{
 var ticid=document.form1.delid.value;
 if(ticid=="")
   {alert("请选择券号！")}
  else
   {
		 document.form1.act.value='1';
		 document.form1.submit();
		//document.all.is.src="sendticketsub.asp?act=1&delid="+ticid;
	}
}

function sendall()
{if(confirm('确定发放吗？'))
  {document.all.is.src="sendticketsub.asp?act=2"}
 }
</script>
<body onLoad="document.form1.ticketid.focus();">
<table width="100%"  border="0" cellpadding="0" cellspacing="1" class="bar">
<form action="sendticketsub.asp" method="post" name="form1" target="is">
<input type="hidden" name="act" value="0">
<input type="hidden" name="delid" value="">
    <tr>
      <td>输入券号：<input type="text" name="ticketid" size="32" onFocus="this.select()" onKeyDown="if(event.keyCode==13){addtic()}"></td>
	  <td align="right">
	      <input type="button" name="del" value="删除所选择券" onClick="deltic()">
	      <input type="button" name="send" value="发放所有券" onClick="sendall()">&nbsp;&nbsp;</td>
    </tr>
</form>
</table>
<iframe name="is" id="is" width="100%" height="90%" frameborder="0" src="sendticketsub.asp?act=0"></iframe>
</body>
</html>
