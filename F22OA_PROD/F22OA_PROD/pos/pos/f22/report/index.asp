<!--#include file="../inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/report.css" rel="stylesheet" type="text/css">
<title>无标题文档</title>
<script type="text/javascript" src="inc/setday.js"></script>
<script language="javascript">
function alt2(){//选发货地
  showModalDialog('selectdepot.asp?action=set&title=选择发货地&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}

function alt3(){//选项收货地
  showModalDialog('selectdepot.asp?action=get&title=选择收货地&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}
function priview(){
  var qs=window.parent.mainFrame.querystring;
  //alert(qs);
  window.open("main.asp?"+qs,"e","height="+(screen.availHeight-20)+",width="+screen.availWidth+",left=0,top=0,scrollbars=auto,status=no,memus=yes");
}
function selectStyle(){
  showModalDialog('../selectStyle.asp?action=set&title=选择款式&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}
</script>
</head>
<body>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="bigbar">
  <tr class="f12">
    <td width="74%" height="26">
	      <form action="main.asp" method="post" name="form1" target="is">
      查询范围:
            <input name="rq1" type="text" id="rq1" onFocus="setday(this)" value="<%=get_date(date-30)%>" size="10" maxlength="10" style="height:20px; ">
              <input name="rq2" type="text" id="rq2" size="10" maxlength="10" value="<%=get_date(date)%>" onFocus="setday(this)" style="height:20px; ">
              <input name="ext" type="hidden" id="ext" value="<%=request.querystring("ext")%>">
              <input type="submit" name="Submit" value="查询(S)">
    </form></td>
    <td width="26%">选店 <a href="javascript:selectStyle();">选款</a> <a href="javascript:priview();">预览</a> 打印 保存</td>
  </tr>
</table>
<iframe name="is" width="100%" height="94%" frameborder="0" src="main.asp"></iframe>
</body>
</html>
