<!--#include file="inc/function.asp" -->
<%action=request("action")
select case action
case "add" add()
case "check" check()
case else main()
end select

sub main()
strPathInfo = Request.ServerVariables("PATH_INFO")
strPathInfo = "http://" & Request.ServerVariables("SERVER_NAME") & ":"& request.ServerVariables("SERVER_PORT") & Left(strPathInfo,InstrRev(strPathInfo,"/"))
%>
<html>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>产品维修登记</title>
<base target="_self">
</head>
<style type="text/css">
.chkbox{margin:0px;
padding:0px;
}
</style>
<script>
function check(t){
  if(t.code.value!="")
  return true;
  else
  return false;
}

function checkclothingid(name1,name2){
}

//function getcode(name1){
//}

function getcode(name1){
    var objXMLHTTP=new ActiveXObject("MICROSOFT.XMLHTTP");
	//var url = "<%=strPathInfo%>" + "product_pos.asp?clothingid=" + name1.value +"&action=check";
	var url = "<%=strPathInfo%>" + "XmlHttp.asp?code=" + name1.value +"&ns=code";
	alert(url);
	objXMLHTTP.open("GET",url,false);
	objXMLHTTP.send();
	var s=objXMLHTTP.ResponseText;
	var t=document.form1;
	//document.write(strReturn);
	if (s=="no"){
		alert("此编码在系统销售记录中不存在，请确认后重新输入！");
	    //name1.value="";
		name1.focus();
	}else{
		s=s.split(",");
		t.clothingid.value=s[0];
		t.st_xh.value=s[1];
		t.c_name.value=s[2];
		t.s_price.value=s[3];
		t.x_price.value=s[4];
		t.buy_date.value=s[5];
	}
}

function tj(t){
  document.form1.action='?action=add&t='+t;
  if(check(document.form1))document.form1.submit();
}
</script>
<script language="javascript" src="../inc/js/setday.js"></script>
<body>
<form action="product_pos_sub.aspx" method="get" name="form1" target="is" onSubmit="return check(this)">
  <table width="100%"  border="0" align="center" class="bar">
    <tr>
      <td align="center">产 品 维 修 登 记</td>
    </tr>
  </table>
  <div style="display:none;">
  <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#ECD4D0" bordercolorlight="#FFFFFF" class="f12">
  <tr>
    <td align="right">内部编码：</td>
    <td><input name="code" type="text" id="code" onKeyDown="if(event.keyCode==13){getcode(this);}" size="15" maxlength="20"></td>
    <td colspan="4" class="notice">输入内部编码,并回车!</td>
    </tr>
</table>
</div>
</form>
<iframe name="is" width="100%" height="80%" frameborder="0" 
 marginheight="0" marginwidth="0" align="middle" scrolling="no"
 src="product/product_pos_sub.aspx"></iframe>
</body>
</html>
<%end sub%>