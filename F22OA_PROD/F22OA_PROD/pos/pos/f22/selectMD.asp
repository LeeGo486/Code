<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="inc/abc.js"></script>
<title><%=request.ServerVariables("QUERY_STRING")%>ѡ��ֿ�����</title>
<script language="javascript">
function selectall(obj){
   var action='<%=request("action")%>';
   if(action!=" ")action=trim(action);
   if(action=="spdx")
	 sms.SetchkselectAll(obj.value);
		 
   if (obj.value=="ȫѡ(Q)")
   {
	   sms.id="0";
	   obj.value="ȡ��ȫѡ(Q)"
   }
   else
   { 
	   sms.id="";
	   obj.value="ȫѡ(Q)"
	}
}

function ok(){
  if(trim(sms.id)!=""){
      //��ѡ��
		var action='<%=request("action")%>';
  		if(action!=" ")action=trim(action);
  		if(action=="spdx")
     	 sms.gtchkselect(sms.gt);
	    else
		 sms.gtDoDblClick(sms.gt);
         
  }else{
    alert("��ѡ��һ��������!");
  }
}
function title(){
  var action='<%=request("action")%> ';
  if(action!=" ")action=trim(action);
  if(action=="sd")
    document.title="ѡ�񷢻��ֿ�";
  else
    document.title="ѡ���ջ��ֵ�";
}
title();
function alta(){
  document.form1.key.value="";
  document.form1.submit();
}
</script>
<base target="_self">
</head>

<body>
  <table width="100%"  border="0" cellpadding="0" cellspacing="0" class="f12">
  <form name="form1" method="get" action="selectMDSub.asp" target="sms">
    <tr>
      <td>����:<input name="key" type="text" id="key" size="70" maxlength="70">
        <input name="action" type="hidden" id="action" value="<%=trim(request("action"))%>">
        <input name="zb" type="hidden" id="zb" value="<%=request.querystring("zb")%>">
</td>
    </tr>
    <tr>
      <td><input name="way" type="radio" value="1" checked>������
	      <input name="way" type="radio" value="2">��������
          <input name="way" type="radio" value="3">�����̱��
      <input type="submit" name="Submit" value="��ѯ(S)" accesskey="s">
      <input type="reset" name="Submit" value="����(ESC)">
      <input type="button" name="Submit" value="��ʾ����(A)" accesskey="a" onClick="alta();">
      <input type="button" name="Submit" value="ȫѡ(Q)" accesskey="q" onClick="selectall(this);">
	 
	  </td>
    </tr></form>
  </table>
<iframe name="sms" src="selectMDSub.asp?<%=request.ServerVariables("QUERY_STRING")%>" width="100%" height="80%" frameborder="0" scrolling="no"></iframe>
  <table width="100%"  border="0">
    <tr>
	
      <td align="center">
	   <input type="button" name="Submit" value="ȷ��(C)" onClick="ok();" accesskey="c">
        <input type="button" name="Submit" value="ȡ��(X)" onClick="window.close();" accesskey="x"></td>
    </tr>
  </table>
</body>
</html>
