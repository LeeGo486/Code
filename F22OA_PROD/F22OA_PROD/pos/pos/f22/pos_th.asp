<html>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�˻�</title>
<base target="_self">
</head>
<style type="text/css">
.chkbox{margin:0px;
padding:0px;
}
</style>
<script>
function check(theform){
  return true;
  if(theform.accept_dname.value==''){alert('������̲���Ϊ�գ�');return false;}
  if(theform.accept_date.value==''){alert('�������ڲ���Ϊ�գ�');return false;}
  if(theform.retailname.value==''){alert('�˿���������Ϊ�գ�');return false;}
  if(theform.retailname.value==''){alert('��Ʒ���벻��Ϊ�գ�');return false;}
  if(theform.c_name.value==''){alert('��ɫ����Ϊ�գ�');return false;}
  if(isNaN(theform.s_price.value)){alert('����۸����ʹ���');return false;}
  return true;
}

function checkclothingid(name1,name2){
}

function getcode(name1){
}

function tj(t){
  document.form1.action='?action=add&t='+t;
  if(check(document.form1))document.form1.submit();
}

function okd(){
  var k=event.keyCode;
  var v=document.form1.s_price.value;
  var d=document.form1.discount.value;
  //alert(k);
  if((k>=48 && k <=57)||(k>=96 && k <=105)){
    //alert(event.keyCode);
  }else if(k==8 || k ==46 || k==189 || k==190 || k==110){
    //return event.keyCode;
  }else if(k==13){
   if(v!="" && d!=""){
	 v=parseFloat(v,2);
	 d=parseFloat(d,2);
	 var vd=v*d;
	 vd=vd.toString();
	 vd=vd.substring(0,4);
	 document.form1.ys.value=vd;
   }
  }else{
    //alert(event.keyCode);
    return false;
  }
}
</script>
<script language="javascript" src="../inc/js/setday.js"></script>
<body>
<form action="pos_th_sub.asp" method="get" name="form1" target="is" onsubmit="return check(this)">
  <table width="600"  border="0" align="center" class="bar">
    <tr>
      <td align="center">�� �� �� ��</td>
    </tr>
  </table>
  <table width="600" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#ECD4D0" bordercolorlight="#FFFFFF" class="f12">
    <tr>
      <td align="right">�ڲ�����:</td>
      <td><input name="code" type="text" id="code" onKeyDown="if(event.keyCode==13){getcode(this);}" size="15" maxlength="20">
      <input type="submit" name="Submit" value="ȷ��"></td>
      <td colspan="4" class="notice">�����ڲ�����,���س�!</td>
    </tr>
  </table>
</form>
<iframe name="is" width="600" height="83%" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="pos_th_sub.asp"></iframe>
</body>
</html>