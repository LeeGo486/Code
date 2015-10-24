<%option explicit
Response.Expires=-1000
'on error resume next%>
<!--#include file="inc/function.asp" -->
<%dim ds
set ds=server.CreateObject("ADODB.Recordset")
    ds.activeconnection = cn%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>加盟商配货单</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../inc/js/setday.js"></script>
<script type="text/javascript" src="inc/abc.js"></script>
<script language="javascript">
<%Call SelectSF()%>
function checkform(){
  var quotaid,quota,set_depotid,get_mchid,backrate,get_depotid,msg="";
  with(document){
    quotaid=trim(form1.quotaid.value);
    quota=trim(form1.quota.value);
    set_depotid=trim(form1.set_depotid.value);
	get_mchid=trim(form1.get_mchid.value);
	get_depotid=trim(form1.get_depotid.value);
	backrate=trim(form1.backrate.value);
    if(isEmpty(quotaid)){
      msg="流水号不能为空!";
	  form1.quotaid.focus();
    }
    if(isEmpty(quota)){
      msg="配货单号不能为空!";
      form1.quota.focus();
    }
	
	if(isEmpty(set_depotid)){
	  msg="发货仓库不能为空!";
	  alert(msg);
	  selectMD('sm');
	  return false;
	}
	if(isEmpty(get_depotid) || isEmpty(get_mchid)){
	  msg="收货仓库不能为空!";
	  alert(msg);
	  selectMD('sm');
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
dim id,sql,action,set_depotid,get_depotid,get_mchid,sdptname,edptname,userid,username
dim quotaid,quota,setdate,sure,chk_sure,getdate,d_type,parentid 'as string
dim cr_date,crdate,comment,backrate,selltype,backdate,indentid 'as string
dim get_sums,set_sums
id=trim(request.QueryString("id"))
action=trim(request.Form("action"))
if id<>"" then session("id")=id
if action="" then action=trim(request.QueryString("action"))
'response.Write(action)
select case action
case "del"
  Call getGant("del",0)
  if id="" then 
    Err.Raise 50001,"create_quota.edit","请选择要删除的单据!"
  else
    sql="delete from d_quota Where quotaid='" & id &"'"
    cn.execute sql
	set cn=nothing
	call close("删除成功!")
  end if
case "save"
  save
case "edit"
  if id="" then
    Err.Raise 50001,"create_quota.edit","请先选择单据,才能编辑!"
  else
    sql="Select * From v22d_quota Where quotaid='" & id &"'"
    ds.source = sql
    ds.open
    'response.Write(sql)
    if not ds.eof then
	  quotaid=id
	  quota=ds("quota")
      set_depotid=ds("setdepotid")
	  sdptname=ds("setdptname")
	  get_depotid=ds("get_depotid")
	  edptname=ds("getdptname")
	  get_mchid=ds("getdepotid") '在视图中getdepotid对应表中的get_mchid
	  parentid=ds("parentid")
	  indentid=ds("indentid")
	  edptname=ds("getdptname")
      quotaid=ds("quotaid")
	  setdate=ds("setdate")
	  getdate=ds("getdate")
      backrate=ds("backrate")
      backrate=ds("backrate")
      backdate=ds("backdate")
      comment=ds("comment")
      selltype=ds("selltype")
	  'get_sums=ds("get_nums")
	  'set_sums=ds("set_sums")
    end if
    ds.close
    set ds=nothing
	call show
  end if
  set cn=nothing
case "create"
  Call getGant("create",0)
  quotaid=getid("d_quota","quotaid","PH",session("dm").System_UserId)
  quota=quotaid
  setdate=get_date(date)
  getdate=get_date(date+15)
  backrate="0"
  backdate=get_date(date+30)
  session("id")=quotaid
  set_depotid=session("dm").System_Depotid
  sdptname=session("dm").System_UnitName
  call show
case else
  Err.Raise 50001,"create_quota.else","没有设置命令!"
end select%>
<%sub show%>
<form name="form1" method="post" action="" onSubmit="return checkform();">
  <table width="480"  border="0" align="center" class="bar">
    <tr>
      <td align="center">给加盟商配货</td>
    </tr>
  </table>
  <table width="480"  border="0" align="center" cellspacing="0" class="tcontent">
    <tr class="label">
      <td width="19%" align="right"><input name="action" type="hidden" value="save">
        流水号:</td>
      <td width="85%"><input name="quotaid" type="text" class="intra13" id="quotaid" value="<%=quotaid%>" size="22" maxlength="22" readonly>
          <input type="hidden" name="hiddenField">      </td>
    </tr>
<tr class="label">
      <td align="right">参照:</td>
      <td><input name="indentid" type="text" disabled class="intra13" id="indentid" value="<%=indentid%>" size="22" maxlength="22"></td>
    </tr>
    <tr class="label">
      <td align="right">目前余额:</td>
      <td><input name="get_sums" type="text" class="intra13" id="get_sums" value="<%=get_sums%>" size="22" maxlength="20" readonly></td>
    </tr>
    <tr class="label">
      <td align="right">目前可用余额:</td>
      <td><input name="set_sums" type="text" class="intra13" id="set_sums" value="<%=set_sums%>" size="22" maxlength="20" readonly></td>
    </tr>    <tr>
      <td align="right">配货单号:</td>
      <td><input name="quota" type="text" id="quota" value="<%=quota%>" size="22" maxlength="22">      </td>
    </tr>
    <tr>
      <td align="right">发货仓库:</td>
      <td><input name="set_depotid" type="text" id="set_depotid" value="<%=set_depotid%>" size="22" maxlength="10" readonly >
          <input type="button" name="Submit" value="..." onClick="selectMD('sd');">
      <input name="sdptname" type="text" class="tcontent" id="sdptname" style="border:none;" value="<%=sdptname%>" size="10" readonly></td>
    </tr>
    <tr>
      <td align="right">收货店铺:</td>
      <td><input name="get_depotid" type="text" id="get_depotid" value="<%=get_depotid%>" size="22" maxlength="10" readonly>
          <input type="button" name="Submit" value="..." onClick="selectMD('sm');">
          <input name="edptname" type="text" class="tcontent" id="edptname" style="border:none;" value="<%=edptname%>" size="10" readonly>
          <input name="get_mchid" type="hidden" id="get_mchid" value="<%=get_mchid%>">
      <span class="intra"><input name="parentid" type="hidden" id="parentid" value="<%=parentid%>">
	  </span></td>
    </tr>
    <tr>
      <td align="right">销售类型:</td>
      <td><%=getLookupByName(4001,selltype)%></td>
    </tr>
    <tr>
      <td align="right">配货日期:</td>
      <td><input name="sdate" type="text" id="sdate" onFocus="setday(this)" value="<%=setdate%>" size="22" maxlength="10" readonly></td>
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
      <td><input name="backdate" type="text" id="backdate" onFocus="setday(this)" value="<%=backdate%>" size="22" maxlength="10" readonly></td>
    </tr>
    
    <tr>
      <td align="right">备注:</td>
      <td><input name="comment" type="text" id="comment" value="<%=comment%>
" size="50"></td>
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
  get_mchid=trim(request.Form("get_mchid"))
  get_depotid=trim(request.Form("get_depotid"))
  parentid=trim(request.Form("parentid"))
  quotaid=trim(request.Form("quotaid"))
  quota=trim(request.Form("quota"))
  setdate=trim(request.Form("setdate"))
  getdate=trim(request.Form("getdate"))
  selltype=trim(request.Form("selltype"))
  backrate=trim(request.Form("backrate"))
  backdate=trim(request.Form("backdate"))
  comment=trim(request.Form("comment"))
  userid=Session("dm").System_userId
  userName=session("dm").System_username
  d_type=session("d_type")
  
  if setdate="" then setdate=get_date(date)
  if getdate="" then getdate=setdate
  if backdate="" then backdate=get_date(date+30)
  
  sql="select * from d_quota where quotaid ='"& id &"'"
  ds.CursorType = 1
  ds.CursorLocation = 2
  ds.LockType = 3
  ds.source = sql
  ds.open
  if ds.eof then
    Call getGant("create",0)
    '保存新增
	sql="insert into d_quota(set_depotid,get_mchid,quotaid,quota,setdate,getdate,selltype,backrate," & _
	"backdate,comment,d_type,cr_name,cr_date,get_depotid,parentid)"& _
	 "values("& qts(set_depotid) &","& qts(get_mchid) &","& qts(quotaid) &","& qts(quota) &","& qts(setdate) &","& _
	 qts(getdate) &","& qts(selltype) &","& backrate &","& backdate &","& qts(comment) &","&session("d_type")& _
	 ",'"&session("dm").System_UserName&"','"&get_date(date())&"','"&get_depotid&"','"&parentid&"')"
	'cn.execute sql
	
	ds.Addnew
	ds("quotaid")=quotaid
	ds("quota")=quota
	ds("get_mchid")=get_mchid
	ds("set_depotid")=set_depotid
	ds("get_depotid")=get_depotid
	ds("parentid")=parentid
	ds("setdate")=setdate
	ds("getdate")=getdate
	ds("selltype")=selltype
	ds("backrate")=backrate
	ds("backdate")=backdate
	ds("comment")=comment
	ds("cr_name")=username
	ds("cr_date")=get_date(date)
	ds("d_type")=d_type
	ds("chk_sure")=0
	ds("sure")=0
	ds("ov_sure")=0
	ds.update
    ds.close
	set ds=nothing
	set cn=nothing
	response.Write("<script language='javascript'>")
	response.Write("showModalDialog('f22_main.asp?id="&quotaid&"&pksname="&session("pksname")&"&opt="&session("pksname")&"&numName=nums','es','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');")
	response.Write("window.returnValue='r';window.close();</script>")
  else
    Call getGant("edit",0)
    'ds("quotaid")=quotaid
	ds("quota")=quota
	ds("get_mchid")=get_mchid
	ds("set_depotid")=set_depotid
	ds("get_depotid")=get_depotid
	ds("parentid")=parentid
	ds("setdate")=setdate
	ds("getdate")=getdate
	ds("selltype")=selltype
	ds("backrate")=backrate
	ds("backdate")=backdate
	ds("comment")=comment
	ds.update
	ds.close
    set ds=nothing
	call show
	call close("修改成功!")
  end if
  set cn=nothing
end sub%>
<script language="javascript">
 window.dialogWidth="500px";
  window.dialogHeight="430px";
  //window.dialogLeft   X座标   
  //window.dialogTop   Y座标 
</script>
</body>
</html>
