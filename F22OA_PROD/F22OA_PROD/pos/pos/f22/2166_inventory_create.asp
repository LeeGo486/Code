<%option explicit
Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<%if not padd and trim(request("action"))="create" then
   call mbox("û������Ȩ�ޣ�")
end if%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����̵���쵥</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../inc/js/setday.js"></script>
<script type="text/javascript" src="inc/abc.js"></script>
<script language="javascript">
function selectMD(str){
    var m=showModalDialog('SelectMD.asp?action='+str,'SelectDepot','dialogWidth:780px;dialogHeight:'+(screen.height-350)+'px;center: yes;help:no;resizable:yes;status:no');
    var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid;
	if(str=='sm'){
    	try{
    	arr=m.split(',');
    	get_depotid=arr[0];//�ֿ�ID
    	edptname=arr[1];//�ֿ���
    	get_mchid=arr[2];//����ID,�������
    	parentid=arr[3];//һ�����
    	document.form1.depotid.value=get_depotid;
    	document.form1.depotname.value=edptname;
    	document.form1.merchantid.value=get_mchid;
    	document.form1.parentid.value=parentid;
    	}catch(ex){}
      }
}
function c1(){
  var m;
  m=window.confirm("���Ҫ�����̵������?�����̵�����,��ͬ�Ŀ�Ž����ϲ�!","bbb","ccc");
  if(m==true)
    showModalDialog('f22_create_inventory.asp?id='+top.id+'&pksname=move','example04','dialogWidth:400px;dialogHeight:200px;center: yes;help:no;resizable:yes;status:no');
}
function c2(){

}
function c3(){

}
function c4(){

}

