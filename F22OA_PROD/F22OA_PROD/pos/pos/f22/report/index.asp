<!--#include file="../inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/report.css" rel="stylesheet" type="text/css">
<title>�ޱ����ĵ�</title>
<script type="text/javascript" src="inc/setday.js"></script>
<script language="javascript">
function alt2(){//ѡ������
  showModalDialog('selectdepot.asp?action=set&title=ѡ�񷢻���&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}

function alt3(){//ѡ���ջ���
  showModalDialog('selectdepot.asp?action=get&title=ѡ���ջ���&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}
function priview(){
  var qs=window.parent.mainFrame.querystring;
  //alert(qs);
  window.open("main.asp?"+qs,"e","height="+(screen.availHeight-20)+",width="+screen.availWidth+",left=0,top=0,scrollbars=auto,status=no,memus=yes");
}
function selectStyle(){
  showModalDialog('../selectStyle.asp?action=set&title=ѡ���ʽ&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}
</script>
</head>
<body>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="bigbar">
  <tr class="f12">
    <td width="74%" height="26">
	      <form action="main.asp" method="post" name="form1" target="is">
      ��ѯ��Χ:
            <input name="rq1" type="text" id="rq1" onFocus="setday(this)" value="<%=get_date(date-30)%>" size="10" maxlength="10" style="height:20px; ">
              <input name="rq2" type="text" id="rq2" size="10" maxlength="10" value="<%=get_date(date)%>" onFocus="setday(this)" style="height:20px; ">
              <input name="ext" type="hidden" id="ext" value="<%=request.querystring("ext")%>">
              <input type="submit" name="Submit" value="��ѯ(S)">
    </form></td>
    <td width="26%">ѡ�� <a href="javascript:selectStyle();">ѡ��</a> <a href="javascript:priview();">Ԥ��</a> ��ӡ ����</td>
  </tr>
</table>
<iframe name="is" width="100%" height="94%" frameborder="0" src="main.asp"></iframe>
</body>
</html>
