<%option explicit
on error resume next%>
<!--#include file="../inc/const.asp" -->
<!--#include file="inc/function.asp"-->
<%dim oldformid,djid
set cn=nothing
oldformid=request("oldformid")
djid=request("djid")%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/f22.css" rel="stylesheet" type="text/css">
<title>���ݿ���</title></head>
<script language="javascript">
function opensub(v){
var s='djcopysub.asp?oldformid=<%=oldformid%>&newformid='+v+'&djid=<%=djid%>';
  document.all.iFrmRef.src=s;
}
</script>
<body> 
<table width="750" border="0" align="center">
  <tr>
    <td><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="159"> 
            <table width="150" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="22"><font class="f12">���Կ����ĵ����б�</font></td>
              </tr>
              <tr>
                <td><select name="select" size="20" onDblClick="opensub(this.value)">
                    <option value="1005">1005 ������</option>
					<option value="1006">1006 ������</option>
					<!--<option value="1007">1007 �̳��ƻ���</option>-->
					<!--<option value="1008">1008 �����</option>-->
					<!--<option value="1009">1009 ������</option>-->
					<option value="1010">1010 �ջ���</option>
					<option value="1011">1011 �˻����뵥</option>
					<!--<option value="1012">1012 �����˻����뵥</option>-->
					<!--<option value="1013">1013 �˻�������</option>-->
					<option value="1014">1014 �˻�������</option>
					<!--<option value="1015">1015 �˻��ջ���</option>-->
					<option value="1017">1017 ����������</option>
					<option value="1018">1018 �����ջ���</option>
					<option value="1019">1019 �̵㵥</option>
					<!--<option value="1020">1020 �̵���쵥</option>-->
					<option value="1021">1021 ���۵�</option>
					<option value="1022">1022 ����������</option>
                  </select></td>
              </tr>
            </table>
          </td>
          <td width="585">
		  <iFrame Name=iFrmRef id=iFrmRef SRC="djcopysub.asp?oldformid=<%=oldformid%>&newformid=&djid=<%=djid%>" width="100%" height="100%" scrolling="auto" frameborder="0"></iFrame>
		  </td>
        </tr>
    </table></td>
  </tr>
</table>
<table width="746" height="32" border="0" align="center" class="tcontent">
  <tr>
    <td width="50%" height="26" align=center><input type="radio" name="copytype" value=0 checked>��ԭ�����ۼ�ѡ�е��ݵ�����
        <input type="radio" name="copytype" value=1>ȡ����</td>
    <td width="50%" align="center">
	<input type="button" name="Submit1" value="����(C)" onClick="iFrmRef.subm();" accesskey="c">
	<input type="button" name="Submit" value="�˳�(X)" onClick="window.close();" accesskey="x"></td>
  </tr>
</table>
</body>
</html>