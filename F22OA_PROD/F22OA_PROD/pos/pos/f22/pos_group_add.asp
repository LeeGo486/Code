<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
</head>
<script>
function check(theform)
{//if (theform.groupid.value==''){alert('��α�Ų���Ϊ�գ�');theform.groupid.focus();return false;}
if (theform.groupname.value==''){alert('������Ʋ���Ϊ�գ�');theform.groupname.focus();return false;}
}
</script>
<body>
<table width="100%" border="0" align="center" class="bar">
  <tr>
    <td align="center">��Ӱ��</td>
  </tr>
</table>
<form name="form1" method="post" action="pos_group_save.asp" onSubmit="return check(this)">
  <table width="100%" border="1" align="center" bordercolor="#ECD5D0" class="f14">
    <tr>
      <td>��α��:</td>
      <td><input name="groupid" type="text" id="groupid">
      <input name="act" type="hidden" id="act" value="add">
      �������Զ�����!�Զ����ɿɱ����ظ�!</td>
    </tr>
    <tr>
      <td width="12%">�������:</td>
      <td width="88%"><input name="groupname" type="text" id="groupname"> *</td>
    </tr>
    <tr>
      <td>����:</td>
      <td><input name="usedstatus" type="checkbox" id="usedstatus" value="1" checked></td>
    </tr>
    <tr>
      <td>˵��:</td>
      <td><textarea name="comment" cols="50" rows="5" id="comment"></textarea></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="Submit" value="�ύ">
      <input type="reset" name="Submit" value="����"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
</form>
</body>
</html>
