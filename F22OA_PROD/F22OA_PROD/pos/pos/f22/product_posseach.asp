<%session("formid")=6100002%>
<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<link href="css/f22.css" rel="stylesheet" type="text/css">
<title>产品维修</title>
</head>
<script language="javascript" src="../inc/js/setday.js"></script>
<script language="javascript" src="inc/abc.js"></script>
<script>
function opennew()
{var s=showModalDialog('product_pos.asp','new','dialogWidth:750px;dialogHeight:570px;center: yes;help:no;resizable:no;status:no');
 document.iFrmRef.src='product_posseachmx.asp';}
</script>
<style type="text/css">
.chkbox{margin:0px;
padding:0px;
}
</style>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bar" >
  <tr>
    <td height="25">销售管理 &gt;&gt; 维修记录</td>
  </tr>
</table>
<table width="99%" height="5%" border="0" cellspacing="0">
  <form name="form1" method="post" action="product_posseachmx.asp" target="iFrmRef">
  <tr height=45%>
    <td colspan="5">
	<%if padd then%>
	<input type=button value="新增维修" onClick="opennew()">&nbsp;&nbsp;
	<%end if%>
	受理开始日期&nbsp;&nbsp;<input name="fdate" id="fdate" type="text" size="15" onFocus="setday(this)" value="<%=get_date(date)%>" readonly>
	受理结束日期&nbsp;&nbsp;<input name="ldate" id="ldate" type="text" size="15" onFocus="setday(this)" value="<%=get_date(date)%>" readonly>
    状态&nbsp;&nbsp;
	<select name="state" size=1>
	   <option value=0>全部(只能查询)</option>
	   <%if padd then%>
	   <option value=1 selected>未提交</option>
	   <%end if%>
	   <option value=2>已提交待处理</option>
	   <option value=3>已处理出货未收货</option>
	   <option value=4>已收货</option>
	</select>
	<input type="submit" name="Submit" value=" 查 询 "></td>
  </tr>
  </form>
</table>
<iFrame Name=iFrmRef id=iFrmRef SRC="product_posseachmx.asp" width="100%" height="94%" scrolling="auto" frameborder="0"></iFrame>
</body>
</html>