<!--#include file="inc/function.asp" -->
<%set rs=server.CreateObject("adodb.recordset")
sql="select top 1 a.indentid from d_indent a,j_user b where a.get_depotid='"&session("dm").System_Depotid&"' "&_
    "and isnull(a.chk_sure,0)=0 and isnull(a.sure,0)=0 and a.d_type=1 and a.cr_name=b.username "&_
	"and b.userid='"&session("dm").System_Userid&"' order by a.indentid desc"
rs.open sql,cn
if not rs.eof then
   response.Cookies("pic_indentid")=rs("indentid")
   response.Write("<script>window.returnValue=1;window.close();</script>")
else
   response.Cookies("pic_indentid")=""
end if

depotid=trim(request("depotid"))
if depotid<>"" then
  response.Cookies("pic_indentdepotid")=depotid
  response.Write("<script>window.returnValue=1;window.close();</script>")
end if%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ѡ��ֿ�</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="inc/abc.js"></script>
<script language="javascript">
<%Call selectSFdh%>
function checkform(theform){
var msg=""
	if(theform.depotid.value==''){
	  msg="�ֿⲻ��Ϊ��!";
	  theform.depotid.focus();
	}
  if(msg=="")
    return true;
  else{
    alert(msg);
    return false;
  }
}
</script>
<base target="_self">
</head>

<body>
<form action="" method="get" name="form1" id="form1" onSubmit="return checkform(this);">
<div align="center">
<table width="400"  border="0" align="center" class="bar">
    <tr align="center">
      <td>ѡ��ֿ� : <input name="depotid" type="text" class="intra13" id="depotid" size="15" maxlength="10" readonly>
          <input type="button" name="Submit" value="..." onClick="selectMD('sd');" size="10">
      <input name="sdptname" type="text" class="tcontent" id="sdptname" style="border:none;" tabindex="-1" size="16" readonly></td>
    </tr>
</table>
<br>
<table width="400"  border="0" class="tcontent">
    <tr>
      <td align="center"><input type="submit" name="Submit" value="ȷ��(S)" accesskey="s">
        <input type="button" name="Submit" value="ȡ��(X)" onClick="window.returnValue=0;window.close();" accesskey="x"></td>
    </tr>
</table>
</div>
</form>
</body>
</html>
<%cn.close
set cn=nothing%>