function checkform(){
  var inventoryid,inventory,depotid,merchantid,backrate,get_depotid,msg="";
  with(document){
    inventoryid=trim(form1.inventoryid.value);
    inventory=trim(form1.inventory.value);
    depotid=trim(form1.depotid.value);
	merchantid=trim(form1.merchantid.value);
    if(isEmpty(inventoryid)){
      msg="��ˮ�Ų���Ϊ��!";
	  form1.inventoryid.focus();
    }
    if(isEmpty(inventory)){
      msg="������Ų���Ϊ��!";
      form1.inventory.focus();
    }
	
	if(isEmpty(depotid) || isEmpty(merchantid)){
	  msg="�̵�ֿⲻ��Ϊ��!";
	  alert(msg);
	  selectMD('sm');
	  return false;
	}
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
<%dim id,ds,sql,userid,fname,merchantid,parentid,d_type,ext
dim action,inventoryid,inventory,depotid,dptname,setdate,comment,get_comment
dim bar
bar=trim(request("bar"))
id=trim(request.QueryString("id"))
action=trim(request.Form("action")) 
ext=trim(request("ext"))
session("ext")=ext
if action="" then action=trim(request.QueryString("action"))
action=Lcase(action)
userid=session("dm").System_UserId
'de action
if id<>"" then session("id")=id

select case action
case "del"
  Call getGant("del",0,session("formid"))
  sql="delete from d_inventory where inventoryid="&qts(id)
  cn.execute sql
  set cn=nothing
  call close("ɾ���̵���쵥�ɹ�!")
case "save"
  call save
case "edit"
  sql="select inventoryid,inventory,depotid,dptname,merchantid,parentid,setdate,comment,d_type from v22p_inventory where inventoryid="&qts(id)
  set ds=server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
  ds.Source = sql
  ds.open
  if not ds.eof then
    inventoryid=ds("inventoryid")
    inventory=ds("inventory")
    depotid=ds("depotid")
	dptname=ds("dptname")
	merchantid=ds("merchantid")
	parentid=ds("parentid")
    setdate=ds("setdate")
    comment=ds("comment")
	d_type=ds("d_type")
  end if
  ds.close
  set ds=nothing
  call show
case "create"
  Call getGant("create",0,session("formid"))
  inventoryid=getid("d_inventory","inventoryid","PC",UserId)
  inventory=inventoryid
  depotid=session("dm").System_Depotid
  dptname=session("dm").System_DepotName
  merchantid=session("dm").System_UnitId
  setdate=get_date(date)
  call show
case else
  Err.Raise 50001,"create_inventory.else","û����������!"
end select%>

<%sub show%>
<form name="form1" method="post" action="" onSubmit="return checkform();">
<input name="bar" type="hidden" id="bar" value="<%=bar%>">
  <table width="480"  border="0" align="center" class="bar">
    <tr>
      <td height="19" align="center">�̵���쵥</td>
    </tr>
  </table>
  <table width="480"  border="0" align="center" class="tcontent">
    <tr>
      <td width="19%" align="right"><input name="action" type="hidden" id="action" value="save">
      ��ˮ��:</td>
      <td><input name="inventoryid" type="text" id="inventoryid" value="<%=inventoryid%>" size="25" maxlength="25" readonly="true"></td>
    </tr>
    <tr>
      <td align="right">�̵���쵥��:</td>
      <td><input name="inventory" type="text" id="inventory" value="<%=inventory%>" size="25" maxlength="25" readonly="true"></td>
    </tr>
    <tr>
      <td align="right">�̵�ֵ�:</td>
      <td><input name="depotid" type="text" id="depotid" value="<%=depotid%>" size="22" maxlength="10" readonly>
      <input type="button" name="Submit" value="..." onClick="selectMD('sm');" disabled>
      <input name="depotname" type="text" class="tcontent" id="depotname" style="border-width:0px " value="<%=dptname%>" size="20">
      <input name="merchantid" type="hidden" id="merchantid" value="<%=merchantid%>">
      <input name="parentid" type="hidden" id="parentid">
      <input name="stype" type="hidden" id="stype" value="1">
      </td>
    </tr>
    <tr>
      <td align="right">�̵�����:</td>
      <td><input name="setdate" type="text" id="setdate" onFocus="setday(this)" value="<%=setdate%>" size="11" maxlength="10" readonly></td>
    </tr>
    <tr>
      <td align="right">��ע:</td>
      <td><input name="comment" type="text" id="comment" value="<%=comment%>" size="50" maxlength="50"></td>
    </tr>
  </table>
  <table width="480"  border="0" align="center">
    <tr>
      <td></td>
    </tr>
  </table>
  <table width="480"  border="0" align="center" class="tcontent">
    <tr>
      <td align="center"><input type="submit" name="Submit" value="����(S)" accesskey="s">
      <input name="Submit" type="button" value="ȡ��(X)" onClick="window.close();" accesskey="x"></td>
    </tr>
  </table>
</form>
<%end sub%>
<%
sub save
  inventoryid=trim(request.Form("inventoryid"))
  inventory=trim(request.Form("inventory"))
  depotid=trim(request.Form("depotid"))
  dptname=trim(request.Form("dptname"))
  merchantid=trim(request.Form("merchantid"))
  parentid=trim(request.Form("parentid"))
  setdate=trim(request.Form("setdate"))
  comment=trim(request.Form("comment"))
  d_type=trim(request.Form("stype"))
  
  if d_type="" then
    d_type="0"
  end if
  
  sql="select top 1 * from d_inventory where inventoryid="&qts(id)
  
  set ds=server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
  ds.LockType=3
  ds.Source = sql
  ds.open
  if ds.eof then
    Call getGant("create",0,session("formid"))
    ds.Addnew
    ds("inventoryid")=inventoryid
		ds("inventory")=inventory
    ds("depotid")=depotid
    ds("setdate")=setdate
		ds("sure_date")=setdate
    ds("comment")=comment
		ds("chk_sure")=0
		ds("sure")=0
		ds("ov_sure")=0
		ds("diff")=0
		ds("cr_date")=get_date(date)
		ds("cr_name")=session("dm").System_UserName
		ds("d_type")=d_type
	ds.update
    ds.close
	set ds=nothing
	response.Write("<script language='javascript'>")
	if bar="1" then
	  response.Write("window.location.href='ajax/2166_inventory.asp?id="&inventoryid&"';")
	else
	response.Write("showModalDialog('f22_main.asp?id="&inventoryid&"&pksname=inventory&opt=inventory&numName=d_nums','es','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');")
	'response.Redirect "create_inventory_sub.asp?id="&inventoryid
	'if d_type="0" then
	'  response.Redirect "create_inventory_all.asp?depotid="&depotid
	'else
	'  response.Redirect "create_inventory_ext.asp?depotid="&depotid
	'end if
	'response.Write("window.returnValue='r';window.close();")
	response.Write("window.location.href='search_frame.asp';")
	end if
	response.Write("</script>")
  else
    Call getGant("edit",0,session("formid"))

    ds("inventory")=inventory
    ds("depotid")=depotid
    ds("setdate")=setdate
		ds("d_type")=d_type
    ds("comment")=comment
		ds.update
    ds.close
	set ds=nothing
    response.Write("<script language='javascript'>alert('�༭���ݳɹ�!');window.close();</script>")
  end if
end sub
%>
<script language="javascript">
 window.dialogWidth="500px";
  window.dialogHeight="280px";
  //window.dialogLeft   X����   
  //window.dialogTop   Y���� 
</script>
</body>
</html>