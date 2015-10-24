<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/report.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<script language="javascript">
function selectStyle(){
  showModalDialog('select1.asp','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}

</script>

</head>

<body>
<%' call cbanner("")%>
<table width="100%"  border="0" cellpadding="0" class="f14">
  <tr>
    <td><form name="form1" method="get" action="f22qry_kcjxc_sub.asp" target="is">
      日期范围:
          <input name="rq1" type="text" id="rq1" size="11" maxlength="10" value="<%=get_date(date()-1)%>" onFocus="setday(this);">
          <input name="rq2" type="text" id="rq2" size="11" maxlength="10" value="<%=get_date(date())%>" onFocus="setday(this);">
	  汇总方式：<select name="dtype" size="1"><option value="0">按款号</option><option value="1">按款式</option><option value="2">汇总</option></select>
      <input type="submit" name="Submit" value="查询(S)" onClick="document.all.form1.act.value=1">
	  <input type=button value=" 选 款 " onClick="javascript:selectStyle();">
	  <input type="hidden" name="act" value="1">
	  <input type="button" name="but" value="导出Excel" onClick="document.all.form1.act.value=2;document.all.form1.submit();">
    </form></td>
    <!--<td>&nbsp;</td>
    <td>打印</td>
    <td>选店</td>
    <td></td>-->
  </tr>
</table>
<iframe name="is" width="100%" height="88%" frameborder="0" src="f22qry_kcjxc_sub.asp"></iframe>
</body>
</html>
