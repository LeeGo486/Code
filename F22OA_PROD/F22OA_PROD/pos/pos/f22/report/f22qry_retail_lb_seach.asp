<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���۲�ѯ-������ۺ�</title>
</head>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<script language="javascript" src="ShowProcessBar.js"></script>
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<body>
<div id="submitok"  style="visibility:hidden;position: absolute; width: 320; height: 100"> 
<table width="320" border="1" align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" ID="Table1">
<tr><td width=100% valign=top>
<table width="320" border="0" height=100 align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor=Honeydew ID="Table2">
<tr><td align=center valign=middle>���ݴ����У����Ժ򡭡�</td></tr>
</table></td></tr></table></div>
<table width="600" border="0" cellspacing="0">
  <tr> 
    <td width="49%"><font size="2">��ǰλ�ã�--&gt; ���۲�ѯ --&gt; ���۲�ѯ-������ۺ�</font></td>
  </tr>
  <tr><td><hr size="2"></td></tr>
</table>
<table width="700" height="214" border="0" cellpadding="0" cellspacing="0">
  <form name="form2" method="post" action="f22qry_retail_lb_seach_mx.asp" onSubmit="document.form2.subm.disabled=true">
    <tr> 
      <td><font size="2">��ʼ���ڣ� 
        <input name="f_date" type="text" id="f_date" size="10" class="box" value="<%=get_date(date)%>" readonly onFocus="setday(this);" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
        </font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2">�������ڣ� 
        <input name="l_date" type="text" id="l_date" size="10" class="box" value="<%=get_date(date)%>" readonly onFocus="setday(this);" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
        </font></td>
      <td><font size="2">�� ��<select name="order" size=1><option value=0>����ѡ���ܷ�ʽ����</option><option value=1>����������</option><option value=2>���������</option></select></font></td>
    </tr>
    <tr> 
      <td colspan=3> <table width="100%" height="87" border="0" cellpadding="0" cellspacing="0">
          <tr> 
            <td height="43"><font size="2">��ѯ��ʽ�� 
              <label>
              <input type="radio" name="seachtype" value="1" <%if request("seachtype")="" or request("seachtype")="1" then response.write "checked"%>>
              ����ݻ���</label>
              <label>
              <input type="radio" name="seachtype" value="2" <%if request("seachtype")="2" then response.write "checked"%>>
              �����ڻ���</label>
              <label>
              <input type="radio" name="seachtype" value="3" <%if request("seachtype")="3" then response.write "checked"%>>
              ���������</label>
              <label>
              <input type="radio" name="seachtype" value="4" <%if request("seachtype")="4" then response.write "checked"%>>
              ���������</label>
              <label>
              <input type="radio" name="seachtype" value="5" <%if request("seachtype")="5" then response.write "checked"%>>
              ��С�����</label>
              <label>
              <input type="radio" name="seachtype" value="6" <%if request("seachtype")="6" then response.write "checked"%>>
              ��Ʒ�ƻ���</label>
              </font></td>
          </tr>
          <tr>
            <td><font size="2">�Ƿ���ʾ��̨�� 
              <label>
              <input type="radio" name="showdepot" value="1">
              ��</label>
              <label>
              <input type="radio" name="showdepot" value="2" checked>
              ��</label>
              </font></td>
          </tr>
        </table>
        <br>
        <br> <table width="251" border="0" align="center" cellspacing="0">
          <tr> 
            <td><div align="center"> 
                <input name="subm" id="subm" type="submit" value=": �� ѯ :" class=box onClick="submitok()">
              </div></td>
            <td><div align="center"> 
                <input name="reset" id="reset2" type="reset" value=": �� ѡ :" class=box>
              </div></td>
          </tr>
        </table></td>
    </tr>
  </form>
</table>
</body>
</html>
<%cn.close
set cn=nothing%>