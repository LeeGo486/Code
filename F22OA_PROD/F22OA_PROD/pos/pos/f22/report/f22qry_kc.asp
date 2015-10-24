<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/report.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<script language="javascript">
function selectStyle(){
  showModalDialog('../selectStyle.asp?action=set&title=选择款式&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}

</script>
</head>

<body>
<% call cbanner("")%>
<table width="100%"  border="0" cellpadding="0" class="f14">
  <tr>
    <td><form name="form1" method="get" action="f22qry_kc_sub.asp" target="is">
      库存日期:
          <input name="rq1" type="text" id="rq1" size="11" maxlength="10" value="<%=get_date(date())%>" onFocus="setday(this);">
      <input type="submit" name="Submit" value="查询(S)">
    </form></td>
    <td>&nbsp;</td>
    <td>打印</td>
    <td>选店</td>
    <td><a href="javascript:selectStyle();">选款</a></td>
  </tr>
</table>
<iframe name="is" width="100%" height="90%" frameborder="0" src="f22qry_kc_sub.asp"></iframe>
<!--<table width="100%"  border="0" cellpadding="0" class="bar">
  <tr>
    <td>该款店铺库存</td>
  </tr>
</table>

<iframe name="iss" width="100%" height="35%" frameborder="0" src="f22qry_kc_subsub.asp"></iframe>
-->
</body>
</html>
