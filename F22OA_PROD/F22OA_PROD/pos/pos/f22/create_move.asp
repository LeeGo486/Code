<%option explicit
Response.Expires=-1000
'on error resume next%>
<!--#include file="inc/function.asp" -->
<%
if not padd and trim(request("action"))="create" then
   call mbox("没有新增权限！")
end if

dim ds
set ds=server.CreateObject("ADODB.Recordset")
    ds.activeconnection = cn%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>编辑查看单据</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../inc/js/setday.js"></script>
<script type="text/javascript" src="inc/abc.js"></script>
<script language="javascript">
function selectMD(str,opt){
  var m=showModalDialog('SelectMD.asp?action='+str,'SelectDepot','dialogWidth:780px;dialogHeight:'+(screen.height-350)+'px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
  var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid;
  if(opt==0){
	try{
	arr=m.split(",");
	get_depotid=arr[0];//仓库ID
	edptname=arr[1];//仓库名
	get_mchid=arr[2];//店铺ID,二级编号
	parentid=arr[3];//一级编号
	document.form1.set_depotid.value=get_depotid;
	document.form1.sdptname.value=edptname;
	//document.form1.get_mchid.value=get_mchid;
	//document.form1.parentid.value=parentid;
	}catch(ex){}
  }else
   if(opt==1){
	try{
	arr=m.split(",");
	get_depotid=arr[0];//仓库ID
	edptname=arr[1];//仓库名
	get_mchid=arr[2];//店铺ID,二级编号
	parentid=arr[3];//一级编号
	document.form1.get_depotid.value=get_depotid;
	document.form1.edptname.value=edptname;
	document.form1.get_mchid.value=get_mchid;
	//document.form1.parentid.value=parentid;
	}catch(ex){}
  }
}

function checkform(){
  var moveid,move,set_depotid,get_mchid,backrate,get_depotid,msg="";
  with(document){
    moveid=trim(form1.moveid.value);
    move=trim(form1.move.value);
    set_depotid=trim(form1.set_depotid.value);
	get_mchid=trim(form1.get_mchid.value);
	get_depotid=trim(form1.get_depotid.value);
	backrate=trim(form1.backrate.value);
    if(isEmpty(moveid)){
      msg="流水号不能为空!";
	  form1.moveid.focus();
    }
    if(isEmpty(move)){
      msg="配货单号不能为空!";
      form1.move.focus();
    }
	
	if(isEmpty(set_depotid)){
	  msg="发货仓库不能为空!";
	  alert(msg);
	  selectMD('sm',0);
	  return false;
	}
	
	//if(isEmpty(get_depotid) || isEmpty(get_mchid)){
	if(isEmpty(get_depotid)){
	  msg="收货仓库不能为空!";
	  alert(msg);
	  selectMD('sm',1);
	  return false;
	}
	if(isEmpty(backrate)){
	  form1.backrate.value="0";
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
<%
dim id,sql,action
dim moveid,move,indentid,setdate,sure,chk_sure,set_depotid,getdate,d_type,crname,chkname,parentid 'as string
dim chk_date,sure_date,ov_date,ov_sure,ov_name,cr_date,crdate,comment,backrate,selltype,backdate 'as string
dim setdptname,getdptname,get_depotid,fname,set_comment,userid,username ' as string
id=trim(request("id"))
action=trim(request.Form("action")) 
if session("d_type")=1 then
 fname="FC"
elseif session("d_type")=2 then
 fname="FC"
elseif session("d_type")=3 then
 '
else
 fname="FC"
end if
if id<>"" then session("id")=id
if action="" then action=trim(request.QueryString("action"))

select case action
case "del"
  Call getGant("del",0,session("formid"))
  if id="" then 
    Err.Raise 50001,"create_move.edit","请选择要删除的单据!"
  else
    sql="delete from d_move Where moveid="&qts(id)
    cn.execute sql
	set cn=nothing
	call close("删除成功!")
  end if
case "save" '保存修改的单据
  save
case "edit" '打开界面
  if id="" then
    Err.Raise 50001,"create_move.edit","请先选择单据,才能编辑!"
  else
    sql="Select * From v22d_move Where moveid="&qts(id)
    ds.source = sql
    ds.open
    if not ds.eof then
      moveid=id
      move=ds("move")
	  set_depotid=ds("setdepotid")
	  setdptname=ds("dptname")
	  get_depotid=ds("getdepotid")
	  getdptname=ds("getdptname")
	  indentid=ds("indentid")
	  setdate=ds("setdate")
	  getdate=ds("getdate")
      backrate=ds("backrate")
      backdate=ds("backdate")
      comment=ds("set_comment")
      selltype=ds("selltype")
	  if not isnumeric(backrate) then backrate="0"
    end if
    ds.close
    set ds=nothing
	call show
  end if
case "create"
  Call getGant("create",0,session("formid"))
  moveid=getid("d_move","moveid",fname,session("dm").System_UserId)
  move=moveid
  set_depotid=session("dm").System_Depotid
  setdptname=session("dm").System_DepotName
  'get_depotid=set_depotid
  setdate=get_date(date)
  getdate=get_date(date+15)
  backrate="0"
  backdate=get_date(date+30)
  session("id")=moveid
  call show
case else
  Err.Raise 50001,"create_move.else","没有设置命令!"
end select%>
<%sub show%>
<form name="form1" method="post" action="" onSubmit="return checkform();">
  <table width="480"  border="0" align="center" class="bar">
    <tr>
      <td align="center">调拔单</td>
    </tr>
  </table>
  <table width="480"  border="0" align="center" class="tcontent">
    <tr>
      <td width="19%" align="right"><input name="action" type="hidden" value="save">
        流水号:</td>
      <td width="85%"><input name="moveid" type="text" class="intra13" id="moveid" value="<%=moveid%>" size="22" maxlength="22" readonly>
          <input type="hidden" name="hiddenField">          </td>
    </tr>
    <tr>
      <td align="right">发货单号:</td>
      <td><input name="move" type="text" id="move" value="<%=move%>" size="22" maxlength="22"></td>
    </tr>
    <tr>
      <td align="right">发货仓库:</td>
      <td><input name="set_depotid" type="text" id="set_depotid" value="<%=set_depotid%>" size="22" maxlength="10" readonly>
          <input type="button" name="Submit" value="..." onClick="selectMD('sm',0);">
          <input name="sdptname" type="text" class="tcontent" id="sdptname" style="border:none;" value="<%=setdptname%>" size="10" readonly></td>
    </tr>
    <tr>
      <td align="right">收货店铺:</td>
      <td><input name="get_depotid" type="text" id="get_depotid" value="<%=get_depotid%>" size="22" maxlength="10" readonly>
          <input type="button" name="Submit" value="..." onClick="selectMD('sm',1);">
          <input name="edptname" type="text" class="tcontent" id="edptname" style="border:none;" value="<%=getdptname%>" size="10" readonly>
          <input name="get_mchid" type="hidden" id="get_mchid">          </td>
    </tr>
    <tr>
      <td align="right">销售类型:</td>
      <td><%=getLookupByName(4001,selltype)%></td>
    </tr>
    <tr>
      <td align="right">发货日期:</td>
      <td><input name="edate" type="text" id="edate" onFocus="setday(this)" value="<%=getdate%>" size="22" maxlength="10" readonly></td>
    </tr>
    <tr>
      <td align="right">换货率:</td>
      <td><input name="backrate" type="text" id="backrate" value="<%=backrate%>" size="22" maxlength="10" readonly>
        %</td>
    </tr>
    <tr>
      <td align="right">换货日期:</td>
      <td><input name="backdate" type="text" id="backdate" onFocus="setday(this)" value="<%=backdate%>" size="22" readonly></td>
    </tr>
    <tr>
      <td align="right">参照配货单:</td>
      <td><input name="indentid" type="text" disabled class="intra13" id="indentid" value="<%=indentid%>" size="22" maxlength="22" readonly></td>
    </tr>
    <tr>
      <td align="right">备注:</td>
      <td><input name="comment" type="text" id="comment" value="<%=comment%>" size="50"></td>
    </tr>
  </table>
  <table width="480"  border="0" align="center">
    <tr>
      <td></td>
    </tr>
  </table>
  <div align="center">
    <table width="480"  border="0" class="tcontent">
      <tr>
        <td align="center"><input type="submit" name="Submit" value="保存(S)" accesskey="s">
            <input type="button" name="Submit" value="取消(X)" onClick="window.close();" accesskey="x"></td>
      </tr>
    </table>
  </div>
</form>
<%end sub%>
<%sub save
 
  set_depotid=trim(request.Form("set_depotid"))
  get_depotid=trim(request.Form("get_depotid"))
  moveid=trim(request.Form("moveid"))
  move=trim(request.Form("move"))
  setdate=trim(request.Form("setdate"))
  getdate=trim(request.Form("getdate"))
  selltype=trim(request.Form("selltype"))
  backrate=trim(request.Form("backrate"))
  backdate=trim(request.Form("backdate"))
  comment=trim(request.Form("comment"))
  
  if setdate="" then setdate=get_date(date)
  if getdate="" then getdate=setdate
  if backdate="" then backdate=get_date(date+30)
  
  userid=Session("dm").System_userId
  userName=session("dm").System_username
  d_type=session("d_type")

  sql="select * from d_move where moveid ='"& id &"'"
  ds.CursorType = 1
  ds.CursorLocation = 2
  ds.LockType = 3
  ds.source = sql
  ds.open
  if ds.eof then
    Call getGant("create",0,session("formid"))
    '保存新增
	sql="insert into d_move(set_depotid,get_depotid,moveid,move,setdate,selltype,backrate," & _
	" backdate,set_comment,setcr_name,setcr_date,setchk_sure,set_sure,getchk_sure,get_sure) "& _
	 " values("& qts(set_depotid) &","& qts(get_depotid) &","& qts(moveid) &","& qts(move) &","& qts(setdate) &","& _
	  qts(selltype) &","& backrate &","& backdate &","& qts(comment) & _
	 ","&qts(UserName)&","&qts(get_date(date()))&",0,0,0,0)"
	cn.execute sql
	ds.close
	set ds=nothing
	set cn=nothing
	
	session("dbfh_setdepotid")=set_depotid
	session("dbfh_setdptname")=trim(request.Form("sdptname"))
	session("dbfh_getdepotid")=get_depotid
	session("dbfh_getdptname")=trim(request.Form("edptname"))
	session("dbfh_moveid")=moveid
	
	response.Write("<script language='javascript'>")
	'response.Write("showModalDialog('f22_main.asp?id="&moveid&"&pksname="&session("pksname")&"','es','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');")
	response.Write("window.returnValue='r';window.close();</script>")
  else
    Call getGant("edit",0,session("formid"))
    ds("move")=move
	ds("get_depotid")=get_depotid
	ds("set_depotid")=set_depotid
	ds("setdate")=setdate
	ds("selltype")=selltype
	ds("backrate")=backrate
	ds("backdate")=backdate
	ds("set_comment")=comment
	ds.update
	ds.close
    set ds=nothing
	call close("修改成功!")
  end if
end sub%>
<%if err.number <>0 then
    response.write "<script language='javascript'>alert("""&err.description&""");window.history.back();</script>"
end if%>
<script language="javascript">
 window.dialogWidth="500px";
  window.dialogHeight="390px";
  //window.dialogLeft   X座标   
  //window.dialogTop   Y座标 
</script>

</body>
</html>
<!--#include file="inc/foot.asp" -->