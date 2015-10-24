<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/report.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../inc/js/setday.js"></script>
</head>

<body>
<%dim rq1,rq2
rq1=request.QueryString("rq1")
rq2=request.QueryString("rq2")
%>
<table width="100%"  border="0" cellpadding="0" class="f14">
  <tr>
    <td><form name="form1" method="get" action="?">
      日期范围:
          <input name="rq1" type="text" id="rq1" size="11" maxlength="10" value="<%if rq1="" then response.write(get_date(date-1)) else response.write(rq1) end if%>" onFocus="setday(this);">
          <input name="rq2" type="text" id="rq2" size="11" maxlength="10" value="<%if rq2="" then response.write(get_date(date)) else response.write(rq2) end if%>" onFocus="setday(this);">
      <input type="submit" name="Submit" value="查询(S)">      
    </form></td>
	<form name="form2" method="get" action="f22qry_dzd_sub2.asp" target="is2">
	<td>
	<input type="hidden" name="act" value="2">
	<input name="rq1" type="hidden" id="rq1" value="<%=rq1%>">
    <input name="rq2" type="hidden" id="rq2" value="<%=rq2%>">
	<input type="submit" name="but" value="导出明细到Excel">
	</td>
	</form>
  </tr>
</table>
<iframe name="is1" width="100%" height="15%" frameborder="0" src="f22qry_dzd_sub1.asp?rq1=<%=rq1%>&rq2=<%=rq2%>"></iframe><br>
<iframe name="is2" width="100%" height="75%" frameborder="0" src="f22qry_dzd_sub2.asp?rq1=<%=rq1%>&rq2=<%=rq2%>"></iframe>
</body>
</html>
