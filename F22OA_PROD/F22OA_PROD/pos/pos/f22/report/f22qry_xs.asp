<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/report.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<script language="javascript">
function clothing(id){
  showModalDialog('clothing.asp?id='+id+'&pksname=','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}

function op(url){
showModalDialog(url,'example05','dialogWidth:600px;dialogHeight:470px;center: yes;help:no;resizable:yes;status:no');
}
</script>
</head>

<body>
<%dim page,cid
cid=trim(request.QueryString("cid"))
'msid=trim(request.QueryString("msid"))
msid=122
select case session("dm").System_UserType
case 1,2,3
  if cid="" then cid="3002"
case 4
  if cid="" then cid="2000"
end select%>
<form action="f22qry_xssub.asp" method="get" name="form1" target="is">
  <table width="100%"  border="0" cellpadding="0" cellspacing="1" class="bar">
    <tr>
      <td>查询范围:
        <input name="rq1" type="text" id="rq1" size="11" maxlength="10" value="<%=get_date(date()-1)%>" onFocus="setday(this);" readonly>
        <input name="rq2" type="text" id="rq2" size="11" maxlength="10" value="<%=get_date(date())%>" onFocus="setday(this);" readonly>
        <input type="submit" name="Submit" value="查询" onClick="document.all.form1.typ.value=1">
        <input name="act" type="hidden" id="act" value="<%=cid%>">
		<input name="msid" type="hidden" id="msid" value="<%=msid%>">
      <input name="rqopt" type="radio" value="0" checked>
      所选日期
      <input type="radio" name="rqopt" value="1">
      所有日期      
      <input name="depotid" type="hidden" id="depotid" value="<%=request.querystring("depotid")%>">
	  <input type="hidden" name="typ" value="1">
	  <input type="button" name="but" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
    <input name="selectdepot" type="button" class="box" value="选择款式" onClick="javascript:op('select1.asp')">
      </td>
    </tr>
  </table>
</form>
<iframe name="is" id="is" width="100%" height="92%" frameborder="0" src="f22qry_xssub.asp?act=<%=cid%>&msid=<%=msid%>"></iframe>
</body>
</html>
