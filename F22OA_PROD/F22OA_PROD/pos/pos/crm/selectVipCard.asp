<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="inc/abc.js"></script>
<title>选择VIP卡</title>
<script language="javascript">
function ok(){
  if(trim(sms.id)!=""){
      //单选的
		 sms.gtDoDblClick(sms.gt);
         
  }else{
    alert("请选择一个VIP卡!");
  }
}

function search() {
    var key = document.form1.key.value;
    document.getElementById("sms").src = "selectVipCardSub.asp?vipid=<%=trim(request.QueryString("vipid"))%>&key=" + key; 
}
</script>
<base target="_self">
</head>

<body>
  <table width="100%"  border="0" cellpadding="0" cellspacing="0" class="f12">
  <form name="form1" method="post" action="selectVipCardSub.asp" target="sms">
    <tr>
      <td>查找:<input name="key" type="text" id="key" size="32" maxlength="70" />
      <input name="vipid" type="hidden" id="vipid" value="<%=trim(request.QueryString("vipid"))%>">
          &nbsp;<input type="button" value="查询(S)" accesskey="s" onclick = "search();"/>  
      </td>
    </tr>
  </form>
  </table>
<iframe name="sms" id="sms" src="selectVipCardSub.asp?vipid=<%=trim(request.QueryString("vipid")) %>" width="100%" height="80%" frameborder="0" scrolling="no"></iframe>
  <table width="100%"  border="0">
    <tr>
	
      <td align="center">
	   <input type="button" name="Submit" value="确定(C)" onClick="ok();" accesskey="c" />
       <input type="button" name="Submit" value="取消(X)" onClick="window.close();" accesskey="x" /></td>
    </tr>
  </table>
</body>
</html>
