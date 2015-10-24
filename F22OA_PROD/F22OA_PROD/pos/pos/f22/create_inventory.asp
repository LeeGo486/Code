<%option explicit
Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>添加盘点单</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript" src="inc/setday.js"></script>
<script type="text/javascript" src="inc/abc.js"></script>
<script language="javascript">
function selectMD(str){
    var m=showModalDialog('SelectMD.asp?action='+str,'SelectDepot','dialogWidth:780px;dialogHeight:'+(screen.height-350)+'px;center: yes;help:no;resizable:yes;status:no');
    var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid;
	if(str=='sm'){
    	try{
    	arr=m.split(',');
    	get_depotid=arr[0];//仓库ID
    	edptname=arr[1];//仓库名
    	get_mchid=arr[2];//店铺ID,二级编号
    	parentid=arr[3];//一级编号
    	document.form1.depotid.value=get_depotid;
    	document.form1.depotname.value=edptname;
    	document.form1.merchantid.value=get_mchid;
    	document.form1.parentid.value=parentid;
    	}catch(ex){}
      }
}
function c1(){
  var m;
  m=window.confirm("真的要生成盘点差异吗?生成盘点差异后,相同的款号将被合并!","bbb","ccc");
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
      msg="流水号不能为空!";
	  form1.inventoryid.focus();
    }
    if(isEmpty(inventory)){
      msg="配货单号不能为空!";
      form1.inventory.focus();
    }
	
	if(isEmpty(depotid) || isEmpty(merchantid)){
	  msg="盘点仓库不能为空!";
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
  Call getGant("del",0)
  sql="delete from d_inventory where inventoryid="&qts(id)
  cn.execute sql
  set cn=nothing
  call close("删除盘点单成功!")
case "save"
  call save
case "edit"
  sql="select inventoryid,inventory,depotid,dptname,merchantid,parentid,setdate,comment from v22p_inventory where inventoryid="&qts(id)
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
  end if
  ds.close
  set ds=nothing
  call show
case "create"
  Call getGant("create",0)

  if ext="0" then
    fname="PD"
  elseif ext="1" then
    fname="PC"
  end if
  inventoryid=getid("d_inventory","inventoryid",fname,UserId)
  inventory=inventoryid
  depotid=session("dm").System_Depotid
  dptname=session("dm").System_DepotName
  merchantid=session("dm").System_UnitId
  setdate=get_date(date)
  call show
case else
  Err.Raise 50001,"create_inventory.else","没有设置命令!"
end select%>

<%sub show%>
<form name="form1" method="post" action="" onSubmit="return checkform();">
  <table width="480"  border="0" align="center" class="bar">
    <tr>
      <td height="19" align="center">盘点单</td>
    </tr>
  </table>
  <table width="480"  border="0" align="center" class="tcontent">
    <tr>
      <td width="19%" align="right"><input name="action" type="hidden" id="action" value="save">
      流水号:</td>
      <td><input name="inventoryid" type="text" id="inventoryid" value="<%=inventoryid%>" size="22" maxlength="22" readonly="true"></td>
    </tr>
    <tr>
      <td align="right">盘点单号:</td>
      <td><input name="inventory" type="text" id="inventory" value="<%=inventory%>" size="22" maxlength="22" readonly="true"></td>
    </tr>
    <tr>
      <td align="right">盘点仓库:</td>
      <td><input name="depotid" type="text" id="depotid" value="<%=depotid%>" size="22" maxlength="10" readonly>
      <input type="button" name="Submit" value="..." onClick="selectMD('sm');">
      <input name="depotname" type="text" class="tcontent" id="depotname" style="border-width:0px " value="<%=dptname%>" size="15">
      <input name="merchantid" type="hidden" id="merchantid" value="<%=merchantid%>">
      <input name="parentid" type="hidden" id="parentid"></td>
    </tr>
    <tr>
      <td align="right">盘点日期:</td>
      <td><input name="setdate" type="text" id="setdate" value="<%=setdate%>" size="11" maxlength="10" readonly></td>
    </tr>
	<%if ext="0" then%>
    <tr>
      <td align="right">&nbsp;</td>
      <td><input name="stype" type="radio" value="0" checked>
      全局盘点
        <input type="radio" name="stype" value="1">
      局部盘点</td>
    </tr>
	<%elseif ext="1" then%>
    <tr>
      <td align="right">&nbsp;</td>
      <td><input name="stype" type="radio" value="0" checked readonly="true" disabled>
      全局盘点
        <input type="radio" name="stype" value="1" readonly="true" disabled>
      局部盘点</td>
    </tr>
	<%end if%>
    <tr>
      <td align="right">备注:</td>
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
      <td align="center"><input type="submit" name="Submit" value="保存(S)" accesskey="s">
      <input name="Submit" type="button" value="取消(X)" onClick="window.close();" accesskey="x"></td>
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
    Call getGant("create",0)

    ds.Addnew
    ds("inventoryid")=inventoryid
	ds("inventory")=inventory
    ds("depotid")=depotid
    ds("setdate")=setdate
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
	response.Write("showModalDialog('f22_main.asp?id="&inventoryid&"&opt=inventory&numName=nums&pksname="&session("pksname")&"','es','dialogWidth:700px;dialogHeight:500px;center:yes;help:no;resizable:yes;status:no');")
	
	''response.Redirect "create_inventory_sub.asp?id="&inventoryid
	'if d_type="0" then
	'  response.Redirect "create_inventory_all.asp?depotid="&depotid
	'else
	'  response.Redirect "create_inventory_ext.asp?depotid="&depotid
	'end if
	response.Write("window.returnValue='r';window.close();</script>")
  else
    Call getGant("edit",0)

    ds("inventory")=inventory
    ds("depotid")=depotid
    ds("setdate")=setdate
	ds("d_type")=d_type
    ds("comment")=comment
	ds.update
    ds.close
	set ds=nothing
    response.Write("<script language='javascript'>alert('编辑单据成功!');window.close();</script>")
  end if
end sub
%>
<script language="javascript">
 window.dialogWidth="500px";
  window.dialogHeight="280px";
  //window.dialogLeft   X座标   
  //window.dialogTop   Y座标 
</script>
</body>
</html>