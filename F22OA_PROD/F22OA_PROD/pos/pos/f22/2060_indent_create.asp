<%option explicit
Response.Expires=-1000
'on error resume next%>
<!--#include file="inc/function.asp" -->
<%
if not padd and trim(request("action"))="create" then
   call mbox("没有新增权限！")
end if

dim ds,formid
formid=2060
set ds=server.CreateObject("ADODB.Recordset")
    ds.activeconnection = cn%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>添加定货单</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../inc/js/setday.js"></script>
<script type="text/javascript" src="inc/abc.js"></script>
<script language="javascript">
<%Call selectSFdh%>
function checkform(){
  var indentid,indent,depotid,merchantid,backrate,get_depotid,msg="";
  with(document){
    indentid=trim(form1.indentid.value);
    indent=trim(form1.indent.value);
    depotid=trim(form1.depotid.value);
	merchantid=trim(form1.merchantid.value);
	parentid=trim(form1.parentid.value);
	//alert(merchantid);
	//return false;
	backrate=trim(form1.backrate.value);
	get_depotid=trim(form1.get_depotid.value);
    if(isEmpty(indentid)){
      msg="流水号不能为空!";
	  form1.indentid.focus();
    }
    if(isEmpty(indent)){
      msg="定货单号不能为空!";
      form1.indent.focus();
    }
	if(isEmpty(depotid)){
	  msg="发货仓库不能为空!";
	  form1.depotid.focus();
	}
	if(isEmpty(get_depotid) || isEmpty(merchantid)){
	  msg="收货仓库不能为空!";
	  alert(msg);
	  selectMD('sm');
	  return false;
	  //form1.get_depotid.focus();
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
dim Indentid,indent,MerchantId,setdate,sure,chk_sure,depotid,getdate,d_type,crname,chkname,parentid 'as string
dim chk_date,sure_date,ov_date,ov_sure,ov_name,cr_date,crdate,comment,backrate,selltype,backdate 'as string
dim sdptname,edptname,get_depotid,fname ' as string
dim get_sums,set_sums
id=trim(request("id"))
action=trim(request.Form("action")) 

if session("d_type")=1 then
 fname="DH"
elseif session("d_type")=2 then
 fname="BH"
elseif session("d_type")=3 then
 '
else
 fname="DH"
end if

if id<>"" then session("id")=id
if action="" then action=trim(request.QueryString("action"))
action=Lcase(action)
select case action
case "del" '删除
  Call getGant("del",0,formid)
  if id="" then 
    Err.Raise 50001,"create_indent.edit","请选择要删除的单据!"
  else
    sql="delete from d_Indent Where indentid='" & id &"'"
    cn.execute sql
	set cn=nothing
	call close("删除成功!")
  end if
case "save" '保存修改的单据
  save
case "edit" '打开界面
  if id="" then
    Err.Raise 50001,"create_indent.edit","请先选择单据,才能编辑!"
  else
     sql="Select a.indentid,a.indent,a.depotid as setdepotid,b.d_name as setdptname,a.merchantid,a.get_depotid as getdepotid,"&_
	     "c.d_name as getdptname,a.parentid,a.setdate,a.getdate,a.backrate,a.backdate,a.comment,a.selltype "&_
		 "From d_indent a,j_depot b,j_depot c Where a.depotid=b.depotid and a.get_depotid=c.depotid and a.indentid="&qts(id)
	'response.Write(sql)
	'response.End()
    ds.source = sql
    ds.open
    if ds.eof then
      Err.Raise 50001,"create_indent.edit","对不起,没有找到该单据,请重新选择!"
	else
      indentid=ds("indentid")
	  indent=ds("indent")
	  depotid=ds("setdepotid")
	  sdptname=ds("setdptname")
	  merchantid=ds("merchantid")
	  edptname=ds("getdptname")
	  get_depotid=ds("getdepotid")
	  parentid=ds("parentid")
	  setdate=ds("setdate")
	  getdate=ds("getdate")
      backrate=ds("backrate")
      backdate=ds("backdate")
      comment=ds("comment")
      selltype=ds("selltype")
    end if
    ds.close
    set ds=nothing
  end if
  call show
case "create" '新增界面
  Call getGant("create",0,formid)
    indentid=getid("d_indent","indentid",fname,session("dm").System_UserId)
    indent=indentid
    depotid=session("dm").System_set_Depotid
    sdptname=session("dm").System_set_DepotName
    merchantid=session("dm").System_UnitId
	parentid=session("dm").System_Parentid
    'edptname=session("dm").System_UnitName
    setdate=get_date(date)
    getdate=get_date(date+15)
    backrate="0"
    backdate=get_date(date+30)
    session("id")=indentid
    
    get_depotid=session("dm").System_depotid
	edptname=session("dm").System_DepotName
  call show
case else
  Err.Raise 50001,"create_indent.else","没有设置命令!"
end select%>

<%sub show%>
<form action="" method="post" name="form1" id="form1" onSubmit="return checkform();">
  <table width="480"  border="0" align="center" class="bar">
    <tr>
      <td height="19" align="center" class="f14">订货单</td>
    </tr>
  </table>
  <table width="480"  border="0" align="center" cellspacing="0" class="tcontent">
    <tr class="label">
      <td width="19%" align="right">流水号:
      <input name="action" type="hidden" value="save"></td>
      <td width="81%"><input name="indentid" type="text" class="intra13" id="indentid"
       value="<%=indentid%>" size="22" maxlength="22" readonly>
      </td>
    </tr>
	
<tr class="label">
      <td align="right">目前余额:</td>
      <td><input name="get_sums" type="text" class="intra13" id="get_sums" value="<%=get_sums%>" size="22" maxlength="22" readonly></td>
    </tr>
    <tr class="label">
      <td align="right">目前可用余额:</td>
      <td><input name="set_sums" type="text" class="intra13" id="set_sums" value="<%=set_sums%>" size="22" maxlength="22" readonly></td>
    </tr>    <tr>
      <td align="right">订货单号:</td>
      <td><input name="indent" type="text" id="indent" value="<%=indent%>" class="intra13"  size="22" maxlength="22">
      </td>
    </tr>
<tr>
      <td align="right">发货仓库:</td>
      <td><input name="depotid" type="text" class="intra13" id="depotid" value="<%=depotid%>" size="22" maxlength="10" readonly>
          <input type="button" name="Submit" value="..." onClick="selectMD('sd');">
      <input name="sdptname" type="text" class="tcontent" id="sdptname" style="border:none;" tabindex="-1" value="<%=sdptname%>" size="20" readonly>      </td>
    </tr>
    <tr>
      <td align="right">收货店铺:</td>
      <td><input name="get_depotid" type="text" class="intra13" id="get_depotid" value="<%=get_depotid%>" size="22" maxlength="10" readonly>
          <input type="button" name="Submit" value="..." onClick="selectMD('sm');" disabled>
          <input name="edptname" type="text" class="tcontent" id="edptname" style="border:none;" tabindex="-1" value="<%=edptname%>" size="20" readonly>
          <input name="merchantid" type="hidden" id="merchantid" value="<%=merchantid%>">
      <span class="notice">
      <input name="parentid" type="hidden" id="parentid" value="<%=parentid%>">
      </span></td>
    </tr>    <tr>
      <td align="right">订货类型:</td>
      <td><%=getLookupByName(4001,selltype)%><span class="notice"> </span></td>
    </tr>
    <tr>
      <td align="right">订货日期:</td>
      <td><input name="setdate" type="text" id="setdate" onFocus="setday(this)" value="<%=setdate%>" size="22" maxlength="10" readonly>
      </td>
    </tr>
    <tr>
      <td align="right">计划上货日期:</td>
      <td><input name="getdate" type="text" id="getdate" onFocus="setday(this)" value="<%=getdate%>" size="22" maxlength="10" readonly>
      </td>
    </tr>
    <tr>
      <td align="right">换货率:</td>
      <td><input name="backrate" type="text" id="backrate" value="<%=backrate%>" size="22" maxlength="10" readonly>
        %</td>
    </tr>
    <tr>
      <td align="right">最迟换货日期:</td>
      <td><input name="backdate" type="text" id="backdate" value="<%=backdate%>" size="22" maxlength="10" onFocus="setday(this)" ></td>
    </tr>
    
    <tr>
      <td align="right">备注:</td>
      <td>      <input name="comment" type="text" id="comment" value="<%=comment%>" size="50" maxlength="50"></td>
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
  depotid=trim(request.Form("depotid")) '发货仓库
  session("set_depotid")=depotid
  merchantid=trim(request.Form("merchantid")) '显示框中的值
  get_depotid=trim(request.Form("get_depotid")) '爷爷
  session("get_depotid")=get_depotid
  parentid=trim(request.Form("parentid"))
  indentid=trim(request.Form("indentid"))
  indent=trim(request.Form("indent"))
  setdate=trim(request.Form("setdate"))
  getdate=trim(request.Form("getdate"))
  selltype=trim(request.Form("selltype"))
  backrate=trim(request.Form("backrate"))
  backdate=trim(request.Form("backdate"))
  comment=trim(request.Form("comment"))
  
  if setdate="" then setdate=get_date(date)
  if getdate="" then getdate=setdate
  if backdate="" then backdate=get_date(date+30)

  sql="select * from d_indent where indentid ='"& indentid &"'"
  ds.CursorType = 1
  ds.CursorLocation = 2
  ds.LockType = 3
  ds.source = sql
  ds.open
  if ds.eof then
    Call getGant("create",0,formid)
	sql="insert into d_indent(depotid,merchantid,indentid,indent,setdate,getdate,selltype,backrate," & _
	"backdate,comment,d_type,cr_name,cr_date,get_depotid,parentid,chk_sure,sure,ov_sure)"& _
	 "values("& qts(depotid) &","& qts(merchantid) &","& qts(indentid) &","& qts(indent) &","& qts(setdate) &","& _
	 qts(getdate) &","& qts(selltype) &","& backrate &","&qts(backdate)&","& qts(comment) &",1"& _
	 ",'"&session("dm").System_UserName&"','"&get_date(date())&"','"&get_depotid&"','"&parentid&"',0,0,0)"
	 'de sql
	cn.execute sql
	ds.close
	set ds=nothing
	set cn=nothing
	response.Write("<script language='javascript'>")
	response.Write("showModalDialog('f22_main.asp?id="&indentid&"&pksname=indent&opt=indent&numName=nums','es','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');")
	'response.Write("window.returnValue='r';window.history.back();")
	response.Write("window.location.href='search_frame.asp';")
	response.Write("</script>")
  else
    Call getGant("edit",0,formid)
    'ds("indentid")=indentid
	ds("indent")=indent
	ds("merchantid")=merchantid
	ds("depotid")=depotid
	ds("get_depotid")=get_depotid
	ds("setdate")=setdate
	ds("getdate")=getdate
	ds("selltype")=selltype
	ds("backrate")=backrate
	ds("backdate")=backdate
	ds("comment")=comment
	ds.update
	ds.close
    set ds=nothing
    response.Write("<script language='javascript'>alert('编辑单据成功!');window.close();</script>")
  end if
end sub%>

<%if err.number <>0 then
    response.write "<script language='javascript'>alert("""&err.description&""");window.close();</script>"
end if
'cn.close()
set cn = nothing
%>
<script language="javascript">
 window.dialogWidth="500px";
  window.dialogHeight="400px";
  //window.dialogLeft   X座标   
  //window.dialogTop   Y座标 
</script>
</body>
</html>