<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="css/report.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<script language="javascript">
function selectStyle(){
  showModalDialog('../selectStyle.asp?action=set&title=ѡ���ʽ&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}

</script>
</head>

<body>
<% call cbanner("")%>
<table width="100%"  border="0" cellpadding="0" class="f14">
  <tr>
    <td><form name="form1" method="get" action="f22qry_kc_sub.asp" target="is">
      �������:
          <input name="rq1" type="text" id="rq1" size="11" maxlength="10" value="<%=get_date(date())%>" onFocus="setday(this);">
      <input type="submit" name="Submit" value="��ѯ(S)">
    </form></td>
    <td>&nbsp;</td>
    <td>��ӡ</td>
    <td>ѡ��</td>
    <td><a href="javascript:selectStyle();">ѡ��</a></td>
  </tr>
</table>
<iframe name="is" width="100%" height="90%" frameborder="0" src="f22qry_kc_sub.asp"></iframe>
<!--<table width="100%"  border="0" cellpadding="0" class="bar">
  <tr>
    <td>�ÿ���̿��</td>
  </tr>
</table>

<iframe name="iss" width="100%" height="35%" frameborder="0" src="f22qry_kc_subsub.asp"></iframe>
-->
</body>
</html>
