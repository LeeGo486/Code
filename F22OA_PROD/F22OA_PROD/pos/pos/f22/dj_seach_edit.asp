<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<title>�޸Ķ���</title>
<base target="_self">
<link href="css/link.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../inc/js/setday.js"></script>
<script language="javascript">
function check(theform)
{if(theform.names.value==""){alert("��������Ϊ�գ�");theform.names.focus();return false;}
if(theform.mobel.value==""){alert("�ƶ��绰����Ϊ�գ�");theform.mobel.focus();return false;}
if(theform.styleid.value==""){alert("������ʽ����Ϊ�գ�");theform.styleid.focus();return false;}
if(theform.nums.value==""){alert("������������Ϊ�գ�");theform.nums.focus();return false;}
if(theform.fullprice.value==""){alert("ȫ�۽���Ϊ�գ�");theform.fullprice.focus();return false;}
if(theform.djprice.value==""){alert("�������Ϊ�գ�");theform.djprice.focus();return false;}
if(isNaN(theform.nums.value)){alert('���������������ʹ���');theform.nums.focus();return false;}
if(isNaN(theform.fullprice.value)){alert('ȫ�۽���������ʹ���');theform.fullprice.focus();return false;}
if(isNaN(theform.djprice.value)){alert('�������������ʹ���');theform.djprice.focus();return false;}
}
</script>
</head>
<body>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%id=request("id")
depotid=session("dm").System_depotid

set rs=server.createobject("adodb.recordset")
sql="select retaildjid,names,mobel,tel,styleid,isnull(nums,0) as nums,isnull(fullprice,0) as fullprice,isnull(djprice,0) as djprice,"&_
    "convert(char(10),setdate,126) as setdate,convert(char(10),getdate,126) as getdate,adds,comment,isnull(ov_sure,0) as ov_sure "&_
	"from d_retaildj where retaildjid='"&id&"'"
rs.open sql,cn,1,1
if cint(rs("ov_sure"))=0 then reonly="" else reonly="readonly" end if%>
<table width="590" height="300" border="0" cellpadding="0" cellspacing="0">
<form name="form1" method="post" action="dj_seach_insert.asp?act=2&id=<%=rs("retaildjid")%>" onSubmit="return check(this)">
  <tr>
    <td align=right><font size=2 color="red">�� ����</font></td>
    <td><input type="text" name="names" size=12 class=editbox2 value="<%=rs("names")%>" <%=reonly%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    <td align=right><font size=2 color="red">�ƶ��绰��</font></td><td><input type="text" name="mobel" <%=reonly%> value="<%=rs("mobel")%>" size=12 class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    <td align=right><font size=2>�̶��绰��</font></td><td><input type="text" name="tel" size=12 <%=reonly%> value="<%=rs("tel")%>" class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
  </tr>
  <tr>
    <td align=right><font size=2 color="red">������ʽ��</font></td><td colspan="5"><input type="text" <%=reonly%> name="styleid" value="<%=rs("styleid")%>" size=50 class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
  </tr>
  <tr>
    <td align=right><font size=2 color="red">����������</font></td><td><input type="text" name="nums" size=12 <%=reonly%>  value="<%=rs("nums")%>" class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    <td align=right><font size=2 color="red">ȫ�۽�</font></td><td><input type="text" name="fullprice" size=12 <%=reonly%> value="<%=rs("fullprice")%>" class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    <td align=right><font size=2 color="red">�����</font></td><td><input type="text" name="djprice" size=12 <%=reonly%> value="<%=rs("djprice")%>" class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
  </tr>
  <tr>
    <td align=right><font size=2 color="red">�¶����ڣ�</font></td><td><input name="setdate" type="text" id="setdate" size="10"  value="<%=rs("setdate")%>" class="editbox2" readonly onFocus="setday(this)"  onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    <td align=right><font size=2 color="red">������ڣ�</font></td><td><input name="getdate" type="text" id="getdate" size="10"  value="<%=rs("getdate")%>" class="editbox2" readonly onFocus="setday(this)"  onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align=right><font size=2>�� ַ��</font></td><td colspan="5"><input type="text" name="adds" size=90 value="<%=rs("adds")%>" <%=reonly%> class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
  </tr>
  <tr>
    <td align=right><font size=2>�� ע��</font></td><td colspan="5"><input type="text" name="comment" size=90 value="<%=rs("comment")%>" <%=reonly%> class=editbox2 onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
  </tr>
  <%if cint(rs("ov_sure"))=0 then%>
  <tr>
    <td colspan="6" align=center>
    <input type="submit" name="Subm" value=" �� �� " class=box>
    <input type="button" name="button" value=" �� �� " class=box onClick="window.close()">
    
    </td>
  </tr>
  <%end if%>
</form>
</table>
<%cn.close
set cn=nothing%>
</body>
</html>