<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="inc/abc.js"></script>
    <script src="../../../Scripts/jquery-1.2.6.min.js" type="text/javascript"></script>
<title>选择销售单</title>

 <!--#include file="../f22/report/inc/function.asp" -->
<script language="javascript">

function ok(){
  if(trim(sms.id)!=""){
    sms.gtchkselect(sms.gt);
  }else{
	    alert("选择销售单!"); 
  }
}

</script>
<base target="_self" />
</head>

<body>

<iframe name="sms" src="selectRetailSub.asp" width="100%" height="88%" frameborder="0" scrolling="no"></iframe>
      <hr />
  <table width="100%"  border="0">
    <tr>
      <td align="center" >
	   <input type="button" name="submit" value="确定(c)" onclick="ok();" accesskey="c" />
        <input type="button" name="submit" value="取消(x)" onclick="window.close();" accesskey="x" /></td>
    </tr>
  </table>
</body>
</html>
